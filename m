Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F99DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227AA20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aan0EMnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227AA20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJaS2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:28:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34088 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeJaS2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:28:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so1473553wre.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZKXzc/9xi2oqrkPABloEIrBfH+ajRu+w1WHKhdOM4Rk=;
        b=aan0EMnXfDfOU3ca4R0bzQftvlM4ux2NUaP9DsCSp15jp64rmSsQvkALE+o9L+aXNj
         NTBE2ziWR+VhvyST0Upny13wP0AL3yUYufEUy+qscRzayHjwqqJCrFx+2ZI7w+XZik8h
         OQKLeLjjRSWHFGdJSu8tczyhIjt85xRHN5Dsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZKXzc/9xi2oqrkPABloEIrBfH+ajRu+w1WHKhdOM4Rk=;
        b=XOn5exS4vzzokD7GPBD/VamNgRkStfGlnp8dCbLz1Y5mnFcJd0DXAXATcSsflxTLW9
         Ox5SjNPyunx/S3Y4Xy/xWLvyfv7CTk0cdvLWeYV+KUoYGoT7D+UH+fgw3hP8XjP1bmgw
         /VMDpMAeVcw+lHnjiRoa8ZAHq8l43tcuppqLo1c6pSB+WVD/gkoGgsE98AYyiBLrJ2qu
         09i2vCjIx30SnB2hERkqzv9fQlM+e0r3leJ+G+z2EVah7zxpdyPiR9iVHKnxN0375/69
         QDVM6Q2HS1EACb9xEYvmjOBu47e9gChhUongot4C4RNYaIN4vAbSnQCMwWNF7+8iPKt6
         aUyQ==
X-Gm-Message-State: AGRZ1gLpLwzusEnXqJOoIqWLf6jKtCLOPWfuFYz0XAgvqyFeDwLl7wXz
        Xwe11zbB+nnC15CLSHL4xhn82g==
X-Google-Smtp-Source: AJdET5cjhOAsBRDqNKR9ofuUFrrUZAH72t0ymGqkOxje1ysdvRhXFohd0iet1pmQ4nYBn5Upa2vqlA==
X-Received: by 2002:adf:e485:: with SMTP id i5-v6mr1953416wrm.101.1540978250250;
        Wed, 31 Oct 2018 02:30:50 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1086:999:fd1b:8629:a7fc:68b])
        by smtp.gmail.com with ESMTPSA id w14-v6sm10737377wrt.73.2018.10.31.02.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 02:30:49 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/5] dt-bindings: hwlock: Document STM32 hwspinlock bindings
Date:   Wed, 31 Oct 2018 10:30:28 +0100
Message-Id: <20181031093032.20386-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181031093032.20386-1-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for STM32 hardware spinlock device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
new file mode 100644
index 000000000000..7a999479d802
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
+		clock-names = "hwspinlock";
+	};
-- 
2.15.0

