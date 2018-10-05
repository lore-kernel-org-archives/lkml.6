Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D46C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACBD2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACBD2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJEVeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:34:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52852 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbeJEVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:34:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37EA80D;
        Fri,  5 Oct 2018 07:35:10 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE493F5D3;
        Fri,  5 Oct 2018 07:35:10 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steve.capper@arm.com, Punit Agrawal <punit.agrawal@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation/arm64: HugeTLB page implementation
Date:   Fri,  5 Oct 2018 15:34:58 +0100
Message-Id: <20181005143458.17875-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm v8 architecture supports multiple page sizes - 4k, 16k and
64k. Based on the active page size, the Linux port supports
corresponding hugepage sizes at PMD and PUD(4k only) levels.

In addition, the architecture also supports caching larger sized
ranges (composed of multiple entries) at the PTE and PMD level in the
TLBs using the contiguous bit. The Linux port makes use of this
architectural support to enable additional hugepage sizes.

Describe the two different types of hugepages supported by the arm64
kernel and the hugepage sizes enabled by each.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arm64/hugetlbpage.txt | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/arm64/hugetlbpage.txt

diff --git a/Documentation/arm64/hugetlbpage.txt b/Documentation/arm64/hugetlbpage.txt
new file mode 100644
index 000000000000..64ee24b88d27
--- /dev/null
+++ b/Documentation/arm64/hugetlbpage.txt
@@ -0,0 +1,39 @@
+HugeTLBpage on ARM64
+====================
+
+Hugepage relies on making efficient use of TLBs to improve performance of
+address translations. The benefit depends on both -
+
+  - the size of hugepages
+  - size of entries supported by the TLBs
+
+The ARM64 port supports two flavours of hugepages.
+
+1) Block mappings at the pud/pmd level
+--------------------------------------
+
+These are regular hugepages where a pmd or a pud page table entry points to a
+block of memory. Regardless of the supported size of entries in TLB, block
+mappings reduces the depth of page table walk needed to translate hugepage
+addresses.
+
+2) Using the Contiguous bit
+---------------------------
+
+The architecture provides a contiguous bit in the translation table entries
+(D4.5.3, ARM DDI 0487C.a) that hints to the mmu to indicate that it is one of a
+contiguous set of entries that can be cached in a single TLB entry.
+
+The contiguous bit is used in Linux to increase the mapping size at the pmd and
+pte (last) level. The number of supported contiguous entries vary by page size
+and level of the page table.
+
+
+
+The following hugepage sizes are supported -
+
+         CONT PTE    PMD    CONT PMD    PUD
+         --------    ---    --------    ---
+  4K:         64K     2M         32M     1G
+  16K:         2M    32M          1G
+  64K:         2M   512M         16G
-- 
2.18.0

