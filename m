Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C1C214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oa/WRdXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfBUIsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:48:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42470 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfBUIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:48:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so7714622pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5iBvG4HqidiXxiGis5rvY71e0EFMSebp/Zntf2KFIo=;
        b=Oa/WRdXX+4W1q0fB/rVIGahugIrASieUZcaKxUUf1E/5TbKb9lwC4zhBD5NDipC8SK
         8HW8jRhnxT1cc0AeeKkw1KqJ8EL0NBva/AIJSK7fxVbCbNszg0SOwO87B/bviWxGCjLJ
         PIzTnoYtieukZcNJ3kWdbXX9PdzM5zGHUdmzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5iBvG4HqidiXxiGis5rvY71e0EFMSebp/Zntf2KFIo=;
        b=O4WxZyjzZpM7vAgLw12xCthYT8jhEmV1J2hWA3vVIm096B5DfjQJcDN9uUWLkUdspM
         Gp3xIKHFrlauZ6l06L7eM39Kl+Ss5BZQG+wA5gRTWpLqmGe+49lEMcjBPre9FMS1x3KB
         dAAbIDtltRiRVDOHFEXfitvZuL/jaVGlaLe7du0rDLvr/ZsZpkvTbqHn9LdueerkZRuH
         HNvBc1meD3RsluniNGnKGSovVCfeQ7Qc3bDnGALMEW2ZOm7utmGh2srb69jTsEOVPU7O
         8MWsEnWQkYvHgLksLGQ/tTo9vJOEf8fDbYAjfhHQm/u6+y0GWYjjJFzaPMFKFKPEdU4l
         tcAA==
X-Gm-Message-State: AHQUAubWtWywkGKK1efBPMrcwjiQf5dXqCkPbJDzBJPZKNL49ILtd/kw
        I/XpqpupKQBVfoN7c/TDfuUwzQ==
X-Google-Smtp-Source: AHgI3Ia0m4hNRUVYGFbaW9a96CjS9AFRocoWSC9WAqTfUc7xQXwvjOlNc9NUoEvU2OUAMpF7uflabw==
X-Received: by 2002:a63:d104:: with SMTP id k4mr32626620pgg.227.1550738915080;
        Thu, 21 Feb 2019 00:48:35 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id b4sm23154027pgq.57.2019.02.21.00.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 00:48:34 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
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
Subject: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
Date:   Thu, 21 Feb 2019 16:47:24 +0800
Message-Id: <20190221084729.101784-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221084729.101784-1-pihsun@chromium.org>
References: <20190221084729.101784-1-pihsun@chromium.org>
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
Changes from v4:
 - Add detail of more properties.
 - Document the usage of mtk,rpmsg-name in subnode from the new design.

Changes from v3:
 - No change.

Changes from v2:
 - No change. I realized that for this patch series, there's no need to
   add anything under the mt8183-scp node (neither the mt8183-rpmsg or
   the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
   directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
   created by SCP name service.

Changes from v1:
 - No change.
---
 .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 00000000000000..8cf8b0e0d98a4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,37 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- reg			Should contain the address ranges for the two memory
+			regions, SRAM and CFG.
+- reg-names		Contains the corresponding names for the two memory
+			regions. These should be named "sram" & "cfg".
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- clock-names		Contains the corresponding name for the clock. This
+			should be named "main".
+
+Subnodes
+--------
+
+When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg
+devices. The names of the devices are not important. The properties of these
+nodes are defined by the individual bindings for the rpmsg devices - but must
+contain the following property:
+
+- mtk,rpmsg-name	Contains the name for the rpmsg device. Used to match
+			the subnode to rpmsg device announced by SCP.
+
+Example:
+
+	scp: scp@10500000 {
+		compatible = "mediatek,mt8183-scp";
+		reg = <0 0x10500000 0 0x80000>,
+		      <0 0x105c0000 0 0x5000>;
+		reg-names = "sram", "cfg";
+		clocks = <&infracfg CLK_INFRA_SCPSYS>;
+		clock-names = "main";
+	};
-- 
2.21.0.rc0.258.g878e2cd30e-goog

