Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFE82086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8jwYgzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFE82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbeK1FCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbeK1FCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so19357907wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ml7D5uOyqWWnonQPOTD87/7BOfbRfDsV25OXCFoF76g=;
        b=f8jwYgzum4FTUuQpvypdKT1nPHCJsAGNBgZrJlzIEXyweImqWeXnKJhtkxLoeB7RZk
         jvMaDoMS66v5lZxYnymgHI3sWR62bwbpZp0HxcqpJ3Ak6p80ogF5vhMN4qPlcRUtMClF
         8j4Q7Bd1a+GXzvyjndHhOnZauDkOhhuWKZKI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ml7D5uOyqWWnonQPOTD87/7BOfbRfDsV25OXCFoF76g=;
        b=DSM0xwxFYLn0xK2q1KiCMjgMvNxyIfyAWAXXH2z46u+Fht2g7GQYiOdXnAMXDWuhiR
         bUMntyW6yysGUwTuYWmi6GmapfoIcLCa3NWlMjzuG70K2zEtLXI/MLbbzT4YWuyhIcei
         B8zseiiL04LsUkrTbsiJ3yWpNNU2sdFM2KUzm7gRVNEXoQOVTEJtzPnKHwmnwXC7p4F5
         0aWxDotIkZ/MDyDkx9q8RVBH4hi9ltUUQK4+M/GTnXp/lW1yeNH4SqvwlueCll0yaNby
         VELO/OVe16xFHWdV/4RiKF9ZN/mEcPI7R9KKns4Vim2Li2OoMf8Rj7W05maBESfQM0bx
         HdXQ==
X-Gm-Message-State: AA+aEWYJgAjD1p7dpQtNUbV2F9DJsJE76qrQCJawQILkRcfoQAbLJkbJ
        3um7RiKZQ9YaZCW+daD+nPs+wg==
X-Google-Smtp-Source: AFSGD/X5BWud01h5ENFmHFpmj46x7vxqZGtyjl/CCNoxmcDk9Ui7A5Q2vVJeN9vpdJve7BvN7s0kIA==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr29942686wrv.187.1543341843459;
        Tue, 27 Nov 2018 10:04:03 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm6459921wrs.58.2018.11.27.10.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 10:04:02 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 6/7] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Tue, 27 Nov 2018 20:03:48 +0200
Message-Id: <20181127180349.29997-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..856d33604e9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1324,6 +1324,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			qnoc: qnoc {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
