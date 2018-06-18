Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F391AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8942208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8942208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965652AbeFRKOV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:14:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934391AbeFRIQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DDF06C50;
        Mon, 18 Jun 2018 08:16:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 038/279] arm64: kasan: avoid pfn_to_nid() before page array is initialized
Date:   Mon, 18 Jun 2018 10:10:23 +0200
Message-Id: <20180618080610.379922155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 800cb2e553d44541b83aa3ec45d9839385fe8ab6 ]

In arm64's kasan_init(), we use pfn_to_nid() to find the NUMA node a
span of memory is in, hoping to allocate shadow from the same NUMA node.
However, at this point, the page array has not been initialized, and
thus this is bogus.

Since commit:

  f165b378bbdf6c8a ("mm: uninitialized struct page poisoning sanity")

... accessing fields of the page array results in a boot time Oops(),
highlighting this problem:

[    0.000000] Unable to handle kernel paging request at virtual address dfff200000000000
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   Exception class = DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [dfff200000000000] address between user and kernel address ranges
[    0.000000] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.16.0-07317-gf165b378bbdf #42
[    0.000000] Hardware name: ARM Juno development board (r1) (DT)
[    0.000000] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[    0.000000] pc : __asan_load8+0x8c/0xa8
[    0.000000] lr : __dump_page+0x3c/0x3b8
[    0.000000] sp : ffff2000099b7ca0
[    0.000000] x29: ffff2000099b7ca0 x28: ffff20000a1762c0
[    0.000000] x27: ffff7e0000000000 x26: ffff2000099dd000
[    0.000000] x25: ffff200009a3f960 x24: ffff200008f9c38c
[    0.000000] x23: ffff20000a9d3000 x22: ffff200009735430
[    0.000000] x21: fffffffffffffffe x20: ffff7e0001e50420
[    0.000000] x19: ffff7e0001e50400 x18: 0000000000001840
[    0.000000] x17: ffffffffffff8270 x16: 0000000000001840
[    0.000000] x15: 0000000000001920 x14: 0000000000000004
[    0.000000] x13: 0000000000000000 x12: 0000000000000800
[    0.000000] x11: 1ffff0012d0f89ff x10: ffff10012d0f89ff
[    0.000000] x9 : 0000000000000000 x8 : ffff8009687c5000
[    0.000000] x7 : 0000000000000000 x6 : ffff10000f282000
[    0.000000] x5 : 0000000000000040 x4 : fffffffffffffffe
[    0.000000] x3 : 0000000000000000 x2 : dfff200000000000
[    0.000000] x1 : 0000000000000005 x0 : 0000000000000000
[    0.000000] Process swapper (pid: 0, stack limit = 0x        (ptrval))
[    0.000000] Call trace:
[    0.000000]  __asan_load8+0x8c/0xa8
[    0.000000]  __dump_page+0x3c/0x3b8
[    0.000000]  dump_page+0xc/0x18
[    0.000000]  kasan_init+0x2e8/0x5a8
[    0.000000]  setup_arch+0x294/0x71c
[    0.000000]  start_kernel+0xdc/0x500
[    0.000000] Code: aa0403e0 9400063c 17ffffee d343fc00 (38e26800)
[    0.000000] ---[ end trace 67064f0e9c0cc338 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Let's fix this by using early_pfn_to_nid(), as other architectures do in
their kasan init code. Note that early_pfn_to_nid acquires the nid from
the memblock array, which we iterate over in kasan_init(), so this
should be fine.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 39d114ddc6822302 ("arm64: add KASAN support")
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/kasan_init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -204,7 +204,7 @@ void __init kasan_init(void)
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
-			   pfn_to_nid(virt_to_pfn(lm_alias(_text))));
+			   early_pfn_to_nid(virt_to_pfn(lm_alias(_text))));
 
 	kasan_populate_zero_shadow((void *)KASAN_SHADOW_START,
 				   (void *)mod_shadow_start);
@@ -224,7 +224,7 @@ void __init kasan_init(void)
 
 		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
 				   (unsigned long)kasan_mem_to_shadow(end),
-				   pfn_to_nid(virt_to_pfn(start)));
+				   early_pfn_to_nid(virt_to_pfn(start)));
 	}
 
 	/*


