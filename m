Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70C820863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="YBm+C6Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfBHS2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:28:16 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:38828 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0oZ8OxPWb9b7WAjQEi4rGHFJVzAGMBwpjJs52ScK25g=; b=YBm+C6BpRT/olr4FeT0gT/yUP8
        MjnV1KrAbTVbOf4im2XMr9ikjri4aFlKFvrVw+exGt6BWUUVXZ/qaI/75Gbg7Aq+DDakWiPOZK4jC
        NNP+Yfef3Z0GC4vtYqaVxKRlge1qNO1cB98sKqgX6z/E8uPVikShApgHB3XBKC4EauUE=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:55180 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1gsAsw-0004fp-O5; Fri, 08 Feb 2019 19:28:22 +0100
To:     Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Subject: Linux 5.0 regression: rtl8169 / kernel BUG at
 lib/dynamic_queue_limits.c:27!
Message-ID: <6c389fde-4c8d-300b-8c3c-300d6105c30a@eikelenboom.it>
Date:   Fri, 8 Feb 2019 19:29:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,

While testing a linux 5.0-rc5 kernel (with some patches on top but they don't seem related) under Xen i the nasty splat below, 
that I haven encountered with Linux 4.20.x.

Unfortunately I haven't got a clear reproducer for this and bisecting could be nasty due to another (networking related) kernel bug.

If you need more info, want me to run a debug patch etc., please feel free to ask.

--
Sander


[ 6466.554866] kernel BUG at lib/dynamic_queue_limits.c:27!
[ 6466.571425] invalid opcode: 0000 [#1] SMP NOPTI
[ 6466.585890] CPU: 3 PID: 7057 Comm: as Not tainted 5.0.0-rc5-20190208-thp-net-florian-doflr+ #1
[ 6466.598693] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
[ 6466.611579] RIP: e030:dql_completed+0x126/0x140
[ 6466.624339] Code: 2b 47 54 ba 00 00 00 00 c7 47 54 ff ff ff ff 0f 48 c2 48 8b 15 7b 39 4a 01 48 89 57 58 e9 48 ff ff ff 44 89 c0 e9 40 ff ff ff <0f> 0b 8b 47 50 29 e8 41 0f 48 c3 eb 9f 90 90 90 90 90 90 90 90 90
[ 6466.648130] RSP: e02b:ffff88807d4c3e78 EFLAGS: 00010297
[ 6466.659616] RAX: 0000000000000042 RBX: ffff8880049cf800 RCX: 0000000000000000
[ 6466.672835] RDX: 0000000000000001 RSI: 0000000000000042 RDI: ffff8880049cf8c0
[ 6466.684521] RBP: ffff888077df7260 R08: 0000000000000001 R09: 0000000000000000
[ 6466.696824] R10: 00000000387c2336 R11: 00000000387c2336 R12: 0000000010000000
[ 6466.709953] R13: ffff888077df6898 R14: ffff888077df75c0 R15: 0000000000454677
[ 6466.722165] FS:  00007fd869147200(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
[ 6466.733228] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6466.746581] CR2: 00007fd867dfd000 CR3: 0000000074884000 CR4: 0000000000000660
[ 6466.758366] Call Trace:
[ 6466.768118]  <IRQ>
[ 6466.778214]  rtl8169_poll+0x4f4/0x640
[ 6466.789198]  net_rx_action+0x23d/0x370
[ 6466.798467]  __do_softirq+0xed/0x229
[ 6466.807039]  irq_exit+0xb7/0xc0
[ 6466.815471]  xen_evtchn_do_upcall+0x27/0x40
[ 6466.826647]  xen_do_hypervisor_callback+0x29/0x40
[ 6466.835902]  </IRQ>
[ 6466.845361] RIP: e030:xen_hypercall_mmu_update+0xa/0x20
[ 6466.853390] Code: 51 41 53 b8 00 00 00 00 0f 05 41 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 51 41 53 b8 01 00 00 00 0f 05 <41> 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[ 6466.874031] RSP: e02b:ffffc90003c0bdd0 EFLAGS: 00000246
[ 6466.883452] RAX: 0000000000000000 RBX: 000000041f83bfe8 RCX: ffffffff8100102a
[ 6466.891986] RDX: deadbeefdeadf00d RSI: deadbeefdeadf00d RDI: deadbeefdeadf00d
[ 6466.903402] RBP: 0000000000000fe8 R08: 000000000000000b R09: 0000000000000000
[ 6466.911201] R10: deadbeefdeadf00d R11: 0000000000000246 R12: 800000050c346067
[ 6466.918491] R13: ffff8880607c4fe8 R14: ffff888005082800 R15: 0000000000000000
[ 6466.926647]  ? xen_hypercall_mmu_update+0xa/0x20
[ 6466.938195]  ? xen_set_pte_at+0x78/0xe0
[ 6466.947046]  ? __handle_mm_fault+0xc43/0x1060
[ 6466.955772]  ? do_mmap+0x44b/0x5b0
[ 6466.964410]  ? handle_mm_fault+0xf8/0x200
[ 6466.973290]  ? __do_page_fault+0x231/0x4a0
[ 6466.981973]  ? page_fault+0x8/0x30
[ 6466.990904]  ? page_fault+0x1e/0x30
[ 6466.999585] Modules linked in:
[ 6467.007533] ---[ end trace 94bec01608fe4061 ]---
[ 6467.016751] RIP: e030:dql_completed+0x126/0x140
[ 6467.024271] Code: 2b 47 54 ba 00 00 00 00 c7 47 54 ff ff ff ff 0f 48 c2 48 8b 15 7b 39 4a 01 48 89 57 58 e9 48 ff ff ff 44 89 c0 e9 40 ff ff ff <0f> 0b 8b 47 50 29 e8 41 0f 48 c3 eb 9f 90 90 90 90 90 90 90 90 90
[ 6467.039726] RSP: e02b:ffff88807d4c3e78 EFLAGS: 00010297
[ 6467.047243] RAX: 0000000000000042 RBX: ffff8880049cf800 RCX: 0000000000000000
[ 6467.054202] RDX: 0000000000000001 RSI: 0000000000000042 RDI: ffff8880049cf8c0
[ 6467.062000] RBP: ffff888077df7260 R08: 0000000000000001 R09: 0000000000000000
[ 6467.069664] R10: 00000000387c2336 R11: 00000000387c2336 R12: 0000000010000000
[ 6467.077715] R13: ffff888077df6898 R14: ffff888077df75c0 R15: 0000000000454677
[ 6467.084916] FS:  00007fd869147200(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
[ 6467.093352] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6467.101492] CR2: 00007fd867dfd000 CR3: 0000000074884000 CR4: 0000000000000660
[ 6467.110542] Kernel panic - not syncing: Fatal exception in interrupt
[ 6467.118166] Kernel Offset: disabled
(XEN) [2019-02-08 18:04:48.854] Hardware Dom0 crashed: rebooting machine in 5 seconds.
