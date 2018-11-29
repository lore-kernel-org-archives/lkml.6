Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3561C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF892146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF892146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeK3Igs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:36:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbeK3Igs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:36:48 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wATLTvHu001812;
        Thu, 29 Nov 2018 22:29:57 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nxvnb6gft-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 29 Nov 2018 22:29:57 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 226D3468;
        Thu, 29 Nov 2018 22:29:27 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BDDE5981;
        Thu, 29 Nov 2018 21:29:56 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov
 2018 22:29:56 +0100
Received: from localhost (10.129.6.191) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov 2018 22:29:55
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 4/7] remoteproc: add warning on resource table cast
Date:   Thu, 29 Nov 2018 22:29:25 +0100
Message-ID: <1543526968-56091-5-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
References: <1543526968-56091-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.191]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_13:,,
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
 drivers/remoteproc/remoteproc_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 18a1bbf820c9..61c954bd695e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -772,6 +772,10 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 		dev_dbg(dev, "carveout mapped 0x%x to %pad\n",
 			mem->da, &dma);
 	} else {
+		/* Update device address as undefined by requester */
+		if (sizeof(dma_addr_t) > sizeof(u32))
+			dev_warn(dev, "DMA address cast in 32bit to fit resource table format\n");
+
 		mem->da = (u32)dma;
 	}
 
@@ -1150,6 +1154,10 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
 			 */
 
 			/* Use va if defined else dma to generate pa */
+			if (sizeof(dma_addr_t) > sizeof(u32) ||
+			    sizeof(phys_addr_t) > sizeof(u32))
+				dev_warn(dev, "Physical address cast in 32bit to fit resource table format\n");
+
 			if (entry->va)
 				rsc->pa = (u32)rproc_va_to_pa(entry->va);
 			else
-- 
2.7.4

