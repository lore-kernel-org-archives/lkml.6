Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC9D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Wa2Rv+u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfAKIXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:23:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45164 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbfAKIXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:23:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so6443887plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rfrxSQ6IO/YES72IRHCzaimUMiJ/XBASjBb5WLpKsYU=;
        b=Wa2Rv+u2eQdwyiYlbICKQpQ6NdaX1jaPNjz+94IyQ3tJ0hR3uHDkJCCsTtKzQ6GcSP
         Mv1GliSKAmXBM6XfDZM8Zxoxk+J5oAAf6139xX2U8xk2PDnccvIB8Lr6GygT2rhb8PqJ
         z8riLpZsXWNgaZHH4qalitXZ4BAZKie/qAQkazMDYdazrHXwNynT3lzYt13sl/CYYEwr
         KqdhDrHLKULzrb12U0tRsT0bZSh/LTx+tA96igtn+7N11RKj6471wwElpSTGeHILRJ2o
         mBmoCn5uNliSoiOeRsa79BDM8slG7xjswevCZDoX+XDtgkhncMDw82sXfxfAM1ae9IYZ
         fZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rfrxSQ6IO/YES72IRHCzaimUMiJ/XBASjBb5WLpKsYU=;
        b=V9T4QLOJmzAHN2dRysiXJKm0Po6n8V9rvT9KzbdvybSihE8tMzvEKFVomY8DwqDlGj
         b8baFqUQ+4rdDknQnkakGCV9VGlvkkpJnQJ78APtHOO0/rdSIpMEdK9nEiIldRNE+6fJ
         btHbquvIlR3gwJwq5Oeu5BCxSSuGEdpD08rvgbRwPcPVws8VLYKigCdaCrBoEmubgSNm
         M8fNDXfqKOeSW6D9wCmv58NwjIn/3aOYp7WrcjHC+fAVV6Q281JT9q2yukEKT6ervZw7
         KYIiL7i5tLoN/d+x/aIhIr+h8XhtKWn3qwNJQwZBKlAtFHjaFG+hYbe+kANn1sTtVsI+
         643w==
X-Gm-Message-State: AJcUukdGpEWr+KcgcuUvgQsVPRUiQcTdfF1Vri/j9dAjXN1Ye15GMYSB
        GfbAC+o5Tue+qcIh+tpQcyylCA==
X-Google-Smtp-Source: ALg8bN72ihbGuSWy1bMDOflT2VfuMHUJbW1W9Q6keqQ5CAC8S1Uq9kyL/c6Kn2Vjow7joP31sw4nhw==
X-Received: by 2002:a17:902:76cb:: with SMTP id j11mr14023595plt.179.1547194984490;
        Fri, 11 Jan 2019 00:23:04 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t87sm248422324pfk.122.2019.01.11.00.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 00:23:03 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Fri, 11 Jan 2019 13:52:43 +0530
Message-Id: <1547194964-16718-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for PWM controller added with updated compatible
string.

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
index 0000000..e0fc22a
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
+- compatible: Please refer to sifive-blocks-ip-versioning.txt
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 2.
+  The first cell is the PWM channel number
+  The second cell is the PWM polarity
+- sifive,approx-period-ns: the driver will get as close to this period as it can
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
+	sifive,approx-period-ns = <1000000>;
+};
-- 
1.9.1

