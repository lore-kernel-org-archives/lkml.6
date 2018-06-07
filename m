Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rKVBCMpDGVtfDAAAmS7hNA
	; Thu, 07 Jun 2018 14:41:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3B98608BF; Thu,  7 Jun 2018 14:41:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8596F607DC;
	Thu,  7 Jun 2018 14:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8596F607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934688AbeFGOls (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:41:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:36344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934604AbeFGOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="62632648"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2018 07:41:33 -0700
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 08/10] mm: Prevent mremap of shadow stack
Date: Thu,  7 Jun 2018 07:38:05 -0700
Message-Id: <20180607143807.3611-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/mremap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 049470aa1e3e..70f20edb248e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -525,7 +525,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		unsigned long, new_addr)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma = find_vma(mm, addr);
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
 	bool locked = false;
@@ -533,6 +533,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	if (vma->vm_flags & VM_SHSTK)
+		return ret;
+
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
 
-- 
2.15.1
