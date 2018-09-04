Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B59B20870
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNKmEXq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B59B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDOwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIDOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so3355817wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GBA7P/n5r9zLUFU1Bhvj3tz7Fy7Lksts7INEKVCm74U=;
        b=gNKmEXq9jgNDX2iYUUkJDT00vPRoV+2VvhFaxsrgNgwzSUt/7QebFW+1jXqZ8h/fvq
         5hIg9DKTMlChesSo8jNPsNm6U78DCbTD6/NwZLVONZFLvYK+hi5vyEgI89NgnoPhqmDs
         wTQF1jkQ5g41VBw3DmlqebLdmqo3bQK3iZvW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GBA7P/n5r9zLUFU1Bhvj3tz7Fy7Lksts7INEKVCm74U=;
        b=idJ2nvSH4X/wNbYZpuAkMsWouT/ZQuBJVeCf7KIzQtRlqXZsCDiH1BS1CT98gcubGi
         kwap7Jq1QJUfk+sIcQc7H3bBf4+k1cwul+YVw8H+uq7pbZhpxb1HqlWcO6qPU6FH2tt/
         BMwn0jpm3yrE/7NJyR5g/prgfxnLz8qZix9nvrQql4z0DwkNjygSXgHFa05DLPFrMRHP
         inbItanVtAF1LVuSbZNuKT56uSktkOS8be9FXoBwSGXgnt5fJJGilGzvdeaQq7zlOBEe
         DMe5aS419j0sfg5bASSBdrWx9G10lFiDcVi/pdt04z8O8NRI1YCivC5hZlEQiJdzu0NT
         YeHw==
X-Gm-Message-State: APzg51C53XYsAItmJ5rfg2HnSZ5CwI6Gs6PpoUOiEV69dd6SJKVBwXVd
        S32JN/zlgBJJzti/MguEmbHJeQ==
X-Google-Smtp-Source: ANB0VdY01b42JTQwZT8R7s4Ntm9U326G6PnJfUnksZJ08dCfxfUXAFUyqLo07ISc76BMD+jIB+9Bkw==
X-Received: by 2002:adf:f984:: with SMTP id f4-v6mr22516073wrr.105.1536056851012;
        Tue, 04 Sep 2018 03:27:31 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 01/13] ASoC: dt-bindings: update wcd9335 bindings.
Date:   Tue,  4 Sep 2018 11:24:48 +0100
Message-Id: <20180904102500.30318-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates wcd9335 bindings with recommended properties.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,wcd9335.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 1d8d49e30af7..5d6ea66a863f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -34,12 +34,12 @@ Required properties with SLIMbus Interface:
 	Definition: Interrupt names of WCD INTR1 and INTR2
 	Should be: "intr1", "intr2"
 
-- reset-gpio:
+- reset-gpios:
 	Usage: required
 	Value type: <String Array>
 	Definition: Reset gpio line
 
-- qcom,ifd:
+- slim-ifc-dev:
 	Usage: required
 	Value type: <phandle>
 	Definition: SLIM interface device
@@ -104,13 +104,13 @@ Required properties with SLIMbus Interface:
 	Value type: <u32>
 	Definition: Must be 1
 
-codec@1{
+audio-codec@1{
 	compatible = "slim217,1a0";
 	reg  = <1 0>;
 	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "intr2"
-	reset-gpio = <&msmgpio 64 0>;
-	qcom,ifd  = <&wc9335_ifd>;
+	reset-gpios = <&msmgpio 64 0>;
+	slim-ifc-dev  = <&wc9335_ifd>;
 	clock-names = "mclk", "native";
 	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
 		 <&rpmcc RPM_SMD_BB_CLK1>;
-- 
2.18.0

