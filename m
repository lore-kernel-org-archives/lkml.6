Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08841ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BC32080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q7CA6jhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BC32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeKADg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41145 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeKADg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so5000487pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuPFzBFJYmQDdcKvcHZoo+z52fBWOTrb1jNgMZtyKLE=;
        b=Q7CA6jhJVuT07mB/3wXk9EBPHZcbabe6qDsUlQvZUd1vIWvScQD3hyyPs5Zl7CzvpF
         JMdpohhxNkf+46RDFGxwoXMtoLRRaeCNmCOsTpfEWe2egKKm5mXn69SVBC4uar5EFAmF
         07zZO7F9Lwn7Ky9D/wMCNT07A6SvqgPy+xq4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuPFzBFJYmQDdcKvcHZoo+z52fBWOTrb1jNgMZtyKLE=;
        b=DsapQXTXsrbPMdmam162dpw0Xf9Xwu9Gh3f+THjnGXSwl8cKMCRIai2BSl6OpLOXOh
         Ek/a9iIh2ULAutlAJdZToNjn6L4FpfV9blN6gcxSwC9GccjaWc+hCy409u+nX/tbLw9Q
         evShWNbOlpgrtqB43eHVz9KopvUXfyviYgdXMLlIYJLh90nn8d6feLLBL7rNOSsV0Hz7
         FcDFet70quFUt2K/mHhaRtIuCEmWaY/N9kWT+jqdkS8U4ZhKpOhwYh1ebnd/Y5nr8Ard
         HQIc4yy+0+PbbS9Kil5PnexC9sG2GvCZ1+wj2tDOud5znsS5P9t3Dv8SBRnkZf6U/yEr
         vI4Q==
X-Gm-Message-State: AGRZ1gJ5ra/DnHkmhYGvkJNONl9UoPYDdMOd59KiZf79pERbKpgnfzF+
        sCgi3oczFegeomjeZlBVHyjFWA==
X-Google-Smtp-Source: AJdET5djJihiUTM5a9Bbgzivl1eC+jiCcWDATBpCxIbLcjaXHqQKWripnNK5N2wJgU+hbww0p356hQ==
X-Received: by 2002:a62:6383:: with SMTP id x125-v6mr4481066pfb.13.1541011035218;
        Wed, 31 Oct 2018 11:37:15 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:37:14 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@openedev.com>
Subject: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
Date:   Thu,  1 Nov 2018 00:06:32 +0530
Message-Id: <20181031183634.29640-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@openedev.com>

RTC controller is similar to A31, so use the same compatible
for H6 and update interrupt numbers as per manual.

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3b9da12e65db..c8d2fe76da7e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -266,6 +266,13 @@
 			status = "disabled";
 		};
 
+		rtc: rtc@7000000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x7000000 0x400>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-- 
2.18.0.321.gffc6fa0e3

