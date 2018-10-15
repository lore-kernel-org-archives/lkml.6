Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF16C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D493920890
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MI+FSJy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D493920890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJOPy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:54:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeJOPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:54:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so8795373pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sqt/MvygSPIA+8fRlfiaRWfbJBdMIOuNNb73rehO8sM=;
        b=MI+FSJy9NhuQ26wbC4sMLs8wrc8NJAFPFS79fO5fDuBM+saBdpfbdIrY8dAzZ/QH20
         CFDYc697xXonfukCVmmbBtKC/CZ33Vzq5umXRvdmEF4HAyv31jRhIW52hV7HatyuwiQ7
         kFV4hvEEczsvYMeKfDqrKvIV2lAiesmTmE7Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sqt/MvygSPIA+8fRlfiaRWfbJBdMIOuNNb73rehO8sM=;
        b=lpWZJR7v1RQj7PGL3VUqK6G9kUSaNKtciI6co5x2QYtte89+TxvzyaFoSwRcSf90kG
         DtvoAzxfwtXtyBuai14sqCjusz9G9eipalSL9TP4Bs8H9a4811ajyRnbvuwfLfBVqtIc
         fHhAPBHfO6csMgUNQwGWIgdt14mNTLL17rpKR+H79l6QZtPVZHJZaO2mMy7gkEkG8u6s
         dNOzhRfQzXj5cQmzV03w1KutS82vL4s2uWOoE+3I8LRCH3g9TnSiZudbuQA88p0lKRaE
         uHOsT4e7cTYyyxHCsnSs2xmZ8IOYa1j00l/SrE8qVFPJEvNTJpegUm2O9S/RTI7AUY/H
         imaQ==
X-Gm-Message-State: ABuFfogCpIY2RDSCbgzr1xI4leCJ95eU+Plo+vAiGi7YVEjFC9hiVhLO
        pKVgVJj7A01D8RuCl+JxMK3cuw==
X-Google-Smtp-Source: ACcGV63BtWRuyjln9zet303GngfUCoui50hS4rmm7GGdiL5+97O7IE7shSpM/0U7b+72qTQ0ZWR8cg==
X-Received: by 2002:aa7:8001:: with SMTP id j1-v6mr16371569pfi.73.1539591045783;
        Mon, 15 Oct 2018 01:10:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m27-v6sm16375855pff.187.2018.10.15.01.10.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 01:10:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v4 3/6] dt-bindings: power: Introduce properties to present the battery OCV capacity table
Date:   Mon, 15 Oct 2018 16:09:22 +0800
Message-Id: <eb56baf2e2d127067e459b6014516071ba9005c0.1539587217.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
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
index 938d027..1f70e5d 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -23,6 +23,17 @@ Optional Properties:
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
  - factory-internal-resistance-micro-ohms: battery factory internal resistance
+ - ocv-capacity-table-0: An array providing the battery capacity percent
+   with corresponding open circuit voltage (OCV) of the battery, which
+   is used to look up battery capacity according to current OCV value.
+   And the open circuit voltage unit is microvolt.
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

