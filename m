Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0D7C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CCE27BD1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TmXg8cdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CCE27BD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936435AbeF2Spt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:45:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40114 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeF2Spr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:45:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so4863189plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=68nC/OxS6qChkNN14QEBdKzEKtZ+4BkQ1FnbbAO0TRU=;
        b=TmXg8cdkdvUog9UxrHwPbffgbtbFILDijHTc8V8LIWFZh3ltFivl1BWi4EE4n4Uw+b
         Aqh2aVXuMHdaaTdYpQWicc8u0gOqliv7sTUhwVrRqdiZwrgmpRPfv2L85MCyoEtwFaLp
         gpvZUkQH50rGfHmH+3Z2OX5uc/K5c+In8pOns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68nC/OxS6qChkNN14QEBdKzEKtZ+4BkQ1FnbbAO0TRU=;
        b=mx/MyFBj1kc7VoYBao2fCNsDtKtf3w54hLyNluFjJ25Wr31qzp3W+YwuoYMrmJKYNH
         dsd1xRMjcb5EcszANw8kV+JJYhavPNTURX4WIVSLsJUnrdLJC0vVtSXJJHPAHYkVNL5O
         sirYsjazIm9kjnM7SqeDVrCCEpWnR8jYBWzny0+LiB0EjLxR4BfbV1ppPrMHbWFu0uh9
         O4ILZSlMSXZQ9bFguN5Lxu7/4mRJrRuBWsOopfxwHT5PGSFmfS00tE95oBExFjyQIxDo
         aUfYMlTuzLu5+SfqR4E4Jsb1Q4zYaClS7NhbpxBC0jSMsQfvkLWhPeJne1+yhKuex9kG
         oHEg==
X-Gm-Message-State: APt69E1FGOGNpDms+EbnzNlKm7r8Okidk0i0wvMY3SfxHuZ0Mu//PrPa
        v2oM2F6TL7YxTK/vGYlo+87c9A==
X-Google-Smtp-Source: AAOMgpdq3npq+rhB+g18g6veBZEQaaI7CKre/rwUzJ0yMAVFfndRO4AEDpcF8Ab6TCH2i5fAMT65NQ==
X-Received: by 2002:a17:902:d218:: with SMTP id t24-v6mr8499978ply.63.1530297947322;
        Fri, 29 Jun 2018 11:45:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id p76-v6sm19598494pfk.147.2018.06.29.11.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:45:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andy.gross@linaro.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: sdm845: Default qupv3_id_0 as "disabled" like _id_1
Date:   Fri, 29 Jun 2018 11:45:27 -0700
Message-Id: <20180629184527.161970-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8e4947ee477d ("arm64: dts: qcom: sdm845: Add I2C, SPI, and
UART9 nodes") I accidentally forgot to add the line:

  status = "disabled";

to qupv3_id_0 to match qupv3_id_1.  Add it now.  NOTE: right now the
only sdm845 board with a device tree in mainline is MTP and that board
currently doesn't have any peripherals under qupv3_id_0.  If any board
was currently using peripherals under qupv3_id_0 then that board would
need to add this snippet to their board dts file:

  &qupv3_id_0 {
     status = "okay";
  };

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 00722b533a92..9c10ff5e5843 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -258,6 +258,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			status = "disabled";
 
 			i2c0: i2c@880000 {
 				compatible = "qcom,geni-i2c";
-- 
2.18.0.399.gad0ab374a1-goog

