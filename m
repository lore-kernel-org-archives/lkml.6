Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA95C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A092089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XZKoIwSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfAHF0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:26:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37575 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfAHF0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:26:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so1200250pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNzw5Mk6p5U5OxaVpQeJN5aDRHrWFdN2erFBwQa0hHs=;
        b=XZKoIwSKfezjosQOu+ngF1GT0QEchy9/7Z+4W2HAe1x2qK98Jfe/dncW1ZnpSbvzJl
         rwrVrYWFm+F7PJ170/SljVsKzTtwOoBFtEHIqqjNq4WHKLyrup1DK1v+MjNA7Ri/thmP
         piRZ+o8FIEOlk0U5jnPV7lKIqGnh3FMc0zZB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNzw5Mk6p5U5OxaVpQeJN5aDRHrWFdN2erFBwQa0hHs=;
        b=XC4dqxe/MhGOOQt/f77qpmAZBkKNA9hFnhgFOg47PTyuKJWaKG+o/3SxeCNsvsyCGO
         D4ugouT1Binyqj9YEOCukAeGXCDaAyTKIMDf/zWFOEEZNXJNtVPxCHLAnv5HA73gv5dB
         u1LEOd5Xiq+J7OkTWfI2xvatAabpsmcNefE5ey/xzZsrURFs+9q+ai5XCWLAZ2xVVwi9
         E3pn3RARU2kTtwjFrWyX5fqTtYaFb2vFWzmTV7Zx+aZ9Wgg42Z/DVhpHwkrWZ7KD+H5E
         x4WBqmaHsIBngRbZjiGVpynqJAidMovcZkhUB2raed5iY6efNFJue9BMz0MGdDwAD0vT
         9IZw==
X-Gm-Message-State: AJcUukeoLvVJ/MmpDD0dQ1Uxp1Rp14+vJdsuIW4zG4fnTjjQN6adNCWn
        kzaKnRKfejrkk0vW3wsdbGW+Xw==
X-Google-Smtp-Source: ALg8bN6y+HgAeIq1CoUzGQS+QOmaCrHLWl3foL3n/aRE2RH9j1FMirVc1Z1h+eZtOpJ6XvgtOxkFLQ==
X-Received: by 2002:a63:d252:: with SMTP id t18mr324509pgi.133.1546925176324;
        Mon, 07 Jan 2019 21:26:16 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:26:15 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 1/6] dt-bindings: Add a binding for Mediatek SCP
Date:   Tue,  8 Jan 2019 13:26:01 +0800
Message-Id: <20190108052606.59426-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108052606.59426-1-pihsun@chromium.org>
References: <20190108052606.59426-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erin Lo <erin.lo@mediatek.com>

Add a DT binding documentation of SCP for the
MT8183 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
Changes from v1:
 - no change
---
 .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 00000000000000..b07e5c4ca9af1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,10 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+
-- 
2.20.1.97.g81188d93c3-goog

