Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B8C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D805B20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR1TG2h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D805B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLIUbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeLIUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so7761814ljc.8;
        Sun, 09 Dec 2018 12:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e34Nm1WV2akdw7lRe24Ur4h5DQ35+UooTwGQ4UYjV/k=;
        b=UR1TG2h8aEMOUnnQR4kWPbex+sXVUIvSkEDp2Kg0B9y/mqMMu/eQzBYDYuu8x5pxMQ
         m1f/kTJDJ/XCHs2aJEASX/lI32ScnaFZj1lUYOdB21CiJMA0mI6IZS+6DG2cTyO4xdnl
         fG4Bn6OvL3sBTo+jpyj/yVS60oyf3yhVNJxh2ubftavcjXRBOuw77NCsR/jimu7QJxRa
         zOY0nedBO7tgFkBgKw+Q7d8ZEGDt5kPqr7wO5L9tHmdw2wfQZXQXey2MKw3Vl29nJKwG
         s6A3LOqb7PIP+BlgdFe/4vmsEEp1z75XlCv/u35N4frJZ6tmkwhd/c69nrTS2HrtrP+A
         6L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e34Nm1WV2akdw7lRe24Ur4h5DQ35+UooTwGQ4UYjV/k=;
        b=dkpisLpXLm4cheGjSUWidZHvHRCvdmaJPVCs3I22IhFviNAn2r4eCU1Dp34OQO/uVm
         YRRcFcrWzK3g3/xwYx77EYm1qDu/qNJOsUo9qWCNrP3EwZB0RKmqxf73DRv3K59v8oRb
         KwDYmvielKhCOaBGTrIZMAB+rmC0dsYQ7xMyKmkp2VHFcs2K4ivEUPbtvGx1ROZW9Www
         4FlppnH43vMYLO/ci8XgVG3VULazTQGF+EWAe3Vapn0OczaQiD+cy1ZaPQkfT/pq/y0i
         puL79UJ7ihrEInWqHGFMfPKb6bsgKJI9GVNlhEJhCcuyUMUM/r8W21yL2ULGyH1F9rSt
         GTGQ==
X-Gm-Message-State: AA+aEWaVlekSVpJdO2sw6zkb/LaQgmaekCahr085eduzWePv3311x9s+
        GEaqCVotPQ7XK6Et/jXtZxw=
X-Google-Smtp-Source: AFSGD/Vwa/dhcQedQOcet93jdt6mH2COHxY1iCIvg+WGvZIt0LQ5ZixKspy8HQqlVuB9FhmL4QBY0A==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr6155336ljj.158.1544387464657;
        Sun, 09 Dec 2018 12:31:04 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/21] ARM: dts: tegra20: Update Memory Controller node to the new binding
Date:   Sun,  9 Dec 2018 23:29:36 +0300
Message-Id: <20181209202950.31486-8-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree binding of Memory Controller has been changed: GART has been
squashed into the MC, there are a new mandatory clock and #iommu-cells
properties, the compatible has been changed to 'tegra20-mc-gart'.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index dcad6d6128cf..8c942e60703e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -616,17 +616,14 @@
 	};
 
 	mc: memory-controller@7000f000 {
-		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
+		compatible = "nvidia,tegra20-mc-gart";
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
-	};
-
-	iommu@7000f024 {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+		#iommu-cells = <0>;
 	};
 
 	memory-controller@7000f400 {
-- 
2.19.1

