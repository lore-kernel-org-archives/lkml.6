Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2732C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790A82084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759983;
	bh=ZNfSQmJKJDhPC9HngVAz5BAmQOiIVtF0/GbSBiI78p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgK6p2oPNleF/4/wIjqQKcaSl1JohuZZ375rTPIQCqUS5wgm1n753gtxQhubFi6yz
	 2iRvnd2OCVAaYps3jaPvF5GTPeewsvEqZqNPdvldOOpcjVCb8UE72dcx5qBsE7JaQH
	 +3obMLvXzHjLsFVHMKuAAqhhzNeRZ53/64MnxXos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfBUOjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfBUOjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC17A20838;
        Thu, 21 Feb 2019 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759979;
        bh=ZNfSQmJKJDhPC9HngVAz5BAmQOiIVtF0/GbSBiI78p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3D04zONYZ8c9Pau/Iuix4mlhQzFBvQ998Ui0uLYBzsBATeapUxpKSQSMmgf+QFF1
         mQsyxejRO7Ht1yGbgOnsObO8tQm7btqi3WxpanPenUOHOelK7gHBVEvPcA6CkrdBFj
         rbt2TVMFJBoFOBAWiHctsI0Zr951k+FyGFeGEvzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/23] net: stmmac: handle endianness in dwmac4_get_timestamp
Date:   Thu, 21 Feb 2019 15:35:54 +0100
Message-Id: <20190221125247.243572967@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Torgue <alexandre.torgue@st.com>

[ Upstream commit 224babd62d6f19581757a6d8bae3bf9501fc10de ]

GMAC IP is little-endian and used on several kind of CPU (big or little
endian). Main callbacks functions of the stmmac drivers take care about
it. It was not the case for dwmac4_get_timestamp function.

Fixes: ba1ffd74df74 ("stmmac: fix PTP support for GMAC4")
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -238,15 +238,18 @@ static inline u64 dwmac4_get_timestamp(v
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


