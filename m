Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3923D216E3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cU6M4DRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3923D216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeHHVfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:35:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37680 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbeHHVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:35:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so1607798pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9mjVMXV3r/soRGXLJS1G2w0di8bLwglKq/vOsLLtIE=;
        b=cU6M4DRMKyJTgQUotIUMRxTS3R6f3WAzJSGPB1+4DorSusXycdWJKvXqOe/ZGcxdT5
         ecsNsmfDjOqhef9PvB3V0v58TFVhR6h+b1xVOagEWXCI0jo/RIycEPy19s2wMnRi6XgU
         HfOyS3zBxFBmv93Urq/JwF9KSpob3Be7FJCMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9mjVMXV3r/soRGXLJS1G2w0di8bLwglKq/vOsLLtIE=;
        b=RZPE4oep37Se2y2CDqm0ofLL5ccctsalqj9Rn/EYtpFIyCD51QRV4EXQ73i+gAuWSb
         4eWcvmY75A01lCQM3ndBuMgXWDIPLoxhPrW7n614ekDisBbe/AoeOQ2CieZxia5Rlevt
         eHsoRxejZnXyoxtuWPs47RUysf7ngMnkn7lCllIHxGRZYlV/QvFN+NrbD71dqevtswGz
         zs9AEGw4OtiFap3uSeg3KeU9IS92Ddu+C9SzEfF5OAjYVKL5fNdzDqo45TKAm3QhvSQ6
         tyqzEeBhdAkicVi9uCsO0/G3QTAfPx/TGsPsOargPLhfPkpa3POdtZxC67Lqzph7kmOj
         lyBw==
X-Gm-Message-State: AOUpUlEq8MRNP9tk/gdou2STsbk04/PorkUuhDqQVC56yMrN5FYaMWiB
        H3wiNkAKh66bWfoRWANko6/eAw==
X-Google-Smtp-Source: AA+uWPzTORRogqggBik7ilpFw3zqYLj3/4whq/OjwHvVJRSKMV3FkIbi1eeSenm31kJLS6qkDNuunw==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr3655670pgp.200.1533755655041;
        Wed, 08 Aug 2018 12:14:15 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5431136pga.58.2018.08.08.12.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 12:14:14 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Wed,  8 Aug 2018 12:13:39 -0700
Message-Id: <20180808191339.16875-4-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180808191339.16875-1-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index f70f6101bceb..499bae0afb7f 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -20,6 +20,11 @@
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 			io-channel-ranges;
+
+			die-temp {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		pm8998_gpio: gpios@c000 {
-- 
2.18.0.597.ga71716f1ad-goog

