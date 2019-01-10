Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD138C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B547B20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfAJNtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:49:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32071 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729023AbfAJNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:28 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADfOr8008990;
        Thu, 10 Jan 2019 14:49:24 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptwtdsw0u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 10 Jan 2019 14:49:24 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E345234;
        Thu, 10 Jan 2019 13:49:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C6CEE504D;
        Thu, 10 Jan 2019 13:49:23 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan
 2019 14:49:23 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 10 Jan 2019 14:49:22
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v2 4/7] remoteproc: add warning on resource table cast
Date:   Thu, 10 Jan 2019 14:49:08 +0100
Message-ID: <1547128151-44077-5-git-send-email-loic.pallardy@st.com>
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

Today resource table supports only 32bit address fields.
This is not compliant with 64bit platform for which addresses
are cast in 32bit.
This patch adds warn messages when address cast is done.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

---
Changes from v1:
- modify implementation to display warning message only when
  data are modified by cast operation
---
 drivers/remoteproc/remoteproc_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 18a1bbf820c9..0ecd37993f41 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -45,6 +45,8 @@
 
 #include "remoteproc_internal.h"
 
+#define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
+
 static DEFINE_MUTEX(rproc_list_mutex);
 static LIST_HEAD(rproc_list);
 
@@ -772,6 +774,10 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
 			mem->da, &dma);
 	} else {
+		/* Update device address as undefined by requester */
+		if ((u64)dma & HIGH_BITS_MASK)
+			dev_warn(dev, "DMA address cast in 32bit to fit resource table format\n");
+
 		mem->da = (u32)dma;
 	}
 
@@ -1115,6 +1121,7 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
 	struct rproc_mem_entry *entry, *tmp;
 	struct fw_rsc_carveout *rsc;
 	struct device *dev = &rproc->dev;
+	u64 pa;
 	int ret;
 
 	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
@@ -1151,10 +1158,15 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
 
 			/* Use va if defined else dma to generate pa */
 			if (entry->va)
-				rsc->pa = (u32)rproc_va_to_pa(entry->va);
+				pa = (u64)rproc_va_to_pa(entry->va);
 			else
-				rsc->pa = (u32)entry->dma;
+				pa = (u64)entry->dma;
+
+			if (((u64)pa) & HIGH_BITS_MASK)
+				dev_warn(dev,
+					 "Physical address cast in 32bit to fit resource table format\n");
 
+			rsc->pa = (u32)pa;
 			rsc->da = entry->da;
 			rsc->len = entry->len;
 		}
-- 
2.7.4

