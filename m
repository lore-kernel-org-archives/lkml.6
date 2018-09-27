Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4396FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E80216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D7Bt4B6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E80216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeI0V4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:56:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40923 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeI0V4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:56:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so3130708wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTK2DT4Pd72/8VL2AD/vc7sQ9SeINmjisiHWs3Fn9uM=;
        b=D7Bt4B6qnQ+6dBXfv4w9qdLKwxM7Ctz0jnV8w1G48f9d1PorFSVOCjyfKgY6YVbi0A
         FgIu+rXlJBol0WNGuGQ7FQsnbM/IP22b8/N/m41jC1irNNHh1QyML9VbKhXgxnYj5pmW
         ZIHkIR44LeMg6T7sAwZFV+JS3hSbdDyRktR7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UTK2DT4Pd72/8VL2AD/vc7sQ9SeINmjisiHWs3Fn9uM=;
        b=mGUwZYPBsknvDaawsCtArNvC3lwErSrCuprH323EsHyhyx8zq18Q0MAITxVcr5wCLj
         Lnv4He+XRcOpYk9clhoiPTyNcV2E/JfWvrID0mjgj0Is3d4lOgtkNCzQnAUmvKAI7Wtk
         IFQIW+YXuVTc3WQw+kvDEVuhtAh/GJ7hG41K5VFzN8WYdVWskaH1IxS5ASiZZGfEAFIi
         S4SQMQic9AXuEpi4rorly1mYHoV0LHrV5ENyHU74McN4+EitD5mcrB6B3p3pPcdrfiq+
         66UNBMoJGWCB+O797hoJAdWXlE7OR14n/p5FxOkMFw9HR7F57VHLqkOskFYVDzII6YWb
         ir3g==
X-Gm-Message-State: ABuFfogy52e4tyh5FrF+8A1b0dPoP5u+NG9G8HAbHs0Qx69A6ayV4sYd
        rZl7F2DW/nDioEJSvOehzeNGpQ==
X-Google-Smtp-Source: ACcGV630tLyPglmSzKmFMPQ5z4DLSetOKLGB1MU34v8rHsMJQtovOlWqfbcN3qOZcUyigSlhenFNHA==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr9560452wrx.173.1538062683206;
        Thu, 27 Sep 2018 08:38:03 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2520033wrd.74.2018.09.27.08.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 08:38:02 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 1/3] dt-bindings: thermal: Add binding document for SR thermal
Date:   Thu, 27 Sep 2018 21:06:41 +0530
Message-Id: <1538062603-7490-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add binding document for supported thermal implementation
in Stingray.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/thermal/brcm,sr-thermal.txt           | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
new file mode 100644
index 0000000..717617b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
@@ -0,0 +1,25 @@
+* Broadcom Stingray Thermal
+
+This binding describes thermal sensors that is part of Stingray SoCs.
+
+Required properties:
+- compatible : Must be "brcm,sr-thermal"
+- reg : memory where tmon data will be available.
+- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
+                  Each bit represents single TMON source.
+- brcm,max-crit-temp: Maximum supported critical temperature.
+
+Example:
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x8f100000 0x100>;
+
+		tmon: thermal@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0 0x40>;
+			brcm,tmon-mask = <0x3f>;
+			brcm,max-crit-temp = <105000>;
+		};
+	};
-- 
2.7.4

