Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94CD2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="euyCdtDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94CD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeKNOaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:30:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41936 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeKNOaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:30:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so7219261pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T7qgvlLODeLc6ErlpcQegOzVpV+3/1/QmgVN1XI0tE=;
        b=euyCdtDNBVt3KvRjxdytQ32KtiEMDEsBUynF4OULbPrjlC5xwGdIHYU/VmuxOI345f
         2UORO8LtVhO4F5Ikf71KYj4ZqkPKuT4mdMnlTOXnneWTc1BChq4rb3SjtjDuXn+R3dno
         YTfLxwE/IJECKFPeak4D3JGru2m7BEadA0C9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T7qgvlLODeLc6ErlpcQegOzVpV+3/1/QmgVN1XI0tE=;
        b=EguUQM6kiZVLYvw0Qup/fD+kYG6p+uwPfYWfOfktpRcg0Yb8oOVY3vDFbTTeD0IC2B
         K92opN6IqWa6eq7Yfz6LasuB7aZbw+TjZCoozcyJ1N64wyvUNeWQsy0zAWbsp4QWZxN2
         RXxuEehKGGfFkta0FwdZPFLcUvcJ8+GziJwHKI1N245hRWskaJvUc33+BXN3kPyTKrEm
         ll9PVD8HVAGcIzWkhkdjEOiTPGIq4i1fke3N71SNMUgXUP7e/Vb5kbHgU7WKXdPJZ2vr
         1a5rI1RB0TkxKa5KbwUUSrIxwhCIxyErQqOCNvdpt6IZL7Fj36qiK7vTdEnQbHcX8Nu3
         u4zw==
X-Gm-Message-State: AGRZ1gLXtqO4E73o/Ceu8tqWdBZ4TdWKZWuzKy95X308Bvl78+Oa+cWh
        1NRP4b2oYX1ZuZjlg2sxdsQuwg==
X-Google-Smtp-Source: AJdET5cowqRpL20/4sz2WhtObRymNiisAV3NVM5VQeoKMm4jJUZS6+ZIRezTQMpxcnE0q+R0MsxpVg==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr371980pgx.10.1542169735605;
        Tue, 13 Nov 2018 20:28:55 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id d24-v6sm37131140pfe.40.2018.11.13.20.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 20:28:55 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/2] dt-bindings: gpu: mali-utgard: Add compatible for A64 Mali
Date:   Wed, 14 Nov 2018 09:58:36 +0530
Message-Id: <20181114042837.15149-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has Mali-400MP2, so document the relevant compatible
as "allwinner,sun50i-a64-mali" along with reset line.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- document reset line
Changes for v2:
- New patch, separated from previous version patch.

 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..3f128e4f95c6 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -11,6 +11,7 @@ Required properties:
       + allwinner,sun4i-a10-mali
       + allwinner,sun7i-a20-mali
       + allwinner,sun8i-h3-mali
+      + allwinner,sun50i-a64-mali
       + allwinner,sun50i-h5-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
@@ -73,6 +74,10 @@ to specify one more vendor-specific compatible, among:
     Required properties:
       * resets: phandle to the reset line for the GPU
 
+  - allwinner,sun50i-a64-mali
+    Required properties:
+      * resets: phandle to the reset line for the GPU
+
   - allwinner,sun50i-h5-mali
     Required properties:
       * resets: phandle to the reset line for the GPU
-- 
2.18.0.321.gffc6fa0e3

