Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7168ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB86E2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EmNeYwP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB86E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJZG4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:56:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeJZG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:56:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so4876655pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79HngiBDiQu2HqmW3Dmf1zE0w4nzN+hU7+BFGeGhgIM=;
        b=EmNeYwP4x1HTsYsJM8cs8H59zEH38Elacy2FAYgWiikugmiTCXVNRgd9CBmueKvb7Z
         MPuBUGeI3IZheUGHM1p/+ST0rcK4kAqzp1sDEr8TnHawSMoovAn1lMtt2KujCI5A7QCK
         y+AZx6HFIenTCK+bYcoy8AEFsCCN9f6v3JH18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79HngiBDiQu2HqmW3Dmf1zE0w4nzN+hU7+BFGeGhgIM=;
        b=GFNK3p8+AGBHFAiqu1/uzpzKQgP6D8T5PvUxXSIPCEKKwaLBB6C1fVIoiOFKHAS2w5
         8GLjhTgJu2oHptdoB4vTyFSAdjgZYnF70M4X5zbakdYbsuhG7x3+ZhrGqHHVZryiFLJm
         U1AuEl6813LOVgerQ9JtuQTE6MALCqNXGATubGQAGSqVRi5STeb+ZGdfF3YkAtuTCdDP
         gOIqClhUlrISmA2hykEY/GpTB9qIPlz/Na//w1ArPRBss3p3FHlzB8CPHWTyPS0JUOLf
         DzXzcdXfxZnBJhv27VvGzAl2dAxDYuNx7nWot13OQuoXT5MTXa9pY4ua6ldAr/hjDBTe
         v65g==
X-Gm-Message-State: AGRZ1gLoA0oxFlQzD80lyNhwS5HWdsuU9i61g4d08r16aYYyTUUtKNdB
        wQA3TBBj34tnzv7arZSBVA4vJg==
X-Google-Smtp-Source: AJdET5eqvzEfmkcLeUAWviq115QBMql7glcC5nEy0ys75ESrypX22pZGmtZwEnq9LDl1Aftu6rGjNQ==
X-Received: by 2002:a62:9316:: with SMTP id b22-v6mr993871pfe.193.1540506133351;
        Thu, 25 Oct 2018 15:22:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id x73-v6sm19813778pfk.139.2018.10.25.15.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:22:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 5/6] dt-bindings: drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1
Date:   Thu, 25 Oct 2018 15:21:33 -0700
Message-Id: <20181025222134.174583-5-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025222134.174583-1-dianders@chromium.org>
References: <20181025222134.174583-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell the bindings that were added in commit
9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel
bindings") weren't actually for Innolux TV123WAM but were actually for
Innolux P120ZDG-BF1.

As far as I can tell the Innolux TV123WAM isn't a real panel and but
it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
Let's unmosh.

Here's my evidence:

* Searching for TV123WAM on the Internet turns up a TI panel.  While
  it's possible that an Innolux panel has the same model number as the
  TI Panel, it seems a little doubtful.  Looking up the datasheet from
  the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.

* As far as I know, the patch adding the Innolux Panel was supposed to
  be for the board that's sitting in front of me as I type this
  (support for that board is not yet upstream).  On the back of that
  panel I see Innolux P120ZDZ-EZ1 rev B1.

* Someone pointed me at a datasheet that's supposed to be for the
  panel in front of me (sorry, I can't share the datasheet).  That
  datasheet has the string "p120zdg-bf1"

* If I search for "P120ZDG-BF1" on the Internet I get hits for panels
  that are 2160x1440.  They don't have datasheets, but the fact that
  the resolution matches is a good sign.

While we doing the rename, also mention that no-hpd can be used with
this panel.  See the previous patch in this series ("drm/panel:
simple: Add "no-hpd" delay for Innolux TV123WAM").

Fixes: 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel bindings")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Sandeep Panda <spanda@codeaurora.org>
---

Changes in v2: None

 .../{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt}     | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt} (70%)

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
similarity index 70%
rename from Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
rename to Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
index a9b35265fa13..513f03466aba 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
@@ -1,20 +1,22 @@
-Innolux TV123WAM 12.3 inch eDP 2K display panel
+Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
 
 This binding is compatible with the simple-panel binding, which is specified
 in simple-panel.txt in this directory.
 
 Required properties:
-- compatible: should be "innolux,tv123wam"
+- compatible: should be "innolux,p120zdg-bf1"
 - power-supply: regulator to provide the supply voltage
 
 Optional properties:
 - enable-gpios: GPIO pin to enable or disable the panel
 - backlight: phandle of the backlight device attached to the panel
+- no-hpd: If HPD isn't hooked up; add this property.
 
 Example:
 	panel_edp: panel-edp {
-		compatible = "innolux,tv123wam";
+		compatible = "innolux,p120zdg-bf1";
 		enable-gpios = <&msmgpio 31 GPIO_ACTIVE_LOW>;
 		power-supply = <&pm8916_l2>;
 		backlight = <&backlight>;
+		no-hpd;
 	};
-- 
2.19.1.568.g152ad8e336-goog

