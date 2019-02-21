Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA342080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760234;
	bh=zxDnsBie/iHvk8CmDKUFmeKd7xG1o+QKWLDOVrc0iB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eufceRYUZuNlqxWRAOaH+owp39h/wGTfJM4NV/X+5wNQoEsUjKSKfKdwK3Zwln0kt
	 AMqtoy1ukK10GIp9rcf3Lg36fKePGLQgaGm8l7AnL63ut5m0rdsmEZrQf05fuFSw7/
	 EGEFE8d97HZAIZfNj0XnW1DT98EMRlHVfSwIBmAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBUOnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbfBUOnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0F92080D;
        Thu, 21 Feb 2019 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760229;
        bh=zxDnsBie/iHvk8CmDKUFmeKd7xG1o+QKWLDOVrc0iB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uodC64/kDGSA82hY83JKn2mGaNoohadchF/Km62jNf4JIuHH2BgnsYDb8b1WM8dV0
         oATtzPrxeDPBxCrcj0i9cu9JsP0q69BkuoCcNlH6tJNXnzT/tY2+m40a5ZW8mK+YRx
         hqTkVQgf5/8ZN6SXlMydyrh4922l1Qj1oEJVQz/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 12/32] net: stmmac: handle endianness in dwmac4_get_timestamp
Date:   Thu, 21 Feb 2019 15:36:00 +0100
Message-Id: <20190221125251.565109844@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 224babd62d6f19581757a6d8bae3bf9501fc10de ]

GMAC IP is little-endian and used on several kind of CPU (big or little
endian). Main callbacks functions of the stmmac drivers take care about
it. It was not the case for dwmac4_get_timestamp function.

Fixes: ba1ffd74df74 ("stmmac: fix PTP support for GMAC4")
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 20299f6f65fce..736e29635b772 100644
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
2.19.1



