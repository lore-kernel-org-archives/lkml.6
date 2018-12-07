Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A825DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB820868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZG+dnTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFB820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeLGQfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40757 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:35:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so4382161wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjxMI89DvPAZnhOIEoj6bLz5gHp2ueDx3cr6cnwUctc=;
        b=ZZG+dnTLN/AgzqGWs+iivvi4u+Fcd6nN+bw6vH4XzZXdMC5os/JmEpF5iTS3EtMoGG
         T+kqZbc+eU3zb/hmFK1OhuxQ6liiPDcJLqytp1Q/Ob2MyCwKCd9aRDrD8AFTkLCvDAty
         /wEeq6nzCHmZJ0QothFu/HRZPBqcbHSaY0RL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjxMI89DvPAZnhOIEoj6bLz5gHp2ueDx3cr6cnwUctc=;
        b=kc4d3RcQCWzYTWruMArRw24egmMsJ4vW5UHgzyo3zzqGQl1C09RIeeJ9dxcmH/ETCo
         5STLkJYPIwvvO9Kymgzk400OEbK/0CDGra0XTefxVmxmGcts/sdB9JrIio+swwN+ko3i
         b6QZa4rJNyy7YlTcJQpdgi1C/dBGzrtpE8+eg4a+wdQDhIxXX48K0z/BCtCy/8OjQbeo
         ydxcAJ70U7SZAid07TJstmOOXSi7PgPmGW+We+efcKmgGeA2LEdE6RFjRDfqQd0x/EQs
         zl0H8CpilH/qZr8f5kKNXSgBfwiu7lu7P6Fd8dPk8EX3N9/iTvIEGJPDO5SltXw8K6Mx
         4R7g==
X-Gm-Message-State: AA+aEWZ3c3mELQYMtD1k2Cjih+ToU8wkpJBrv16tgtowFNujylDMnPBO
        EIxeyqU80ndO2Xy6lP5kDC6iRA==
X-Google-Smtp-Source: AFSGD/V+L7wZxad36lpl2UnekVZ+mIEKWa//5EOmKhgYxFLJl1dATRKmB69HjrTzq/R2lOuab2wubQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr2307626wrm.328.1544200518646;
        Fri, 07 Dec 2018 08:35:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w6sm4268752wme.46.2018.12.07.08.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 08:35:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/6] misc: dt-bindings: Add Qualcomm Fastrpc bindings
Date:   Fri,  7 Dec 2018 16:35:08 +0000
Message-Id: <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
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

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/misc/qcom,fastrpc.txt | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
new file mode 100644
index 000000000000..06e8c25839d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
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
+Each subnode of the Fastrpc node represents compute context banks available
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

