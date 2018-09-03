Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD85C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280FB20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHcBIfvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280FB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeICQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:57:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44606 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeICQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:57:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so475118wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a+gI26lyns6hC1V60ut4yEh2GS5VZAaewovdMW5NRgg=;
        b=JHcBIfvzUvhPgHDyQE2buEKr3EIVOrzX050yoxEWWIYsaWerRPZCeD9DfR6Z87xHPj
         rsv/nTZESIJEdz6rQeQIpBCp+z7Xl/vF28Re6n+MwqdfenV4i41cBIxQZpOKUPak2JWg
         2JiwTLkJuzjCtUcnhw6jzT0eZvNk0F8zn24Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a+gI26lyns6hC1V60ut4yEh2GS5VZAaewovdMW5NRgg=;
        b=TFcwABi/jUgjNHb2PmEmZcBMLHt0yNK4L+w911NfS7qLZOwax+G38Id2JErqMg4zHU
         wc1+fSZ5rZM8cjJWwPOxavl29UgpE6wkKrsRnMZu8NwbWQVhzUUoJhejS7h6eVL273w7
         ffH5UpU++hkIFwn2KxPu42B43RkGzk4M5+be0EMRsgi9sSVSJvuTm5ckws7GS+JsmRDI
         uyObx5QrFbiCn5EcYFjuytXaGWez5vSY67ydKEBY+JnnTwCkG5pxQ+4WhzmO4CR605XQ
         cqtmq0DSuxhPagCCgWcFZyQ25KDHSYxSj/QYHghhroGdJJBy7gIWomtTBditby4uRxS6
         NNLQ==
X-Gm-Message-State: APzg51DmfYkpIZNBlsDhu9OSaa+pfa4yBvGcMPL0dzdPx+PVeg4EjDMc
        8IOBUBhTpPuMjKsMNiU8+4oMOw==
X-Google-Smtp-Source: ANB0VdYY1yivRRJPD3947MXKVBeYSoo/IBIswba6/pJLOlTgUcsRTM7g/LMfLoQYjRgcRXQb7m4Vyg==
X-Received: by 2002:adf:e991:: with SMTP id h17-v6mr19787727wrm.238.1535978252921;
        Mon, 03 Sep 2018 05:37:32 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id j44-v6sm27481099wre.40.2018.09.03.05.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 05:37:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: q6asm-dai: dt-bindings: Add support to compress dais
Date:   Mon,  3 Sep 2018 13:34:53 +0100
Message-Id: <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds board specific bindings required for dais, In particular
for compressed dais and dai direction.

Board specific setup involves setting up some of dais as compressed dais
and also specify direction of any dai. Some of the dais might only
support capture/playback depending on the board level wiring.

These two new dt properties will allow such flexibilty at board level dts.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6asm.txt  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
index f9c7bd8c1bc0..9f5378c51686 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
@@ -27,6 +27,28 @@ used by the apr service device.
 	Value type: <u32>
 	Definition: Must be 1
 
+== ASM DAI is subnode of "dais" and represent a dai, it includes board specific
+configuration of each dai. Must contain the following properties.
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Must be dai id
+
+- direction:
+	Usage: Required for Compress offload dais
+	Value type: <u32>
+	Definition: Specifies the direction of the dai stream
+			0 for both tx and rx
+			1 for only tx (Capture/Encode)
+			2 for only rx (Playback/Decode)
+
+- is-compress-dai:
+	Usage: Required for Compress offload dais
+	Value type: <boolean>
+	Definition: present for Compress offload dais
+
+
 = EXAMPLE
 
 q6asm@7 {
@@ -35,5 +57,10 @@ q6asm@7 {
 	q6asmdai: dais {
 		compatible = "qcom,q6asm-dais";
 		#sound-dai-cells = <1>;
+		mm@0 {
+			reg = <0>;
+			direction = <2>;
+			is-compress-dai;
+		};
 	};
 };
-- 
2.18.0

