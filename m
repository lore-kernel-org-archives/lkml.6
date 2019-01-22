Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448C220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hgiUYY1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfAVN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:29:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43514 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfAVN30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:29:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so27466557qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZobmOX2RnjjwMTekUZRV4KZkyaPzmJrMtDFY/zT5fWk=;
        b=hgiUYY1Zv38rllaGc/Dqx5sumCCcVbqE3ZTnV2chD2vWzm5Cva1yfGgWjau5yGvMVq
         1ApDRpHeceF09+LzWKLHT6YFp5282nDFO6ouHsRCM3M9xbc5symulPMl46IfB2xw5C2+
         tJlK+pHQhdSXrC10CwmcTkwbOsC2CIXNRnZUjm4h7wcHrC8Qz5qfcR13NaB2Y+kGcbq/
         uu3hQkyKQA8tiVmBxWaf/NTr/6A5yNTGB8QLQtbzXuaIcvLNm2qFLIQ3waI86FMkenxR
         gRZGrALk8tFa4L9kqWNp+5f8B3Wh1jlaD8qUmMdcGMGwqI63mEJqwrW7amHccuSGF6aI
         /qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZobmOX2RnjjwMTekUZRV4KZkyaPzmJrMtDFY/zT5fWk=;
        b=Weuirr3xN+m5nCe6HO4Lqem41qf1w8+0gM82RNXGDPx/vWI8/9/OIkDlb3bKMiQ03I
         LxzZQR3ZcIUToOyhcOOsQnXPkAXR/vFEDPVSuKRh1XbaJJzBH/g73NNd065OZmgVvXxM
         YNmXLRBBmyW8G3vnWeurku6HPbw/CFJzfnn8h9cyAxnGvTGcgs3yaJ1IV4r0T+cwznwL
         nDqcNQHv6ZHvA1MxVbtFCfH2ITrdFLdfyr7oa1pQJt2B4hovBI209cexeiTB3WQWRBm3
         ZWeLIebIAeth7gDUYEc06b+6CNBlC0fUplxEPoZ5qVOQ7kotFaQBvPEBiArK+8oJzpGD
         ntcQ==
X-Gm-Message-State: AJcUukfAlV35od2h3SpLG0pl3XPp/GdUCi71VPY3Wq17Z6EYsxkPUNKn
        igPVKMu9KqPod/Avkf+VD3Mt3g==
X-Google-Smtp-Source: ALg8bN76Cn4h6Y4oZX8zFJCJO5vXZUPpEabI8kgtI/uW6n4lLmxxe3h8VgNT8kxyiw6UIKgCHLI1Ig==
X-Received: by 2002:ac8:1794:: with SMTP id o20mr29146970qtj.98.1548163764810;
        Tue, 22 Jan 2019 05:29:24 -0800 (PST)
Received: from ovpn-120-54.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n11sm31511718qke.82.2019.01.22.05.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 05:29:23 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     osalvador@suse.de, catalin.marinas@arm.com, vbabka@suse.cz,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v4] mm/hotplug: invalid PFNs from pfn_to_online_page()
Date:   Tue, 22 Jan 2019 08:29:16 -0500
Message-Id: <20190122132916.28360-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an arm64 ThunderX2 server, the first kmemleak scan would crash [1]
with CONFIG_DEBUG_VM_PGFLAGS=y due to page_to_nid() found a pfn that is
not directly mapped (MEMBLOCK_NOMAP). Hence, the page->flags is
uninitialized.

