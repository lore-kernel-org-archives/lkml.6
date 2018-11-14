Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB21C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA5214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDK1/+/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeKNTDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:03:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38940 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbeKNTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:03:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so13973022wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NVMx9s0p6eS3mdR74Q8qaGNUdHlTjWWP5rB6sIuitXE=;
        b=ZDK1/+/FRKEwwPawhs+yyhdyNtZFMlja8+roKGKMxAb1QHb6QEGreUk7SwGCC1DsDN
         lhBJ+CpAlNELO9d4CJqDokjD/GXQ2R60qT4auHuDgUnzwZI4S1gk9M7qKIfRtFwnAJht
         ZcfjzRJv3peFKuEZ8QS4vAIcHNvCQPSUzGO2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NVMx9s0p6eS3mdR74Q8qaGNUdHlTjWWP5rB6sIuitXE=;
        b=J+yMj7Osq+ypUSrNorMahnycdrhkuNFhDknJMMy1PRtCTXsPEUj+WN7qo4Mn0bJln+
         xaugPN+Cgte0hYKW5siwJrbCWjpvyofpLYIz4/VXtJNo7uViF0KxLP4xpeY+91jizVjt
         QrguhRq9dPJQIx72X6WksXvRPGwLzp+XKD5Ml3mcbkHva/URbZSDssF3dnC04bDabCAH
         q3Qn57ipppt+Bq2swMtVqpSZPbujYeR7i0DpV8AsORZbDtAAGXqI0ypGHtYb/Xfg51Nj
         gZBSv4vZWgEvrq0UpoCLoz6ZEBTJ91gzL1XkMvCn2SH+FYDGRAMV06dJ5YyzG8cY5OCq
         8aJQ==
X-Gm-Message-State: AGRZ1gJeI173UPbXeJOVfhDs/zaLS7GNkWC8zcoNXGGbVqCMfggD1miz
        YLCMnZEjXEA5TRpyTEaltyqokw==
X-Google-Smtp-Source: AJdET5eaE6wWngOfToyeWHX5LFNPjYG0JB2ezHRD6TDE5muhGdzlgTrkzgcYIpx/cPs3onlNv2XJmA==
X-Received: by 2002:a1c:3a8d:: with SMTP id h135-v6mr1119470wma.92.1542186040945;
        Wed, 14 Nov 2018 01:00:40 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:4d39:8b22:d570:822a])
        by smtp.gmail.com with ESMTPSA id n7-v6sm16951441wrt.60.2018.11.14.01.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:00:40 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: hwlock: Document STM32 hwspinlock bindings
Date:   Wed, 14 Nov 2018 10:00:24 +0100
Message-Id: <20181114090027.7580-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 hardware spinlock device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
version 4:
- add Linaro SoB

version 3 :
- fix clock name in properties description
version 2 :
- change clock name from hwspinlock to hsem to be align with hardware
  documentation

 .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
new file mode 100644
index 000000000000..adf4f000ea3d
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
+- clock-names : Must contain "hsem".
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

