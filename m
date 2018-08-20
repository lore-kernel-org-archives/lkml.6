Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58135C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BFE208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BFE208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeHTOZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:25:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:50114 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTOZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:25:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7KB9UPP030991;
        Mon, 20 Aug 2018 06:09:32 -0500
Message-ID: <21451a6ba97eada5d4a8a49b2726edde58266817.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Hari Vyas <hari.vyas@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Aug 2018 21:09:30 +1000
In-Reply-To: <CAM5rFu_dsfAiQtVnM58631tFUxYyzXrA5tgz8_v0=or3Lv8YbA@mail.gmail.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
         <20180817044902.31420-2-benh@kernel.crashing.org>
         <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
         <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
         <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
         <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
         <CAM5rFu_dsfAiQtVnM58631tFUxYyzXrA5tgz8_v0=or3Lv8YbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-20 at 11:55 +0530, Hari Vyas wrote:
> On Mon, Aug 20, 2018 at 7:40 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Sat, 2018-08-18 at 21:24 -0500, Bjorn Helgaas wrote:
> > > On Sat, Aug 18, 2018 at 01:24:51PM +1000, Benjamin Herrenschmidt wrote:
> > > > On Fri, 2018-08-17 at 10:44 -0500, Bjorn Helgaas wrote:
> > > > > On Fri, Aug 17, 2018 at 02:48:57PM +1000, Benjamin Herrenschmidt wrote:
> > > > > > This reverts commit 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76.
> > > > > 
> > > > > Just to be clear, if I understand correctly, this is a pure revert of
> > > > > 44bda4b7d26e and as such it reintroduces the problem solved by that
> > > > > commit.
> > > > > 
> > > > > If your solution turns out to be better, that's great, but it would be
> > > > > nice to avoid the bisection hole of reintroducing the problem, then
> > > > > fixing it again later.
> > > > 
> > > > There is no way to do that other than merging the revert and the fix
> > > > into one. That said, the race is sufficiently hard to hit that I
> > > > wouldn't worry too much about it.
> > > 
> > > OK, then at least mention that in the changelog.
> > 
> > Sure will do. This is just RFC at this stage :-)
> > 
> > As for the race with enable, what's your take on my approach ? The
> > basic premise is that we need some kind of mutex to make the updates to
> > enable_cnt and the actual config space changes atomic. While at it we
> > can fold pci_set_master vs. is_busmaster as well as those are racy too.
> > 
> > I chose to create a new mutex which we should be able to address other
> > similar races if we find them. The other solutions that I dismissed
> > were:
> > 
> >  - Using the device_lock. A explained previously, this is tricky, I
> > prefer not using this for anything other than locking against
> > concurrent add/remove. The main issue is that drivers will be sometimes
> > called in context where that's already held, so we can't take it inside
> > pci_enable_device() and I'd rather not add new constraints such as
> > "pci_enable_device() must be only called from probe() unless you also
> > take the device lock". It would be tricky to audit everybody...
> > 
> >  - Using a global mutex. We could move the bridge lock from AER to core
> > code for example, and use that. But it doesn't buy us much, and
> > slightly redecuces parallelism. It also makes it a little bit more
> > messy to walk up the bridge chain, we'd have to do a
> > pci_enable_device_unlocked or something, messy.
> > 
> > So are you ok with the approach ? Do you prefer one of the above
> > regardless ? Something else ?
> > 
> > Cheers,
> > Ben.
> > 
> > 
> 
> Some concern was raised about race situation so just to be more clear
> about race condition.

This is not what the above discussion is about.

The race with is is_added is due to the fact that the bit is set too
later as discussed previously and in my changelog.

The race I'm talking about here is the race related to multiple
subtrees trying to simultaneously enable a parent bridge.

> Situation is described in Bug 200283 - PCI: Data corruption happening
> due to a race condition.
> Issue was discovered by our broadcom QA team.
> Initially commit was to use one separate lock only for avoiding race
> condition but after review, approach was slightly changed to move
> is_added  to pci_dev private flags as it was completely
> internal/private variable of pci core driver.
> Powerpc legacy arch code was using is_added flag directly which looks
> bit strange so  ../../ type of inclusion of pci.h was required. I know
> it looks ugly but it is being used in some legacy code still.
> Anyway, as stated earlier too, problem should be just solved in better way.

The is_added race can be fixed with a 3 lines patch moving is_added up
to before device_attach() I believe. I yet have to find a scenario
where doing so would break something but it's possible that I missed a
case.

At this stage, I'm more intested however in us agreeing how to fix the
other race, the one with enabling. As I wrote above, I proposed an
approach based on a mutex in pci_dev, and this is what I would like
discussed.

This race is currently causing our large systems to randomly error out
at boot time when probing some PCIe devices. I'm putting a band-aid in
the powerpc code for now to pre-enable bridges at boot, but I'd rather
have the race fixed in the generic code.

Ben.


