Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F32C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2ED2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2ED2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeKZILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:11:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36562 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:11:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so15481417qtn.3;
        Sun, 25 Nov 2018 13:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=r/2+M63UuAJuJms3m/6f1vD2KKXomz0M49HpXRFfEag=;
        b=pciXTj9p2DX8/hYggkJsf1TR1ydebLSCmvjxYhdQDgZXBsW4hBG7PNteaRH9Qe3KgQ
         iqc1HeGVxrlJ3SCthZVTFVO9ns6C1PVRDkI5A0Ux12Gvf7szPclKchDF+L/n598FqO8W
         /a5uCAwTNEWrgHWzMaioi4hZsLlrf27aT1b6yj1MsWucg416U1V/PqN6iRjcEVb3Tv8v
         oBdTolIorRunADfCld+LJWPd/h2LO/vceoZnQN3u1/lRJN2rMu1dz/vHD8nv7B6HAdbu
         PUWLN6Pnudxu0vn53HQsSLjUGaF94uuFBJWKD6oMDOxHrIIKxeNCJgXMhMiPb0VEzpTa
         BnqQ==
X-Gm-Message-State: AGRZ1gK+vNMPgDm2c5EY44O0EhMIBwchmt5dd0gj9CYoU66xDyj7z8v9
        0dNxqSx8t3G7xbtUX4YVH9z6QmX7
X-Google-Smtp-Source: AJdET5eAy7UACFbqLvZPY1JaT+cGFqwOyA4bFFnEFtf5vxo9xgyfsuZlU/YnGTMjE9+zyIK3aCUtCQ==
X-Received: by 2002:ac8:962:: with SMTP id z31mr22630315qth.305.1543180772089;
        Sun, 25 Nov 2018 13:19:32 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id b188sm13642238qkc.58.2018.11.25.13.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:31 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:25 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Jose Abreu <joabreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 03/13] net: stmmac: dwmac-rk: Allow the driver to probe when phy-supply is not present
Date:   Sun, 25 Nov 2018 19:18:57 -0200
Message-Id: <20181125211907.9895-3-otavio@ossystems.com.br>
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

The phy-supply is an optional regulator, so we should not treat
as an error when phy-supply is not passed in the device tree.

This allows the dwmac-rk driver to probe when phy-supply is not
present in the dts.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 7b923362ee55..73855622445b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1205,7 +1205,7 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 
 	if (!ldo) {
 		dev_err(dev, "no regulator found\n");
-		return -1;
+		return 0;
 	}
 
 	if (enable) {
-- 
2.19.1

