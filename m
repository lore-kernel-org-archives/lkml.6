Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE89EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A473A2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393485AbfBOJtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:49:23 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39247 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404070AbfBOJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:49:22 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1F9mQlH008930;
        Fri, 15 Feb 2019 10:49:11 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qn0jx04ry-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 15 Feb 2019 10:49:11 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6EC831;
        Fri, 15 Feb 2019 09:49:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A08A2BD4;
        Fri, 15 Feb 2019 09:49:10 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Feb 2019 10:49:10
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <f.fainelli@gmail.com>
Subject: [net, PATCH v2] net: stmmac: handle endianness in dwmac4_get_timestamp
Date:   Fri, 15 Feb 2019 10:49:09 +0100
Message-ID: <1550224149-30380-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GMAC IP is little-endian and used on several kind of CPU (big or little
endian). Main callbacks functions of the stmmac drivers take care about
it. It was not the case for dwmac4_get_timestamp function.

Fixes: ba1ffd74df74 ("stmmac: fix PTP support for GMAC4")

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

changes since V1:
 -consider this patch as a fix
 -change targeted tree from net-next to net

regards
Alex


diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 20299f6..736e296 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -241,15 +241,18 @@ static inline void dwmac4_get_timestamp(void *desc, u32 ats, u64 *ts)
 static int dwmac4_rx_check_timestamp(void *desc)
 {
 	struct dma_desc *p = (struct dma_desc *)desc;
+	unsigned int rdes0 = le32_to_cpu(p->des0);
+	unsigned int rdes1 = le32_to_cpu(p->des1);
+	unsigned int rdes3 = le32_to_cpu(p->des3);
 	u32 own, ctxt;
 	int ret = 1;
 
-	own = p->des3 & RDES3_OWN;
-	ctxt = ((p->des3 & RDES3_CONTEXT_DESCRIPTOR)
+	own = rdes3 & RDES3_OWN;
+	ctxt = ((rdes3 & RDES3_CONTEXT_DESCRIPTOR)
 		>> RDES3_CONTEXT_DESCRIPTOR_SHIFT);
 
 	if (likely(!own && ctxt)) {
-		if ((p->des0 == 0xffffffff) && (p->des1 == 0xffffffff))
+		if ((rdes0 == 0xffffffff) && (rdes1 == 0xffffffff))
 			/* Corrupted value */
 			ret = -EINVAL;
 		else
-- 
2.7.4

