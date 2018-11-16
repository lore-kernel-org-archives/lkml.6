Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE57C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5F21019
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE5F21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeKPKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:37:41 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:46098 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389186AbeKPKhk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 05:37:40 -0500
Received: from linux-r8p5.psav.com (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 15 Nov 2018 17:27:22 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm: Remove caller signal_pending branch predictions
Date:   Thu, 15 Nov 2018 16:27:11 -0800
Message-Id: <20181116002713.8474-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181116002713.8474-1-dave@stgolabs.net>
References: <20181116002713.8474-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already done for us internally by the signal machinery.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/filemap.c | 2 +-
 mm/gup.c     | 2 +-
 mm/hugetlb.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8ee02c..abd6c4591855 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1096,7 +1096,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 				break;
 		}
 
-		if (unlikely(signal_pending_state(state, current))) {
+		if (signal_pending_state(state, current)) {
 			ret = -EINTR;
 			break;
 		}
diff --git a/mm/gup.c b/mm/gup.c
index f76e77a2d34b..391c71dde267 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -722,7 +722,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		 * If we have a pending SIGKILL, don't keep faulting pages and
 		 * potentially allocating memory.
 		 */
-		if (unlikely(fatal_signal_pending(current))) {
+		if (fatal_signal_pending(current)) {
 			ret = -ERESTARTSYS;
 			goto out;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c007fb5fb8d5..da798bc2e948 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4184,7 +4184,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * If we have a pending SIGKILL, don't keep faulting pages and
 		 * potentially allocating memory.
 		 */
-		if (unlikely(fatal_signal_pending(current))) {
+		if (fatal_signal_pending(current)) {
 			remainder = 0;
 			break;
 		}
-- 
2.16.4

