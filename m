Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B542183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866234;
	bh=azAeCQBLjjD+kw1O0SjlSAN3HGWzRebbeaKg/aZ5YLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evw2jEMjm776ehg2KfWvVCqRGtJTbBnVOqH7VLhALp9qKc0gkpTp1nH8ddU4vUSjc
	 YMZyMNv63ErP0ooMAAWpYeM6rO9nLTM71sifCzqwjymJnevYka2rizjSy7oPCtGY7F
	 n3KGTe1PfQ5WXhhHXbKthK3i6dmruraxjWPDcU/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfAGNDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731080AbfAGNDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B892089F;
        Mon,  7 Jan 2019 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866229;
        bh=azAeCQBLjjD+kw1O0SjlSAN3HGWzRebbeaKg/aZ5YLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWHqh8dG/r9BmYjPRw4rAnfDBpDFMFAaEUQTIq8ipsV5BwIfX5o1O9/CBiuXbdHOv
         tsHbxJXkbHi+/L1oDFaXd+kMyIxm9jYV6gStCJ/PSg3zXhx5aLe1Y9cLzDmpt8v2QC
         YSw+1aJt2VuJtb54mh/LcJq7VLoqLmjO7dJIUiwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: [PATCH 4.14 090/101] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Date:   Mon,  7 Jan 2019 13:33:18 +0100
Message-Id: <20190107105337.790421457@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit bb53fdf395eed103f85061bfff3b116cee123895 upstream.

For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
only flush Node-0's scache. So we add r4k_blast_scache_node() by using
(CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
start address.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
[paul.burton@mips.com: Include asm/mmzone.h from asm/r4kcache.h for
		       nid_to_addrbase(). Add asm/mach-generic/mmzone.h
		       to allow inclusion for all platforms.]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21129/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@mips.com>
Cc: Steven J . Hill <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: <stable@vger.kernel.org> # 3.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mach-generic/mmzone.h    |    2 +
 arch/mips/include/asm/mach-loongson64/mmzone.h |    1 
 arch/mips/include/asm/mmzone.h                 |    8 ++++
 arch/mips/include/asm/r4kcache.h               |   22 ++++++++++++
 arch/mips/mm/c-r4k.c                           |   44 +++++++++++++++++++++----
 5 files changed, 70 insertions(+), 7 deletions(-)

--- /dev/null
+++ b/arch/mips/include/asm/mach-generic/mmzone.h
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Intentionally empty */
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -21,6 +21,7 @@
 #define NODE3_ADDRSPACE_OFFSET 0x300000000000UL
 
 #define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
+#define nid_to_addrbase(nid) ((nid) << NODE_ADDRSPACE_SHIFT)
 
 #define LEVELS_PER_SLICE 128
 
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -9,6 +9,14 @@
 #include <asm/page.h>
 #include <mmzone.h>
 
+#ifndef pa_to_nid
+#define pa_to_nid(addr) 0
+#endif
+
+#ifndef nid_to_addrbase
+#define nid_to_addrbase(nid) 0
+#endif
+
 #ifdef CONFIG_DISCONTIGMEM
 
 #define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -20,6 +20,7 @@
 #include <asm/cpu-features.h>
 #include <asm/cpu-type.h>
 #include <asm/mipsmtregs.h>
+#include <asm/mmzone.h>
 #include <linux/uaccess.h> /* for uaccess_kernel() */
 
 extern void (*r4k_blast_dcache)(void);
@@ -747,4 +748,25 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
 __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
 
+/* Currently, this is very specific to Loongson-3 */
+#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)	\
+static inline void blast_##pfx##cache##lsize##_node(long node)		\
+{									\
+	unsigned long start = CAC_BASE | nid_to_addrbase(node);		\
+	unsigned long end = start + current_cpu_data.desc.waysize;	\
+	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
+	unsigned long ws_end = current_cpu_data.desc.ways <<		\
+			       current_cpu_data.desc.waybit;		\
+	unsigned long ws, addr;						\
+									\
+	for (ws = 0; ws < ws_end; ws += ws_inc)				\
+		for (addr = start; addr < end; addr += lsize * 32)	\
+			cache##lsize##_unroll32(addr|ws, indexop);	\
+}
+
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
+
 #endif /* _ASM_R4KCACHE_H */
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -459,11 +459,28 @@ static void r4k_blast_scache_setup(void)
 		r4k_blast_scache = blast_scache128;
 }
 
+static void (*r4k_blast_scache_node)(long node);
+
+static void r4k_blast_scache_node_setup(void)
+{
+	unsigned long sc_lsize = cpu_scache_line_size();
+
+	if (current_cpu_type() != CPU_LOONGSON3)
+		r4k_blast_scache_node = (void *)cache_noop;
+	else if (sc_lsize == 16)
+		r4k_blast_scache_node = blast_scache16_node;
+	else if (sc_lsize == 32)
+		r4k_blast_scache_node = blast_scache32_node;
+	else if (sc_lsize == 64)
+		r4k_blast_scache_node = blast_scache64_node;
+	else if (sc_lsize == 128)
+		r4k_blast_scache_node = blast_scache128_node;
+}
+
 static inline void local_r4k___flush_cache_all(void * args)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
-	case CPU_LOONGSON3:
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -480,6 +497,11 @@ static inline void local_r4k___flush_cac
 		r4k_blast_scache();
 		break;
 
+	case CPU_LOONGSON3:
+		/* Use get_ebase_cpunum() for both NUMA=y/n */
+		r4k_blast_scache_node(get_ebase_cpunum() >> 2);
+		break;
+
 	case CPU_BMIPS5000:
 		r4k_blast_scache();
 		__sync();
@@ -840,10 +862,14 @@ static void r4k_dma_cache_wback_inv(unsi
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-		if (size >= scache_size)
-			r4k_blast_scache();
-		else
+		if (size >= scache_size) {
+			if (current_cpu_type() != CPU_LOONGSON3)
+				r4k_blast_scache();
+			else
+				r4k_blast_scache_node(pa_to_nid(addr));
+		} else {
 			blast_scache_range(addr, addr + size);
+		}
 		preempt_enable();
 		__sync();
 		return;
@@ -877,9 +903,12 @@ static void r4k_dma_cache_inv(unsigned l
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-		if (size >= scache_size)
-			r4k_blast_scache();
-		else {
+		if (size >= scache_size) {
+			if (current_cpu_type() != CPU_LOONGSON3)
+				r4k_blast_scache();
+			else
+				r4k_blast_scache_node(pa_to_nid(addr));
+		} else {
 			/*
 			 * There is no clearly documented alignment requirement
 			 * for the cache instruction on MIPS processors and
@@ -1910,6 +1939,7 @@ void r4k_cache_init(void)
 	r4k_blast_scache_page_setup();
 	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
+	r4k_blast_scache_node_setup();
 #ifdef CONFIG_EVA
 	r4k_blast_dcache_user_page_setup();
 	r4k_blast_icache_user_page_setup();


