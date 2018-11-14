Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A0C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5043214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP//3U7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5043214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeKNTDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:03:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbeKNTDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:03:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id y3-v6so16316154wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ksJ+8XjL23kMtQWv2Hf9iBBlF+Q91Ku8huwPUBKghB4=;
        b=RP//3U7prQwfBC8rFgQpxhZ5HbU7aRgKzhlUvzGUTnk8YO21iLJidGCbdUItzpTa4R
         tzwmqd2C2EVg/OJEpTmLiu0ey3ZdrMuXMuvVHknR3qJOHb9yMkPCOv0zXFnmNxMpqZpS
         +5otPP1mDiMpDri7dIu6AAc8XSmpoii6fAEEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ksJ+8XjL23kMtQWv2Hf9iBBlF+Q91Ku8huwPUBKghB4=;
        b=PayGYZzw70LeVeGHXL2TMPo258+s/mrCH6geJewRssZlvav3GT9sQy0tLk9We0EExo
         OwukiW9BhyU3ifegb446eV4lgDyKc/lQMC2Dq3gtBpbcGFBUZnxxo6iplHtLDihTJGLL
         eAjubCgnnUb2mwGpr92t8DTv4L4Hu57+tPZjLrOqVSVF/0/5/JTHFUfYo6AKPeLls2Tk
         ei0tcPrBtsJenYirxWCCsGLURbQ6jEVxnGxWb4UgHYSDukpWFeRASBo1L0W0sfScpKXm
         q/YwvVRDSPIRdEybHgpsB6lrc+CVsntrYrIEyoXa9IsVupGjL3M0jrKB6yWOUnh0jBib
         PfKw==
X-Gm-Message-State: AGRZ1gLtPfPW52zZFRDukBCO2ZJdqN4KFzugoRtUjaH6yw5Sw9Z4YDv0
        QgCH6OkExTUOmXDST2Fbxr+4mw==
X-Google-Smtp-Source: AJdET5f00Ir3Iyybptx8ZoNjwZdF8DFlROHkpR4Om/q0myorMmY53MRqM889DSemLM42VLwPho4dnQ==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr1053636wre.157.1542186046010;
        Wed, 14 Nov 2018 01:00:46 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:4d39:8b22:d570:822a])
        by smtp.gmail.com with ESMTPSA id n7-v6sm16951441wrt.60.2018.11.14.01.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:00:45 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v4 3/4] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
Date:   Wed, 14 Nov 2018 10:00:26 +0100
Message-Id: <20181114090027.7580-4-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 185541a5b69f..98f824d8b0f0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -803,6 +803,15 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock@4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwsem";
+			status = "disabled";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0

