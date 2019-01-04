Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4AD217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAfnkqU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfADIkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:40:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33793 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfADIkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:40:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so17220953pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vA4FdA+xrF1FW2AW7WTGhQzRUh1P5ZxTvkLhazo2968=;
        b=QAfnkqU/6aDqLvsuaEx2ewRaeLYoffcqkPoBHL9ilV7ryC7AJU6Qf9Wjus/KehKYc4
         AcH/RWNySda19Qq+J6GxCVHo+l04z39yLu8GocFD8rRQBu28UArQuz9Mehi27XLDBJuv
         DvD+uOMrn5IW/bTG5LhX9i3lURm7KVeRpyLRfDBiPCkqhRtAqzGfdlZVmhyAMpBkpnI7
         IpCU0R2M26u2TAjEAXykXb1FGh/I49o7i0TYisM0UC69W1kEw7q2MxnWSMhQFZUOt6Tf
         hOOiP8viQC4zKTkQSt8WuIw9Y0ntRpoW2QL1bmac7p7N2iRGb3jRy9VB2ksvZ69P4WfE
         Uzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vA4FdA+xrF1FW2AW7WTGhQzRUh1P5ZxTvkLhazo2968=;
        b=WylBAxVnPcyy9AZaxzGdyejZq5MkfveOC3/ZWGB8vV9wGRKKdNbLmhWqOIhiveaf2d
         xl3JcbofNTu5XL4qbCSlTGH4XFSnhGKZcJge/u5+//4BZpdBO2uFEoD3Wmj+1Kt0iE7c
         3xCvomyZlSu9Pswye8XCAXce3FNsReniJgqsdUln3d/ltx30iBlTB3gmf0t231KGV6SO
         fFc6B4kNoClCtccYPiLPSG9428Orn/ZHRquFYyreoI9E6TXHDMZ/N3ueWxyao5yUCs4c
         D9CXfW49mUiasac6EzWaKtMCZlLI71pn8MJDQSO9hA97/VnS23dtX6eZRY8hCO2n3h2C
         I6ew==
X-Gm-Message-State: AJcUukcgNik/dQ16J/+ObwrYWsDxp5a4dP+8cWedbnYZqV99CCTcwVMw
        hA33ecjykQ6eOqEMNua0Sg==
X-Google-Smtp-Source: ALg8bN6qin0FujyGhSctyl62dK6fKhVD6YNgr22TDrSuInYy8jdaK/nAz+oz9nyqCCMohwr9Y7q+hg==
X-Received: by 2002:a65:6215:: with SMTP id d21mr876640pgv.289.1546591220047;
        Fri, 04 Jan 2019 00:40:20 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b2sm102115783pgg.87.2019.01.04.00.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 00:40:19 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     kexec@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCHv4] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Fri,  4 Jan 2019 16:39:55 +0800
Message-Id: <1546591195-21853-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Customer reported a bug on a high end server with many pcie devices, where
kernel bootup with crashkernel=384M, and kaslr is enabled. Even
though we still see much memory under 896 MB, the finding still failed
intermittently. Because currently we can only find region under 896 MB,
if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
randomly, and crashkernel reservation need be aligned to 128 MB, that's
why failure is found. It raises confusion to the end user that sometimes
crashkernel=X works while sometimes fails.
If want to make it succeed, customer can change kernel option to
"crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
limited space to behave even though its grammer looks more generic.
And we can't answer questions raised from customer that confidently:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.

This patch simplifies the method suggested in the mail [1]. It just goes
bottom-up to find a candidate region for crashkernel. The bottom-up may be
better compatible with the old reservation style, i.e. still want to get
memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.

There is one trivial thing about the compatibility with old kexec-tools:
if the reserved region is above 896M, then old tool will fail to load
bzImage. But without this patch, the old tool also fail since there is no
memory below 896M can be reserved for crashkernel.

[1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Daniel Vacek <neelx@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org
Cc: vgoyal@redhat.com
Cc: linux-kernel@vger.kernel.org
---
v3 -> v4:
 instead of exporting the stage of parsing mem hotplug info, just using the bottom-up allocation func directly
 arch/x86/kernel/setup.c  | 8 ++++----
 include/linux/memblock.h | 4 ++++
 mm/memblock.c            | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..082aadd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -546,10 +546,10 @@ static void __init reserve_crashkernel(void)
 		 * as old kexec-tools loads bzImage below that, unless
 		 * "crashkernel=size[KMG],high" is specified.
 		 */
-		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+		crash_base = __memblock_find_range_bottom_up(CRASH_ALIGN,
+			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN,
+			NUMA_NO_NODE, MEMBLOCK_NONE);
+
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aee299a..39720bf 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -116,6 +116,10 @@ phys_addr_t memblock_find_in_range_node(phys_addr_t size, phys_addr_t align,
 					int nid, enum memblock_flags flags);
 phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
 				   phys_addr_t size, phys_addr_t align);
+phys_addr_t __init_memblock
+__memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
+				phys_addr_t size, phys_addr_t align, int nid,
+				enum memblock_flags flags);
 void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 81ae63c..53b1707 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -172,7 +172,7 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
  * Return:
  * Found address on success, 0 on failure.
  */
-static phys_addr_t __init_memblock
+phys_addr_t __init_memblock
 __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
 				phys_addr_t size, phys_addr_t align, int nid,
 				enum memblock_flags flags)
-- 
2.7.4

