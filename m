Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1241AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB739206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCpHKBtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB739206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409763AbeKWXCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:02:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44256 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387898AbeKWXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:02:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so10085307edd.11;
        Fri, 23 Nov 2018 04:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UFvpLh8JCCWiGkqWwfjN9rWDhTen85Z4fj+eExc9wc=;
        b=UCpHKBtdATIFPupPEQWgqgLvt99ORdn1VOI83onH6zM9WKyC0i1WzomFK+dzACbDSM
         CE4QmvI/oL6oqrmhq3ebrTHYOz/tGHiYjD17yZW5bp7Tz3xn/iWK0zrnEaAAZqbgfYyF
         4gs3/s4fA7W31LiYl/I4lxZ/jyPFRzKCJ64pRtjhpJO5s0xXbBjvpf+kYR1coTIAg5Mx
         CHU7wYGB0EJ7qNoIxJdEjy+G/eLfjHd0b3ScwNr0wpKYKMeF1+BTLrurF0j+C8lBgMcS
         txIS2f3GKjsKabEuX+8AJ9dVnD6nmi6qduTEF/3nYNRkySRZId2uJeqxxJ4wJIC+o81P
         Bj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UFvpLh8JCCWiGkqWwfjN9rWDhTen85Z4fj+eExc9wc=;
        b=OTVTVuFmEQiOHtP3tGYVpPkIOTvyfW7ms8vKEXqCliTUEqRGJBoxZpZ8rq00AAHzJT
         Ii3viFderqJazWiastfegmp5xW2+m3Nd7Ho4jxI90UN172vdONKIF56VtLbRSFAF0UwL
         e0HsAGKSFP/Q8aTtokp/qzM/O/XYr7Vy1Ay7yKtgtXTeZ26Rgw4IMeOnRLcMsmamowgj
         GlJ2sCTebN87pE15o1b+EoV41yaPLApX1RCkhQycR0pIvmpBGpmLiWI8I2K7WsVstZdZ
         kGqiEL1ilEPX7BrLzt84qTIzeI/8Zq535s21y9ttH5k74UT/EmkkPMkzeJOfgoAHgbqn
         S8tg==
X-Gm-Message-State: AGRZ1gLfn2kH5UeTfaruM9AGHby8iROCpSNNjCGw2L0KJxfI6crwPIi7
        mHfa7BucDD7mSWUktu2txtE=
X-Google-Smtp-Source: AJdET5dRh0SHLpv6o/qLRhiHcYU0PiYSsTJYNf6kOd7ZZMsRoiKE4k0vqeX1d1DnaJkOr/BC6NVPmg==
X-Received: by 2002:a17:906:14d8:: with SMTP id y24-v6mr11441079ejc.216.1542975522020;
        Fri, 23 Nov 2018 04:18:42 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e53sm13775000ede.90.2018.11.23.04.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:18:40 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: thermal: tegra-bpmp: Add Tegra194 support
Date:   Fri, 23 Nov 2018 13:18:37 +0100
Message-Id: <20181123121839.18573-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The thermal controller implementation on Tegra194 is very similar to the
implementation on Tegra186. Add a compatible string for the new
generation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../thermal/nvidia,tegra186-bpmp-thermal.txt      |  3 ++-
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h   | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
index 276387dd6815..e17c07be270b 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
@@ -15,7 +15,8 @@ Required properties:
 - compatible:
     Array of strings.
     One of:
-    - "nvidia,tegra186-bpmp-thermal".
+    - "nvidia,tegra186-bpmp-thermal"
+    - "nvidia,tegra194-bpmp-thermal"
 - #thermal-sensor-cells: Cell for sensor index.
     Single-cell integer.
     Must be <1>.
diff --git a/include/dt-bindings/thermal/tegra194-bpmp-thermal.h b/include/dt-bindings/thermal/tegra194-bpmp-thermal.h
new file mode 100644
index 000000000000..aa7fb08135ca
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra194-bpmp-thermal.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides constants for binding nvidia,tegra194-bpmp-thermal.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA194_BPMP_THERMAL_H
+#define _DT_BINDINGS_THERMAL_TEGRA194_BPMP_THERMAL_H
+
+#define TEGRA194_BPMP_THERMAL_ZONE_CPU 2
+#define TEGRA194_BPMP_THERMAL_ZONE_GPU 3
+#define TEGRA194_BPMP_THERMAL_ZONE_AUX 4
+#define TEGRA194_BPMP_THERMAL_ZONE_PLLX 5
+#define TEGRA194_BPMP_THERMAL_ZONE_AO 6
+#define TEGRA194_BPMP_THERMAL_ZONE_TJ_MAX 7
+
+#endif
-- 
2.19.1

