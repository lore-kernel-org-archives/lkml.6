Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD020879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfAJNtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:49:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45171 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729055AbfAJNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:30 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADf3T3008196;
        Thu, 10 Jan 2019 14:49:26 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ptvjg2pu3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:49:26 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E17AF31;
        Thu, 10 Jan 2019 13:49:25 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C113E504C;
        Thu, 10 Jan 2019 13:49:25 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:49:25 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:49:25
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 6/7] remoteproc: fix trace buffer va initialization
Date:   Thu, 10 Jan 2019 14:49:10 +0100
Message-ID: <1547128151-44077-7-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
References: <1547128151-44077-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With rproc_alloc_registered_carveouts() introduction, carveouts are
allocated after resource table parsing.
rproc_da_to_va() may return NULL at trace resource registering.
This patch modifies trace debufs registering to provide device address
(da) instead of va.
da to va translation is done at each trace buffer access
through debugfs interface.

Fixes: d7c51706d095 ("remoteproc: add alloc ops in rproc_mem_entry struct")

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
Changes from v1:
- Add missing implementation in rproc_resources_cleanup()
---
 drivers/remoteproc/remoteproc_core.c     | 35 ++++++++++++++------------------
 drivers/remoteproc/remoteproc_debugfs.c  | 21 +++++++++++++++----
 drivers/remoteproc/remoteproc_internal.h |  9 +++++++-
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e85722ee156b..45d97871ca69 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -564,9 +564,8 @@ void rproc_vdev_release(struct kref *ref)
 static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
 			      int offset, int avail)
 {
-	struct rproc_mem_entry *trace;
+	struct rproc_debug_trace *trace;
 	struct device *dev = &rproc->dev;
-	void *ptr;
 	char name[15];
 
 	if (sizeof(*rsc) > avail) {
@@ -580,28 +579,23 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
 		return -EINVAL;
 	}
 
-	/* what's the kernel address of this resource ? */
-	ptr = rproc_da_to_va(rproc, rsc->da, rsc->len);
-	if (!ptr) {
-		dev_err(dev, "erroneous trace resource entry\n");
-		return -EINVAL;
-	}
-
 	trace = kzalloc(sizeof(*trace), GFP_KERNEL);
 	if (!trace)
 		return -ENOMEM;
 
 	/* set the trace buffer dma properties */
-	trace->len = rsc->len;
-	trace->va = ptr;
+	trace->trace_mem.len = rsc->len;
+	trace->trace_mem.da = rsc->da;
+
+	/* set pointer on rproc device */
+	trace->rproc = rproc;
 
 	/* make sure snprintf always null terminates, even if truncating */
 	snprintf(name, sizeof(name), "trace%d", rproc->num_traces);
 
 	/* create the debugfs entry */
-	trace->priv = rproc_create_trace_file(name, rproc, trace);
-	if (!trace->priv) {
-		trace->va = NULL;
+	trace->tfile = rproc_create_trace_file(name, rproc, trace);
+	if (!trace->tfile) {
 		kfree(trace);
 		return -EINVAL;
 	}
@@ -610,8 +604,8 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
 
 	rproc->num_traces++;
 
-	dev_dbg(dev, "%s added: va %pK, da 0x%x, len 0x%x\n",
-		name, ptr, rsc->da, rsc->len);
+	dev_dbg(dev, "%s added: da 0x%x, len 0x%x\n",
+		name, rsc->da, rsc->len);
 
 	return 0;
 }
@@ -1205,15 +1199,16 @@ static void rproc_coredump_cleanup(struct rproc *rproc)
 static void rproc_resource_cleanup(struct rproc *rproc)
 {
 	struct rproc_mem_entry *entry, *tmp;
+	struct rproc_debug_trace *trace, *ttmp;
 	struct rproc_vdev *rvdev, *rvtmp;
 	struct device *dev = &rproc->dev;
 
 	/* clean up debugfs trace entries */
-	list_for_each_entry_safe(entry, tmp, &rproc->traces, node) {
-		rproc_remove_trace_file(entry->priv);
+	list_for_each_entry_safe(trace, ttmp, &rproc->traces, node) {
+		rproc_remove_trace_file(trace->tfile);
 		rproc->num_traces--;
-		list_del(&entry->node);
-		kfree(entry);
+		list_del(&trace->node);
+		kfree(trace);
 	}
 
 	/* clean up iommu mapping entries */
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index e90135c64af0..11240b4d0a91 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -47,10 +47,23 @@ static struct dentry *rproc_dbg;
 static ssize_t rproc_trace_read(struct file *filp, char __user *userbuf,
 				size_t count, loff_t *ppos)
 {
-	struct rproc_mem_entry *trace = filp->private_data;
-	int len = strnlen(trace->va, trace->len);
+	struct rproc_debug_trace *data = filp->private_data;
+	struct rproc_mem_entry *trace = &data->trace_mem;
+	void *va;
+	char buf[100];
+	int len;
+
+	va = rproc_da_to_va(data->rproc, trace->da, trace->len);
+
+	if (!va) {
+		len = scnprintf(buf, sizeof(buf), "Trace %s not available\n",
+				trace->name);
+		va = buf;
+	} else {
+		len = strnlen(va, trace->len);
+	}
 
-	return simple_read_from_buffer(userbuf, count, ppos, trace->va, len);
+	return simple_read_from_buffer(userbuf, count, ppos, va, len);
 }
 
 static const struct file_operations trace_rproc_ops = {
@@ -288,7 +301,7 @@ void rproc_remove_trace_file(struct dentry *tfile)
 }
 
 struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
-				       struct rproc_mem_entry *trace)
+				       struct rproc_debug_trace *trace)
 {
 	struct dentry *tfile;
 
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f6cad243d7ca..7d8936688164 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -25,6 +25,13 @@
 
 struct rproc;
 
+struct rproc_debug_trace {
+	struct rproc *rproc;
+	struct dentry *tfile;
+	struct list_head node;
+	struct rproc_mem_entry trace_mem;
+};
+
 /* from remoteproc_core.c */
 void rproc_release(struct kref *kref);
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
@@ -37,7 +44,7 @@ void rproc_remove_virtio_dev(struct rproc_vdev *rvdev);
 /* from remoteproc_debugfs.c */
 void rproc_remove_trace_file(struct dentry *tfile);
 struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
-				       struct rproc_mem_entry *trace);
+				       struct rproc_debug_trace *trace);
 void rproc_delete_debug_dir(struct rproc *rproc);
 void rproc_create_debug_dir(struct rproc *rproc);
 void rproc_init_debugfs(void);
-- 
2.7.4

