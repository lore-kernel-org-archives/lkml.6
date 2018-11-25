Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DF42084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DF42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKZILk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:11:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42835 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:11:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so15472174qtq.9;
        Sun, 25 Nov 2018 13:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=C6R+qDyqlpWn0q3ocsfJiX9fqgAizmAInnj+rDl9fvk=;
        b=A87tFJQ1+0PJJ24u8tpnIwc9A/bNdvJDT1KEcE03/MqgXwTNADMsG+QFr4hj7VvMO6
         sRyWt2Hc0SSs2jlfWkhL7a7IbuA0a1+qUg601pctEfeYiQmc1VRPtlJIJFiPWP9RWo4K
         xpUMhhIyv2dWcFFhxTLnBIc8pwOZh0ImPw2cWCpxLDh3yjkpg7CEoKlHWfGJjeB+n9iH
         isxCF1zrb3c5Hd4ne7JVIIQkssLoPNG4roU5AVkj0HBuw222U+BG7jRfVQ6XAWP85ubC
         Afq3qDfLXFaAUuDWdNr8B/F+WJq8jJbhKhKOjL09V4sDnsqf+HAgGlELTwS0xDmYJc+r
         2m5Q==
X-Gm-Message-State: AA+aEWboOSoEduTHudBauR+znsPptf/J1r7lNrL+0182u5PQvFKDpJ82
        Hcz6B06Xzyai/7eAX/kkb14iENXx
X-Google-Smtp-Source: AFSGD/WD7ZEFHung7/AsWCHqTvU5aRTsdWLTHpaQ1r/9X7BfKwotFk3IVLfvvNVJZzpEoiHoE7PPMQ==
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr23454409qvr.85.1543180779340;
        Sun, 25 Nov 2018 13:19:39 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id a54sm25897391qtc.17.2018.11.25.13.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:38 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:32 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Berton <fabio.berton@ossystems.com.br>,
        Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 04/13] net: stmmac: dwmac-rk: Do not print redundant error message
Date:   Sun, 25 Nov 2018 19:18:58 -0200
Message-Id: <20181125211907.9895-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk_gmac_setup() already prints a message saying that the PHY regulator
is not found, so we should not print it again.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 73855622445b..c895a9a6939a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1203,10 +1203,8 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo) {
-		dev_err(dev, "no regulator found\n");
+	if (!ldo)
 		return 0;
-	}
 
 	if (enable) {
 		ret = regulator_enable(ldo);
-- 
2.19.1

