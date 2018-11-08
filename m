Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF88A2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRCeYAKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF88A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeKHSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeKHSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so446392wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jRCk5lNBlPCD7GwKBzaRehaZeMJbLJXp2+/KqxIsFvY=;
        b=PRCeYAKI1JDWmpfIB+fVwGmz1XhZopfERjhSMfAfj3b0fJndvCuqDwWV6yzY1OtbFK
         0W//QSrqpdNuwU+HsEqHP9pCgjJsWcXAJay1v5nz294M2/jrG/HVUvpKpy0mHF2fRCeq
         M0S3gqspgYb9Z1kMebrHkdqa0KPLAVfu6Vbzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jRCk5lNBlPCD7GwKBzaRehaZeMJbLJXp2+/KqxIsFvY=;
        b=gGS4/nFgOA7jT8RZj4sV74dMcC9JzOXFvLlSxj+A93GqKeJ+mulys1ILiIumdlABEW
         lAXueP0VvETjBcaPY4jXEW3mQC6Mbcte8YWs7mxDv/SsSHM35KZNRTNzdl725RhJl3VZ
         v2gykjW/EOjg2NCNs6+PepzewMXVWNMS1nmjnAoidBXHI7qgYbIKYSw/ow/IJM05egAA
         Rmj27iB3v+HwvZK5fAX7bU1a+Mm+VuFXqDE/754Txg56rUXCCJ2GGvQDEfLzvp6SSmKP
         BN784byiedW7Sfg0our1j4+tY/9qvWHyWq8Oa0y1OVoYDLRvs+JbAtoSAgBcEM+2HhJr
         WoEw==
X-Gm-Message-State: AGRZ1gIl5LXa9o3N4J4utqc79p+mTf2iMlJZtZcmYWJ3U/Dq/KVeBwOx
        YRa3M7A9QkeXwaWlqTd5qlIQsA==
X-Google-Smtp-Source: AJdET5fTS06uzWUmAt5qrVnJNaHoFWBuVdlyggZVVgrWQkFkHAKhOM7cxVKHTm9+CO0iMvwifDK43A==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr412831wmf.143.1541667916129;
        Thu, 08 Nov 2018 01:05:16 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1094:149:440c:9368:8cda:a020])
        by smtp.gmail.com with ESMTPSA id l140-v6sm6974469wmb.24.2018.11.08.01.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:05:15 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 1/4] dt-bindings: hwlock: Document STM32 hwspinlock bindings
Date:   Thu,  8 Nov 2018 10:04:59 +0100
Message-Id: <20181108090502.14543-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181108090502.14543-1-benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for STM32 hardware spinlock device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2 :
- change clock name from hwspinlock to hsem to be align with hardware
  documentation

 .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
new file mode 100644
index 000000000000..6e933b218574
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
@@ -0,0 +1,23 @@
+STM32 Hardware Spinlock Device Binding
+-------------------------------------
+
+Required properties :
+- compatible : should be "st,stm32-hwspinlock".
+- reg : the register address of hwspinlock.
+- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
+	hwlock, so the number of cells should be <1> here.
+- clock-names : Must contain "hwspinlock".
+- clocks : Must contain a phandle entry for the clock in clock-names, see the
+	common clock bindings.
+
+Please look at the generic hwlock binding for usage information for consumers,
+"Documentation/devicetree/bindings/hwlock/hwlock.txt"
+
+Example of hwlock provider:
+	hwspinlock@4c000000 {
+		compatible = "st,stm32-hwspinlock";
+		#hwlock-cells = <1>;
+		reg = <0x4c000000 0x400>;
+		clocks = <&rcc HSEM>;
+		clock-names = "hsem";
+	};
-- 
2.15.0

