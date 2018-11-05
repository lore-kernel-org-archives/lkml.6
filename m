Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D49B20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvqvZyO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D49B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeKEQ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:57:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45118 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbeKEQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:57:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so4011924pll.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7+KsQAiIFIxoDmz5EswpwgvRJ2yLAWBeV0S1HKrrYFA=;
        b=SvqvZyO7B1AF6b9TeCGIzx2VB+ajoHGmW9zoX5HpAJPVxATmn2JLN2W/tYH7qKzExA
         vlR6CQwotJLPR/SZcr0LHzSnak9H58TGTlqJl5lZKZPeoYQV0Q8oEDurYTfUKN5FniIH
         aXMKcrtluvcvI5cNn1GeNKK/uyqLipvhpsk0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+KsQAiIFIxoDmz5EswpwgvRJ2yLAWBeV0S1HKrrYFA=;
        b=sDKETSBF4DWbUeJ08kErb49UGdG5uppvlSrhY/hWon4NhVAV2uMZiiaueV3Wh0/LpQ
         ZCFNZRvkhALESZfTInmAypqUCJT0DhZg/8uUPKnohl7Bq7N/10U8YjNwhGLRcNKQdwzV
         fg6FjBDX2+GOu7em6GWihQBesGBra2F3pyo5NDwT1NsVwcx8zYrRUI9vbMe3GHsfMsN/
         jbmbr611irhsVhWskVlbW7illqKydD4pLsvoiswpEX0fOGgAFOXjbIPjxi3O/ACYC3iN
         GL0iMJ7SjCSUeIXIOXsrA4wDj3vboFGJeyAsSLqqPWuHPVN7bXkjG7SQYo1dlOwhnn1T
         PKiw==
X-Gm-Message-State: AGRZ1gJ8XyAfb+A7HpzODW7wWR4a0uDs87dJJaHyes1earb6J8XKWh8z
        FhfBrKVIjjEqQADk47OpnQ3xnA==
X-Google-Smtp-Source: AJdET5cjZKxUmRmUO/gdfCN64iASfiI3XiQUKX9hhRf37PVclw4pDcKO7v6LcAdHecbLwrrEuRet3w==
X-Received: by 2002:a17:902:544:: with SMTP id 62-v6mr20148145plf.73.1541403570279;
        Sun, 04 Nov 2018 23:39:30 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d5-v6sm27632040pfo.131.2018.11.04.23.39.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 23:39:29 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org, quentin.schulz@bootlin.com
Subject: [PATCH v7 1/6] dt-bindings: power: Introduce one property to present the battery internal resistance
Date:   Mon,  5 Nov 2018 15:39:06 +0800
Message-Id: <5640f29e0b7f46f9ee77d80745f8c93eda355c34.1541393063.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal resistance of a battery is not a constant in its life cycle,
this varies over the age of the battery or temperature and so on. But we
just want use one constant battery internal resistance to estimate the
battery capacity. Thus this patch introduces one property to present
the battery factory internal resistance for battery information.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v6:
 - None.

Changes from v5:
 - None.

Changes from v4:
 - None.

Changes from v3:
 - Split binding into one separate patch.
 - Add LinusW reviewed tag.

Changes from v2:
 - Rename the property.
 - Improve the commit message.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index f4d3b4a..938d027 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -22,6 +22,7 @@ Optional Properties:
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
+ - factory-internal-resistance-micro-ohms: battery factory internal resistance
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -42,6 +43,7 @@ Example:
 		charge-term-current-microamp = <128000>;
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <250000>;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

