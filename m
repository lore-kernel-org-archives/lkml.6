Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA97C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8122120665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFB80zIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8122120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeJWFIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:08:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38339 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeJWFIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:08:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id p7-v6so673178plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9quqmV2lX7vsdq6jXIqD+prLue7GJEdsIfV8n4tr2kY=;
        b=MFB80zIh70s//Sww6znYj2Gkcnwnh9oj5+gBmfuoHFdXPChng1u6J8DPxn4iSKt1cP
         9Pl3/fxJl5n4uAgbJjXUN8LFGvRWcT1LGLO+bJKz/VlsM8HPQ8y+wUz3XEF7g1oDN2WE
         Y+qZoNrL1VpMbwFa+v60sUjpuu0y1h3DEiH9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9quqmV2lX7vsdq6jXIqD+prLue7GJEdsIfV8n4tr2kY=;
        b=PGc4PIwm2545Pw7HuD1zJT9i2Lcc9WVjVwXcB4rQ0uzdRZX1k/kG2FYzIZjzQud0FT
         NoOakcwQqRzRa0/nV6DTIS0+4Zgx6P3DFoZMYbm+skYynOY8Xs72NpRXGQu+itVC2EnL
         LiYdJFGOtJMdP/ZAHIpwvQW0Qah4AsfDVUuYtjT1s/Z9/LLk4WjYGjC0Ghwvd5MQkdGm
         rjUPwCjTMBQMR2Z0fJtHlk5Xnp2nK5lhCWsBrvbB91KunHNmWSCPfueU/ohe9lya06Dv
         n686P6TjGwMAn6XRaCGVSwQ5Ulf18sMQvkgXGpzGUxqDpVNcG7hspQPEdlwmf83VJ5A9
         SV6w==
X-Gm-Message-State: ABuFfoimTHzCTfUIqep3cr8BqZ5miRPJgEB8odPET/rP4b9Hq3NM2WKx
        zJ7K9CoXC4W6L+yM7HviJ9E6lw==
X-Google-Smtp-Source: ACcGV62f5GWRKT8OaC7N91FNyB2dMUhTVxo7qO1KXtmQpiW7n1IDqjZbkw22D02ZCJOAF2gOra6+AA==
X-Received: by 2002:a17:902:2909:: with SMTP id g9-v6mr40887098plb.223.1540241319754;
        Mon, 22 Oct 2018 13:48:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id y144-v6sm47483001pfb.81.2018.10.22.13.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:48:38 -0700 (PDT)
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
Subject: [PATCH 1/6] dt-bindings: drm/panel: simple: Add no-hpd property
Date:   Mon, 22 Oct 2018 13:46:34 -0700
Message-Id: <20181022204639.8558-1-dianders@chromium.org>
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
---

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

