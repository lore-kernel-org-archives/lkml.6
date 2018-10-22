Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68961ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3167F2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNSutfge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3167F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJVQB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:01:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38294 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeJVQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:01:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id w13-v6so1271983plp.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Rzrg3Nb5SBp7VXw/4XGUW1RnZO/wOXB9fjUvxLQgixU=;
        b=CNSutfgeYez61SScuGiZBcS0sQx0HpKErIh5fP+To7wM2JI32SOunMCA8/x8jM2yUh
         VKfZpJY7VYNnwcP4RO/uawA5icXn/x0urmaoMLC4ZWOE5AacGLOTt5/pfFvBYy4WGIai
         AAZcz/UplOKkCsmP5pxU6NgnrzZyvIuyvhPmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Rzrg3Nb5SBp7VXw/4XGUW1RnZO/wOXB9fjUvxLQgixU=;
        b=F6VcSgiSxuWSyD9jb3rXKwmw2XpcTUKZJgpSSdfgmNVr/DThV2OYJoAAqK/ORx4DpQ
         TCdtinurpTYYXkRbDCu8TJWfy9YQv3EN9Ffx8CBiEtEYsvh7HOw3ktyayHlZoD/j+8EX
         oKedc5wxzsJ2INuLxdmgBwN1mDUcwFIVS1X/9HtY7PXVuZDBgmfN7do8o4nXlx55JA6h
         gS4E5fKX3lSJKjaLf/erD42bA6qBlFgqDUrb/gycgIVmYMcdI9KcVhanuxAq+9Y1HBkS
         O9N0AtN9FKvGnq3leip6xeSpzJPk7FLhzTPgEuzHtbJLRt0ew0qnwFqGugMyhIDob3Uj
         hQOQ==
X-Gm-Message-State: AGRZ1gK2ujM/i63ZqvQ7ozgVyVjrgb5LnkBsU99QbMJ0L/Cr0m5mJchf
        siQECaTugzNuxvssW6bWxF2bCQ==
X-Google-Smtp-Source: AJdET5fcK3Q9aYDQSTbTNaT0IkmIXVgOEVnwtTaxNXPeSL7M4I30f1YTOglYSeqThTOJL2TuMM9sKA==
X-Received: by 2002:a17:902:6b04:: with SMTP id o4-v6mr3255754plk.333.1540194275537;
        Mon, 22 Oct 2018 00:44:35 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d186-v6sm43704253pfg.173.2018.10.22.00.44.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 00:44:34 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v6 3/6] dt-bindings: power: Introduce properties to present the battery OCV capacity table
Date:   Mon, 22 Oct 2018 15:43:59 +0800
Message-Id: <3a0c6487c9503cf64432f630e65790cc5c3f70ab.1540189330.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
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
---
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