This is due to the commit 9f1eb38e0e11 ("mm, kmemleak: little
optimization while scanning") starts to use pfn_to_online_page() instead
of pfn_valid(). However, in the CONFIG_MEMORY_HOTPLUG=y case,
pfn_to_online_page() does not call memblock_is_map_memory() while
pfn_valid() does.

Historically, the commit 68709f45385a ("arm64: only consider memblocks
with NOMAP cleared for linear mapping") causes pages marked as nomap
being no long reassigned to the new zone in memmap_init_zone() by
calling __init_single_page().

Since the commit 2d070eab2e82 ("mm: consider zone which is not fully
populated to have holes") introduced pfn_to_online_page() and was
designed to return a valid pfn only, but it is clearly broken on arm64.

Therefore, let pfn_to_online_page() call pfn_valid_within(), so it can
handle nomap thanks to the commit f52bb98f5ade ("arm64: mm: always
enable CONFIG_HOLES_IN_ZONE"), while it will be optimized away on
architectures where have no HOLES_IN_ZONE.

[1]
[  102.195320] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000006
[  102.204113] Mem abort info:
[  102.206921]   ESR = 0x96000005
[  102.209997]   Exception class = DABT (current EL), IL = 32 bits
[  102.215926]   SET = 0, FnV = 0
[  102.218993]   EA = 0, S1PTW = 0
[  102.222150] Data abort info:
[  102.225047]   ISV = 0, ISS = 0x00000005
[  102.228887]   CM = 0, WnR = 0
[  102.231866] user pgtable: 64k pages, 48-bit VAs, pgdp = (____ptrval____)
[  102.238572] [0000000000000006] pgd=0000000000000000, pud=0000000000000000
[  102.245448] Internal error: Oops: 96000005 [#1] SMP
[  102.264062] CPU: 60 PID: 1408 Comm: kmemleak Not tainted 5.0.0-rc2+ #8
[  102.280403] pstate: 60400009 (nZCv daif +PAN -UAO)
[  102.280409] pc : page_mapping+0x24/0x144
[  102.280415] lr : __dump_page+0x34/0x3dc
[  102.292923] sp : ffff00003a5cfd10
[  102.296229] x29: ffff00003a5cfd10 x28: 000000000000802f
[  102.301533] x27: 0000000000000000 x26: 0000000000277d00
[  102.306835] x25: ffff000010791f56 x24: ffff7fe000000000
[  102.312138] x23: ffff000010772f8b x22: ffff00001125f670
[  102.317442] x21: ffff000011311000 x20: ffff000010772f8b
[  102.322747] x19: fffffffffffffffe x18: 0000000000000000
[  102.328049] x17: 0000000000000000 x16: 0000000000000000
[  102.333352] x15: 0000000000000000 x14: ffff802698b19600
[  102.338654] x13: ffff802698b1a200 x12: ffff802698b16f00
[  102.343956] x11: ffff802698b1a400 x10: 0000000000001400
[  102.349260] x9 : 0000000000000001 x8 : ffff00001121a000
[  102.354563] x7 : 0000000000000000 x6 : ffff0000102c53b8
[  102.359868] x5 : 0000000000000000 x4 : 0000000000000003
[  102.365173] x3 : 0000000000000100 x2 : 0000000000000000
[  102.370476] x1 : ffff000010772f8b x0 : ffffffffffffffff
[  102.375782] Process kmemleak (pid: 1408, stack limit = 0x(____ptrval____))
[  102.382648] Call trace:
[  102.385091]  page_mapping+0x24/0x144
[  102.388659]  __dump_page+0x34/0x3dc
[  102.392140]  dump_page+0x28/0x4c
[  102.395363]  kmemleak_scan+0x4ac/0x680
[  102.399106]  kmemleak_scan_thread+0xb4/0xdc
[  102.403285]  kthread+0x12c/0x13c
[  102.406509]  ret_from_fork+0x10/0x18
[  102.410080] Code: d503201f f9400660 36000040 d1000413 (f9400661)
[  102.416357] ---[ end trace 4d4bd7f573490c8e ]---
[  102.420966] Kernel panic - not syncing: Fatal exception
[  102.426293] SMP: stopping secondary CPUs
[  102.431830] Kernel Offset: disabled
[  102.435311] CPU features: 0x002,20000c38
[  102.439223] Memory Limit: none
[  102.442384] ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: 9f1eb38e0e11 ("mm, kmemleak: little optimization while scanning")
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v4: avoid unsafe macros with side effects.
v3: change the "Fixes" line.
v2: update the changelog; keep the bound check; use pfn_valid_within().

 include/linux/memory_hotplug.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 07da5c6c5ba0..368267c1b71b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -21,14 +21,16 @@ struct vmem_altmap;
  * walkers which rely on the fully initialized page->flags and others
  * should use this rather than pfn_valid && pfn_to_page
  */
-#define pfn_to_online_page(pfn)				\
-({							\
-	struct page *___page = NULL;			\
-	unsigned long ___nr = pfn_to_section_nr(pfn);	\
-							\
-	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr))\
-		___page = pfn_to_page(pfn);		\
-	___page;					\
+#define pfn_to_online_page(pfn)					   \
+({								   \
+	struct page *___page = NULL;				   \
+	unsigned long ___pfn = pfn;				   \
+	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
+								   \
+	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
+	    pfn_valid_within(___pfn))				   \
+		___page = pfn_to_page(___pfn);			   \
+	___page;						   \
 })
 
 /*
-- 
2.17.2 (Apple Git-113)

