Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD0FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837FA20854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AJAz/vZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837FA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJYXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:40:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39578 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeJYXkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:40:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id e67-v6so3991433plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=micYtTo5QVhpN/6dTLcBOD4+EYbwLN/GgclMyLGFI8o=;
        b=AJAz/vZukC7viYZnrq/2G4+yfxAY/t9TmnoXeE1cbiuArKj+kty4X0dDyfJ6zH5iAT
         zT/Dum8fiRulu4kJP7aGT3mvOkLt0GkmrOiJZZNXsZyTqtQI/6xCrBYgDDAzTqPVIBwb
         ii5qRAiEvYpL8co8ghfpzyg3S7thh5+kkRBl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=micYtTo5QVhpN/6dTLcBOD4+EYbwLN/GgclMyLGFI8o=;
        b=CMRhpWXAVpHnOPIrljgcYHflWY+Sizvvl/feOdLp3Ld78fjrTBN8DE2SHF20yrt7n6
         TrMURtz7iJsKQwpttYN7Djo+9SLdu3HLxFLAga4gk80ZzctZActDXD+Z42qAyrIM3JUb
         7ok860RY7khts0qS4RBfTpHRjRM6MOFrTf3Jfv+KCrT7xAwLwc72C04iwOoLEG6AaDwD
         irEQ/pzYgELUBnn1j9cM4Ra44SIKBrZkQUz90sMsnXlMhbhICwsxLQ8Xpch0rPpHJinw
         0vwq4WNdsaV+IEExzx1V4M8eWJzpPG1E1kUKHrR4Sgyncm7k25GlhDfzVZgZ6SxTDMSz
         IcXA==
X-Gm-Message-State: AGRZ1gK0odnljltS9LgQU82hZyJND3BsWiurWlVCexL14WP1yAH9X8Hl
        CINRWKUiOugS05xDVmux3P+2UINjpKM=
X-Google-Smtp-Source: AJdET5cokFaU/vgx6y+4x+nQfj4h80GaC21KzcgNkFZPLdFTtQJNdFe20pDDAl93rVICY/hh+Y/iCg==
X-Received: by 2002:a17:902:9698:: with SMTP id n24-v6mr1912336plp.9.1540480033999;
        Thu, 25 Oct 2018 08:07:13 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.175])
        by smtp.gmail.com with ESMTPSA id 130-v6sm9777012pfz.174.2018.10.25.08.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 08:07:13 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2] arm64: defconfig: Enable MFD_AXP20X_I2C
Date:   Thu, 25 Oct 2018 20:36:59 +0530
Message-Id: <20181025150659.19657-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
connected via I2C.

Enable the driver for this PMIC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # OPI-1+
---
Changes for v2:
- collect Maxime ack
- add tested-by credit

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b1071d42b4ca..4aebbcf70f9f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -389,6 +389,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
-- 
2.18.0.321.gffc6fa0e3

