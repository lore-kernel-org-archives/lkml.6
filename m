Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A90C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6565920663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GDsqbdyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6565920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeJWFIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:08:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46443 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbeJWFIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:08:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id r190-v6so7945128pgr.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4a7sqGi0woSvMngHSP5nAGi8IS8dbPL7pezY6AoAXTg=;
        b=GDsqbdypuvyVQp6CFQr7rsmI70RmOerzUKasq0mh4Q/KZkcBCezShgB/voc1wward7
         zbSxdCwKi+id3XIYxcNe6d9gpcU+Q+DK+fMBkMk8ErJDjMmOXo/f5S+T5YDEJhGv4uNL
         he58a0yriSm3AG7lRDuyEUSNG76piArj+a6ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4a7sqGi0woSvMngHSP5nAGi8IS8dbPL7pezY6AoAXTg=;
        b=syCo+744nZcjsjduGUt/gxs/liW5GCEh0V0k1QbLXk//CZpd25hK8oH6eCBvSpsUM1
         AFmuSNIKXYxSpCHtosf3WYmQTXqIiguC5g2wYU4jMOkSKEmaXbSFDs4fKIgsz5/zCYJR
         bwhDT2IDxmYSTC+oyzYpFg8VyOkTnH1GSsPHxT3w1WuhhRGTpG2A/oq8juXwqKQLflKt
         0i7gtxIBD9U/8ODO6VhV7Buj1M0XrN6HAruNhCTqKQr1EmvOdEedjvj0IjwNFB+Fnns0
         IHlgs0/0EF0GrtNeL0HbMVlzKDpTnmRe8tXIuj3jt2MuWhS+5rTs205CU3X9WLUTavmJ
         FuuQ==
X-Gm-Message-State: ABuFfojZzcu5ntEbZizxtmqTh7NJow2SFEJVvygAsvE17JnmMUeSSXqN
        ExuObpDuKFyYz5HvhKbXMK1Zuw==
X-Google-Smtp-Source: ACcGV63MOz9xU64vSNdyCgJbX6qtYuydqvMy5srNCOVlvnR69Hh2QkvlSodWDoIL+fK4TivAbENJAg==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr42240926pge.232.1540241327219;
        Mon, 22 Oct 2018 13:48:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id y144-v6sm47483001pfb.81.2018.10.22.13.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:48:46 -0700 (PDT)
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
Subject: [PATCH 6/6] dt-bindings: drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1
Date:   Mon, 22 Oct 2018 13:46:39 -0700
Message-Id: <20181022204639.8558-6-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181022204639.8558-1-dianders@chromium.org>
References: <20181022204639.8558-1-dianders@chromium.org>
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
Cc: Sandeep Panda <spanda@codeaurora.org>
---

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

