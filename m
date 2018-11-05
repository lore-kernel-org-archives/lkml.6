Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED76DECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70E820827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9Fcj1yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70E820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeKEQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:57:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45129 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbeKEQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:57:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so4012066pll.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=t6P0NC6uUx2aJ/BT8V+UjrWtOm+Y+ZsbL1DmEhfJd1w=;
        b=P9Fcj1yMgv+H8w+PhmoxV9IUi+jlJEKDkzB0NP8CoZq7+EoCOjuA9hU7JEgzEr+lBV
         OsUCPJTuHtO8TOHuCCU6TaQiGXvBSLdWnlJrts1iPWrnBnLEdOVLQZLnFhOHdtUaHHAH
         LlpieYeQ1RQg8lEtiuDA7fVYfaSOWk+CyuSrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=t6P0NC6uUx2aJ/BT8V+UjrWtOm+Y+ZsbL1DmEhfJd1w=;
        b=mGA7adPqLHfoHEGy943M4jZyb46PFwCFbhCnextNLooSbxJUW/l0R85cVoBaf329K0
         czX2/1FxlvtuVkwwwWrNSwFGB4S/8GuJP86JUGkPxkifWrRSKQGVOBpe0/PisoiggzHA
         yxu5NCnRlOm9z4vgzuv1PVKrz6q70k8yJW+IRx7cVT7L+jYqihL+3cZnV5e27l8pv8BT
         9dhlafnhxQzR0gt4iaWb3qHR/s5yU+0+W/Xr4FlJFsRuC8ai++HrMzm+hB7tZckjf7zn
         A39qX38NaTrtfKkeBtsBZ0ToJU5S/4e57PkWIOcQflkf9zWI26cx1Sex08YXgTIzNbd6
         DyrA==
X-Gm-Message-State: AGRZ1gKoYKLQ/XHo1fs+IQg06zgEdUMCJFi2+mUCRZezuC42D8Y/NcOF
        O7UVvDfeaRzdmZcRJafcMOt9Lw==
X-Google-Smtp-Source: AJdET5eTd6Glc2JTxCT2r94YCHS8YelIxQCK23dGREZNPmacgpOy9MUuKoFKwDezXCIg8mj9859dOg==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4-v6mr21299643plp.332.1541403578182;
        Sun, 04 Nov 2018 23:39:38 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d5-v6sm27632040pfo.131.2018.11.04.23.39.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 23:39:37 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org, quentin.schulz@bootlin.com
Subject: [PATCH v7 3/6] dt-bindings: power: Introduce properties to present the battery OCV capacity table
Date:   Mon,  5 Nov 2018 15:39:08 +0800
Message-Id: <ca572c16a79a51819850ac89b814155920dba28f.1541393063.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
In-Reply-To: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
References: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some battery driver will use the open circuit voltage (OCV) value to look
up the corresponding battery capacity percent in one certain degree Celsius.
Thus this patch provides some battery properties to present the OCV table
temperatures and OCV capacity table values.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v6:
 - Add reviewed tag from Rob.

Changes from v5:
 - None.

Changes from v4:
 - Improve the description of ocv-capacity-table-n to make the order clear.

Changes from v3:
 - Split binding into one separate patch.
 - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
 - Add some words to specify the OCV's unit.

Changes from v2:
 - Use type __be32 to calculate the table length.
 - Update error messages.
 - Add some helper functions.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 938d027..89871ab 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -23,6 +23,17 @@ Optional Properties:
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
  - factory-internal-resistance-micro-ohms: battery factory internal resistance
+ - ocv-capacity-table-0: An array providing the open circuit voltage (OCV)
+   of the battery and corresponding battery capacity percent, which is used
+   to look up battery capacity according to current OCV value. And the open
+   circuit voltage unit is microvolt.
+ - ocv-capacity-table-1: Same as ocv-capacity-table-0
+ ......
+ - ocv-capacity-table-n: Same as ocv-capacity-table-0
+ - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
+   for each of the battery capacity lookup table. The first temperature value
+   specifies the OCV table 0, and the second temperature value specifies the
+   OCV table 1, and so on.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -44,6 +55,10 @@ Example:
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
 		factory-internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-celsius = <(-10) 0 10>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
+		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
+		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

