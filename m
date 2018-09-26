Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60651C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7A214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7ermJss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE7A214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeIZQiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:38:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40171 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeIZQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so1688941wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HEPUdBWDT21/CbUw0qj1CFFc0ibgZ+M4DOX00nfRHk=;
        b=V7ermJsspmGGZkAixJ06hvGrqfb+can4oZ+NeNgKdvFO5410gXDuzUvrJrUG5fF00q
         TGrFwIRnXw5e966e5qGEioSNAuwB9mIRFpRkJRqYf8S05vaR63vVS0tm9tdluf+5UCx3
         LRQDm3+cwEL+olhxnZhpOHBN9MwWWKCu3du9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HEPUdBWDT21/CbUw0qj1CFFc0ibgZ+M4DOX00nfRHk=;
        b=sbHT76EbRVegt7tPaVTZ4jVNyrCZOJbHXqHfd5lkluIexNL8oAm0+pXiFPu+JHHC0U
         /nIwj6JJsgudDPpoQCor/xVaWVJpOTX+FvHHa9qqKFOfYgPD9TroiLLS2uPbzlAb8pwc
         UMGrrWuNhwoLobQD5Hu/wgj1LgzMB/HmdAGm2BE6hrwZDn+fxh5R5vURA1WrwveOHjrr
         R8ax3qDTYIBlpconNMbqsWBkn8c/elcN0Pa9VMPYGT0D9hecKHHS991qES2zp4ffjBhA
         QGx+buqx9GrAch/SsMSDQSSa14q4NQ2uC2GpLOhM+6ETlyk3N7VgsZFkj9GqwErCqmVX
         srhg==
X-Gm-Message-State: ABuFfogiGTW/8+nV7ObS41jpMSDWLgxMYgggznBoIX9nntAOMNYd7ZSq
        nqm3OyBSxtfPJfHavp4S09d4nw==
X-Google-Smtp-Source: ACcGV62yOfZ5MarhHsFw04Am56TZudMenMRJYLPWvrbuwleILFYzJz8iPxZ4n+VY49sXGPmaN66WWw==
X-Received: by 2002:a1c:7305:: with SMTP id d5-v6mr3672366wmb.53.1537957559455;
        Wed, 26 Sep 2018 03:25:59 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b12sm4442648wrx.11.2018.09.26.03.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:25:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] ASoC: q6asm-dai: dt-bindings: Add support to compress dais
Date:   Wed, 26 Sep 2018 11:23:47 +0100
Message-Id: <20180926102349.23481-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
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
2.19.0

