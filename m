Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E84320663
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502599AbfBNQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:04:01 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405282AbfBNQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:04:00 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EG1j6E022794;
        Thu, 14 Feb 2019 17:03:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qn0jwughc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 17:03:47 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D51831;
        Thu, 14 Feb 2019 16:03:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2044258E8;
        Thu, 14 Feb 2019 16:03:46 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb 2019 17:03:46
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [net-next, PATCH v2] net: stmmac: use correct define to get rx timestamp on GMAC4
Date:   Thu, 14 Feb 2019 17:03:44 +0100
Message-ID: <1550160224-8927-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dwmac4_wrback_get_rx_timestamp_status we looking for a RX timestamp.
For that receive descriptors are handled and so we should use defines
related to receive descriptors. It'll no change the functional behavior
as RDES3_RDES1_VALID=TDES3_RS1V=BIT(26) but it makes code easier to read.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

changes since v1:
 *use le32_to_cpu to handle endianess

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 20299f6..90045ff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -268,7 +268,7 @@ static int dwmac4_wrback_get_rx_timestamp_status(void *desc, void *next_desc,
 	int ret = -EINVAL;
 
 	/* Get the status from normal w/b descriptor */
-	if (likely(p->des3 & TDES3_RS1V)) {
+	if (likely(le32_to_cpu(p->des3) & RDES3_RDES1_VALID)) {
 		if (likely(le32_to_cpu(p->des1) & RDES1_TIMESTAMP_AVAILABLE)) {
 			int i = 0;
 
-- 
2.7.4

