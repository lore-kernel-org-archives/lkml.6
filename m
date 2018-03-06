Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeCFQ6q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:58:46 -0500
Received: from cmta16.telus.net ([209.171.16.89]:58857 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbeCFQ6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:58:44 -0500
X-Authority-Analysis: v=2.2 cv=EJrp6xRC c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=9oqwl-f-OR4gXzqXwRMA:9
 a=CjuIK1q_8ugA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: sc97eXGePpApssc9CeDAYz
In-Reply-To: sc97eXGePpApssc9CeDAYz
Subject: RE: [RFC/RFT][PATCH 0/7] sched/cpuidle: Idle loop rework
Date: Tue, 6 Mar 2018 08:50:30 -0800
Message-ID: <000a01d3b56b$3fd8b050$bf8a10f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO0CGa4JO6iVqXPSJGY/c8kVHh+IAAyl8Gg
X-CMAE-Envelope: MS4wfNYFIA5RXduOh5zOoJdpqsD8SIvXJ50IawsedfGS5fsGdDXE22zoF0Zgi7iRneZTnHOXBLPMlCWk6PzITUv7CCqPbuvg1jzaX4qULBev4msdFsx539VL
 d++gKECSHtTBtiL9Nj46gRx6K/TzAzRY6vIuX1R7MP13HsQUAO84HmbO0xY91N5Fd487Ur0NQlfx5GUKhWLyPBk82C/L8VpIObYemT1qi5Ov6AVhq2uDJrhu
 FcBavgh0mxuWQxjcnQrfc+V4OoiSDrIWQPDrzA06CSnNvmHxxj3V3bntoaqcJr8Z7uz3ARq6NFTpSiVHgan1U6IE5QMQXNVXKQaA1btreg8Axya/NjJnbB3+
 ixzCg762T+s28GluEvbjePYHm27GGYblCG2DkmvnUvsh2+oZXSM2ZgEaDiANj/XCDDtxfV42titIvV/1AVmvcDLZFl82UTs0sUTtM5r1Sr3nNpBQXTey6gwm
 5bKWHQBtkRdLzhFEGUtG9kZHmH6CsQRVp1EbQjvwRZIouTnDISRZS3UEnH8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.04 14:22 Rafael J. Wysocki wrote:

...[snip]...

> I have tested these patches on a couple of machines, including the very laptop
> I'm sending them from, without any obvious issues, but please give them a go
> if you can, especially if you have an easy way to reproduce the problem they
> are targeting.  The patches are on top of 4.16-rc3 (if you need a git branch
> with them for easier testing, please let me know).

I am having some troubles with the patch set.
My test server takes anywhere between nominal (about 30 seconds) and 10X nominal
(about 5 minutes) time to boot.
I have booted 5 times:

1. took about 5 minutes to boot. No test data acquired. Kern.log excerpt:
	[    5.760740] Btrfs loaded, crc32c=crc32c-intel
	[    5.779522] random: crng init done
	[  336.185559] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
	[  346.823627] Loading iSCSI transport class v2.0-870.

2. took about 5 minutes to boot. Minimal test data acquired. Kern.log excerpt:
	[    8.963959] async_tx: api initialized (async)
	[    9.001124] Btrfs loaded, crc32c=crc32c-intel
	[    9.024652] random: crng init done
	[  332.768025] clocksource: timekeeping watchdog on
			 CPU3: Marking clocksource 'tsc' as unstable because the
			 skew is too large:
	[  332.768128] clocksource: 'hpet' wd_now: 1c082869 wd_last:
			 a5053b0 mask: ffffffff
	[  332.768129] clocksource: 'tsc' cs_now: 11a0d3a34be cs_last:
			 1b534f1252 mask: ffffffffffffffff
	[  332.768129] tsc: Marking TSC unstable due to clocksource watchdog
	[  332.768145] TSC found unstable after boot, most likely due to
			 broken BIOS. Use 'tsc=unstable'.	

	Observe 25.14 average processor package watts. 100% load on CPU 7.
	Test Duration 2.5 hours.
	Reference: K4.16-rc3: Not done yet.
	Reference: K4.15-rc1: 27.34 Watts
	Reference: K4.15-rc1, idle states 0-3 disabled: 23.92 Watts
	Reference: This kernel, idle states 0-3 disabled: ~23.65 Watts

3. crashed during boot. No useful log info.

4. booted kernel 4.16-rc3 stock. Booted normally in about 30 seconds.

5. took about 30 seconds to boot. Minimal test data acquired.
	Observe 24.77 average processor package watts. 100% load on CPU 7.
	Test duration 15 hours. Peak power 32.8 watts.
	There is a graph. I'll send it off-list.

Oh, I see a version 2 of the patch set. I'll move on to version 2.

... Doug
