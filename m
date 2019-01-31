Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4EAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85C1218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EyD/2NgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbfAaJbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:31:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45114 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfAaJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:31:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so1209031plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwV5NceIy8SJWO3Dn5rgCTKNVRtgdNg201S3RdP6Xfs=;
        b=EyD/2NgIXL7x73pg8ki6VPw4vEUFhE6XVUvYefF3PQPqJME7sUlp2njdPxo71N/OHe
         jWXcD22DZyUuHxaYMpPg3qZzPDrh3PesE2SxdIK93OHtWWdONgKnBMKClBKMAvfdfnZO
         wXq7m1o6FXoGsjeCfnMzxMdKdf9GKMYGE6bpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwV5NceIy8SJWO3Dn5rgCTKNVRtgdNg201S3RdP6Xfs=;
        b=mEFU2erYK13CZpv2Wy9AOOdmTdsgmLgsQwhiACFeLt0eI3toDnPrVTS5suJr38kKXh
         vmf3J8ED9puo7QsrNg4hD65877+m2THJxRmpjk7DlAB9QbDDqIaRPTwlVMilM6tJ9BC0
         RbXI43FG0aGxlDTDxojHdcTLEW5ldlPwYdHfz+Cxh7UArvbH0/IwJ/VUN+HATq/F/c8y
         IApB0LImpfsmuubdLSU90HxG+G01cgTocbEz5mHWczY2XLJkVP77ZhCEYxy7yVGQCJ9f
         b1A3VQCUZ0TWz6A88qq1mnepCWpAzArbaQp704EMqBG4KZD1gRXzfwbeTrXwKCE9mxwI
         ZIJg==
X-Gm-Message-State: AJcUukfxUVDMKbbG8XIqu4uc7F3lLbucT3sA8FBVmJXXQ+0FNo7xcWrS
        jT1OiypdaJlZW0BpEO0g32CuHA==
X-Google-Smtp-Source: ALg8bN7bnuOCF1AxOQGwk6uupYKVfweajlM1oD/fg3GZG2MGvCwoK9Gl2zQZOTAHduE5E5kpVijwJw==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr34986569plf.28.1548927100583;
        Thu, 31 Jan 2019 01:31:40 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:31:39 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v4 1/6] dt-bindings: Add a binding for Mediatek SCP
Date:   Thu, 31 Jan 2019 17:31:26 +0800
Message-Id: <20190131093131.245531-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190131093131.245531-1-pihsun@chromium.org>
References: <20190131093131.245531-1-pihsun@chromium.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
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
2.20.1.611.gfbb209baf1-goog

