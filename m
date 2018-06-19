Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA95C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F982075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghs8WsKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F982075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967028AbeFSQOn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:14:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41648 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967119AbeFSQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so234139wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJdsAyA3boANJ8Oig23dpaUGq6oUImWdAfDoOGWfLfE=;
        b=ghs8WsKz1qg3X17IJAAOgGVu3bkBS3d/CF2oSzS04FPZR8GX3W2LJ3e5Qp8anIP+hm
         OQo2dM7eow0wrmgzZnpBoZy7kXuXG0bgdxO5coQw24It9KQhmKuRgq59JpYHT7AwRXex
         RXFTUMHCIPn0DtDtTQnCpnzBzavCiopp0lujk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJdsAyA3boANJ8Oig23dpaUGq6oUImWdAfDoOGWfLfE=;
        b=HVDqqP1skBXw1gVauwYkSBiNxMbZtGHoKsy45o6usfgusN7rvaXG1T/KnUtUmgVmAG
         xEhBwzPWlcQ8F717WEw0aHfQnJcwm8bCo8s+VEn/6gIylyjHGyeVzfhOkvuikVDJOpgc
         AE0bChJfKesXJSHA8hE7hBtRBc4PtwTSd3o3UXLUKFOBDj124pyVgsmb/CrOAUqi3ZMj
         KUrWaLroyOnJxxw5ffWs0rFabcdQg/zQYQXnKu1/4NwjmqKJ3J6UcCczycIb7VBkMWCg
         FwrwL9Yd05D35OOw7/1eIzdBsNbzGEVzNVypZGqBR2zfpIIMBaylgbkQjhCXYMjZovCC
         EtoA==
X-Gm-Message-State: APt69E01n596hAu6mvn9e2IKWuBkT4ObUvaPa+DMNd0ClM5iDwvsrEm8
        7ipTHs9NY9jbqMpclDjRfaq+Yw==
X-Google-Smtp-Source: ADUXVKIi1F9atWZuK5M50TiyMYWFZfc4+a2wfLjTNmZ6XyzuesFz4PRy90PjMs/t/Gg/J5JW7CjIxA==
X-Received: by 2002:adf:afe3:: with SMTP id y35-v6mr16031859wrd.176.1529424790628;
        Tue, 19 Jun 2018 09:13:10 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r5-v6sm47248wrp.59.2018.06.19.09.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 09:13:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/5] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
Date:   Tue, 19 Jun 2018 17:13:00 +0100
Message-Id: <20180619161301.4556-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
References: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Qualcomm SLIMBus NGD controller.
SLIMBus NGD controller is a light-weight driver responsible for
communicating with SLIMBus slaves directly over the bus using messaging
interface and communicating with master component residing on ADSP for
bandwidth and data-channel management

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Craig Tatlor <ctatlor97@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
new file mode 100644
index 000000000000..e94a2ad3a710
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -0,0 +1,84 @@
+Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
+
+SLIMBus NGD controller is a light-weight driver responsible for communicating
+with SLIMBus slaves directly over the bus using messaging interface and
+communicating with master component residing on ADSP for bandwidth and
+data-channel management
+
+Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,slim-ngd-v<MAJOR>.<MINOR>.<STEP>"
+	must be one of the following.
+	"qcom,slim-ngd-v1.5.0" for MSM8996
+	"qcom,slim-ngd-v2.1.0" for SDM845
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the controller
+		    register space.
+- dmas
+	Usage: required
+	Value type: <array of phandles>
+	Definition: List of rx and tx dma channels
+
+- dma-names
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "rx" and "tx".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list controller IRQ.
+
+#address-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 1, reflecting the instance id of ngd.
+
+#size-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 0
+
+= NGD Devices
+Each subnode represents an instance of NGD, must contain the following
+properties:
+
+- reg:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be instance id of ngd.
+
+#address-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+#size-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+= EXAMPLE
+
+slim@91c0000 {
+	compatible = "qcom,slim-ngd-v1.5.0";
+	reg = <0x91c0000 0x2c000>;
+	interrupts = <0 163 0>;
+	dmas =	<&slimbam 3>, <&slimbam 4>;
+	dma-names = "rx", "tx";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ngd@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		codec@1 {
+			compatible = "slim217,1a0";
+			reg  = <1 0>;
+		};
+	};
+};
-- 
2.16.2

