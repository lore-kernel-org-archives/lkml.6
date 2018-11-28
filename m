Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE233C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B102081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HG2bRYBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B102081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeK2Aye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:54:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37822 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeK2Ayd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:54:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so9543749pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qgs9dW8J2ciuq8Fdw9KElZ0yIlhVVHPqlEym1CikztU=;
        b=HG2bRYBRUSrhaHTD+gS8s5FYnSbSIi8JW1rSPkP2+5ADvQ8AQoYlpHzzRi5kCZXCkH
         O4mdzruKNXCLycLS/5lQ5xw1ZzHKev8Dv1zHqL/yrbPzLmr8EbBqIcPlpQZw5YwRcQA+
         t2ypO5SsJfHgcDDt0AvVPRd9mVKEwyyYE643o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qgs9dW8J2ciuq8Fdw9KElZ0yIlhVVHPqlEym1CikztU=;
        b=Kuq+3d45nS0JhRfZlJBz6Smmaqm4cRcDnC4oULVge5ftSo3+fWrlWPQMcBSuJfQiQ/
         lz75SbmvtZoEQC/RkMPz3+8LQsXMioKr56FtYyIG7vjFBaC88QlgsmlQftwpvyl+d3It
         7b7hi+jZtI1NTG/IRjHhzUZ5y9nfueVBl7cbG/8KdaFU+vVq8z9/TqcB4ztMquDd00gm
         gvChfPH2O5xuPBMGgh75ggVdbCAWehLymyE8/H6ZGnS+Bk1XfBY8h5PHElcAnVcT2lxt
         DddDKe5XNob1PzmpefY9Z6egIaKgdjEClFu0oj6vOVQmnBLRVMbSxi4OEGsw1cixyxGG
         3CDQ==
X-Gm-Message-State: AA+aEWYWPjPFYbJvD0p5sxUY4UTGWFpm3uBFgdj3zSfbN2fe6Qe8d8DS
        hJSj/6vQRBwoOGH4XEtNqDWv
X-Google-Smtp-Source: AFSGD/WcFtGyDh/rNwGXy5cRjEOvMBKb9A8NAmyBeaalgf9UiV4c/G+EeST1GkV7kOgYszv//umSJw==
X-Received: by 2002:a62:3603:: with SMTP id d3mr6441139pfa.146.1543413169448;
        Wed, 28 Nov 2018 05:52:49 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:52:48 -0800 (PST)
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
Subject: [PATCH v3 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Date:   Wed, 28 Nov 2018 19:21:00 +0530
Message-Id: <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
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

