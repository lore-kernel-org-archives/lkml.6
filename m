Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334B8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011B7222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aEXA47NO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfBMJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:26:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34587 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbfBMJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:26:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id j18so895235pfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7HfAbF1OGZMXhqcW96klsMo8xb5zJKMak24RvfCSKmU=;
        b=aEXA47NOOXupF/+oe1euEBQpwlZjP7ua8ri4CbaCemkHQwLOit2Qu+VS+MqTdvODUo
         ipAIsY0QNZAExHmVnrGE+I6nx8GDmM3y6AviKEZTUkj+VC6+Kot1AdVT1rP0y2IbsOII
         b4kZ0XI91gu/UWcSJbwzxgdHBy2DY7qPAAlFL5tLzp17+JWMrmKgyBtf0TTaPwx+laGf
         jzRj8YHSa0abX7D7HNK+O7+FSwvZNFRLGi+rDkTSkV8bAplL9+XO1daIylZEwUIaCuuL
         QmRUfWrmrFtIszeBgbeQ2LezVFLgN5nksSRGYwgbIvq+Y/ecAtsvXBVwVpF3TTFozuWy
         KZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7HfAbF1OGZMXhqcW96klsMo8xb5zJKMak24RvfCSKmU=;
        b=CLqHxa4NpZVNAp3A+vyA02MAhnxYrmQoqayxyBrSLBGXmKd2bBXEiTrnlsS5QhpZCm
         xMfXCfpluPMaZFJbIWouiSg25niWA2WnTV7OLuxI+Iakm1oTzAvVqfIrGp5+qyFRfS1d
         q6Y5fXcH+6icHAFsBcfp43VZ4jdjpJahxV1Hr3H9qPXtOcTKopdpSB0KycBNywxFe+Bn
         zoX4FHC3pYg6PbyD8xcq+jg8LLhxEnmDd1E9KjQvM1GFx7LWLdQfGrqvQ+OuVpx54huc
         6eD9LqVXJMKl1//McOIbyu3HADYVMhU24labVABH39OIVMpfucCXSTg2RHTp/5NYoxcR
         jDNA==
X-Gm-Message-State: AHQUAuYrzHZ7v3g985kV0eSZqzHm49UhxVwimZaE7aU2puF2nr/Si5rF
        yRkaMMosBNh0i29Qa7iuASnG5Q==
X-Google-Smtp-Source: AHgI3IYiZYTquB1nbBmJispxpSWQvSYjO4O+QY5Wv/u/E1HF1fderjX1fgboTgLoVQr27hz9l2kVRA==
X-Received: by 2002:a62:c302:: with SMTP id v2mr8729772pfg.155.1550049997824;
        Wed, 13 Feb 2019 01:26:37 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v75sm188875pfa.164.2019.02.13.01.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 01:26:37 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v6 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
Date:   Wed, 13 Feb 2019 14:56:17 +0530
Message-Id: <1550049978-20705-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
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
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..3b9c64c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,30 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. All PWMs need to run at
+the same period. The period also has significant restrictions on the values
+it can achieve, which the driver rounds to the nearest achievable period.
+PWM RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+Required properties:
+- compatible: Should be "sifive,$socname-pwm" and "sifive,pwmX".
+  Please refer to sifive-blocks-ip-versioning.txt for details.
+- reg: physical base address and length of the controller's registers
+- clocks: Should contain a clock identifier for the PWM's parent clock.
+- #pwm-cells: Should be 3. See pwm.txt in this directory
+  for a description of the cell format.
+- interrupts: one interrupt per PWM channel
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <3>;
+};
-- 
1.9.1

