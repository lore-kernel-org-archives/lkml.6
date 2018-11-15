Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01672C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0F421582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTDD3gwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0F421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbeKPEY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:24:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33206 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388865AbeKPEY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:24:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so22243517wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avO3Jb5XTMv2tnrPkaTW5Kc01HF/m3+otreEVZeHHFk=;
        b=VTDD3gwhgDIPz5nedhd5G093CeMP5MBrm1dIUNevSVuqkvu9dAj1O1Jgm2m1UQoZId
         WiiTINybGZ58hv2HZ2GWUPIQI5aWUN8B/02y9504NHQa1YmsC86NdhciT/s2aZp/m02l
         C4YPO9PAY6yaB3fwN1evcMZR0acfLeD8D9JBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avO3Jb5XTMv2tnrPkaTW5Kc01HF/m3+otreEVZeHHFk=;
        b=ryXPCG0/VJsTPgF0AO0Di2ki+xHDxBQKX2uYt6iEFkJhM6/VuUVxOvVlBEAwOt+90L
         Zg/ow+ec3GYO8IZoz+Gd3wOH17HFyBAI0nGL0gJPvx8b3mzAtP+bUSvSLB7VQXV5D1fi
         8CDFSrPt/iHy7JKxSnQk4LaejCnTfaPJnyhlsVpmf8GW/YqFP8zqCqluLQ87LcZ7OOCW
         l9u4icmC3zgMpQ1C0guvmxl00QetyNLGXA4GRBjC+oB3LwTCALQxeG+BJN1jLRwLy0+6
         9Ctf8nzUjQxxe7KW5KImRahI4Lybl8o7Th0muYdPEGfMq+Kmtbdt5MEZW+9MmiHxOnQ+
         8hTg==
X-Gm-Message-State: AGRZ1gJw39QVkcz+efrj8n/7rtE6pR2apvh6Q/d5DuwtGchNn23N99zD
        hWQ1KelFPwp6ehXUAqVER8fENQ==
X-Google-Smtp-Source: AJdET5cTVtDvwaztQBzYS0OdKrezVBP4eDKVyEncR/n2l5jksEqbwcWtiqMi1Gg4VEGkwYhBdR3vVg==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11-v6mr6964115wrt.72.1542305732679;
        Thu, 15 Nov 2018 10:15:32 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r76-v6sm20934737wmb.21.2018.11.15.10.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 10:15:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com,
        devicetree@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/5] ASoC: q6asm-dai: dt-bindings: Add support to compress dais
Date:   Thu, 15 Nov 2018 18:13:22 +0000
Message-Id: <20181115181324.26784-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.19.1

