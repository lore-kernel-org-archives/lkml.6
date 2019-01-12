Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C771A20878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfALAKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:10:25 -0500
Received: from sdaoden.eu ([217.144.132.164]:43546 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfALAKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:10:25 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2019 19:10:23 EST
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 94B181604A; Sat, 12 Jan 2019 01:05:12 +0100 (CET)
Date:   Sat, 12 Jan 2019 01:05:17 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: 4.19.{12,[13],14}: RIP:
 0010:nf_conncount_cache_free+0x26/0x2f [nf_conncount]
Message-ID: <20190112000517.nQ-CW%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.11-134-gcc46cfe8
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

this is my first post to a Linux list, and i am not subscribed.

  [Used it from 01-11-1999 to about 2001, then happily went to
  FreeBSD.  ^_^  But Linux again since 2015, on bare metal since
  last October/November.
  Many thanks -- working Unix/POSIX on a Laptop.  Fantastic
  improvements on the documentation side, and upsetting
  technologies wherever i look and as far as i can penetrate that,
  sched, namespaces, filesystems ..  Grazy!

  At the moment i am running AlpineLinux [edge] on both rented
  Linux VM and Lpatop(s).  (Note well: i love CRUX Linux!)]

They have updated from flawless 4.14.xx to 4.19.xx series in
December.  I went with 4.19.12, but after some hours there were
problems, the first time the server VM got completely stuck and
i had to force a hard shutdown -- the first in 606 days.
In the following twelve hours i saw two automatic reboots, i went
back to 4.14.89.

4.19.13: i saw announcement with nothing mentioned, went to the
net stuff git repo and saw some commits mid december which could
address the problem of 4.19.12

  Dec 28 12:20:48 kernel: [34107.761146] RIP: 0010:__list_del_entry_valid+0x7f/0x86

(conn_free+0x36/0x86 [nf_conncount]), so i decided to wait for
4.19.14.  Today it came in, but after exactly 10 hours this:

crit:
  Jan 12 00:15:00 kernel: [36690.017115] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
warn:
  Jan 12 00:15:00 kernel: [36690.023028] Oops: 0000 [#1] SMP PTI
  Jan 12 00:15:00 kernel: [36690.024368] CPU: 0 PID: 3708 Comm: iptables Not tainted 4.19.14-0-vanilla #1-Alpine
  Jan 12 00:15:00 kernel: [36690.025679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Jan 12 00:15:00 kernel: [36690.027056] RIP: 0010:nf_conncount_cache_free+0x26/0p
messages:
  Jan 12 00:15:00 crond[2046]: USER root pid 3677 cmd run-parts /etc/periodic/12hourly
  Jan 12 00:15:00 kernel: [36690.021645] PGD 0 P4D 0

That periodic script outputs sort(1)ed entries from xt_recent, and
shows the state of the firewall.  Here is the full warn entry:

  Jan 12 00:15:00 kernel: [36690.023028] Oops: 0000 [#1] SMP PTI
  Jan 12 00:15:00 kernel: [36690.024368] CPU: 0 PID: 3708 Comm: iptables Not tainted 4.19.14-0-vanilla #1-Alpine
  Jan 12 00:15:00 kernel: [36690.025679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
  Jan 12 00:15:00 kernel: [36690.027056] RIP: 0010:nf_conncount_cache_free+0x26/0x2f [nf_conncount]
  Jan 12 00:15:00 kernel: [36690.028459] Code: 19 9f c5 ed 66 66 66 66 90 55 53 48 8b 77 08 48 8d 5f 08 48 8b 2e 48 39 de 74 15 48 8b 3d 05 20 00 00 e8 f6 9e c5 ed 48 89 ee <48> 8b 6d 00 eb e6 5b 5d c3 66 66 66 66 90 41 55 41 54 55 53 83 7f
  Jan 12 00:15:00 kernel: [36690.030482] RSP: 0018:ffffb5f5c055fd28 EFLAGS: 00010202
  Jan 12 00:15:00 kernel: [36690.031411] RAX: ffff9c3bf96b4c01 RBX: ffff9c3bf7c7e680 RCX: 00000000802e002c
  Jan 12 00:15:00 kernel: [36690.032376] RDX: 00000000802e002d RSI: 0000000000000000 RDI: ffff9c3bfbc17080
  Jan 12 00:15:00 kernel: [36690.033374] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff9c3bfb5028a8
  Jan 12 00:15:00 kernel: [36690.034372] R10: 0000000000000401 R11: ffffb5f5c0374001 R12: ffff9c3bf7c7e660
  Jan 12 00:15:00 kernel: [36690.035374] R13: ffff9c3bf5eb1808 R14: ffffffffaeea3e40 R15: ffff9c3bf96fa118
  Jan 12 00:15:00 kernel: [36690.036406] FS:  00007f9ca8e25b68(0000) GS:ffff9c3bfc200000(0000) knlGS:0000000000000000
  Jan 12 00:15:00 kernel: [36690.037472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  Jan 12 00:15:00 kernel: [36690.038532] CR2: 0000000000000000 CR3: 0000000079ae0000 CR4: 00000000000006b0
  Jan 12 00:15:00 kernel: [36690.039628] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  Jan 12 00:15:00 kernel: [36690.040724] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Jan 12 00:15:00 kernel: [36690.041791] Call Trace:
  Jan 12 00:15:00 kernel: [36690.042919]  nf_conncount_destroy+0x5a/0x82 [nf_conncount]
  Jan 12 00:15:00 kernel: [36690.044035]  cleanup_match+0x45/0x6d [ip_tables]
  Jan 12 00:15:00 kernel: [36690.045175]  cleanup_entry+0x3e/0xa8 [ip_tables]
  Jan 12 00:15:00 kernel: [36690.046305]  __do_replace+0x171/0x203 [ip_tables]
  Jan 12 00:15:00 kernel: [36690.047421]  do_ipt_set_ctl+0x133/0x195 [ip_tables]
  Jan 12 00:15:00 kernel: [36690.048643]  nf_setsockopt+0x4b/0x64
  Jan 12 00:15:00 kernel: [36690.049809]  __sys_setsockopt+0x8b/0xc1
  Jan 12 00:15:00 kernel: [36690.050957]  __x64_sys_setsockopt+0x20/0x23
  Jan 12 00:15:00 kernel: [36690.052110]  do_syscall_64+0x55/0xe4
  Jan 12 00:15:00 kernel: [36690.053329]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
  Jan 12 00:15:00 kernel: [36690.054516] RIP: 0033:0x7f9ca8dd08d3
  Jan 12 00:15:00 kernel: [36690.055666] Code: 83 c4 18 48 89 c7 e9 0c 3b fe ff c3 c3 31 c0 c3 49 89 ca 50 48 63 d2 48 63 f6 48 63 ff 45 89 c0 45 31 c9 b8 36 00 00 00 0f 05 <48> 89 c7 e8 e5 3a fe ff 5a c3 48 63 f6 50 48 63 ff 45 31 d2 45 31
  Jan 12 00:15:00 kernel: [36690.058146] RSP: 002b:00007fff0c384370 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
  Jan 12 00:15:00 kernel: [36690.059415] RAX: ffffffffffffffda RBX: 0000555df0249f40 RCX: 00007f9ca8dd08d3
  Jan 12 00:15:00 kernel: [36690.060754] RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000004
  Jan 12 00:15:00 kernel: [36690.062089] RBP: 0000555df0251b60 R08: 00000000000073d0 R09: 0000000000000000
  Jan 12 00:15:00 kernel: [36690.063405] R10: 0000555df0249f40 R11: 0000000000000246 R12: 00007f9ca8d937a0
  Jan 12 00:15:00 kernel: [36690.064755] R13: 0000555df0251260 R14: 00007f9ca8d937a8 R15: 0000000000000082
  Jan 12 00:15:00 kernel: [36690.066146] Modules linked in: tcp_diag udp_diag inet_diag unix_diag af_packet_diag sch_sfq sch_htb xt_connlimit nf_conncount nf_log_ipv4 nf_log_common xt_LOG xt_recent xt_limit ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_CLASSIFY
  Jan 12 00:15:00 kernel: [36690.077301]  mbcache jbd2 usb_storage usbcore sd_mod scsi_mod
  Jan 12 00:15:00 kernel: [36690.079009] CR2: 0000000000000000
  Jan 12 00:15:00 kernel: [36690.080724] ---[ end trace 594a84d5b5df9f19 ]---
  Jan 12 00:15:00 kernel: [36690.082415] RIP: 0010:nf_conncount_cache_free+0x26/0x2f [nf_conncount]
  Jan 12 00:15:00 kernel: [36690.084055] Code: 19 9f c5 ed 66 66 66 66 90 55 53 48 8b 77 08 48 8d 5f 08 48 8b 2e 48 39 de 74 15 48 8b 3d 05 20 00 00 e8 f6 9e c5 ed 48 89 ee <48> 8b 6d 00 eb e6 5b 5d c3 66 66 66 66 90 41 55 41 54 55 53 83 7f
  Jan 12 00:15:00 kernel: [36690.087424] RSP: 0018:ffffb5f5c055fd28 EFLAGS: 00010202
  Jan 12 00:15:00 kernel: [36690.089106] RAX: ffff9c3bf96b4c01 RBX: ffff9c3bf7c7e680 RCX: 00000000802e002c
  Jan 12 00:15:00 kernel: [36690.090786] RDX: 00000000802e002d RSI: 0000000000000000 RDI: ffff9c3bfbc17080
  Jan 12 00:15:00 kernel: [36690.092422] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff9c3bfb5028a8
  Jan 12 00:15:00 kernel: [36690.094056] R10: 0000000000000401 R11: ffffb5f5c0374001 R12: ffff9c3bf7c7e660
  Jan 12 00:15:00 kernel: [36690.095673] R13: ffff9c3bf5eb1808 R14: ffffffffaeea3e40 R15: ffff9c3bf96fa118
  Jan 12 00:15:00 kernel: [36690.097295] FS:  00007f9ca8e25b68(0000) GS:ffff9c3bfc200000(0000) knlGS:0000000000000000
  Jan 12 00:15:00 kernel: [36690.098911] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  Jan 12 00:15:00 kernel: [36690.100513] CR2: 0000000000000000 CR3: 0000000079ae0000 CR4: 00000000000006b0
  Jan 12 00:15:00 kernel: [36690.102189] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  Jan 12 00:15:00 kernel: [36690.103828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

I have reverted to 4.14.89 again.
Ciao from Germany, and thanks again!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
