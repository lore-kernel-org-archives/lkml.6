Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD385C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A562147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzInBpv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A562147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeKUOLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:11:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42533 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKUOLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:11:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so3370561pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qgs9dW8J2ciuq8Fdw9KElZ0yIlhVVHPqlEym1CikztU=;
        b=AzInBpv6w0Elaea+1eLs6wwFKhrsXEy+zh+4jUzH9KIQ5LKONHUBFW4HlVTJW0fvSj
         D7C4/cV2VYgBNDLmpghMoXtdWqh9gjEEKsV65RFvvY/J/LtyLQTxnYMSmCxWGH1KpoxJ
         JBThphmhfRFMgFufKURSAmO8OXegTIyUHUkTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qgs9dW8J2ciuq8Fdw9KElZ0yIlhVVHPqlEym1CikztU=;
        b=H5EaLPAhNz/t390YQPdPD7+P/picohliclqJNtHTOzd0zzEqMdSy182CTLgmbp9VlV
         Cwqpy/O3KmDIOSSHt7P+z3KFxsH0LRanikklzbw8wwa/6qgH/0PTtrf14714LVuHwnWu
         4xpCAan7QxtirHd/xu2073zk9qJwoBahyHWlaXl/LNE08i8e9nsERuqHa+JQ6gl5e/12
         M+aCTa55Q6KuQRR4lB4oFe3ihZeYxhhsHW8Z+I6VfXrE9mGDif/iwTQOWEgPdTx5fi78
         uI28Qp3uN+xH7dSY3OO7TjDneQfqgAZibASu1ZDtCLFCu30uZKC+IN6ZHk3lkCtsnwDT
         OE3A==
X-Gm-Message-State: AA+aEWZj1G4qZ/Ys7peU6c1nBAzVxIIl49SkzJYVVISoV6mmZtzmaaGU
        WIVgtnZ/wXuxu5+VQ5glPe+g
X-Google-Smtp-Source: AFSGD/XtNfoMv5UoMVB9myZYZEEKCSlgNAoCfad/oWzbLGHsjBJYXPWczQRYm5Ivwu0oQQyarjU6/w==
X-Received: by 2002:a62:2c81:: with SMTP id s123mr1582230pfs.174.1542771523461;
        Tue, 20 Nov 2018 19:38:43 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:38:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Date:   Wed, 21 Nov 2018 09:06:46 +0530
Message-Id: <20181121033652.12247-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RDA Micro RDA8810PL SoC timer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
new file mode 100644
index 000000000000..06cc2b00be12
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
@@ -0,0 +1,21 @@
+RDA Micro RDA8810PL Timer
+
+Required properties:
+- compatible      :  "rda,8810pl-timer"
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain the interrupts.
+- interrupt-names :  Valid names are: "hwtimer", "ostimer".
+                     See ../resource-names.txt
+
+Example:
+
+		apb@20900000 {
+			compatible = "simple-bus";
+			...
+			timer@10000 {
+				compatible = "rda,8810pl-timer";
+				reg = <0x10000 0x1000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "hwtimer", "ostimer";
+			};
-- 
2.17.1

