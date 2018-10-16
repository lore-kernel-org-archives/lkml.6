Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B9C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9E12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PVJ12pwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9E12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeJPXCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:02:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJPXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:02:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id a5-v6so10983390pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=On565HBkCyaEcPohsmgzNvP2rwrp9F3R/TfXDSPdaBA=;
        b=PVJ12pwmupKnDLWSq99htio06TI1mu/S4dm5MdVNNWEt5QdBDrx8TjOqUhjkDQYdSv
         fwBrFsol0zSokTC7y+DcDSQeWLCZ+AXH44pvYApT57jCN+D5WELBYK0zQ89uA6T7QsUw
         k7lrBp4aRix890O6ItItGwrXvzD1gdq70LDfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=On565HBkCyaEcPohsmgzNvP2rwrp9F3R/TfXDSPdaBA=;
        b=AdGwcT3ePbHx3Rum7Uq7tc1oxzZVpqDC9u9yUMh/RMBMk6lx9EcnL4nUOBx/hj9wIK
         uJN5yX26n/M4dDiJ+NGr3ZAolA7d6SVvY8JZ519K8NiSm+dr9Ju8+NNc69RlLKXdx9in
         nJ7q1lYTkMFeoC5etm7OsvkWVNJTjRekBGTpj7/i2zm5rFMEagzRb7TSbRwWTa0KTX3X
         0p8ZTIsDOmmXjhOwXBFXrxGRrpOCqCLdyUVyfpkeoc53bqmPEO5w7GlFYXp2Hw8C/INL
         xOrFjVX369pcYlWVB9WaGfVaI9G2YC4N0xpfWe6wuMyro+/COvAz9UInXJoU/NHx7Rov
         slLA==
X-Gm-Message-State: ABuFfogsOaqzZe3k12YkioxtWSrMZEJih7AxSdydGMJ9E4qclI9Q7zhd
        gLgs8p/vN/sa1FIbI3RU95QKog==
X-Google-Smtp-Source: ACcGV62H/wWHYIJUF2/K2zGq78JNu2BbIz+wHf1QfkOPEwBxSXc1xk9156onqOm1OMk+jLp83q1R/A==
X-Received: by 2002:a63:cd12:: with SMTP id i18-v6mr20930547pgg.319.1539702708853;
        Tue, 16 Oct 2018 08:11:48 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i29-v6sm24227122pfj.82.2018.10.16.08.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 08:11:48 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 3/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date:   Tue, 16 Oct 2018 20:41:20 +0530
Message-Id: <1539702680-3746-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add DT nodes for thermal zones memory base address
to read temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e283480..0d246ba 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,93 @@
 			status = "disabled";
 		};
 	};
+
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x8f100000 0x100>;
+
+		tmon: tmon@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x0 0x40>;
+			brcm,tmon-mask = <0x3f>;
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		ihost0_thermal: ihost0-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 0>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		ihost1_thermal: ihost1-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 1>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		ihost2_thermal: ihost2-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 2>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		ihost3_thermal: ihost3-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 3>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		crmu_thermal: crmu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 4>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+		nitro_thermal: nitro-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tmon 5>;
+			trips {
+				cpu-crit {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.7.4

