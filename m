Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDST0l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:26:41 -0400
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:51203 "EHLO
        cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752558AbeDST0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:26:40 -0400
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=;e3=0(e1=10;e3=10;e2=00);EVW:White;BM:KPN.E
        mailWasstraat.ScanProcessingSink.Scanning.MailScanResultSet;FinalVerdi
        ct:Clean
X-Brightmail-Tracker: H4sIAAAAAAAAC+NgFjrPKsWRWlGSWpSXmKPExsVyuJKZRTfh
        1Y0og4YVuxIsLu+aw+bA6PF5k1wAYxRrZl5SfkUCa8b8vs1MBW94KvrP3GZqYOzi6mLk4p
        AQOMQocbRjE3sXIyeQoy6x5MtJRpCEkMBSRomJH7sYQRLMAvISHZcbWSFsHYkFuz+xgRSx
        CHQySyyY/pENojtTYtHL5SwQ3dsZJfaf6wdLsAkoS+x88wbMFhFQkNjc+wxskrCAosShbf
        NYQGwWAVWJCYcvgdm8AhoSzz8eBjuJX0BKYs+jL4wQcUGJkzOfgNUICchKfF13EersYInZ
        U/YxTWAUnIXk2FlIjp2FpH0BI/MqRonkguKCYt3U8mJDQ73sgjwgQy8nPzkxZxMjMDivem
        vY7mD82hd7iNGUg0lJlPfY5BtRQnxJ+SmVGYnFGfFFpTmpxUpSvHs2OEQJCcOFi0uTcjOL
        izPz8w4xWnNwKEnwGr0E6hMsSk1PrUjLzAHGF1SrLK9wj16kkBiyDLJuYw4eJRFeFpBu3u
        KCxNzizHSoTkmITiGYKELXKUZ7KXHeVJAeAZBsRmke3EIpGV7N5qtRQqJIEgidoBQ0scXg
        2C1GPiGWvPy8VCmowCtGQw5GJWHeMJChPJl5JQh3SPBKCZ0H+g0qiDDsFdDxTEDHG6iAHV
        +SWILF8VBRhC6pBka+TOV/2b0inn2V4kGvX9y4HtW2e+1fpWczzl2+p126qPSJ4cRyOeNn
        dlxG0beTT4ituv3NZo6ideN3811+a/a+i97qzGUtZpJbPv+x0v+tRjOe3HsREpSrEnmWZX
        GuVX5ebN47yZh+tWezbDbKnbW9f//Qbe/32TdTOWq2SxfHKE5b+7ORvVKJpTgj0VCLuag4
        EQBojnonYgMAAA==
X-CMAE-Analysis: v=2.3 cv=RMad4bq+ c=1 sm=1 tr=0 a=LzU8FWS6tX6H791gvgu
        rLw==:117 a=WlLoZYvoDPkrvwfrrc3pQQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdev
        IA:10 a=ZfNxyw7ZWojhWlxPhXkA:9 a=CjuIK1q_8ugA:10
X-CM-AcctID: kpn@feedback.cloudmark.com
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMASSUN: 33|kFZpDlyPvQv+CRdOa0tbFSs6UByXXETINYBAIxDGG800CkmHl/TOud064lFouP/d
        NNMa8MmTdrZgCMo6ndLZIw==
From: Ferry Toth <ftoth@telfort.nl>
To: linux-kernel@vger.kernel.org
Subject: DOS by unprivileged user
Date: Thu, 19 Apr 2018 21:13:35 +0200
Message-ID: <9023506.UBh6vynRGa@delfion>
Organization: Exalon Delft
MIME-Version: 1.0
X-OriginalArrivalTime: 19 Apr 2018 19:13:35.0976 (UTC) FILETIME=[84044680:01D3D812]
X-RcptDomain: vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears any ordinary user can easily create a DOS on linux.

One sure way to reproduce this is to open gitk on the linux kernel repo 
(SIC) on a machine with 8GB RAM 16 GB swap on a HDD with btrfs and quad core 
+ hyperthreading. But I will be easy enough to get the same effect with more 
RAM, other fs etc.

In this case gitk allocates more and more memory (until my system freezes 
6.5GB of 7.5GB avaiable), the system starts swapping or writing to tmp files 
(can't investigate as there is no time until it freezes) and the io wait 
goes to 100% on all cores. At this point it is impossible to login from 
remote and local keyboard and mouse are frozen. Hard reset is the only way 
out at this point.

IMHO there is something wrong in how the kernel hands out resources, in this 
case memory, CPU time and disk accesses. It should be easily measurable that 
a single application is allocating all memory and consequently all CPU time 
is spent in io wait. I'm pretty sure that if the kernel would stop or reduce 
allocating CPU time to the hogging (user) process causing excessive io wait, 
the machine would continue just fine. And probably a single process should 
not even be allowed to allocate this amount of memory. Or at least should 
not force other applications to get swapped out.

In effect gitk should have beeb forced to run slow or be killed off (which 
doesn't happen because probably the kernel itself doesn't receive enough CPU 
time).

As a positive side effect maybe someone would dig into gitk and make it less 
memory hungry (qgit is half as hungry, still a lot).

-- 
Ferry Toth
