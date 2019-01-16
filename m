Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A827DC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89720883
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547634230;
	bh=38XnjTO57L9iqbktUZwHdTwH3cKDytQRT6rvrFQiMoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JcABOYLGP8svnPLG24s9NjpxkoJUgSa8JEimn3sowhauchJNxLg54c3XQhHc5DUh0
	 iaR3R1FwvmQkpOEVgQwV1H1LHPFXd8ew7B+lG5jxdmKV65HmlS69LFeNLGWPSPbhBI
	 5ovww8Mu2TMKFmnpqkBgzhf3KsGqSbhBz2CAvq7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391971AbfAPKXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:23:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34580 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389312AbfAPKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:23:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so4475181lfc.1;
        Wed, 16 Jan 2019 02:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJ5y+r34Be8kigWKj+hhR8ahXyO53U2Pxhu9H83xqfw=;
        b=VZZ02mxiD2T53Whtw4YvEvvajA7BpUHlcKUkLxnHwASyf6OBkSGa1g2q6dHI8T80Sg
         KjyJ/EJ/RNaGshIm2UzW4T9y30/mo+TLPa1ODkyjnpmA4uanqReP2/WXTPhQ4j7veib7
         kZgKESg940fcXvkc2OhEd/qCDf59WH43ERel2cjYyIRiTD1cxhO2RT5Q8VznaXH/tK/G
         SFt9Vwk4PQOAZ8d7L804wzDihhDbnDRqF5aLqkUxqMfdpQaD7UJHyq/drTn7Rpl4nF0j
         cQWE82TIj+OCtrbInJ1PyLP1ESX2jUpuglfA+tu67yEfxaeztxU+dY35o+HlrmlgOgKG
         nIsQ==
X-Gm-Message-State: AJcUukc+n2NNd9zXkGmG9KomZqa3GsmxkarjtKYhNhJ9ZYP/sJnftAPN
        nEvNTw6ftV/qch/TVGsA1JW8q/Nv
X-Google-Smtp-Source: ALg8bN6RWKHIYSUb21CL3IIt/572Xgsbnhzktgvl2pLQ6vLAL51ENr60rRsDpaDxEcworEF4m1VaLw==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr6095440lfb.121.1547634222245;
        Wed, 16 Jan 2019 02:23:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y14-v6sm956481ljj.55.2019.01.16.02.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:23:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gjiMH-0007vh-Nh; Wed, 16 Jan 2019 11:23:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 1/3] net: dsa: lantiq_gswip: fix use-after-free on failed probe
Date:   Wed, 16 Jan 2019 11:23:33 +0100
Message-Id: <20190116102335.30433-2-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116102335.30433-1-johan@kernel.org>
References: <20190116102335.30433-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to disable and deregister the switch on late probe errors to
avoid use-after-free when the device-resource-managed switch is freed.

Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Cc: stable <stable@vger.kernel.org>	# 4.20
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/dsa/lantiq_gswip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 693a67f45bef..b06c41c98de9 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1099,7 +1099,7 @@ static int gswip_probe(struct platform_device *pdev)
 		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
 			priv->hw_info->cpu_port);
 		err = -EINVAL;
-		goto mdio_bus;
+		goto disable_switch;
 	}
 
 	platform_set_drvdata(pdev, priv);
@@ -1109,6 +1109,9 @@ static int gswip_probe(struct platform_device *pdev)
 		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
 	return 0;
 
+disable_switch:
+	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
+	dsa_unregister_switch(priv->ds);
 mdio_bus:
 	if (mdio_np)
 		mdiobus_unregister(priv->ds->slave_mii_bus);
-- 
2.20.1

