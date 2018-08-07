Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B1C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7939D21885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7939D21885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwaak.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390082AbeHGSUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:20:04 -0400
Received: from gw-fsck-sorbs.kwaak.net ([84.245.27.153]:56204 "EHLO
        mail.kwaak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbeHGSUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:20:04 -0400
Received: from [192.168.0.44] (port=39601 helo=shell3.kwaak.net)
        by mail.kwaak.net with esmtp (Exim 4.50)
        id 1fn4Te-000814-B7; Tue, 07 Aug 2018 18:04:55 +0200
Received: from ard by shell3.kwaak.net with local (Exim 4.80)
        (envelope-from <ard@kwaak.net>)
        id 1fn4Tc-00080z-JL; Tue, 07 Aug 2018 18:04:52 +0200
Date:   Tue, 7 Aug 2018 18:04:52 +0200
From:   ard <ard@kwaak.net>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180807160452.GE23827@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180806132234.GA23827@kwaak.net>
 <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
 <20180806142414.GB23827@kwaak.net>
 <20180807065400.nxpndw4kf6jdd55i@linux-x5ow.site>
 <20180807092619.GC23827@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807092619.GC23827@kwaak.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.168.0.44 (failed)
X-Kwaak-Spam-Score: -2.6
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.304,
        required 5, autolearn=not spam, BAYES_00 -2.60,
        DNS_FROM_AHBL_RHSBL 0.29)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 07, 2018 at 11:26:19AM +0200, ard wrote:
> So a conclusion of my rambling:
> 1) you either need 6 vn2vn hosts *or* you need more than one 4.14
> kernel in a network to trigger. One of the two. I need to think
> about this. The fact that the 4.14 systems can't see eachother is
> an indicator.  I can turn off the FCoE on some other system to
> see if the memleak stops.

I've gone all out:

Ok, deleted everything, long story short:
(for now(!))

PC+steam machine with 4.14 (patched) and 4.16 (upstream,
nodebug): no kmemleaks
Every device sees every device.

Now if I add two odroids running 4.14 (not patched):
The odroids will see *every* device running < 4.14 and vv
The odroids will not see any device running >= 4.14 and vv
The PC starts to kmemleak a lot.

I've removed the two 4.14 odroids again from the FCoE lan, and
upgraded them with a patched 4.14 .
I rebooted the PC with steam (4.16 upstream unpatched) and all
other systems in the lan I mentioned.
To be clear: the steam machine has a dedicated nic for FCoE. All
other systems use a vlan.
I will let that talk with eachother for now.

I fear there is a platform specific thing in the vn2vn chatter
that has changed > 4.9 .
4.14 can communicate with lower revisions, but they can't see
eachother, and whatever they chat about, it induces memory leaks
on the PC.
Oh, another difference is that steam and the PC has targets
assigned. I might try that for the 4.14 too.

Anyway, I will do some cooking and let the current systems chat
with eachother and see if we get a kmemleak making my statement
bogus.

Regards,
Ard

-- 
.signature not found
