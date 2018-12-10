Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1982082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGlkSDyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1982082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeLJRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34680 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbeLJRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so5581168plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
        b=AGlkSDyV4ns2334v1ZYiu7kNpDVrFQ/E4gZNcudTBLEdt/j5qpg80n1QN50gmZCoGT
         6Mhrh3Idbbo8Ejsd0j0YaZPbv/mrJNZEITnTtH4I41xIWXdrs9vTs1J2IvlX/msycokX
         QzVrI3Tq0JI1wEiLhRDaju+cvhKGOHzEC/1kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
        b=e0xIaKoXUj3zEb7IjD3Cgl9zVdqsn1V26/lvYAOdUcS0hH/3S++vDE7ZMxOCQewJDD
         qwV0//f3YTI+WFtfSNalLg4FJSwNB/wv5/tmQxgxk/EGN5aA+peqLHHP5hrKqOzMWoKH
         HCwqqyvFJ6+mLX41P4jcJMYX0V7Gco9nw4xAotsM0D1fRmbQxKJCYIXqP5myn/bbznqR
         vSCPV0loVUXMWmFz+zkPjdbqa5FQ6AllYQXh4uLx96J25DCCjSduusL5zeW2vIdD+NOP
         FkF2+ZqqONihmgZnetCZQg/DeDr9zLIArjW09k0F4fshlz3NP9rVGHHJNhd378giZUM9
         ZIrw==
X-Gm-Message-State: AA+aEWZR28r3fXQaPVlyJffCKrZ/aeawC1CrXb/JFoVEpQeJoKcHHvvn
        Ijs2Veiq6pUKOVEqZ1EfklYf
X-Google-Smtp-Source: AFSGD/WlF+xuJEU1KBWr3sQndFFkB9adKzU2vqd8abhLHX5J88zYdjbHuZ4W8q+Dasn1E5FjFxd9YQ==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr12940556pls.5.1544463468534;
        Mon, 10 Dec 2018 09:37:48 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:37:47 -0800 (PST)
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
Subject: [PATCH v4 12/15] dt-bindings: serial: Document RDA Micro UART
Date:   Mon, 10 Dec 2018 23:05:47 +0530
Message-Id: <20181210173550.29643-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add an initial binding for the UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..a08df97a69e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,17 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+- clocks     :  Phandle to the input clock.
+
+
+Example:
+
+		uart2: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+		};
-- 
2.17.1

