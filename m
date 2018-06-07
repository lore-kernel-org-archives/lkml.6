Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id U4f6MzJSGVvVFQAAmS7hNA
	; Thu, 07 Jun 2018 15:42:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CD95607E7; Thu,  7 Jun 2018 15:42:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EC9FA60590;
	Thu,  7 Jun 2018 15:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC9FA60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbeFGPmI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:42:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:36348 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934016AbeFGOlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="62632655"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2018 07:41:34 -0700
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
Subject: [PATCH 09/10] mm: Prevent madvise from changing shadow stack
Date: Thu,  7 Jun 2018 07:38:06 -0700
Message-Id: <20180607143807.3611-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180607143807.3611-1-yu-cheng.yu@intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4d3c922ea1a1..2a6988badd6b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -839,6 +839,14 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
+	/*
+	 * Don't do anything on shadow stack.
+	 */
+	if (vma->vm_flags & VM_SHSTK) {
+		error = -EINVAL;
+		goto out_no_plug;
+	}
+
 	blk_start_plug(&plug);
 	for (;;) {
 		/* Still start < end. */
@@ -876,6 +884,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	}
 out:
 	blk_finish_plug(&plug);
+out_no_plug:
 	if (write)
 		up_write(&current->mm->mmap_sem);
 	else
-- 
2.15.1
