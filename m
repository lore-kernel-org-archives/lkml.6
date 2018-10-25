Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F3FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DEE2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XnFg+twc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DEE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJZG4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:56:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34044 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJZG4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:56:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id f10-v6so4534002plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+LgcWkQxncFqD35FDqpvfp7mOi58SqLpjOIXD6LCUY=;
        b=XnFg+twccYS6WPM5VAT3U7gHPAvWqMtdXR0uo97VxhfAtJAFcG6BrqhGvGrnXkHUR5
         MQ/gYWyf9J+GZK6xEZme1/8Tzu/PrXJ00bvMR8eklmus60hhYHEK2WiiTH1ED+ilIiqz
         fo4G7iDuiaJrq8im72wIn17mtO5EjPCysivGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+LgcWkQxncFqD35FDqpvfp7mOi58SqLpjOIXD6LCUY=;
        b=MCikaO4nPmEAvMVFUpIkx0FsKMglujAhUDdZHQnj68r9tl4230G8Wwrg4jFzjqrlPA
         4zf74cGFQrk9p3318U3u6MHPrDfgDKBQsvGgRD+3RPE/aC4SmO83BY3bmVGvSW1XiHbo
         eygkYlcMq925TIKqXsDI/UEOEDE+SmflqIEvKi+XUgN6uPMU5gfdvEbCX2U05NDlTkAJ
         nTsCBoyiCE5cEOFxOOi6yEA/P0tgw5CwtkvNvGBkJcun7IWxPYe1TTgr9HKCbSHcvqTh
         Q5sTIiGtSeNPrQiUHov0wxRpaSHXGQHB+JjPaFdeKJ9nfK97+K44bw/EJ9UOZV7M0QHb
         suTQ==
X-Gm-Message-State: AGRZ1gLsOKlJCnIowVHYz04Xc41eFhpfWvljYrsFdb7orZZbrhYvDewm
        CmlEctibAG1qU24KJbYmt/knlQ==
X-Google-Smtp-Source: AJdET5eBvm0W+ZrjAgVekK9Dk6m4WXSwBmTEZY+9sHXXYPpvaQPioUmALvOOTipUaIPSH7SISaiPjQ==
X-Received: by 2002:a17:902:2808:: with SMTP id e8-v6mr882658plb.327.1540506127727;
        Thu, 25 Oct 2018 15:22:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id x73-v6sm19813778pfk.139.2018.10.25.15.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:22:06 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: drm/panel: simple: Add no-hpd property
Date:   Thu, 25 Oct 2018 15:21:29 -0700
Message-Id: <20181025222134.174583-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some eDP panels that are designed to be always connected to a board
use their HPD signal to signal that they've finished powering on and
they're ready to be talked to.

However, for various reasons it's possible that the HPD signal from
the panel isn't actually hooked up.  In the case where the HPD isn't
hooked up you can look at the timing diagram on the panel datasheet
and insert a delay for the maximum amount of time that the HPD might
take to come up.

Let's add a property in the device tree for this concept.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sean Paul <sean@poorly.run>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2: None

 .../devicetree/bindings/display/panel/simple-panel.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
index 45a457ad38f0..b2b872c710f2 100644
--- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
@@ -11,6 +11,9 @@ Optional properties:
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
 - enable-gpios: GPIO pin to enable or disable the panel
 - backlight: phandle of the backlight device attached to the panel
+- no-hpd: This panel is supposed to communicate that it's ready via HPD
+  (hot plug detect) signal, but the signal isn't hooked up so we should
+  hardcode the max delay from the panel spec when powering up the panel.
 
 Example:
 
-- 
2.19.1.568.g152ad8e336-goog

