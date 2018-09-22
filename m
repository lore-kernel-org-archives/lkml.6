Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6FEECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A692154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3HH4Yrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A692154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIVNue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:50:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37353 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeIVNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:50:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id q1-v6so1464825plr.4;
        Sat, 22 Sep 2018 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6x61LsIEMPBlMr59UuLtUedNy+MpQHDFd6/mORvL11w=;
        b=u3HH4YrwJujQk/fRc0wt3bzcAT8sQNKVBzaOceZg7FWl44rxke1+BzNfdI8Lg7fgeH
         MSXT+EIeZvV19zjury+E2mJShfpmXKtmk5rkVXsmYAeWh0hMXSuMmHdhwjrBAKmG/wuE
         YWba8tEIs2uQsmwJ1I23tvTx7KEFJN/nAs9LTTl9Jdon+kR/pfDHupXNBUbUxVBrJGlF
         Ju0pzf/XPFGRMwKVTm9mXDeDo/Xv8rxtb11GvNv1fw6xRfNJOPI2H7+7U+OhaUrcp6Xt
         CH6ISlOPePZaV3ERPsk6XTdOdZIG1/z503EsHG2fnMgW61E/MJzCctJvyfoT8CEViSIg
         ibEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6x61LsIEMPBlMr59UuLtUedNy+MpQHDFd6/mORvL11w=;
        b=hnwM328E1Cnyq75UdBVNO64HrW6fnAd5H7583HvNBv7zDQQb1QQf75xzE1CeScqlx/
         hLXdRq6FJJK5F8rgG7uRJ4nlZQ34eC0uvC4PJSR4/rF6OVXNX2kaTa0PqSAgct+lpLBz
         ZjWyUfBTAz1ZGaYOQyTt8Q7TTGNWR9zIqhCYebBIlhsFC8mcX/oKOtvplXlp1DJiWAPS
         AQ859AfiCKJZ3MJgrszvXUq2IYDRHtAWdVc8Irxub6uHbXGJuox9YZE3hbFS0ImHuetF
         bS7mC00DeiQs+uOhvLHjmDuvja4vA7g5dVSeHDS8lLls3vB08wk+H1pt4zUWZbumDpNi
         TTzw==
X-Gm-Message-State: ABuFfohfMo/7Y/anIQmRNPtZotJYydiclBG5a8ORHo3Bg9YcDJZKS36G
        wLFHgZBsGFWtnWyfGfKU78g=
X-Google-Smtp-Source: ACcGV60UBqHVmX1zgFJ6IrSrng0L/uAZ9QpWXgG89XeICEWavgeDrROmWO+MYG3h0UYu2etdUch1fA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr1492340pla.131.1537603075182;
        Sat, 22 Sep 2018 00:57:55 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id o10-v6sm30713164pgp.70.2018.09.22.00.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:57:54 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv4 6/6] mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
Date:   Sat, 22 Sep 2018 07:57:32 +0000
Message-Id: <20180922075732.946-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075732.946-1-linux.amoon@gmail.com>
References: <20180922075732.946-1-linux.amoon@gmail.com>
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

