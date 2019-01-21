Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF10C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09ED20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHGposEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfAUHSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:18:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfAUHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:18:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so9060853pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2k9l07RpBYtlakWHYn6mfcQ2BX0Oyp6D4xN2whb1JAM=;
        b=YHGposEiTssTcSqGZtgYx2dVgnPBd0Hr2L0ZNoezTNxOFX9gYK0GT0rIektdBsqfSh
         pAYERBOy19LCrDiO6D2D27WKl7PmD4ApYqXmcgsixiKHIW+ukuq3WKUuFt2cTbYpNKHG
         3PXRcCB00xNMVcW+f/vMoStwKtEWceweud/Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2k9l07RpBYtlakWHYn6mfcQ2BX0Oyp6D4xN2whb1JAM=;
        b=tWKJmLt8bnnnjR/bWov92DyiOhN/VznSaGj3aIejRTdk6ukrTxhTmRwThuSnbr6JHw
         RInUQqz3aLVPt4EicfdgNRjA7H8BkLIkbhFfw6c8Je/KZRL33UUKv7+9H5O0UHIkRWTt
         5kZrail7QcOGGcS8nuVXtgGfc1FtJfLxwUcLZWUbeGgyAe0BvEMRrjuiljDafSnZoRlQ
         XwVF6SKgY1OSEHiQYZ93FnnQ0b1kLfUraPZccLzctluIzDUQNzXG9+8h/sOTfC+R73Xy
         lDhJYwwP6wSk5SQIUnGuni8B4j5iTCIkhPibNGOUJtDnYKRT7WL/9o+TpURAR/D0n8pR
         Eyfg==
X-Gm-Message-State: AJcUukdxFso0Kn3qmIMzh4f1dfGG98ZqAbHzgTPu2m1sET1ALdN5r5vm
        Tjga5VpGu2liDOAvbwZ9HfHvrQ==
X-Google-Smtp-Source: ALg8bN7ctnSw77rAAv6wB9bo8P+orwZEGpWC6exG6HSvmM+5Hnnvhww0NAiky5glTrOkAaYkL/KMNQ==
X-Received: by 2002:a63:4665:: with SMTP id v37mr27520144pgk.425.1548055123617;
        Sun, 20 Jan 2019 23:18:43 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id v15sm14941843pfn.94.2019.01.20.23.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 23:18:43 -0800 (PST)
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
Subject: [RFC v3 1/5] dt-bindings: Add a binding for Mediatek SCP
Date:   Mon, 21 Jan 2019 15:18:29 +0800
Message-Id: <20190121071833.43443-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190121071833.43443-1-pihsun@chromium.org>
References: <20190121071833.43443-1-pihsun@chromium.org>
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
Changes from v2:
 - No change. I realized that for this patch series, there's no need to
   add anything under the mt8183-scp node (neither the mt8183-rpmsg or
   the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
   directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
   created by SCP name service.

Changes from v1:
 - No change.
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
2.20.1.321.g9e740568ce-goog

