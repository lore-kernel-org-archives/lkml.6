Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C4120835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCRD4xO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C4120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeH3TsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54866 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeH3TsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so2472489wmb.4;
        Thu, 30 Aug 2018 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/SC5i8JP4t8++oAR2mX2JW6l48vvz33dbW/6zVBuRL4=;
        b=TCRD4xO+1P11C2egwwKOMJhII4iYcUVlekbe6kDOlOTwzPR2/AsGcMNYK5/zyOMcP4
         hf4mYEPT7qPIvpJpEIYIOitl5KuE6/tiZXV0sMX3Vb1sI3QtqVuRSxIpB/7jAaR5Dmyh
         nvobXecTK8ZUe1YOCf/EJzPKgppOZRk6nmSUTnpWVvkpfc8gmJlofyfN04w89Hi9NmVA
         szZ79KDQAnVY9FXMLIt2NcoRNEeECdWLTHHReKLFSh6sedsqR1RtlwBd9nzgo5G5GqXo
         pVy6Qi5zUNVvlfymNE7zGE0868zhCjNAlTzXYpcHrKlMjsFtpBTQXnqTNnuUjbNHw8eh
         yneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/SC5i8JP4t8++oAR2mX2JW6l48vvz33dbW/6zVBuRL4=;
        b=WHy9TNLXZJZ+NnJYkTGBpNJ4gbtd6j1EHf1GXU8YAzPSTV2EHrCzfkJaAVx0koellH
         DY8HkieD8TGc2hkrnArMMoawVV+Gjv90v1Uzp3ErjwYRTLlpzWOhB0pEHlzbjjVL3Nzr
         2GzOw9BOWclz9izxdRahcdpZjjlgyFXRUmItIQwEhc5sp37NvzKc0QbOtBlpiiqBYUVt
         1kSKf1eA+xhAhsNVXMn5Djbbd6dOp2qAl/48WLfq4/AdUMFLSMxRGzAXO4E9hluxu7zi
         OaC2KZs9xr9AibkM1LnhEWWzvoqZVxtTuCz4c4GMOPk2huyj0+xT8wNMzjLUKOECRowQ
         PQ5g==
X-Gm-Message-State: APzg51Aopht6/HzZAYTr22fdnKtomLApyyLAOIwV5QYam7KGCig3jtCG
        WcmVEOwThKYBLaHLlJ2Kzac=
X-Google-Smtp-Source: ANB0VdaLjA7zyEY01kY8ytkdtd7jeSNKwZ6haIieI8UVzOWiFROpu2oWoL9rBquUlscVb+GPgEv0bw==
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr2023371wmd.145.1535643932712;
        Thu, 30 Aug 2018 08:45:32 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:32 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 13/30] arm: config: Enable SUN4I_GPADC in defconfig
Date:   Thu, 30 Aug 2018 17:45:01 +0200
Message-Id: <20180830154518.29507-14-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have now new compatibles we can enable the SUN4I_GPADC driver
next to the sun4i-ts driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..2189349820ac 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -132,6 +132,7 @@ CONFIG_DMA_SUN6I=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXTCON=y
 CONFIG_IIO=y
+CONFIG_SUN4I_GPADC=y
 CONFIG_AXP20X_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_SUN4I=y
-- 
2.11.0

