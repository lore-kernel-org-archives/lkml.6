Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5E9C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F03820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeLIWH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37272 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727945AbeLIWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:54 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002io-HI; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003G2-Q2; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "James Hogan" <jhogan@kernel.org>, linux-mips@linux-mips.org,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Paul Burton" <paul.burton@mips.com>,
        "Huacai Chen" <chenhc@lemote.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.576643502@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 049/328] MIPS: Change definition of cpu_relax() for
 Loongson-3
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/processor.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -366,7 +366,20 @@ unsigned long get_wchan(struct task_stru
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

