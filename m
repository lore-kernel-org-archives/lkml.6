Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73410C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388FB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388FB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLAHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:34:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:49152 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAHeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:34:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="96481101"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2018 12:23:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8FC2F368; Fri, 30 Nov 2018 22:23:45 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        hans.van.kranenburg@mendix.com, x86@kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 2/2] x86/dump_pagetables: Fix LDT remap address marker
Date:   Fri, 30 Nov 2018 23:23:28 +0300
Message-Id: <20181130202328.65359-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130202328.65359-1-kirill.shutemov@linux.intel.com>
References: <20181130202328.65359-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LDT remap placement has been changed. It's now placed before direct
mapping in the kernel virtual address space for both paging modes.

Change address markers order accordingly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging")
---
 arch/x86/mm/dump_pagetables.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index dad153e5a427..abcb8d00b014 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -55,10 +55,10 @@ struct addr_marker {
 enum address_markers_idx {
 	USER_SPACE_NR = 0,
 	KERNEL_SPACE_NR,
-	LOW_KERNEL_NR,
-#if defined(CONFIG_MODIFY_LDT_SYSCALL) && defined(CONFIG_X86_5LEVEL)
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
 	LDT_NR,
 #endif
+	LOW_KERNEL_NR,
 	VMALLOC_START_NR,
 	VMEMMAP_START_NR,
 #ifdef CONFIG_KASAN
@@ -66,9 +66,6 @@ enum address_markers_idx {
 	KASAN_SHADOW_END_NR,
 #endif
 	CPU_ENTRY_AREA_NR,
-#if defined(CONFIG_MODIFY_LDT_SYSCALL) && !defined(CONFIG_X86_5LEVEL)
-	LDT_NR,
-#endif
 #ifdef CONFIG_X86_ESPFIX64
 	ESPFIX_START_NR,
 #endif
-- 
2.19.2

