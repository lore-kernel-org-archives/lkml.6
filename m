Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E70C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE18C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BgBMbIwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE18C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJPXCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:02:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40783 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeJPXCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:02:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so4610068pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RArOkgJ6iozCqW4Amczd+Jty4/unLLqgawp7H0t8Irg=;
        b=BgBMbIwmFXedm08XKzLrV4Kb+sr6arL6sphjgf6KM0wPkBJZMdlgARpl30iOKAyC3r
         w5dQD3D0zCPVi3M9xRwD6+elU4PAgsKB7g49SU+bQBS6QziDKzkMu+2tQXe99vq6NeeA
         OGC01M+CaC50Nhiv33MYkwryQZMJ8d+aS87+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RArOkgJ6iozCqW4Amczd+Jty4/unLLqgawp7H0t8Irg=;
        b=XgZcAJE2SU5eLckWpJbLPw6vmj7EZv9yTPdaX84EfcOwDp5bqsTyOFiB0CVvzyWgrs
         arbcm6hRHZ05DzKLA/NAULAkYcYSkDYZcy53EmHtfHYs2CvaZw70b9WMDyTPjgBmuZbn
         csETDTFmEw7tmbk+ELBCEhjhfbPyg1SR/daI00IpjaPOsOiviCtWVOMQ/5R6HQm0l8Id
         w8MlZR4xb4Kk/tmCaWBkoe7dl9MvmUwR73E5sJxWyOhMvGdlySYLBZ2S3dcntbF7eYvM
         t1dcRskmclum95a3rol7WZaBaX1V9TaZfidQ3L+paroZnr8mJFGKxSDuUKOi27RdZvhm
         A75A==
X-Gm-Message-State: ABuFfojohd7Lv37KsfrbDv2c9ZXp7Tbd//Pm84FiA61Oq/tIdz5QE+Cw
        4efocVFPXMJelvC61sc1b3E6a/XB+Zc=
X-Google-Smtp-Source: ACcGV62S2g1E8mL9I4tzKMoHoS6ZY2Wk9Z6hXJFqBFMudOWd6nnC5T580NNd+kYPPt+o+h3VSa+p9g==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr22354378pfk.173.1539702698647;
        Tue, 16 Oct 2018 08:11:38 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i29-v6sm24227122pfj.82.2018.10.16.08.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 08:11:38 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 1/3] dt-bindings: thermal: Add binding document for SR thermal
Date:   Tue, 16 Oct 2018 20:41:18 +0530
Message-Id: <1539702680-3746-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
References: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
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
 .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
new file mode 100644
index 0000000..3ab3302
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
@@ -0,0 +1,105 @@
+* Broadcom Stingray Thermal
+
+This binding describes thermal sensors that is part of Stingray SoCs.
+
+Required properties:
+- compatible : Must be "brcm,sr-thermal"
+- reg : Memory where tmon data will be available.
+- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
+                  Each bit represents single TMON source.
+- #thermal-sensor-cells : Thermal sensor phandler
+- polling-delay: Max number of milliseconds to wait between polls.
+- thermal-sensors: A list of thermal sensor phandles and specifier.
+                   specifier value is tmon ID and it should be
+                   in correspond with brcm,tmon-mask.
+- temperature: trip temperature threshold in millicelsius.
+
+Example:
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
-- 
2.7.4

