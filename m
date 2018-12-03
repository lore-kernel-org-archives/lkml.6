Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6D920850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6D920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeLCUoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:44:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:44076 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeLCUoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:44:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 12:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="126741549"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.10.74])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2018 12:44:19 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] x86/mpx: pass 'mm' to kernel_managing_mpx_tables() in mpx_notify_unmap()
Date:   Mon,  3 Dec 2018 12:43:57 -0800
Message-Id: <20181203204357.26209-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mm is not the same as current->mm, mpx_notify_unmap() will yield
invalid results and at worst will lead to a crash if it gets called by
a kthread.

Cc: Dave Hansen <dave.hansen@intel.com>
Fixes: 1de4fa14ee25 ("x86, mpx: Cleanup unused bound tables")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/mm/mpx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index 2385538e8065..15fb62657ee9 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -882,7 +882,7 @@ static int mpx_unmap_tables(struct mm_struct *mm,
  * necessary, and the 'vma' is the first vma in this range (start -> end).
  */
 void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
+		      unsigned long start, unsigned long end)
 {
 	int ret;
 
@@ -890,7 +890,7 @@ void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * Refuse to do anything unless userspace has asked
 	 * the kernel to help manage the bounds tables,
 	 */
-	if (!kernel_managing_mpx_tables(current->mm))
+	if (!kernel_managing_mpx_tables(mm))
 		return;
 	/*
 	 * This will look across the entire 'start -> end' range,
-- 
2.19.1

