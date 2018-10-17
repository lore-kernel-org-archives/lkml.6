Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58626ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0A221486
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dj6SG4p4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0A221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJRBUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:20:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38903 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeJRBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:20:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id f8-v6so12848798pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cCTK2ppRlB6er40eSHAXoUbuoFkweFdZ8znYjF+YJKc=;
        b=dj6SG4p4o5OIu36I3PZWIQFuep2QqiXzNbAZZjwUs00/SLrmiWJqaVuO79ep9IEoe1
         gq11t1k1iJIAn/KzUWdMPb2EZsBY5Q9/zqoYG8evcKQfav3MKI9zdhjqANamiIEdyneD
         4BcmxQreIWJlsWCavwsycXUw9dUeGPjg823lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cCTK2ppRlB6er40eSHAXoUbuoFkweFdZ8znYjF+YJKc=;
        b=s8fOoWPYLY2w/Vh7GZJf+v4OMnQ76Z49OXdhIKLWzN2nI/DTXDgzPXOrR50TBBmWr/
         huUQcBXnQqtMmAS6cz/a0+X3almsCgGjUxWDoiwwjC973sKTzkrghHbN23etEkE0uAi2
         oGr4QBDLzd9ANQx8Q1aB+nXY00orAAY+plnsRouf2ud3opMMOZcb+NnrUVZYnY/dkI99
         1mgI+MJx7aT+dvdg8tspHmxh1zkxnZMyimfnYVRaKV2zm7+uXRDGYfKllRoLg2tAzwr4
         18r6dnS1MBplaCWC0Jxxf074YoTDd1DjH9i8lxDl9ZUEh5exCk+iRY1u6ae9+gizzkoJ
         1soA==
X-Gm-Message-State: ABuFfoifLX+SmrNSwMAwHs4n83iyVsP6iGvfbwPwDw3K3zexQFcoaTiM
        2iFmNOC4EHmb5cchkdEAo8W84g==
X-Google-Smtp-Source: ACcGV635WKETw56JtJwxAej6DUsFmVPvLj7kjp624epkdtRxOZqwyZjaOGfHsJ51S+PIL4zqJhMpzg==
X-Received: by 2002:a65:6295:: with SMTP id f21-v6mr25497288pgv.167.1539797043984;
        Wed, 17 Oct 2018 10:24:03 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id h75-v6sm19760141pfe.146.2018.10.17.10.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 10:24:02 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     swboyd@chromium.org, dianders@chromium.org,
        Can Guo <cang@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Wed, 17 Oct 2018 10:23:12 -0700
Message-Id: <20181017172312.194281-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181017172312.194281-1-evgreen@chromium.org>
References: <20181017172312.194281-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

This change enables the UFS host controller and PHY on sdm845-mtp.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Evan Green <evgreen@chromium.org>
---
I was unable to test this on an MTP, if somebody could give this a try I would
be grateful. This applies atop agross/for-next, since it needs the regulators.

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index eedfaf8922e2..d5fddea71a85 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -356,6 +356,20 @@
 	status = "okay";
 };
 
+&ufshc1 {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <600000>;
+};
+
+&ufsphy1 {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_ufs1_core>;
+	vdda-pll-supply = <&vdda_ufs1_1p2>;
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
2.16.4

