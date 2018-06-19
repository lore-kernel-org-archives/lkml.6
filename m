Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728A4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24622208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24622208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966234AbeFSM6M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:58:12 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:37714 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965727AbeFSM6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:58:10 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 41A2E90015;
        Tue, 19 Jun 2018 15:58:08 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 2F5382205E1; Tue, 19 Jun 2018 15:58:06 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 383932205D1;
        Tue, 19 Jun 2018 15:58:06 +0300 (EEST)
Date:   Tue, 19 Jun 2018 15:58:06 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: iomi-si UBSAN warning and NULL pointer dereference
Message-ID: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 4.18.0-rc1-00043-gba4dbdedd3ed on HP Proliant Microserver N36L 
and got the follsing UBSAN warning + NULL pointer dereferences. It was 
working without any warnings in 4.17.0.

[    7.587532] ipmi message handler version 39.2
[    7.594899] ipmi device interface
[    7.605792] IPMI System Interface driver.
[    7.605949] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[    7.606047] ipmi_si: SMBIOS: mem 0x0 regsize 1 spacing 1 irq 0
[    7.606120] ipmi_si: Adding SMBIOS-specified kcs state machine
[    7.606326] ipmi_si: Trying SMBIOS-specified kcs state machine at mem address 0x0, slave address 0x20, irq 0
[    7.606463] ipmi_si dmi-ipmi-si.0: Could not set up I/O space
[    7.606534] ================================================================================
[    7.606629] UBSAN: Undefined behaviour in drivers/char/ipmi/ipmi_msghandler.c:3477:6
[    7.606722] member access within null pointer of type 'struct ipmi_smi'
[    7.606797] CPU: 1 PID: 1360 Comm: systemd-udevd Not tainted 4.18.0-rc1-00043-gba4dbdedd3ed #26
[    7.606892] Hardware name: HP ProLiant MicroServer, BIOS O41     10/01/2013
[    7.606962] Call Trace:
[    7.607042]  ? dump_stack+0x5a/0x9b
[    7.607116]  ? ubsan_epilogue+0x9/0x40
[    7.607188]  ? ubsan_type_mismatch_common+0x11f/0x1a0
[    7.607260]  ? __ubsan_handle_type_mismatch+0x3a/0x60
[    7.607337]  ? ipmi_unregister_smi+0x55c/0x570 [ipmi_msghandler]
[    7.607424]  ? try_smi_init+0xbaa/0x1ab5 [ipmi_si]
[    7.607509]  ? init_ipmi_si+0x158/0x240 [ipmi_si]
[    7.607590]  ? ipmi_si_add_smi+0x390/0x390 [ipmi_si]
[    7.607662]  ? do_one_initcall+0x58/0x230
[    7.607735]  ? kmem_cache_alloc+0x43/0x1f0
[    7.607807]  ? do_init_module+0xa7/0x2a9
[    7.607877]  ? load_module+0x1f40/0x3510
[    7.607947]  ? __symbol_put+0x80/0x80
[    7.608020]  ? kernel_read_file+0x229/0x3a0
[    7.608092]  ? __do_sys_finit_module+0xfa/0x120
[    7.608163]  ? do_syscall_64+0x5a/0x1e0
[    7.608233]  ? page_fault+0x8/0x30
[    7.608306]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    7.608376] ================================================================================
[    7.608503] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[    7.608600] PGD 0 P4D 0 
[    7.608672] Oops: 0000 [#1] SMP NOPTI
[    7.608743] CPU: 1 PID: 1360 Comm: systemd-udevd Not tainted 4.18.0-rc1-00043-gba4dbdedd3ed #26
[    7.608836] Hardware name: HP ProLiant MicroServer, BIOS O41     10/01/2013
[    7.608913] RIP: 0010:ipmi_unregister_smi+0x31/0x570 [ipmi_msghandler]
[    7.608982] Code: 54 55 48 89 fd 53 48 83 ec 30 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 48 85 ff 0f 84 24 05 00 00 48 c7 c7 c0 23 16 c0 <44> 8b 65 00 e8 a6 65 5c c2 48 83 fd f0 c7 45 00 ff ff ff ff c6 45 
[    7.609210] RSP: 0018:ffffa52c40227bb8 EFLAGS: 00010292
[    7.609281] RAX: 0000000000000000 RBX: ffff8e8e3b2df200 RCX: 0000000000000006
[    7.609352] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffffffffc01623c0
[    7.609424] RBP: 0000000000000000 R08: 0000000000000199 R09: 000000000000025a
[    7.609495] R10: ffffffff821bc0b0 R11: 0000000000000006 R12: ffffffffc0181aa8
[    7.609566] R13: 0000000000000000 R14: ffff8e8e3b2df240 R15: ffffffffc0181260
[    7.609640] FS:  00007fef3a80b8c0(0000) GS:ffff8e8e3dd00000(0000) knlGS:0000000000000000
[    7.609734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.609803] CR2: 0000000000000000 CR3: 000000003ab1a000 CR4: 00000000000006e0
[    7.609873] Call Trace:
[    7.609956]  ? try_smi_init+0xbaa/0x1ab5 [ipmi_si]
[    7.610040]  ? init_ipmi_si+0x158/0x240 [ipmi_si]
[    7.610121]  ? ipmi_si_add_smi+0x390/0x390 [ipmi_si]
[    7.610191]  ? do_one_initcall+0x58/0x230
[    7.610262]  ? kmem_cache_alloc+0x43/0x1f0
[    7.610333]  ? do_init_module+0xa7/0x2a9
[    7.610404]  ? load_module+0x1f40/0x3510
[    7.610475]  ? __symbol_put+0x80/0x80
[    7.610547]  ? kernel_read_file+0x229/0x3a0
[    7.610618]  ? __do_sys_finit_module+0xfa/0x120
[    7.610689]  ? do_syscall_64+0x5a/0x1e0
[    7.610759]  ? page_fault+0x8/0x30
[    7.610832]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    7.610902] Modules linked in: ipmi_si(+) ipmi_devintf ipmi_msghandler k10temp jc42 w83795 eeprom ip_tables
[    7.611014] CR2: 0000000000000000
[    7.611094] ---[ end trace 099b4ef2a90b74a1 ]---
[    7.611170] RIP: 0010:ipmi_unregister_smi+0x31/0x570 [ipmi_msghandler]
[    7.611239] Code: 54 55 48 89 fd 53 48 83 ec 30 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 48 85 ff 0f 84 24 05 00 00 48 c7 c7 c0 23 16 c0 <44> 8b 65 00 e8 a6 65 5c c2 48 83 fd f0 c7 45 00 ff ff ff ff c6 45 
[    7.611466] RSP: 0018:ffffa52c40227bb8 EFLAGS: 00010292
[    7.611537] RAX: 0000000000000000 RBX: ffff8e8e3b2df200 RCX: 0000000000000006
[    7.611609] RDX: 0000000000000000 RSI: 0000000000000202 RDI: ffffffffc01623c0
[    7.611680] RBP: 0000000000000000 R08: 0000000000000199 R09: 000000000000025a
[    7.611751] R10: ffffffff821bc0b0 R11: 0000000000000006 R12: ffffffffc0181aa8
[    7.611822] R13: 0000000000000000 R14: ffff8e8e3b2df240 R15: ffffffffc0181260
[    7.611894] FS:  00007fef3a80b8c0(0000) GS:ffff8e8e3dd00000(0000) knlGS:0000000000000000
[    7.611988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.612067] CR2: 0000000000000000 CR3: 000000003ab1a000 CR4: 00000000000006e0


-- 
Meelis Roos (mroos@linux.ee)
