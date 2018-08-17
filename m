Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70216C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF5D218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF5D218AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeHQMmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:42:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:36367 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbeHQMme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:42:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7H9d2QV031797;
        Fri, 17 Aug 2018 04:39:04 -0500
Message-ID: <af7ceae785489f2006074109b27b3f07b190c89b.camel@kernel.crashing.org>
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
Date:   Fri, 17 Aug 2018 19:39:02 +1000
In-Reply-To: <CAM5rFu-h25j-vfvybKbKr4huhBgpV3Rusj8E2JyaoG1YnokeMw@mail.gmail.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
         <20180817044902.31420-6-benh@kernel.crashing.org>
         <66577784.13494160.1534493390262.JavaMail.zimbra@kalray.eu>
         <1ffafe01887e3b760f84488b06339aba64f586e5.camel@kernel.crashing.org>
         <CAM5rFu-h25j-vfvybKbKr4huhBgpV3Rusj8E2JyaoG1YnokeMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 14:30 +0530, Hari Vyas wrote:
> So many mail threads for common issues going so just trying to
> summarize concern from my side.
> 1) HW level
> PCI Config data overwritten (ex: PCI_COMMAND bits etc) was happening
> at lower layer so from my
> perspective, it is best to handle concern at lower level with locking
> mechanism and that is what
> I proposed in my upcoming patch. Without that, I guess, we may end up
> in issues later with some weird scenario
> which may not be known today  and we will again be fine tuning stuff
> here and there.

Maybe... at this point I'm not trying to address that specific issue.
That being said, the PCI_COMMAND register should be under control of
the driver at runtime and thus shouldn't be exposed to races like that
except in the usual case of races in configuring bridges. Those races
definitely need to be handled at the higher level.

So I'm rather dubious of adding a whole new layer of "modify" callbacks
to config space accessors for that, especially since they won't do any
good on architectures with lockless config accesses such as ... x86 

> 2) SW level(internal data structure):
> About is_added,is_busmaster: These all are bit fields so infact I too
> suggested to remove those bit fields and
> make separate variables in pci_dev structure. 
> This will avoid all data-overwritten,concurrency issues but ofcourse
> at the level of space cost.

It's unnecessary to do blanket changes without first understanding the
details of what's going on. A lot of these things are never touched
outside of the overall single threaded environment of
discovery/assignment or under driver control, in which case it's
expectd that the driver doesn't call them in racy ways

That said, I'm happy to move some of them under my proposed
dev_state_lock.

For is_added specifically, the field is simply set at the wrong time as
you can see in my previous patch.

> Other possibility will be either to use atomic

Atomic is almost always wrong. It doesn't synchronize anything other
than the field, so either it's a big waste of it gives a false sense of
security for something that's almost always still racy.

I'd rather keep the indication that a bunch of those fields *are*
unprotected and rely on the outer layers being single threaded.

>  or locking mechanism
> for these. My point here is also same, better
> avoid fine tuning later stage.
> Moving is_added up and down doesn't look like good as we are just
> shifting issue up and down.

No, you are wrong. I also originally covered is_added with my new mutex
but in hindsight it's the wrong thing to do, and went back to the
correct fix at this point which is precisely to move it up.

is_added is essentially owned by the part of the PCI probe code that
runs single threaded before the device gets exposed to the device
model.

Pretty much all of the code, including all the corresponding fields
(struct resources etc...) in pci_dev are unprotected and rely on being
accessed in a single threaded manner. is_added is no exception.

It was simply a mistake to set it after device_attach().

Thus moving it back up fixes it *correctly* by making it follow the
same rules as all the related fields.

That said, if we want to start adding protection to all those other
fields, then this is a different matter alltogether. But at this point,
this is the best fix for the problem at hand.

> Please check and decide accordingly. I will hold my to-be-submitted
> modify() patch about handling hw level
> over-written case with locking around read-write operation.

Can you remind us in this thread which specific cases of RMW races of
config space you were trying to address ?

Cheers,
Ben.


