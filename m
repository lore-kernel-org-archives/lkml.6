Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94943C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA0520851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYP/0cOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA0520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeLJRhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40440 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbeLJRhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so5720223pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ve2dYgrCZ5Tle2sJqAhn9PzIY+bLP3s6YNDsILvoiZc=;
        b=LYP/0cOgbYK2nuTZi3UJj5tE6bBV7bMqxBkzrvcG0JwpitEI8gurlVUXxCV1K5T6bH
         9dD74F1YiYMpWDoDRmL+v/ag9WgP8e7xEHLcPRbM4+QXtIBuQ2J6icUpPP0cCAfKBeFs
         SKG0VT9WQOO1cb2rhdQM9z5x0jznpwl6Xi4y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ve2dYgrCZ5Tle2sJqAhn9PzIY+bLP3s6YNDsILvoiZc=;
        b=SE7pos0yNXb3HsHrVKmW0suCsqdFI8WpohGlvvypBOWjJsUelCYfEytZJQmld8TD6y
         4C090rZpcdh/CBPd0AmjI/hxSkYiexgsV6+kgVrIYTYG3JzVMSkZDEjO5qAwC9VV3d29
         B5kKE7+fbXtJY5qm7x1UyVNVg4dLr/csYdHa6BpOi3mhThTyynvShn77IyTjPCD5Lxo8
         edxFbpHa77piiQAB2jsOXeOvLibXSq9ZEdMKW+xXuzHCBTKw5vK8TUHMt7PFkXpllXgF
         qbMeLVAr/KA2qGseeqFnilV2J9MATmRbTWPduVjecFS3TQdwSEK0G+3ExQFrLJbYO0G/
         ecPw==
X-Gm-Message-State: AA+aEWbjP/UQKj/rr3qZQLeb4Lh7MdZzbgSOGLhlhg4/Q6b+/Z9fAanE
        SJdQt0YyRvd1IkzebZcRPwfI
X-Google-Smtp-Source: AFSGD/VCP41P+oi6oAUSJ5qVFaUMQwfwdDsobUxtD/1d6CKrDLV5is0oFowj+9K3e3Pk7BMNQt6akw==
X-Received: by 2002:a63:181c:: with SMTP id y28mr11299843pgl.75.1544463441170;
        Mon, 10 Dec 2018 09:37:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:37:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Date:   Mon, 10 Dec 2018 23:05:44 +0530
Message-Id: <20181210173550.29643-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RDA Micro RDA8810PL SoC timer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/timer/rda,8810pl-timer.txt       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
new file mode 100644
index 000000000000..4db542c9a0fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
@@ -0,0 +1,20 @@
+RDA Micro RDA8810PL Timer
+
+Required properties:
+- compatible      :  "rda,8810pl-timer"
+- reg             :  Offset and length of the register set for the device.
+- interrupts      :  Should contain two interrupts.
+- interrupt-names :  Should be "hwtimer", "ostimer".
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

