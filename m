Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE207601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeFFIeJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:34:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932520AbeFFIeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:34:05 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 1/7] Uprobes: Simplify uprobe_register() body
Date: Wed,  6 Jun 2018 14:03:38 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060608-4275-0000-0000-0000028AA926
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060608-4276-0000-0000-00003791B124
Message-Id: <20180606083344.31320-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060098
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify uprobe_register() function body and let __uprobe_register()
handle everything. Also move dependency functions around to fix build
failures.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 69 ++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1725b90..c377a85 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -840,13 +840,8 @@ static inline struct map_info *free_map_info(struct map_info *info)
 	return err;
 }
 
-static int __uprobe_register(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	consumer_add(uprobe, uc);
-	return register_for_each_vma(uprobe, uc);
-}
-
-static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+static void
+__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
@@ -860,24 +855,46 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
 }
 
 /*
- * uprobe_register - register a probe
+ * uprobe_unregister - unregister a already registered probe.
+ * @inode: the file in which the probe has to be removed.
+ * @offset: offset from the start of the file.
+ * @uc: identify which probe if multiple probes are colocated.
+ */
+void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+{
+	struct uprobe *uprobe;
+
+	uprobe = find_uprobe(inode, offset);
+	if (WARN_ON(!uprobe))
+		return;
+
+	down_write(&uprobe->register_rwsem);
+	__uprobe_unregister(uprobe, uc);
+	up_write(&uprobe->register_rwsem);
+	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister);
+
+/*
+ * __uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
  * @uc: information on howto handle the probe..
  *
- * Apart from the access refcount, uprobe_register() takes a creation
+ * Apart from the access refcount, __uprobe_register() takes a creation
  * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
  * inserted into the rbtree (i.e first consumer for a @inode:@offset
  * tuple).  Creation refcount stops uprobe_unregister from freeing the
  * @uprobe even before the register operation is complete. Creation
  * refcount is released when the last @uc for the @uprobe
- * unregisters. Caller of uprobe_register() is required to keep @inode
+ * unregisters. Caller of __uprobe_register() is required to keep @inode
  * (and the containing mount) referenced.
  *
  * Return errno if it cannot successully install probes
  * else return 0 (success)
  */
-int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
+static int __uprobe_register(struct inode *inode, loff_t offset,
+			     struct uprobe_consumer *uc)
 {
 	struct uprobe *uprobe;
 	int ret;
@@ -904,7 +921,8 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 	down_write(&uprobe->register_rwsem);
 	ret = -EAGAIN;
 	if (likely(uprobe_is_active(uprobe))) {
-		ret = __uprobe_register(uprobe, uc);
+		consumer_add(uprobe, uc);
+		ret = register_for_each_vma(uprobe, uc);
 		if (ret)
 			__uprobe_unregister(uprobe, uc);
 	}
@@ -915,6 +933,12 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 		goto retry;
 	return ret;
 }
+
+int uprobe_register(struct inode *inode, loff_t offset,
+		    struct uprobe_consumer *uc)
+{
+	return __uprobe_register(inode, offset, uc);
+}
 EXPORT_SYMBOL_GPL(uprobe_register);
 
 /*
@@ -946,27 +970,6 @@ int uprobe_apply(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-/*
- * uprobe_unregister - unregister a already registered probe.
- * @inode: the file in which the probe has to be removed.
- * @offset: offset from the start of the file.
- * @uc: identify which probe if multiple probes are colocated.
- */
-void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
-{
-	struct uprobe *uprobe;
-
-	uprobe = find_uprobe(inode, offset);
-	if (WARN_ON(!uprobe))
-		return;
-
-	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
-	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
-}
-EXPORT_SYMBOL_GPL(uprobe_unregister);
-
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-- 
1.8.3.1
