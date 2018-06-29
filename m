Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA94C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A428094
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4A428094
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936926AbeF2Wl2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:41:28 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53385 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934916AbeF2Wki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:40:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0T3dXmHm_1530312021;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3dXmHm_1530312021)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Jun 2018 06:40:29 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@kernel.org, willy@infradead.org, ldufour@linux.vnet.ibm.com,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 PATCH 2/5] mm: introduce VM_DEAD flag
Date:   Sat, 30 Jun 2018 06:39:42 +0800
Message-Id: <1530311985-31251-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_DEAD flag is used to mark a vma is being unmapped, access to this
area will trigger SIGSEGV.

This flag will be used by the optimization for unmapping large address
space (>= 1GB) in the later patch. It is 64 bit only at the moment,
since:
  * we used up vm_flags bit for 32 bit
  * 32 bit machine typically will not have such large mapping

All architectures, which support 64 bit, need check this flag in their
page fault handler. This is implemented in later patches.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9f..28a3906 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -242,6 +242,12 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_64BIT
+#define VM_DEAD			BIT(37)	/* bit only usable on 64 bit kernel */
+#else
+#define VM_DEAD			0
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
-- 
1.8.3.1

