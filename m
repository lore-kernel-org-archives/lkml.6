Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB5C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0734C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+NzoRbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0734C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeK3V4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:56:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37121 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3V4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:56:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so4816141wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8/Z9dGXIQOxPTs9TSRgVL7E99JpcJSyKVbjnodmw1M=;
        b=e+NzoRbtaS9ATfMaMiqTvO2BYg2lZwgDkM8ahZdR5jCBr+WiLRHQXpm7V5nXq+7RRJ
         4bxPXYRwrh0B1nyYdS6XdTxYpigh+ZGhs48jLeVKZZnQE37nni692kwZMOxKoPq9h3jJ
         w3ghOd4dPKXeWjzYsXmfmcEPT6TcR1YgKqt4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8/Z9dGXIQOxPTs9TSRgVL7E99JpcJSyKVbjnodmw1M=;
        b=DERddJ66mFewWBsFZc/y+jBwok7Dv9DzBzUPdfMf9qT+GoS+4FVN2jIGQhm96iKPvg
         96+iWVEERzMQgo8SNONNLPC0qCyHnqxPSOzqO3wX0qXg7Hwq0o6mDq2IfFzR7d5kEnuP
         qcvdkSXpUgOfDfSf/DXLFSwIdI3uIPNA3q3QZKmet6AP8bl74CIdI5ldl7GemQeldtA+
         gtueh4B230QbOdAxqM7R5yNGtxxJH63buK8nhjiVWhT+5LkHZXwTZa8Apwfp+c9kA8h+
         BQdXs52z+3sPrbhLr3IJ6x1f/NH7TatFbr09kfuQis/vQS+Gjop+4NJpkChBS50UKHTm
         Ul/g==
X-Gm-Message-State: AA+aEWbwsx3XtJFagS/iFRNfJv9f0yjuHjJM35XiBPO0EVuc6aFkKm4+
        hIL+wYm5ieA/oMYvO3MHLrRVaA==
X-Google-Smtp-Source: AFSGD/W+aTaNfiHRTqJ1JLfnK+ndlc1EhNkImGI5YXms6cl5kO1wsrvrqUtVOB4ahBFBYwWLl0vCoQ==
X-Received: by 2002:a5d:628a:: with SMTP id k10mr4340764wru.254.1543574878755;
        Fri, 30 Nov 2018 02:47:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 18sm6964211wmm.32.2018.11.30.02.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 02:47:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/6] char: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Fri, 30 Nov 2018 10:46:52 +0000
Message-Id: <20181130104657.14875-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FastRPC driver implements an IPC (Inter-Processor Communication)
mechanism that allows for clients to transparently make remote method
invocations across DSP and APPS boundaries. This enables developers
to offload tasks to the DSP and free up the application processor for
other tasks.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/char/qcom,fastrpc.txt | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/char/qcom,fastrpc.txt

diff --git a/Documentation/devicetree/bindings/char/qcom,fastrpc.txt b/Documentation/devicetree/bindings/char/qcom,fastrpc.txt
new file mode 100644
index 000000000000..d5ff548960f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/char/qcom,fastrpc.txt
@@ -0,0 +1,73 @@
+Qualcomm Technologies, Inc. FastRPC Driver
+
+The FastRPC driver implements an IPC (Inter-Processor Communication)
+mechanism that allows for clients to transparently make remote method
+invocations across DSP and APPS boundaries. This enables developers
+to offload tasks to the DSP and free up the application processor for
+other tasks.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,fastrpc"
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: DSP Processor ID.
+	Possible values are :
+			0 - ADSP
+			1 - MDSP
+			2 - SDSP
+			3 - CDSP
+
+= COMPUTE BANKS
+Each subnode of the Fastrpc node represents compute context banks avaiable
+on the dsp. The name of the nodes are not important. The properties of these
+nodes are defined by the individual bindings for the specific service
+- All Compute context banks MUST contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,fastrpc-compute-cb"
+
+- reg
+	Usage: required
+	Value type: <u32>
+	Definition: Context Bank ID.
+
+- secured:
+	Usage: Optional
+	Value type: <boolean>
+	Defination: Indicating context bank is secured
+
+- nsessions:
+	Usage: Optional
+	Value type: <u32>
+	Defination: A value indicating how many sessions can share this
+		    context bank. Defaults to 'One' when this property
+		    is not specified.
+
+Example:
+
+fastrpc {
+	compatible = "qcom,fastrpc";
+	qcom,smd-channels = "fastrpcsmd-apps-dsp";
+	reg = <0>; /* DOMAIN_ADSP */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	cb@1 {
+		compatible = "qcom,fastrpc-compute-cb";
+		reg = <1>;
+		iommus = <&lpass_q6_smmu 1>;
+	};
+
+	cb@2 {
+		compatible = "qcom,fastrpc-compute-cb";
+		reg = <2>;
+		iommus = <&lpass_q6_smmu 2>;
+	};
+	...
+};
-- 
2.19.2

