Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB856C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A3E208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A3E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbeHAOx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:53:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:23303 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388930AbeHAOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:53:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 06:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="250193287"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2018 06:08:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5D20E86; Wed,  1 Aug 2018 16:08:12 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] ia64: Make stack VMA anonymous
Date:   Wed,  1 Aug 2018 16:08:01 +0300
Message-Id: <20180801130801.30095-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA64 allocates stack in a custom way. Stack has to be marked as
anonymous otherwise the process will be killed with SIGBUS on the first
access to the stack.

Add missing vma_set_anonymous().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Tony Luck <tony.luck@intel.com>
Fixes: bfd40eaff5ab ("mm: fix vma_is_anonymous() false-positives")
---
 arch/ia64/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index e6c6dfd98de2..99044db28040 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -116,6 +116,7 @@ ia64_init_addr_space (void)
 	 */
 	vma = vm_area_alloc(current->mm);
 	if (vma) {
+		vma_set_anonymous(vma);
 		vma->vm_start = current->thread.rbs_bot & PAGE_MASK;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_flags = VM_DATA_DEFAULT_FLAGS|VM_GROWSUP|VM_ACCOUNT;
-- 
2.18.0

