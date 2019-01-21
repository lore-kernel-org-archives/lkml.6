Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D99C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121632087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KW0hsGUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfAUKVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:21:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40111 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfAUKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:21:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so9921177pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fmoJrVzwYFHZWOk1bMmXKD4eQEtHgLKeyJmB+PpZY1Y=;
        b=KW0hsGUc4Q45vgSw8HKUIJpINXbRFHPOTcS+MDH6hnslwsHUZbmm8fDkRh4UllYsa4
         ACBqFiX1CcIK44IzlyuA0w2F/sqvf18oED1FOEEzwC9eTLBdXp2sPSNq7SdhV+Ak6+Lt
         x1gEjq1qLzRcCcWn8KKbVBY1uRfYNFW6gsl6S0ErKkjzrBECo+hjEusp8J4YgBUVFxET
         fKENmHl485ThiRGIZbkCbW6+cjKSobWRn1gPxrGwf752ant7zV6N8dWHcGkQevrTe6Si
         dYsyGKcJS+Rsshlc1aq7JSEVgpvF5JTVLsx81XtOlyquF9Q/A8iDfUC4oyqu5juQFggI
         t8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fmoJrVzwYFHZWOk1bMmXKD4eQEtHgLKeyJmB+PpZY1Y=;
        b=WvGvQohX56+D5ctVnQ+OM1HBGO+9THcwkHL/ogFb5cReFG/hKv/xEwPcmqqB7Qsw1f
         dd+QATZwFwgYCGnHMyOBOpGNhvlKEnlkqv4Fh37TKv9SmjdXKkHiwwlM0zmWQbykV6jq
         etm/HTt9QZDY2qyIFHfTqKf0BedwVyHwtYS41euit6WTetJFEbryZsftUS15/izzVfDk
         mrXGY3lDLHilqxNTECcZO6cT4cfTB+ouvKE8hdo3k5UCnBfziN2QjZu5tYo2yh8uf3qI
         fe9LrREAeXRCUev565feCciYJXgtwj2/xhnzZPjLJ+YRDNED4hu/1ko2hV01GKrDOyh/
         KALA==
X-Gm-Message-State: AJcUukdPa6w+8CrvKvTO+iDfgWfoV6u4P5ST9O30e/Pkp84dOrqzd3OI
        HU7sZuuQEkUA4aLSyJylE0njKA==
X-Google-Smtp-Source: ALg8bN5x+22efiFnU/FtDH3OQ8cc56IzsUwzel2+8q6gEF5nL2uq9xo6kRp7+f9PouaDwcCj17Zq3g==
X-Received: by 2002:a63:d157:: with SMTP id c23mr27380659pgj.170.1548066070793;
        Mon, 21 Jan 2019 02:21:10 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id m85sm20048874pfj.171.2019.01.21.02.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 02:21:10 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v4 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Mon, 21 Jan 2019 15:50:42 +0530
Message-Id: <1548066043-1252-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548066043-1252-1-git-send-email-yash.shah@sifive.com>
References: <1548066043-1252-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..b207908
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,37 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. This is set globally in DTS.
+The period also has significant restrictions on the values it can achieve,
+which the driver rounds to the nearest achievable frequency.
+
+Required properties:
+- compatible: Should be "sifive,pwmX" and "sifive,$socname-pwm".
+  Please refer to sifive-blocks-ip-versioning.txt for details.
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 2.
+  Refer to bindings/pwm/pwm.txt for details.
+- sifive,period-ns: the driver will get as close to this period as it can
+- interrupts: one interrupt per PWM channel
+
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Further information on the format of the IP
+block-specific version numbers can be found in
+Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <2>;
+	sifive,period-ns = <1000000>;
+};
-- 
1.9.1

