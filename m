Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3BC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B420320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WhFrpNRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfAUV1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:27:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39447 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfAUV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:27:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so25174764qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LrP922lpYU2vozu0HFe9/Pw0aQMdA08hosgTsXe9s8g=;
        b=WhFrpNRk8zmpNWmFSzdYAD2bFXvOPzWOdkDmx+FkpAInm4lLlubJGQdyMju4lbAbY2
         XONVG7Bq3/9BIaX3WREhx3TqMoh+Oli7kXyT6l8c8f9b3haipYAXOob07IG+O3i0wK7a
         pR5MBiah5K6H/4JblBW2N7Rkw2d4VvNQjcEV9x7/GgLGmjY2ihYNoo11I4pb6nccAeLP
         kODKsyO0m8fh4bGrhbjV4A31SnBfdpBi2kasaTK/bam+VgOzoXizteMJxdqTE19TS2wm
         U3ALdeQPm0n4X8GiPGEIGcTuEIplCOt3LRS+hms+Gp+afaNIPZfI16RC76DnXy1/y25V
         KVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LrP922lpYU2vozu0HFe9/Pw0aQMdA08hosgTsXe9s8g=;
        b=ElSOgfzTn8aBL45JCAHxCxgsEHzr1P07B5YvwoQGJ9qzWDRNRUBB30GxOQf/GUt1Gr
         1zzcrxTtI2BWg5KMAEG2QgG+6QjI9YQVVR9IezmcgmvbgE/YYpd2hE7AXtpt9kWUtrUf
         vtV2IN/84u3JIfcXHNYCuux0z901rAvrqAj9kngWsafAXq7ZvzZJCd0Q5WnFOaL9cqQb
         CyrRN796c90pVsgVv8koZfpMHKzGmGtMZUssJaFkICNfGnD5LpXKBlD+RmOhyc4ck+ns
         z/h4CeXOnUreC/BGzeY2VDnS0s8c1Pn+txEAZgip8GZ0Am8/fMEGoM+tW3e67ff06j63
         3DlQ==
X-Gm-Message-State: AJcUukdEeXmszb9aiI5orsSf/9+52R40wSzHgs89/KUK+TxlW+il6ewD
        UoT/44RG5FhJBvYlkDJ0y1tQyg==
X-Google-Smtp-Source: ALg8bN7i3mppciKjYqY5f7ZWaLr9oNLywyOBgkk3IS84NvR/rP5DaxtPXKalrIJ2KU+8x8c+zENeaQ==
X-Received: by 2002:ac8:29d2:: with SMTP id 18mr28045458qtt.174.1548106069649;
        Mon, 21 Jan 2019 13:27:49 -0800 (PST)
Received: from ovpn-120-54.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n71sm45343772qkl.72.2019.01.21.13.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 13:27:49 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     osalvador@suse.de, catalin.marinas@arm.com, vbabka@suse.cz,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] mm/hotplug: invalid PFNs from pfn_to_online_page()
Date:   Mon, 21 Jan 2019 16:27:47 -0500
Message-Id: <20190121212747.23029-1-cai@lca.pw>
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

v3: change the "Fixes" line.
v2: update the changelog; keep the bound check; use pfn_valid_within().

 include/linux/memory_hotplug.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 07da5c6c5ba0..cdeecd9bd87e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -21,14 +21,15 @@ struct vmem_altmap;
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
+	unsigned long ___nr = pfn_to_section_nr(pfn);		   \
+								   \
+	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
+	    pfn_valid_within(pfn))				   \
+		___page = pfn_to_page(pfn);			   \
+	___page;						   \
 })
 
 /*
-- 
2.17.2 (Apple Git-113)

