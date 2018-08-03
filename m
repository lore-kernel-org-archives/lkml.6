Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88259C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515822177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515822177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeHCUhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:37:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728139AbeHCUhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F04588197021;
        Fri,  3 Aug 2018 18:39:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AF767C4F;
        Fri,  3 Aug 2018 18:39:33 +0000 (UTC)
Date:   Fri, 3 Aug 2018 14:39:32 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180803183932.GA3258@redhat.com>
References: <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com>
 <20180803152034.GD32066@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803152034.GD32066@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 18:39:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 03 Aug 2018 18:39:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03 2018 at 11:20am -0400,
Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Fri, Aug 03, 2018 at 09:31:03AM -0400, Mike Snitzer wrote:
> > 
> > Debian is notorious for having a stale and/or custom lvm2.
> > Generally speaking, it is recommended that lvm2 not be older than the
> > kernel (but the opposite is fine).
> 
> On Fri, Aug 03, 2018 at 03:31:18PM +0200, Zdenek Kabelac wrote:
> > IMHO (as the author of fixing lvm2 patch) user should not be upgrading
> > kernels and keep running older lvm2 user-land tool (and there are very good
> > reasons for this).
> 
> I'm going to have to strenuously disagree.
> 
> In *general* it's quite common for users to update their kernel
> without updating their userspace.  For example, I as a *developer*, I
> am often running bleeding kernels (e.g., at the moment I am running
> something based on 4.18-rc6 on a Debian testing system; and it's not
> at all uncommon for users to run a newer kernel on older
> distribution).
> 
> This is the *first* I've heard that I should be continuously updating
> lvm because I'm running bleeding edge kernels --- and I would claim
> that this is entirely unreasonable.

It isn't a hard requirement.  But relative to a newer kernel, you simply
cannot deny that a newer lvm2 will work better than on older lvm2.  Not
even speaking about this block regression.  Lessons are learned, fixes
are made, support for the newer kernel's targets are available, etc etc.

That is where the suggestion to keep lvm2 updated along with the kernel
comes from.

It isn't about "oh we regress _all_ the time.. screw users!".

> I'll also note that very often users will update kernels while running
> distribution userspace.  And if you are using Linode, very often
> *Linode* will offer a newer kernel to better take advantage of the
> Linode VM, and this is done without needing to install the Linode
> kernel into the userspace.
> 
> It *used* to be the case that users running RHEL 2 or RHEL 3 could try
> updating to the latest upstream kernel, and everything would break and
> fall apart.  This was universally considered to be a failure, and a
> Bad Thing.  So if LVM2 is not backwards compatible, and breaks in the
> face of newer kernels running older distributions, that is a bug.

Please stop with the overreaction and making this something it isn't.
