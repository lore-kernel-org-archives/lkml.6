Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65271C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3376A217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw0WGHJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfBSGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:32:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38003 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfBSGcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:32:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so2457679pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 22:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UV3B+xBgLoio5q5tCht2yjz3ygXKrXEGxSKWQW1x/vU=;
        b=Iw0WGHJXXWTtNP3Vgds5NSBRcFNV4w57sTqtUOzG6LS7IOXihcg7fPIR4JBUB4L7Ej
         iqZR1IPOwpBllasmPJBRLRJwZ8/4FNKwojg3SrQSwMPGpXY3I3fTTlIJy3slB6j83X+U
         IHfoXz7a6rmaVaC8HSsvh34jEa1jea/Dzbzt9vb2fGHxhbSHVA1WCnPevAeQR09bqDCs
         rO3FSoZOpVQDgKtpl6oVk0fd9YgbAj6RTWw0mEy6AwsbpvDKVFn9pKfq9+ECl1TkZrk3
         neEL9M+y0GD7Rv3NPz6x9QSDV6kIGRnmm6hoxdNClzHODb06Jb0KfqpLMbBfEokE74GD
         DJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UV3B+xBgLoio5q5tCht2yjz3ygXKrXEGxSKWQW1x/vU=;
        b=pP4VIAjnWzaIgKK118DzVqrkjASPI7vdpbSBfwb4gB4OpiBPf+B2ZD2Vq8i7KFjieU
         qWlVAQEjXnQsZk/L6p3rvd5wHE6KxMsiX4i6V3z76Da1TOA9PQ1SviwgFNZet2TT94P7
         ObvZu5RzXE43Ri2q05xpvvtBxD5RP4KMB+I0qOIH6MsWO7Mo+a4Cer9Zx3VR/oW7YndY
         T5MdI4R4aEeO3Xb6ljvH3DP48EF8YfIo3yylAB/40ciKHG3Y61sSkCQU2vIyK+OVTh+x
         bRbrvJMBLGdoW5Og+JArJ+YcSlu8oD/Wekz1FsnPnlOCv/kCC3HB+3TFEZ/ZoDEOO6lH
         1CKQ==
X-Gm-Message-State: AHQUAuYVzb63MNp1pXSL42LsNwA0nY67dF6A/B06ebv3DIsxGJlEk2ZR
        BPV7ajzmG79c490iT9rPhBALrw==
X-Google-Smtp-Source: AHgI3IYBVv+puxwc+tCcRvvfZkC/Qxpc0mzmgOXp0ro0cFm684dgOUh+YiVDw4HVaZi8pJVp60zOBQ==
X-Received: by 2002:a65:5c41:: with SMTP id v1mr2736420pgr.404.1550557923564;
        Mon, 18 Feb 2019 22:32:03 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t6sm18048025pgu.46.2019.02.18.22.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:32:02 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcs404: evb: Fix voltage for l3
Date:   Mon, 18 Feb 2019 22:32:22 -0800
Message-Id: <20190219063222.15656-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMS405 L3 is outside the acceptable range, causing PCIe to fail. Fix
this.

Fixes: 0b363f5b871c ("arm64: dts: qcom: qcs404: Add PMS405 RPM regulators")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Rebased upon https://lore.kernel.org/lkml/20181213183200.3204-1-bjorn.andersson@linaro.org/

 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 3a7f0d42e35a..6146f3577961 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -87,7 +87,7 @@
 		};
 
 		vreg_l3_1p05: l3 {
-			regulator-min-microvolt = <976000>;
+			regulator-min-microvolt = <1048000>;
 			regulator-max-microvolt = <1160000>;
 		};
 
-- 
2.18.0

