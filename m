Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA4FC6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCAA20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCAA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ2KSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:18:43 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:26562 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbeJ2KSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:18:43 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 29 Oct 2018 11:51:00 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gGwEl-0003YU-1M; Mon, 29 Oct 2018 12:20:59 +1100
Date:   Mon, 29 Oct 2018 12:20:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: XFS: Hang and dmesg flood on mounting invalid FS image
Message-ID: <20181029012058.GK19305@dastard>
References: <CAE5jQCc3hrq6E-Ff1oiYUOSDA08PMrqnu80XQtaD5adcUQvV8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCc3hrq6E-Ff1oiYUOSDA08PMrqnu80XQtaD5adcUQvV8w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 08:50:46PM +0300, Anatoly Trosinenko wrote:
> Hello,
> 
> When mounting a broken XFS image, the kernel hangs and floods dmesg
> with stack traces.

How did the corruption occur?

$ sudo xfs_logprint -d /dev/vdc
xfs_logprint:
    data device: 0xfd20
    log device: 0xfd20 daddr: 131112 length: 6840

     0 HEADER Cycle 1 tail 1:000000 len    512 ops 1
[00000 - 00000] Cycle 0xffffffff New Cycle 0x00000001
     2 HEADER Cycle 1 tail 1:000002 len    512 ops 5
     4 HEADER Cycle 1 tail -2147483647:000002 len    512 ops 1
                           ^^^^^^^^^^^^
     6 HEADER Cycle 0 tail 1:000000 len      0 ops 0
[00000 - 00006] Cycle 0x00000001 New Cycle 0x00000000
     7 HEADER Cycle 0 tail 1:000000 len      0 ops 0

Ok, so from this the head of the log is block 4, and it has a
corrupt tail pointer it points to:


$ sudo xfs_logprint -D -s 4 /dev/vdc |head -10
xfs_logprint:
    data device: 0xfd20
    log device: 0xfd20 daddr: 131112 length: 6840

BLKNO: 4
 0 bebaedfe  1000000  2000000    20000  1000000  3610000  1000080  2000000 
                                                 ^^^^^^^       ^   ^
						 wrong       wrong wrong

 8 2f27bae6  2000000  1000000 dabdbab0        0        0        0        0 
10        0        0        0        0        0        0        0        0 
18        0        0        0        0        0        0        0        0 
20        0        0        0        0        0        0        0        0 

They decode as:

cycle: 1        version: 2              lsn: 1,24835    tail_lsn: 2147483649,2

So the tail LSN points to an invalid log cycle and the previous
block. IOWs, the block number in the tail indicates the whole log is
valid and needs to be scanned. but the cycle is not valid.

And that's the problem. Neither the head or tail blocks are
validated before they are used. CRC checking of the head and tail
blocks comes later....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
