Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B730C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB72E20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB72E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbeICVsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:48:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeICVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:48:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EEE68CF4;
        Mon,  3 Sep 2018 17:27:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH 4.14 151/165] MIPS: Change definition of cpu_relax() for Loongson-3
Date:   Mon,  3 Sep 2018 18:57:17 +0200
Message-Id: <20180903165704.649556175@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit a30718868915fbb991a9ae9e45594b059f28e9ae upstream.

Linux expects that if a CPU modifies a memory location, then that
modification will eventually become visible to other CPUs in the system.

Loongson 3 CPUs include a Store Fill Buffer (SFB) which sits between a
core & its L1 data cache, queueing memory accesses & allowing for faster
forwarding of data from pending stores to younger loads from the core.
Unfortunately the SFB prioritizes loads such that a continuous stream of
loads may cause a pending write to be buffered indefinitely. This is
problematic if we end up with 2 CPUs which each perform a store that the
other polls for - one or both CPUs may end up with their stores buffered
in the SFB, never reaching cache due to the continuous reads from the
poll loop. Such a deadlock condition has been observed whilst running
qspinlock code.

This patch changes the definition of cpu_relax() to smp_mb() for
Loongson-3, forcing a flush of the SFB on SMP systems which will cause
any pending writes to make it as far as the L1 caches where they will
become visible to other CPUs. If the kernel is not compiled for SMP
support, this will expand to a barrier() as before.

This workaround matches that currently implemented for ARM when
CONFIG_ARM_ERRATA_754327=y, which was introduced by commit 534be1d5a2da
("ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore").

Although the workaround is only required when the Loongson 3 SFB
functionality is enabled, and we only began explicitly enabling that
functionality in v4.7 with commit 1e820da3c9af ("MIPS: Loongson-3:
Introduce CONFIG_LOONGSON3_ENHANCEMENT"), existing or future firmware
may enable the SFB which means we may need the workaround backported to
earlier kernels too.

[paul.burton@mips.com:
  - Reword commit message & comment.
  - Limit stable backport to v3.15+ where we support Loongson 3 CPUs.]

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
References: 534be1d5a2da ("ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore")
References: 1e820da3c9af ("MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT")
Patchwork: https://patchwork.linux-mips.org/patch/19830/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Cc: stable@vger.kernel.org # v3.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/processor.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -388,7 +388,20 @@ unsigned long get_wchan(struct task_stru
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
 
+#ifdef CONFIG_CPU_LOONGSON3
+/*
+ * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely when a
+ * tight read loop is executed, because reads take priority over writes & the
+ * hardware (incorrectly) doesn't ensure that writes will eventually occur.
+ *
+ * Since spin loops of any kind should have a cpu_relax() in them, force an SFB
+ * flush from cpu_relax() such that any pending writes will become visible as
+ * expected.
+ */
+#define cpu_relax()	smp_mb()
+#else
 #define cpu_relax()	barrier()
+#endif
 
 /*
  * Return_address is a replacement for __builtin_return_address(count)


