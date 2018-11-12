Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D337EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B352224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6y9GgLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B352224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeKMBRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:17:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeKMBRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:17:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id j17-v6so9777532wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+scvbKSgWS1sZ8YB01SJV/sDev8JcNZzuzRnAPkaFfU=;
        b=b6y9GgLsXE2zRQnjmQunelvLgg8c9S0wwRJK0W/oiYfTleWd3qPPEJApTjNUCCq1EE
         uaozXLjzqYz84qZx6+GQRfk9u5zF9wjXRzAnEfyd7g5iykFth4NhXtDktP1yC+M3mIau
         3mKYNxogJxOm+cDKkyc/0ftEVUj9LKTcW90lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+scvbKSgWS1sZ8YB01SJV/sDev8JcNZzuzRnAPkaFfU=;
        b=Db+AcjEy4adHA/j9wfoB42BbnU8Zb2URVqyb+DILc5fku6AVVxT6nf82RUz4nK1cco
         69z0QiaoQgfqELGfxyPJ1hzmrg1wuSb/Yv4d6KXoJA1TpMASc++ewfaCVaC77YPl2gWh
         5yBSvUSoAvVo02eutXv+ZMBHP7xv5muvGdrdioyHmLEfqNO7sIH2Wa5GYoeJSCqIkrft
         3MQZEFaTyhr3K+zrrbwkTGU3nPCjDVi5Pv2w5cyHJJuWhL6CV/JbcY6tY6PseA6uL2gZ
         qYgOYq+cgp5g9yKPf2aw+StjoKO1m1ZxosEjJ4Y+LkxEJUPEIr6Ityle5deztOEi7ujO
         aaNQ==
X-Gm-Message-State: AGRZ1gL1ODuQ1nPSSa46H15sauHvjKkGKX/H3nTnkIa5XTuOcA0LkrzU
        hM0zC1pPLnO35UqWBqlu2fuH9Q==
X-Google-Smtp-Source: AJdET5eOqBQjVl2aY+ctwq8SwBfWpS6FCukxRI6DOeEBlq0uijcaAowAORTWJaIuYZfbUC+ORgVSvg==
X-Received: by 2002:a5d:410d:: with SMTP id l13-v6mr1363524wrp.61.1542036230916;
        Mon, 12 Nov 2018 07:23:50 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:105e:a8d5:7c2c:2737:d373:11ee])
        by smtp.gmail.com with ESMTPSA id t82-v6sm11192849wme.30.2018.11.12.07.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 07:23:50 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 1/4] dt-bindings: hwlock: Document STM32 hwspinlock bindings
Date:   Mon, 12 Nov 2018 16:23:39 +0100
Message-Id: <20181112152342.6561-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for STM32 hardware spinlock device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
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

