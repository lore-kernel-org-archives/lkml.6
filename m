Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD94C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37836204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7iNXgPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37836204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeILO6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:58:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46682 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeILO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:58:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id k14-v6so1228755edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=riG+y2OQmTlvhmbDhsUEl+RI4V/hGhEUB0MS2rrQeBQ=;
        b=J7iNXgPxBSZ+pki5xkFgN0QR8tpRD4VGQACWhqUWNwi7rc+e0kureuFPWn+6dNadnw
         Gk8mV9fDNXq68e+GmyyOI1J/pAGAkSxokIpX33cahxTw07n8xjiU0hBVxu95NGfBefQc
         eK/B3u36f2wFA5kIQ6PwGQHuJqFwLVPFfi0OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=riG+y2OQmTlvhmbDhsUEl+RI4V/hGhEUB0MS2rrQeBQ=;
        b=g97aCt+TkeoohEdgpWCo8mL+18mroaJ1oOizo9N4iCslOQAqyE5pMIc7zAEJFo8En8
         cO0+l9o4uHklrhT6/KUk8IXySctIIZWwvC7N2mrbG0wfxxKVtXKMpnwK7BGWhPezrb2r
         ICOdNNGS2VwrIO1+YQ7jWrVhRGg631zITZBfrr5v1UPERpSIjvCyl8dImR+8RPWX62K3
         Yu5Pi7jfoTjKs4886TxzPSrHL5IiRi5yg6J1JYECBxaO+DKiyIO7zZd5oXIY0TZ2dT+8
         czHcqmDlORYKyRedB7biJK5S3lmzgmqsEhxjrcG14U1vxvC1Ez8/tho4D9SmNQQaGhPh
         ssCw==
X-Gm-Message-State: APzg51CevBmjEjxx/PV7QUahzLeKqxwyd4rFrmhUppUzTfKxcGjnpEas
        Ok3/B121TbcrEVNpvE/zJlblxFIS1gM=
X-Google-Smtp-Source: ANB0VdY/OWh6YPLatwTYa29i5URA7qpn/6cMeHf89ksVho+2kxum4qiqZDBdAJtPLYfysa9utnV7GA==
X-Received: by 2002:a50:d90e:: with SMTP id t14-v6mr1766863edj.241.1536746066927;
        Wed, 12 Sep 2018 02:54:26 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id x22-v6sm397969edb.8.2018.09.12.02.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:54:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 09/16] arm: dts: msm8974: thermal: split address space into two
Date:   Wed, 12 Sep 2018 15:22:54 +0530
Message-Id: <088724896f21d556ecf1e16a6c59c0e404444fa6.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've earlier added support to split the register address space into TM
and SROT regions. Split up the regmap address space into two for msm8974
that has a similar register layout.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT).  This is OK since the
code doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..56dbbf788d15 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -427,9 +427,10 @@
 			};
 		};
 
-		tsens: thermal-sensor@fc4a8000 {
+		tsens: thermal-sensor@fc4a9000 {
 			compatible = "qcom,msm8974-tsens";
-			reg = <0xfc4a8000 0x2000>;
+			reg = <0xfc4a9000 0x1000>, /* TM */
+			      <0xfc4a8000 0x1000>; /* SROT */
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#thermal-sensor-cells = <1>;
-- 
2.17.1

