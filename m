Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4064C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7B621775
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SiF7cAwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7B621775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeHCRRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:17:31 -0400
Received: from imap.thunk.org ([74.207.234.97]:34790 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeHCRRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gS6of1Wqx+Ga/Z6ewxwT1nDoWFudzhaHANCaL5kDyYM=; b=SiF7cAwFQy9rjIjWJXajYhZcs9
        gMwvHAX4/Oc79SUrH4j1p3EkD57rchS5KjlnCmDK7Jbo9aFfW5T1oyKTN24JaKzSAgGJ8x7oudCyN
        UWwTSpbe2NTvefSt3B6NYdBGtrqbbu/ftRIY/CxlpNM5jAHLtzj03J0HlDTs3U3mZwpk=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1flbsZ-0002al-Ld; Fri, 03 Aug 2018 15:20:35 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C5D817A64C9; Fri,  3 Aug 2018 11:20:34 -0400 (EDT)
Date:   Fri, 3 Aug 2018 11:20:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [dm-devel] LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180803152034.GD32066@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mike Snitzer <snitzer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
References: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
 <CAOi1vP_tYG77e71CdDiOcszSSEWrp9Vfi+KB7yFAXVQChkjP5A@mail.gmail.com>
 <93bff248-6897-4867-841b-2dace11597de@torlan.ru>
 <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru>
 <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803133102.GA3092@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:31:03AM -0400, Mike Snitzer wrote:
> 
> Debian is notorious for having a stale and/or custom lvm2.
> Generally speaking, it is recommended that lvm2 not be older than the
> kernel (but the opposite is fine).

On Fri, Aug 03, 2018 at 03:31:18PM +0200, Zdenek Kabelac wrote:
> IMHO (as the author of fixing lvm2 patch) user should not be upgrading
> kernels and keep running older lvm2 user-land tool (and there are very good
> reasons for this).

I'm going to have to strenuously disagree.

In *general* it's quite common for users to update their kernel
without updating their userspace.  For example, I as a *developer*, I
am often running bleeding kernels (e.g., at the moment I am running
something based on 4.18-rc6 on a Debian testing system; and it's not
at all uncommon for users to run a newer kernel on older
distribution).

This is the *first* I've heard that I should be continuously updating
lvm because I'm running bleeding edge kernels --- and I would claim
that this is entirely unreasonable.

I'll also note that very often users will update kernels while running
distribution userspace.  And if you are using Linode, very often
*Linode* will offer a newer kernel to better take advantage of the
Linode VM, and this is done without needing to install the Linode
kernel into the userspace.

It *used* to be the case that users running RHEL 2 or RHEL 3 could try
updating to the latest upstream kernel, and everything would break and
fall apart.  This was universally considered to be a failure, and a
Bad Thing.  So if LVM2 is not backwards compatible, and breaks in the
face of newer kernels running older distributions, that is a bug.

If there is a fundamental bug in the userspace API, and it can't be
fixed without a serious security bug, sometimes we need to have an
exception to the "you can't mandate newer userspace" rule.  But I
don't think this falls into this category; how would a user "exploit"
what people are calling a "security bug" to break root?

    	      	      	      	    		   	- Ted
