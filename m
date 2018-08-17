Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FEEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606C5208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606C5208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeHQN2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:28:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:39672 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbeHQN2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:28:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7HAOepp002966;
        Fri, 17 Aug 2018 05:24:41 -0500
Message-ID: <e6d45448f3bde4b1d83f1588b7e6aa729cf77300.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/6] pci: Protect the enable/disable state of
 pci_dev using the state mutex
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Hari Vyas <hari.vyas@broadcom.com>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Aug 2018 20:24:40 +1000
In-Reply-To: <CAM5rFu8ebfaV=8QQ8u=4HThM2T4ZRR9XHxqhKoyAfnv0N79Z8Q@mail.gmail.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
         <20180817044902.31420-6-benh@kernel.crashing.org>
         <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
         <1ffafe01887e3b760f84488b06339aba64f586e5.camel@kernel.crashing.org>
         <CAM5rFu-h25j-vfvybKbKr4huhBgpV3Rusj8E2JyaoG1YnokeMw@mail.gmail.com>
         <af7ceae785489f2006074109b27b3f07b190c89b.camel@kernel.crashing.org>
         <CAM5rFu8ebfaV=8QQ8u=4HThM2T4ZRR9XHxqhKoyAfnv0N79Z8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 15:40 +0530, Hari Vyas wrote:
> 
> > So I'm rather dubious of adding a whole new layer of "modify" callbacks
> > to config space accessors for that, especially since they won't do any
> > good on architectures with lockless config accesses such as ... x86
> > 
> 
> modify() is optional.  host/controller layers may override it.
> It was just a proposal to avoid race issues which happens in SMP environment and
> solves other issues. I agree, nothing great anyhow can be done in
> lockless config

Right so let's not go down the path of creating low level accessors
providing a semantic that cannot actually be provided by some
architectures :-)

> > > 2) SW level(internal data structure):
> > > About is_added,is_busmaster: These all are bit fields so infact I too
> > > suggested to remove those bit fields and
> > > make separate variables in pci_dev structure.
> > > This will avoid all data-overwritten,concurrency issues but ofcourse
> > > at the level of space cost.
> > 
> > It's unnecessary to do blanket changes without first understanding the
> > details of what's going on. A lot of these things are never touched
> > outside of the overall single threaded environment of
> > discovery/assignment or under driver control, in which case it's
> > expectd that the driver doesn't call them in racy ways
> > 
> > That said, I'm happy to move some of them under my proposed
> > dev_state_lock.
> > 
> > For is_added specifically, the field is simply set at the wrong time as
> > you can see in my previous patch.
> > 
> Issue needs to be addressed and that is our goal.

Yes.

> Some times simple mistakes need lot of debugging which happened in my case and
> my suggestion is to just avoid. SMP related issues are popping up now
> so we just need to be careful.

Oh I agree, and I took me a while to re-debug independently some of the
issues on my side too :-) I should be clearer that I very much do
appreciate your debugging work and finding those problems !

I might disagree on the solution but your effort is very valuable and
I'm sure we can converge on a solution that works for everybody.

 .../...

> > Can you remind us in this thread which specific cases of RMW races of
> > config space you were trying to address ?
> > 
> 
> Same pci bridge master, memory bit setting concern only (which my
> colleague Srinath figured out after lot of effort some time back) where only one bit in
> PCI_COMMAND  was getting set.
> (Bug 200793 - PCI: read-write config operation doesn't look like SMP safe)
> My approach is to handle with modify operations at lower level so bits
> are not over-written or lost.

Right so those are the same old races with pci_set_master() on the
bridge upward chain ?

If yes then this should be addressed by my patches but there are still
some debate about whether to add that new mutex or try to use an
existing one, so let's see what Bjorn has to say.

I think the set-master and enable/disable issues are intimately related
and should be solved together by some higher level locking.

This is a typical case where the "atomic" enable_cnt provided people
with a false sense of safety while the code in practice was still
completely racy.

> As stated earlier, issue should be just resolved in better way. No
> issue in going with majority

Hehe, ok. I think the is_added fix is simply to move it up since it
matches the rest of the code in that area, but let's see what Bjorn has
to say in that regard.

As for the enable/disable/set_master races, Ive wrote my arguments in
favor of a dedicated lock, let's see what others have to respond.

Cheers,
Ben.

> Regards,
> hari
> > Cheers,
> > Ben.
> > 
> > 

