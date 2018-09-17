Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25322147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxwI7DgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25322147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIQGWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:22:53 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39854 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeIQGWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:22:53 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so8898499itj.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JClPaKdY1LTVqiDjx508QpkxhWOiXBTEVHQ6RL1wVVY=;
        b=HxwI7DgNuPNYufmqKDRngV6aSx8OI0idvNPfOFXuaD4cxneotxM199DTa+fC1jqwkb
         lJ2g3ftAPEwuMOXeWzzlq9zQqy0sswLAdzp2USqFZC0oIYWUtVDVrEEVuYEFswfl75wd
         1O8yk99pfbuK1cttJ/g4HN4GTe6730Wrxf+eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JClPaKdY1LTVqiDjx508QpkxhWOiXBTEVHQ6RL1wVVY=;
        b=NVb8eTV9P50yJgdZXsyHNmv65MjqpvRT98x6VVAlWeyghv9wFuZDqlYKOIvlYtrYPY
         f5FQp6zEYbXgIXRuXPaI8QKx1Bl3wojbcf2anAfFjPB+e8/3O23BLVKiFkfPixp4KOeg
         LmgaDhuFcA7o+DdGTO9Ccdr11RF6CHejUTKR0NG17OvGyvKjhbGK5U0ktszGbaTq6V0n
         iYwQPEphIFbvaUSp3YOJX9fJ5ePJu3ceisAIIT5eHtRWFLR6v7xeSKSBEBZ6xsIcGgdP
         MxW4TMAp2vq0YLAefSeww4EFj4ADsPqdGjOisikQWVIZV6UgyH9W3e7IirIPlxdwfXyl
         jrJA==
X-Gm-Message-State: APzg51DB2zbSJaCmsoRbObWHOxXZhmgUiR8z97IwJ1ZMOwPfVOGswK0L
        NK7ZvuXpthL/6CzR1lxpd7+XiQ==
X-Google-Smtp-Source: ANB0VdZ8W21pZoLjCEkfP4fzM5/Z26LR1sI+jVrEPl39jdIwYVHYggP60xMBGrlpeELxf20gSkz5kA==
X-Received: by 2002:a24:1ad1:: with SMTP id 200-v6mr657931iti.4.1537145879540;
        Sun, 16 Sep 2018 17:57:59 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id f64-v6sm829972ite.4.2018.09.16.17.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:57:59 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 01/14] ASoC: dt-bindings: update wcd9335 bindings.
Date:   Sun, 16 Sep 2018 17:57:14 -0700
Message-Id: <20180917005727.32728-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch updates wcd9335 bindings with recommended properties.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 1d8d49e..5d6ea66 100644
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
2.9.3

