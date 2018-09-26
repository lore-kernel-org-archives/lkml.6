Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C886621528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C886621528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeIZW1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbeIZW1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:27:17 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986C521533;
        Wed, 26 Sep 2018 16:13:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1g5CRU-0003pE-LA; Wed, 26 Sep 2018 12:13:36 -0400
Message-Id: <20180926161336.554979682@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 12:12:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [for-next][PATCH 3/5] uprobes/sdt: Prevent multiple reference counter for same uprobe
References: <20180926161226.098070917@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

We assume to have only one reference counter for one uprobe.
Don't allow user to register multiple uprobes having same
inode+offset but different reference counter.

Link: http://lkml.kernel.org/r/20180820044250.11659-3-ravi.bangoria@linux.ibm.com

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Song Liu <songliubraving@fb.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/events/uprobes.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 934feb39f6be..96fb51f3994f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
+static void
+ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
+{
+	pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
+		"ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
+		uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
+		(unsigned long long) cur_uprobe->ref_ctr_offset,
+		(unsigned long long) uprobe->ref_ctr_offset);
+}
+
 static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 				   loff_t ref_ctr_offset)
 {
@@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
+			ref_ctr_mismatch_warn(cur_uprobe, uprobe);
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
 	/*
 	 * We can race with uprobe_unregister()->delete_uprobe().
 	 * Check uprobe_is_active() and retry if it is false.
-- 
2.18.0


