Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7AFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C4821EF9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C4821EF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeGFTMV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:12:21 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:33519 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932751AbeGFTMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:12:20 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 85F999001F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 22:12:15 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 610B22206AD; Fri,  6 Jul 2018 22:12:13 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 59670220307
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jul 2018 22:12:13 +0300 (EEST)
Date:   Fri, 6 Jul 2018 22:12:13 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: UBSAN: Undefined behaviour in lib/percpu_counter.c:92:14
Message-ID: <alpine.LRH.2.21.1807062210100.21056@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is on a AMD Athlon64 X2 compiling kernel with make -2:

[91550.438790] ================================================================================
[91550.438832] UBSAN: Undefined behaviour in lib/percpu_counter.c:92:14
[91550.438862] signed integer overflow:
[91550.438888] 91550438785688 + 9223336756968817285 cannot be represented in type 'long long int'
[91550.438923] CPU: 0 PID: 8875 Comm: cc1 Not tainted 4.18.0-rc3-00113-gfc36def997cf #11
[91550.438924] Hardware name: HP-Pavilion RT589AA-ABU t3709.uk/Nance, BIOS 5.02 11/26/2006
[91550.438924] Call Trace:
[91550.438929]  <IRQ>
[91550.438937]  dump_stack+0x5a/0x9b
[91550.438941]  ubsan_epilogue+0x9/0x40
[91550.438944]  handle_overflow+0xf2/0x100
[91550.438946]  percpu_counter_add_batch+0xfb/0x120
[91550.438949]  cfq_completed_request+0x320/0xb00
[91550.438953]  __blk_put_request+0x15d/0x390
[91550.438957]  scsi_end_request+0x154/0x370
[91550.438960]  scsi_io_completion+0x603/0x9e0
[91550.438963]  blk_done_softirq+0xe6/0x1c0
[91550.438967]  __do_softirq+0x118/0x414
[91550.438970]  irq_exit+0xa2/0xd0
[91550.438972]  do_IRQ+0xac/0x160
[91550.438974]  common_interrupt+0xf/0xf
[91550.438976]  </IRQ>
[91550.438978] RIP: 0033:0x7f54e89631b7
[91550.438979] Code: 83 f9 02 48 0f 47 cf 83 c1 7c e9 a9 fa ff ff 4c 8b 41 08 4c 89 c2 48 83 e2 f8 48 39 d3 0f 87 fb 00 00 00 48 8d 3c 11 48 8b 07 <48> 39 d0 0f 85 35 01 00 00 48 8b 51 10 48 8b 71 18 48 39 4a 18 0f 
[91550.439006] RSP: 002b:00007ffc7398a470 EFLAGS: 00000287 ORIG_RAX: ffffffffffffffde
[91550.439007] RAX: 00000000000002a0 RBX: 0000000000000060 RCX: 0000000003311380
[91550.439009] RDX: 00000000000002a0 RSI: 00007f54e8c96f30 RDI: 0000000003311620
[91550.439010] RBP: 0000000000000004 R08: 00000000000002a1 R09: 00007f54e8c96cb0
[91550.439011] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[91550.439012] R13: 00007f54e8c96c40 R14: 0000000002e3b010 R15: 00007f54e8c96ca0
[91550.439013] ================================================================================


-- 
Meelis Roos (mroos@linux.ee)
