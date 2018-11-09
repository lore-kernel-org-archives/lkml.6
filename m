Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFBEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958020855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UPlUMnMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3958020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeKJJfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:35:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45702 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeKJJfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:35:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so1602773pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5OoJT0WOZS2FNfOqlmZUVV5SU61YXQeiHNH6j83zQNA=;
        b=UPlUMnMikhYeglBHpU1RqH9hrc6Wj5oCk/ksAprs6edfTzJqp5a35zfaNMhGVhWnKS
         JNz4R8LGp03nC6R3Sd1+N0MRj8wez5wH67uKvq9m2d9aSqXc70848SEYfeaoHPIzUI/W
         9qRrhalRzb6eeiDva3bCSiQ2P5yZfmnm9pbNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5OoJT0WOZS2FNfOqlmZUVV5SU61YXQeiHNH6j83zQNA=;
        b=rRgSKnaaKt/JgDjEoFguMYMx+UKBXRRfYjTw5w3dQzgSFa02QEMJqB23kareo2QXIe
         6unk0vZnLfhG4x74+qRHIrIyVtKj8fZYMlDlvbzhTPymMSiQOUidAkrjkRY2mj4p/Cb2
         PjgJVY1iXiTuFdk9iK5gxllnzlUbv0xgRCFuj24GEhW64zLEkJQxVOUZRTDGsZUP9+rI
         wE0zCalAHFFvSTHCBO5yNhb33/3i/+ujvDeyGvuuaghb1UV0f0i2+KRNce7q5pfF83p3
         O9+izFcXn44bhkfvTa0m2vV4D3YNtYkj9W38Fc9p02NIXyZDjxkR3N8fTZm0+k+o5jHb
         YJvQ==
X-Gm-Message-State: AGRZ1gIvjYPKmioRbf7k2Twna5kPaZajGpaVo4kDdtOCJGYCgMTmQbkF
        V8AywfejeEHTSn4XqtQ731kC2J82MiU=
X-Google-Smtp-Source: AJdET5f3JucPMvkAUSiYD5w+/AyOGf6hi24gh4oMtThky/2NA6XWd2cU/nIt8dqMguFtAWe1fVOP6Q==
X-Received: by 2002:a63:df13:: with SMTP id u19mr9343605pgg.294.1541807550592;
        Fri, 09 Nov 2018 15:52:30 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id j12-v6sm8634747pfi.61.2018.11.09.15.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:52:29 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Add gpio-ranges to TLMM node
Date:   Fri,  9 Nov 2018 15:52:12 -0800
Message-Id: <20181109235212.111169-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gpio-ranges property to the TLMM node so that GPIO hogs work.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a57..f02530ecbe0b9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -821,6 +821,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 150>;
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
2.16.4

