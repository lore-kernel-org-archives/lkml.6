Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C649ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D1720671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWLQzpll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D1720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeGTVd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:33:29 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32998 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeGTVd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:33:28 -0400
Received: by mail-yw0-f195.google.com with SMTP id c135-v6so4818741ywa.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9/MsawOHQLPrgqHNmYuxB6NQ2v1q/U889Lmn9RF2P9c=;
        b=nWLQzpllj9NNn2XB9Xp+PYTWNfEXmhJf3WlWmeD5Y4RziLKFtnujKK09UrlqlUaDhj
         Agu31GUBgl87lDCBmxi99qElDQCRs3kqnMVI2sYinhc7k8z05+Jb4srceo1tV2hdfqEV
         520pyrDF86AHbxGPuti/3d0pKj+z6+fqmAFu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/MsawOHQLPrgqHNmYuxB6NQ2v1q/U889Lmn9RF2P9c=;
        b=t3eBTuLS05qMmYQoYzo0cVElwv/b/+HRHKEOLysW8l3FsI5SBV8qJFeqF9k0L2zrnf
         zIfLE6OnhdT3c9pYGBInuCnVB+hPEEmhpsCtEiDaFk4+t6lxZimoj/nfqQ/W2SWcX7yn
         vg7r530RQ35lUi0Q4P9d12tfjDKC8aaig/hV8SU0xdkU/eF/H6VVfHLEMDYeDcHLgHVk
         uSVkYYGbs0dCY61RNTzextPuSU8waN6mQhESDOAWPsaVvYaxD3K9sDrFkkkF1lgX3MGf
         /asSPTmoRjFwleyvx/LT+P/6ZbeR0j8MhPzB0J9qUyiN04+CeEYbgqb+kFUD4jL3srU0
         tjng==
X-Gm-Message-State: AOUpUlFhRy8tehdfY8T/nUf5ub/vv8Z+oc8FemywuSjQpESfD2VcI2Bv
        dVyxWraBIC/BPBxihbZZW8bpHQ==
X-Google-Smtp-Source: AAOMgpd8KPw6M1CROsI/Ql90w4o1DinRn+zASycFcEu5FdulBT9ipEUdbwxZ9aFPVGKCDTflNl72bw==
X-Received: by 2002:a0d:e742:: with SMTP id q63-v6mr1808188ywe.432.1532119411974;
        Fri, 20 Jul 2018 13:43:31 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id a2-v6sm2453831ywm.7.2018.07.20.13.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:43:31 -0700 (PDT)
From:   Sean Paul <seanpaul@chromium.org>
To:     abhinavk@codeaurora.org, architt@codeaurora.org,
        chandanu@codeaurora.org, jsanka@codeaurora.org,
        jcrouse@codeaurora.org, ryadav@codeaurora.org,
        seanpaul@chromium.org, skolluku@codeaurora.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        airlied@linux.ie, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, nganji@codeaurora.org,
        hoegsberg@chromium.org, dovizu@chromium.org, robh+dt@kernel.org
Cc:     vkorjani <vikas.korjani@intel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 02/19] drm: Add support for pps and compression mode command packet
Date:   Fri, 20 Jul 2018 16:42:53 -0400
Message-Id: <20180720204315.19054-3-seanpaul@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720204315.19054-1-seanpaul@chromium.org>
References: <20180720204315.19054-1-seanpaul@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: vkorjani <vikas.korjani@intel.com>

After enabling DSC we need to send compression mode command packet
and pps data packet, for which 2 new data types are added
07h  Compression Mode Data Type Write , short write, 2 parameters
0Ah  PPS Long Write (word count determines number of bytes)
This patch adds support to send these packets.

Cc: David Airlie <airlied@linux.ie>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

Changes in v3:
- None

Signed-off-by: vkorjani <vikas.korjani@intel.com>
[seanpaul removed pps_write_buffer fn, added types to packet_format helpers]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 ++
 include/video/mipi_display.h   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index bc73b7f5b9fc..80b75501f5c6 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -392,6 +392,7 @@ bool mipi_dsi_packet_format_is_short(u8 type)
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
 	case MIPI_DSI_DCS_READ:
+	case MIPI_DSI_DCS_COMPRESSION_MODE:
 	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
 		return true;
 	}
@@ -410,6 +411,7 @@ EXPORT_SYMBOL(mipi_dsi_packet_format_is_short);
 bool mipi_dsi_packet_format_is_long(u8 type)
 {
 	switch (type) {
+	case MIPI_DSI_PPS_LONG_WRITE:
 	case MIPI_DSI_NULL_PACKET:
 	case MIPI_DSI_BLANKING_PACKET:
 	case MIPI_DSI_GENERIC_LONG_WRITE:
diff --git a/include/video/mipi_display.h b/include/video/mipi_display.h
index 19aa65a35546..49a53ef8da96 100644
--- a/include/video/mipi_display.h
+++ b/include/video/mipi_display.h
@@ -38,6 +38,9 @@ enum {
 
 	MIPI_DSI_DCS_READ				= 0x06,
 
+	MIPI_DSI_DCS_COMPRESSION_MODE                   = 0x07,
+	MIPI_DSI_PPS_LONG_WRITE                         = 0x0A,
+
 	MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE		= 0x37,
 
 	MIPI_DSI_END_OF_TRANSMISSION			= 0x08,
-- 
Sean Paul, Software Engineer, Google / Chromium OS

