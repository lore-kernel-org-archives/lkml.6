Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B96BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1220989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="k45yqU3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A1220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeIXCOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 22:14:05 -0400
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:59330 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbeIXCOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 22:14:04 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2018 22:14:04 EDT
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-07v.sys.comcast.net with ESMTP
        id 4AZsgrm3dUrSz4AevgRNy0; Sun, 23 Sep 2018 20:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1537733233;
        bh=Vx+vVy51q1uYYJoVugwEZ/l1+Y/GiuJQwJvsXkQZF1A=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=k45yqU3VUG4QGzVQthAH4MeHpAFqT6Hv5Ayc2gl4f8qN5MNWdlpWJTa2inVA1Is9Y
         QVi6UA7NlfyZKF8S47pJQI9snPSL9MzpbaZtXtnTCXSbcly+9wN5d9EmsrU3Na1mda
         9jpRoVH0uMEN+wdAg+s0bOSJD9axb/WZsQO3FAdM4lfVVF0JM354wlG8YITnZk60ww
         Bjg1Ef06PXlslreFsPzIgdU6A4oNT0b+cahtNFumnqt6mWPKABtWe3jlzyaZEIx8/6
         2kBSc5zEiZjsKdT6zbHVcVJa4XvnNjzgUkKT2va7dOIliTHAnlAxjBnFFK47q5/6F9
         +WkrGpefy11kQ==
Received: from [10.1.10.100] ([73.214.254.59])
        by resomta-ch2-17v.sys.comcast.net with ESMTPSA
        id 4AeuggYwvvmOM4AeugE2HS; Sun, 23 Sep 2018 20:07:12 +0000
To:     linux-kernel@vger.kernel.org
From:   Rob Prowel <rprowel@comcast.net>
Subject: AMD Athlon bogus performance value causing RCU stalls?
Message-ID: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net>
Date:   Sun, 23 Sep 2018 16:07:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP0xrToatYGHXqcHYGMfEP4wmzPobztP3Ujr7sH6OD6QBsVlOq2k05l9UPlOjEwKR2FD2oxICbODfPtzqh9WFe/EGfSowTGEPfh8wXIex/jaIUKHERBF
 j34fwAyPm28OuO23dFESIBi3Qsh4pCxbYv54vULv0KNFgvqcIrBVIw8Af+G2YYE7mUEedru2w5hy9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please CC me on comments.

I'm seeing a lot of these errors on my dual core fileserver:
-----------------------------------------------------------------------

Sep 23 01:51:28 files kernel: INFO: rcu_sched detected stalls on CPUs/tasks:
Sep 23 01:51:28 files kernel:         1-...!: (0 ticks this GP) idle=27c/0/0 softirq=35425/35425 fqs=0
Sep 23 01:51:28 files kernel:         (detected by 0, t=60009 jiffies, g=20812, c=20811, q=121)
Sep 23 01:51:28 files kernel: Sending NMI from CPU 0 to CPUs 1:
Sep 23 01:51:28 files kernel: NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x2/0x10
Sep 23 01:51:28 files kernel: rcu_sched kthread starved for 60009 jiffies! g20812 c20811 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
Sep 23 01:51:28 files kernel: RCU grace-period kthread stack dump:
Sep 23 01:51:28 files kernel: rcu_sched       I    0    10      2 0x80000000
Sep 23 01:51:33 files kernel: Call Trace:
Sep 23 01:51:33 files kernel:  ? __schedule+0x25c/0x860
Sep 23 01:51:33 files kernel:  schedule+0x28/0x80
Sep 23 01:51:33 files kernel:  schedule_timeout+0x174/0x370
Sep 23 01:51:33 files kernel:  ? __next_timer_interrupt+0xc0/0xc0
Sep 23 01:51:33 files kernel:  rcu_gp_kthread+0x4b6/0x8c0
Sep 23 01:51:33 files kernel:  ? _synchronize_rcu_expedited.constprop.68+0x310/0x310
Sep 23 01:51:33 files kernel:  kthread+0x113/0x130
Sep 23 01:51:33 files kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
Sep 23 01:51:33 files kernel:  ret_from_fork+0x35/0x40

-----------------------------------------------------------------------

The kernel reported bogoMIPS for the cores are as follows:

$ grep bogo /proc/cpuinfo
bogomips        : 4219.49
bogomips        : 184253.06
$

What is that value for the second Athlon core (seems extremely bogus), and would/could that be the reason for the schedule_timeouts?  This bogus value also shows up in the bootup log when the second core is activated.  Seems to be AMD specific, as the values are correct on my Xeon machines.

Kernel is a stock Fedora 4.18.7-100 release.  Machine is an old Dell Experion that I've repurposed as a fileserver and postgresql machine.

Other than RTFM, or please build a bunch of kernels from source on your slow machine, using differing config options to help track down the cause of this...any thoughts about a solution?


