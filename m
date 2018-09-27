Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C118FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1221547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK5oxA1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF1221547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeI0U0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeI0U0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so1443884pgq.9;
        Thu, 27 Sep 2018 07:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6x61LsIEMPBlMr59UuLtUedNy+MpQHDFd6/mORvL11w=;
        b=hK5oxA1kT3GF/C0NdnkiSQKmbAxE8f0r24KbjjU2EKGiTUP36hhvdhM64exlFWt9pv
         cQos8Flq+D6+etuwtu61Yv9nVht0FVRQqqGP+g7PcXwgfK43piS1EAHZKQUo60S9mA0p
         b8E13xBBc5VqSKuR7zpuqB+uP4sDdY3XP3XlclSZ7+dH27IbQVRCI44geuk2oiN5JNr2
         ZTK3MoEZnyD+fn+fy+Wv6PKoecV6k4Vd+l+YnRrkFAYXrenwjimiwuu3CDBdemz5FL89
         VDZaQpzlkuVspjKrCH8Xar4PnPl2BTLVQGWzlXSs7aL4g9EY7k+yuP39TUeG3Z0PNySu
         l9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6x61LsIEMPBlMr59UuLtUedNy+MpQHDFd6/mORvL11w=;
        b=fOFyyB777k9H8+eFJOzHC1PcXi299dT6z0mJejwR2kU280HimWf3v40PG0FVa0/13R
         uekscmHQqHKxrVJBJumiO2cHcycZFuWSh+Itcpd+en5TXKzTlASXpsgy4QrITeplSucl
         h0vvspumRLi1VuysSu1Dflr/5QWyoZ8inP1n+2UedStrx7x9o9y+dnqqBvIWP/vZuujg
         jvHvN6TOpt34yLFxp6fP1iFFyvhR6WgywcYV17/+PsZeGk2KihujV61g9QFSY9NFnJz+
         mPBIcEstVwVaZKtRYm1oa543TmKJGm6+Dn9hZZT7Kk2RGudQvm7b3eyp52s5vZXokDIs
         Xxgw==
X-Gm-Message-State: ABuFfohCOnW5p2ZGF4D5I6Sl7avetlQ2IT+aZYEsMOxkvFW511qLzSOa
        0/uvbiAzgoiqxLclvkVrhoY=
X-Google-Smtp-Source: ACcGV615vJqnSIKgvgZ3wV3wvJQoyk/Afvl/CmrUd9Ref4PhlrIehb8cxmfaUyh1+OyTEBCXOonkaA==
X-Received: by 2002:a63:1b52:: with SMTP id b18-v6mr10408382pgm.303.1538057307578;
        Thu, 27 Sep 2018 07:08:27 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:08:27 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv5 6/6] mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
Date:   Thu, 27 Sep 2018 14:07:38 +0000
Message-Id: <20180927140738.1006-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tuning for sdr and ddr timing for USH-I mode sdr104/sdr50/ddr50
for host controller.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
No changes from previous patch
---
 drivers/mmc/host/dw_mmc-exynos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index ab47b018716a..d46c3439b508 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -253,6 +253,8 @@ static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 	if (timing == MMC_TIMING_MMC_HS400) {
 		dqs |= DATA_STROBE_EN;
 		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
+	} else if (timing == MMC_TIMING_UHS_SDR104) {
+		dqs &= 0xffffff00;
 	} else {
 		dqs &= ~DATA_STROBE_EN;
 	}
@@ -312,6 +314,15 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		if (ios->bus_width == MMC_BUS_WIDTH_8)
 			wanted <<= 1;
 		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_SDR50:
+		clksel = (priv->sdr_timing & 0xfff8ffff) |
+			(priv->ciu_div << 16);
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		clksel = (priv->ddr_timing & 0xfff8ffff) |
+			(priv->ciu_div << 16);
+		break;
 	default:
 		clksel = priv->sdr_timing;
 	}
-- 
2.17.1

