Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91D5ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E5C20882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GImp8Plq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E5C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeIOFyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:54:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeIOFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:54:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8F0bSGX030650;
        Fri, 14 Sep 2018 19:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536971848;
        bh=wLEYCzC9XufBzVfjjUNucSdiCcLogJD4kaqjN567E+s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GImp8Plq9X0wJlxcM7EmsAIuMPRjI0lcXNCaDb/ZM/iCpEyF4oDP4SiP8RcUBECcF
         Si8H9yyuP6OZdFi0Tq66D9EL3HrHXKz3h9F7Nq9qMW/a6KQVNT7qkWcicgd1iaIJUS
         G2MFnLydd1iT/0dXbwp1Dkk3R7MSjGpKOQCFP/Ns=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bSPf023617;
        Fri, 14 Sep 2018 19:37:28 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 14
 Sep 2018 19:37:28 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 14 Sep 2018 19:37:28 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bSx9018266;
        Fri, 14 Sep 2018 19:37:28 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8F0bRx13351;
        Fri, 14 Sep 2018 19:37:27 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/5] remoteproc: Introduce deny_sysfs_ops flag
Date:   Fri, 14 Sep 2018 19:37:24 -0500
Message-ID: <20180915003725.17549-5-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180915003725.17549-1-s-anna@ti.com>
References: <20180915003725.17549-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remoteproc framework provides sysfs interfaces for changing
the firmware name and for starting/stopping a remote processor
through the sysfs files 'state' and 'firmware'. These interfaces
are currently allowed irrespective of how the remoteprocs were
booted (like remoteproc self auto-boot, remoteproc client-driven
boot etc). These interfaces can adversely affect a remoteproc
and its clients especially when a remoteproc is being controlled
by a remoteproc client driver(s). Also, not all remoteproc
drivers may want to support the sysfs interfaces by default.

Add support to deny the sysfs state/firmware change by introducing
a state flag 'deny_sysfs_ops' that the individual remoteproc drivers
can set based on their usage needs. The default behavior is to
allow the sysfs operations as before.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 8 ++++++++
 include/linux/remoteproc.h            | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index ce93f4d710f3..b2d8c11b89d0 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -36,6 +36,10 @@ static ssize_t firmware_store(struct device *dev,
 	char *p;
 	int err, len = count;
 
+	/* restrict sysfs operations if not allowed by remoteproc drivers */
+	if (rproc->deny_sysfs_ops)
+		return -EPERM;
+
 	err = mutex_lock_interruptible(&rproc->lock);
 	if (err) {
 		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
@@ -102,6 +106,10 @@ static ssize_t state_store(struct device *dev,
 	struct rproc *rproc = to_rproc(dev);
 	int ret = 0;
 
+	/* restrict sysfs operations if not allowed by remoteproc drivers */
+	if (rproc->deny_sysfs_ops)
+		return -EPERM;
+
 	if (sysfs_streq(buf, "start")) {
 		if (rproc->state == RPROC_RUNNING)
 			return -EBUSY;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 75f9ca05b865..d21252b4f758 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -440,6 +440,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @deny_sysfs_ops: flag to not permit sysfs operations on state and firmware
  * @dump_segments: list of segments in the firmware
  */
 struct rproc {
@@ -472,6 +473,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool deny_sysfs_ops;
 	struct list_head dump_segments;
 };
 
-- 
2.18.0

