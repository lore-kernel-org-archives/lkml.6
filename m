Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C744C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD8A20882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD8A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJHRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:15:00 -0400
Received: from foss.arm.com ([217.140.101.70]:47016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHRPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:15:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6EC57A9;
        Mon,  8 Oct 2018 03:04:04 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578FA3F5D3;
        Mon,  8 Oct 2018 03:04:04 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steve.capper@arm.com, rdunlap@infradead.org,
        Punit Agrawal <punit.agrawal@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] Documentation/arm64: HugeTLB page implementation
Date:   Mon,  8 Oct 2018 11:03:55 +0100
Message-Id: <20181008100355.31820-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
References: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
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
Hi,

This version incorporates the feedback on v1.

Thanks,
Punit

 Documentation/arm64/hugetlbpage.txt | 38 +++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/arm64/hugetlbpage.txt

diff --git a/Documentation/arm64/hugetlbpage.txt b/Documentation/arm64/hugetlbpage.txt
new file mode 100644
index 000000000000..cfae87dc653b
--- /dev/null
+++ b/Documentation/arm64/hugetlbpage.txt
@@ -0,0 +1,38 @@
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
+mappings reduce the depth of page table walk needed to translate hugepage
+addresses.
+
+2) Using the Contiguous bit
+---------------------------
+
+The architecture provides a contiguous bit in the translation table entries
+(D4.5.3, ARM DDI 0487C.a) that hints to the MMU to indicate that it is one of a
+contiguous set of entries that can be cached in a single TLB entry.
+
+The contiguous bit is used in Linux to increase the mapping size at the pmd and
+pte (last) level. The number of supported contiguous entries varies by page size
+and level of the page table.
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

