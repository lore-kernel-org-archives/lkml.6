Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B155ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9541208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9541208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbeGQLyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:54:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:40800 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbeGQLyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:54:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 04:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="67665041"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2018 04:21:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7D14E85E; Tue, 17 Jul 2018 14:21:49 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 19/19] x86: Introduce CONFIG_X86_INTEL_MKTME
Date:   Tue, 17 Jul 2018 14:20:29 +0300
Message-Id: <20180717112029.42378-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new config option to enabled/disable Multi-Key Total Memory
Encryption support.

MKTME uses MEMORY_PHYSICAL_PADDING to reserve enough space in per-KeyID
direct mappings for memory hotplug.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b6f1785c2176..023a22568c06 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1523,6 +1523,23 @@ config ARCH_USE_MEMREMAP_PROT
 	def_bool y
 	depends on AMD_MEM_ENCRYPT
 
+config X86_INTEL_MKTME
+	bool "Intel Multi-Key Total Memory Encryption"
+	select DYNAMIC_PHYSICAL_MASK
+	select PAGE_EXTENSION
+	depends on X86_64 && CPU_SUP_INTEL
+	---help---
+	  Say yes to enable support for Multi-Key Total Memory Encryption.
+	  This requires an Intel processor that has support of the feature.
+
+	  Multikey Total Memory Encryption (MKTME) is a technology that allows
+	  transparent memory encryption in upcoming Intel platforms.
+
+	  MKTME is built on top of TME. TME allows encryption of the entirety
+	  of system memory using a single key. MKTME allows having multiple
+	  encryption domains, each having own key -- different memory pages can
+	  be encrypted with different keys.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
@@ -2199,7 +2216,7 @@ config RANDOMIZE_MEMORY
 
 config MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
-	depends on RANDOMIZE_MEMORY
+	depends on RANDOMIZE_MEMORY || X86_INTEL_MKTME
 	default "0xa" if MEMORY_HOTPLUG
 	default "0x0"
 	range 0x1 0x40 if MEMORY_HOTPLUG
-- 
2.18.0

