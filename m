Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E10DC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0B2217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0B2217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwaak.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeHIMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:25:47 -0400
Received: from gw-fsck-sorbs.kwaak.net ([84.245.27.153]:43309 "EHLO
        mail.kwaak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeHIMZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:25:47 -0400
Received: from [192.168.0.44] (port=54946 helo=shell3.kwaak.net)
        by mail.kwaak.net with esmtp (Exim 4.50)
        id 1fnhl5-0002Ap-Fx; Thu, 09 Aug 2018 12:01:32 +0200
Received: from ard by shell3.kwaak.net with local (Exim 4.80)
        (envelope-from <ard@kwaak.net>)
        id 1fnhl5-0002Ak-09; Thu, 09 Aug 2018 12:01:31 +0200
Date:   Thu, 9 Aug 2018 12:01:30 +0200
From:   ard <ard@kwaak.net>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180809100130.GF23827@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180806132234.GA23827@kwaak.net>
 <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
 <20180806142414.GB23827@kwaak.net>
 <20180807065400.nxpndw4kf6jdd55i@linux-x5ow.site>
 <20180807092619.GC23827@kwaak.net>
 <20180807160452.GE23827@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807160452.GE23827@kwaak.net>
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

Hi Guys,

On Tue, Aug 07, 2018 at 06:04:52PM +0200, ard wrote:
> PC+steam machine with 4.14 (patched) and 4.16 (upstream,
> nodebug): no kmemleaks
> Every device sees every device.

New day, new conflicting results.
Yay \0/.

As I did not trust the results, I redid the tests, and the same
tests gave some different results.
Before giving the results I've changed my stance on the bug:
The bug is not a regression in memory leak. As far as I can tell
now, the memory leaks were already there.
It's a regression in vn2vn enodes being able to PLOGI.
Since I've seen the steam machine and the PC setup an rport,
there must be some racy thing going on how the accept or reject
the PLOGI.
Now once it rejects, it will never succeed to accept, and the
relogin happens ad infinitum.
In this mode there are about 47 kmemleaks per 10 minutes.
I also notice that the kmemleaks takes a while to be detected or
to die out. So there are state timers involved that hold on to
the memory and after time out do not free it.
And another thing I noticed: When the pc and the steam machine
had a working rport, after a while the steam machine (4.16
unpatched) fc_timedout the rports to all nodes (so all nodes with
kernel < 4.14 too), and all with different timeouts, except the
one it has an fc_transport with.
So it's sole remaining rport was the "designated" target.
Currently I am compiling 4.9 with kmemleak to determine if that
exhibits the same leaks when disconnecting and reconnecting the
FCoE vlan.
This to determine if we have a single regression in just the
login handling or both.
I will add the dmesg's of a working rport, and a failing rport
later.

Regards,
Ard

-- 
.signature not found
