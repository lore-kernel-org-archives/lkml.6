Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB855ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10B22080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="b/O3jfQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10B22080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeKADgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbeKADgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id j13-v6so4528306pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtDP696hbO19uToYRi7oM6dHh9NSDT61nMATPXIXC/I=;
        b=b/O3jfQmePj1DX/wEvh1E1sHCiG32OHdJYfc5fz9LSkWXnNMwf09WHXyR0jQkUfy9K
         O9kqLyiY0Hz0Q3uIszZdCCTygWpegMfg5pcGGAf3o7Ja/AMAT9ZP8UZq/sBnDBFXTiJg
         ctjfIaeCukgbr1uI+C981hVVq7CdrsxUdLqVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtDP696hbO19uToYRi7oM6dHh9NSDT61nMATPXIXC/I=;
        b=hJXc58z++y24eLVbtaKb1y8XF9dM6m19TZMMB3qiUK7Tp8kIV1gYDFAGQtEIRI8L+e
         TKuorUxAuzGkEq4mGA6Aqff2vKKfd6NLdlZNlZh58lAOQkPIGhmgpkZm87clkvHmkFsy
         HmmHZmYU1pdKjLHtxAYXdegOCeRuSidWrEN1f0dRtmxXvF0WpBXglZuk8tJsQ81N7l2G
         mUeP+s1vNMjfIt+BjCudcooxnLsS/pNeaR5j0qiMIylhCub1gyduux3aNWm4VavJFjHK
         Fp7QEQcvWJaMA6Yz43Yb3rw57vXql+P+OMLY9liO87eprWi74kpe3v77d/bY5jfYqto8
         GavA==
X-Gm-Message-State: AGRZ1gLO4wUVsq9E1q4Hcef1daN4u/cebvn3c3pG7ceEWWQEPWpGHUCW
        fEELlLfE1+ygBnYDeX+mQk0C1A==
X-Google-Smtp-Source: AJdET5cMSIuSoFjnbVwXw2d+D/0rORXJnxBTh1/oH9UGMwTm03/QvOSMluE4MeLZ0SEkToopfzZN+Q==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr4209217pgn.334.1541011029505;
        Wed, 31 Oct 2018 11:37:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:37:09 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 4/7] arm64: allwinner: h6: Add MMC1 pinmux
Date:   Thu,  1 Nov 2018 00:06:31 +0530
Message-Id: <20181031183634.29640-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMC1 controlled is already added, but mmc1 pinmux would
need to function SDIO.

So, add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 040828d2e2c0..3b9da12e65db 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -157,6 +157,14 @@
 				bias-pull-up;
 			};
 
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3",
+				       "PG4", "PG5";
+				function = "mmc1";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			mmc2_pins: mmc2-pins {
 				pins = "PC1", "PC4", "PC5", "PC6",
 				       "PC7", "PC8", "PC9", "PC10",
-- 
2.18.0.321.gffc6fa0e3

