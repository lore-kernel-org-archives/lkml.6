Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E205C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A05F216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aOHWE24T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A05F216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeI0V5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:57:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38009 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbeI0V5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:57:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id j8-v6so3136195wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sAOcr6SVn9AxMveOh/fICS9075N3yCUmB5MZuESswnU=;
        b=aOHWE24TPGE2us5ZTx6vHZafU2MBCqnXXwSc6ABZvptq0unaQoYSn22C7dyo1FJa5w
         p6mr5wjT2/rhG2BE1h6tOgS1HF/K0HNoBsP+Cp6rAdg3NvLWCGC8OfjbfpVVlMj31MGm
         7UjySmsXGO5RwcYQilNuUmn53zke0oMm+LMQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sAOcr6SVn9AxMveOh/fICS9075N3yCUmB5MZuESswnU=;
        b=Md+M7Zq6fb82Dkg3DnVnITHq7b6eXAZnDWhfrTqO9/ZWvuEcLU3C/d2fVix+KnBDPt
         fEGOD5aj6cgvOm6rVHvGi2NcerzErVVLixdfSADRfsbMOWX/rM/Y9+VTHT5/n3cy55KT
         GqtoMbrfRZbRsC8nHx9vjLrZYKum4tq0khas/VLBUOxjyodMJSBx9rKIUWHOQ8EyXjAK
         SnQwMuzxIidCjW6MZ3WEA1eSt2b5R9esIHAsjbtdiRAMdjKwhN9NAUcHCHV4cPWDKS3l
         5ml1bh5ajXYpo5z6J/8vN5VsOAb45wA1G/Kc0lXpmNWTeviOEonMS6Wkf6GoT3qoJu0/
         2X6w==
X-Gm-Message-State: ABuFfog3neHukUaDiodBGi4cb7/ZZ/Q2D1cFcYsMxw5223VJCSCkUUwh
        ilFp62pJNlVfqcJ2Osa2icbuwA==
X-Google-Smtp-Source: ACcGV60jsNe2/Yjjg9pniyXIEgMZ6HoIcFGk/BBJBLdYF2m3Roihkllw/KTJkCk4qfoV0GLzCIRg3Q==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr8975034wre.13.1538062690629;
        Thu, 27 Sep 2018 08:38:10 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2520033wrd.74.2018.09.27.08.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 08:38:09 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 2/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date:   Thu, 27 Sep 2018 21:06:42 +0530
Message-Id: <1538062603-7490-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
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
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e283480..a30985c 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,18 @@
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
+		tmon: thermal@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x0 0x40>;
+			brcm,tmon-mask = <0x3f>;
+			brcm,max-crit-temp = <105000>;
+		};
+	};
 };
-- 
2.7.4

