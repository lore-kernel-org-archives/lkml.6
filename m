Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE7AC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D18F20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYEmU2t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D18F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeKCERc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:17:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50790 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCERb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:17:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2-v6so2887556wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AYhygTC2wYv/caLmoYMF60fvpB/eiIKLPujtWer++2M=;
        b=kYEmU2t9DfhBK6D9RUmtbcXwDpJ5OwD5nX0jV1vnQwlVqxEMz3+Mok9IUSV8iduF1g
         o+O6vjRoPsss7yOZSGxY7C6I67HP7HBaAzrqtx+RV6qJp54/NOcBBL2lRG/1+pVrXQO1
         z6OINvE7FW6oaUMsKftiAaKIDBhqv17XIJr0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AYhygTC2wYv/caLmoYMF60fvpB/eiIKLPujtWer++2M=;
        b=Of2jl8HunQboj2I5M7U9ZzMRe7rVzpEJVfdYqlDAsT7NX26UZvZ+zzVHH0RHXwqSRh
         DOdAVrX/dsIjAnCKleSz3j4p6oAzh00HolO7Jup0g0aiCZSkPAJry4gG263j76/bDYtZ
         GYXYoqjDOCVvtb/LwufmA9JRfXuJnsfkjoRv06W0Rol1q9N3lp2vcZEXEU8D9E2OeWPj
         6o8HQWLglIgA5wTz5rP3wyD5ljyygCTCJAQm2ssW4O5cCtqbO7Iu5Mw+DTy83/Ax2Hqd
         oiV6EMvotoKymGiQBkrfsM/wTPTzLeTdujgVN1GEYKQ0oVTjaG90ZKhQUO7f/CV+BkFv
         r3LQ==
X-Gm-Message-State: AGRZ1gKMKMfffbGMgEczAIqqwQtJ0TAfNypIj3d8B9/Tmk+9jC9u/miY
        YLDPLuFWSHqwSO2R/qTBfJWO4g==
X-Google-Smtp-Source: AJdET5eg2UEdfeZRNT7JiH4n4ED/Vb4xC+DK7pkxSGJh6rFqlPCzZO+MEJO3C62ueaZ245Sh6lR6nA==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr165944wmd.3.1541185749708;
        Fri, 02 Nov 2018 12:09:09 -0700 (PDT)
Received: from localhost.localdomain ([80.125.186.228])
        by smtp.gmail.com with ESMTPSA id s195-v6sm3899337wmd.39.2018.11.02.12.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 12:09:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ren_guo@c-sky.com
Subject: [PATCH 2/4] dt-bindings: timer: C-SKY Multi-processor timer
Date:   Fri,  2 Nov 2018 20:08:56 +0100
Message-Id: <1541185738-8208-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
References: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
 <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Dt-bingdings doc for C-SKY SMP system setting.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/csky,mptimer.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
new file mode 100644
index 0000000..15cfec0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
@@ -0,0 +1,42 @@
+============================
+C-SKY Multi-processors Timer
+============================
+
+C-SKY multi-processors timer is designed for C-SKY SMP system and the
+regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
+
+ - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
+ - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
+ - PTIM_CCVR "cr<3, 14>" Current counter value reg.
+ - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
+
+==============================
+timer node bindings definition
+==============================
+
+	Description: Describes SMP timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,mptimer"
+	- clocks
+		Usage: required
+		Value type: <node>
+		Definition: must be input clk node
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer: timer {
+		compatible = "csky,mptimer";
+		clocks = <&dummy_apb_clk>;
+		interrupts = <16>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4

