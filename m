Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11796C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B9820879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfAJNth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:49:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45172 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729071AbfAJNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:32 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADf37u008195;
        Thu, 10 Jan 2019 14:49:27 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ptvjg2pu5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:49:27 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0787F38;
        Thu, 10 Jan 2019 13:49:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4681504E;
        Thu, 10 Jan 2019 13:49:26 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:49:26 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:49:26
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 7/7] remoteproc: fix rproc_check_carveout_da() returned error and comments
Date:   Thu, 10 Jan 2019 14:49:11 +0100
Message-ID: <1547128151-44077-8-git-send-email-loic.pallardy@st.com>
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

Fix typo in comments.
Change returned error from ENOMEM to EINVAL as
not dealing with memory allocation.
Remove carveout forced da update and return an error
when no configuration match

Fixes: c874bf59add0 ("remoteproc: add helper function to check carveout device address")

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 45d97871ca69..fc9bf99cd96f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -278,25 +278,27 @@ rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...)
  * @len: associated area size
  *
  * This function is a helper function to verify requested device area (couple
- * da, len) is part of specified carevout.
+ * da, len) is part of specified carveout.
+ * If da is not set (defined as FW_RSC_ADDR_ANY), only requested length is
+ * checked.
  *
- * Return: 0 if carveout match request else -ENOMEM
+ * Return: 0 if carveout matches request else error
  */
-int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry *mem,
-			    u32 da, u32 len)
+static int rproc_check_carveout_da(struct rproc *rproc,
+				   struct rproc_mem_entry *mem, u32 da, u32 len)
 {
 	struct device *dev = &rproc->dev;
-	int delta = 0;
+	int delta;
 
 	/* Check requested resource length */
 	if (len > mem->len) {
 		dev_err(dev, "Registered carveout doesn't fit len request\n");
-		return -ENOMEM;
+		return -EINVAL;
 	}
 
 	if (da != FW_RSC_ADDR_ANY && mem->da == FW_RSC_ADDR_ANY) {
-		/* Update existing carveout da */
-		mem->da = da;
+		/* Address doesn't match registered carveout configuration */
+		return -EINVAL;
 	} else if (da != FW_RSC_ADDR_ANY && mem->da != FW_RSC_ADDR_ANY) {
 		delta = da - mem->da;
 
@@ -304,13 +306,13 @@ int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry *mem,
 		if (delta < 0) {
 			dev_err(dev,
 				"Registered carveout doesn't fit da request\n");
-			return -ENOMEM;
+			return -EINVAL;
 		}
 
 		if (delta + len > mem->len) {
 			dev_err(dev,
 				"Registered carveout doesn't fit len request\n");
-			return -ENOMEM;
+			return -EINVAL;
 		}
 	}
 
-- 
2.7.4

