Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC40C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFC020855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFC020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeKZILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:11:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:11:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so15470346qte.11;
        Sun, 25 Nov 2018 13:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=pHzAzHhNc0z/FMpnZXFEjL0s8efZLZAz089bFx1FlsM=;
        b=PBmF+yvorbXoceR7O/N/U0NZ7VGl9QXJiFQ4XFuGC+2a3jFyDf7gFu8ogprrN7fxEX
         MBEnENnGOx1BAwXwOVXuR8S59juoJKe7a9WhuOKXKk8DsiZJ2Q5OZJU5q5YNYiTnNM3U
         jeCeN5hPHT9OLF74QfPrwkQXdEbe604XPUHWwozYHOlBkyJ8Rjbeck+vAvL2FqejXA9a
         I1hgbxl2c82kE/9cFLPbH00i5q3lTwm7+dUBkRT4S8d8L22uTcvLahBA5AHFhn4hkQf4
         r1Dc7yQKFUcECuFFGrpLwtintea+QsjabfWcErtMoh+gE6Fo6V/V1U+58M1vxC7gQ4LP
         SD4w==
X-Gm-Message-State: AA+aEWbQk47OCPAo1b39sPzVHzPcrd57G9AlrH/f2TAqHCaqXBatwUET
        2XbAx7ETaNCzpDYBk0igBS/NzcbH
X-Google-Smtp-Source: AFSGD/V/b/s/5ounGvWdXie0Dbii7EYHa2xhg7smezLs+OT0XpuoR77dyE1/1bewBj5bvn2fDQ3Dng==
X-Received: by 2002:ad4:410c:: with SMTP id i12mr23163168qvp.219.1543180787011;
        Sun, 25 Nov 2018 13:19:47 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id q70sm33922665qkq.10.2018.11.25.13.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:46 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:39 -0200
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
Subject: [PATCH 05/13] net: stmmac: dwmac-rk: Do not print error when PHY regulator is not found
Date:   Sun, 25 Nov 2018 19:18:59 -0200
Message-Id: <20181125211907.9895-5-otavio@ossystems.com.br>
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

The PHY regulator is optional, so when it is not present move the message
level from error to debug, which is more appropriate.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
---

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index c895a9a6939a..6b4ea95a30e0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1242,7 +1242,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 			dev_err(dev, "phy regulator is not available yet, deferred probing\n");
 			return ERR_PTR(-EPROBE_DEFER);
 		}
-		dev_err(dev, "no regulator found\n");
+		dev_dbg(dev, "no regulator found\n");
 		bsp_priv->regulator = NULL;
 	}
 
-- 
2.19.1

