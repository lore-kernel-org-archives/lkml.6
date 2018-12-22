Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060A02146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392403AbeLVRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:02 -0500
Received: from ozlabs.org ([203.11.71.1]:50987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388222AbeLVRBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:01 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSs1wdzz9sPT; Sat, 22 Dec 2018 20:54:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6bf752daca07c85c181159f75dcf65b12056883b
X-Patchwork-Hint: ignore
In-Reply-To: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3] powerpc: implement CONFIG_DEBUG_VIRTUAL
Message-Id: <43MLSs1wdzz9sPT@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:52 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 22:40:53 UTC, Christophe Leroy wrote:
> This patch implements CONFIG_DEBUG_VIRTUAL to warn about
> incorrect use of virt_to_phys() and page_to_phys()
> 
> Below is the result of test_debug_virtual:
> 
> [    1.438746] WARNING: CPU: 0 PID: 1 at ./arch/powerpc/include/asm/io.h:808 test_debug_virtual_init+0x3c/0xd4
> [    1.448156] CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0-rc5-00560-g6bfb52e23a00-dirty #532
> [    1.457259] NIP:  c066c550 LR: c0650ccc CTR: c066c514
> [    1.462257] REGS: c900bdb0 TRAP: 0700   Not tainted  (4.20.0-rc5-00560-g6bfb52e23a00-dirty)
> [    1.471184] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 48000422  XER: 20000000
> [    1.477811]
> [    1.477811] GPR00: c0650ccc c900be60 c60d0000 00000000 006000c0 c9000000 00009032 c7fa0020
> [    1.477811] GPR08: 00002400 00000001 09000000 00000000 c07b5d04 00000000 c00037d8 00000000
> [    1.477811] GPR16: 00000000 00000000 00000000 00000000 c0760000 c0740000 00000092 c0685bb0
> [    1.477811] GPR24: c065042c c068a734 c0685b8c 00000006 00000000 c0760000 c075c3c0 ffffffff
> [    1.512711] NIP [c066c550] test_debug_virtual_init+0x3c/0xd4
> [    1.518315] LR [c0650ccc] do_one_initcall+0x8c/0x1cc
> [    1.523163] Call Trace:
> [    1.525595] [c900be60] [c0567340] 0xc0567340 (unreliable)
> [    1.530954] [c900be90] [c0650ccc] do_one_initcall+0x8c/0x1cc
> [    1.536551] [c900bef0] [c0651000] kernel_init_freeable+0x1f4/0x2cc
> [    1.542658] [c900bf30] [c00037ec] kernel_init+0x14/0x110
> [    1.547913] [c900bf40] [c000e1d0] ret_from_kernel_thread+0x14/0x1c
> [    1.553971] Instruction dump:
> [    1.556909] 3ca50100 bfa10024 54a5000e 3fa0c076 7c0802a6 3d454000 813dc204 554893be
> [    1.564566] 7d294010 7d294910 90010034 39290001 <0f090000> 7c3e0b78 955e0008 3fe0c062
> [    1.572425] ---[ end trace 6f6984225b280ad6 ]---
> [    1.577467] PA: 0x09000000 for VA: 0xc9000000
> [    1.581799] PA: 0x061e8f50 for VA: 0xc61e8f50
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6bf752daca07c85c181159f75dcf65

cheers
