Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E0A2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4z38Sjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0A2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeKNTDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:03:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35038 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbeKNTDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:03:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15-v6so14008207wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6m0CH9mIIg1HDofUPyfAueceCWtH5wTcJRcojQSCMGM=;
        b=g4z38SjkyjLKeo5V4lsEdgeExeXnHVS5EIfT+46S7mLy97IXnQ05/I5BXN5mZeAwcW
         23wyPi65Psn8IPmQF4zO3UHe5hsQlcryYZlSFgGPQAfCEHqp9eHrCKxVQUIQY6ibnoeH
         Q9GUeunN7Rcf4QvEA9mNxTm/uI7SdRkvFXMNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6m0CH9mIIg1HDofUPyfAueceCWtH5wTcJRcojQSCMGM=;
        b=bG5dAri7yAP6j+27k/Ucl+oLNrP6+wQud3Xtkw5zhqixyYH4TAgCrXOd9jJsXgaEXX
         lMfyO1hagjSmbaYhHuNYRCkGzosNKHTKtfhLo5yBz43ylVx5yiFw7lU85T3HDy9k8pu9
         wAzNhppzHXnCT8tD6CmXOgBTUIu/gIqIWp2zW2e7Wg5L8uvJbRePPjd9aqKvw4RsJ4Uv
         gK9FTzJ7SX3KdPzFP7IgBPj4K3XFhWQf3VJP56H+Ne3DJjCKYs/kSEOwIu1/Hb6zm8Es
         Mb1PGuM+H2EIh4BX1g2exywn8hl05KLwULN3q3LDQsM2/IPIZvW+zVOlrNHfBbbIrdgj
         RRfA==
X-Gm-Message-State: AGRZ1gKlVqCWM1TUupevxf8ezOgd6jW3ovcw2RpOuy9xaC6A6PhESD98
        rYEBcPbaJx403vOtLEumrJCFKw==
X-Google-Smtp-Source: AJdET5fR6fMimlj3bxEbiK+BbfJmV+sSxIwOEaE1FswYudlJhKy/DVBiS12ITrTCTo/ajDSqtj8haQ==
X-Received: by 2002:a1c:80c4:: with SMTP id b187-v6mr1072965wmd.97.1542186048039;
        Wed, 14 Nov 2018 01:00:48 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:4d39:8b22:d570:822a])
        by smtp.gmail.com with ESMTPSA id n7-v6sm16951441wrt.60.2018.11.14.01.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:00:47 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v4 4/4] ARM: dts: stm32: enable hwspinlock on stm32mp157c-ed1
Date:   Wed, 14 Nov 2018 10:00:27 +0100
Message-Id: <20181114090027.7580-5-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index f77bea49c079..158a337b3129 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -94,3 +94,7 @@
 	vdda1v1-supply = <&reg11>;
 	vdda1v8-supply = <&reg18>;
 };
+
+&hsem {
+	status = "okay";
+};
-- 
2.15.0

