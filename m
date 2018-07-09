Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38664C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E144420864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gw3upmrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E144420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933883AbeGIRct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:32:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35313 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933617AbeGIRcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:32:47 -0400
Received: by mail-yb0-f193.google.com with SMTP id x15-v6so7503299ybm.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q3/Dfl26JmFTMhRSLOf8HmACWIUALpACFyoE5/iMMSs=;
        b=gw3upmrzXxvv8fOBmKHyxk38P/fcWfVNoCMsbayUHWGHd9ZK/YxCU6tdEMizPWB/BV
         2C/CbMiSR9Me5NX9GX1BhqkaE9uQbS63U2++0MNG5quTzZTfCXqK3k8OQvZWJpbtWVXO
         N0lNbStByMnLQK053D6wqGdPQieriuJxe8vaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q3/Dfl26JmFTMhRSLOf8HmACWIUALpACFyoE5/iMMSs=;
        b=Q9pyVaFebyzY6DwBxuyNgSriRoZWxKl9eZFuRNTdaRVfU1pezX53+t1C70lkKGGtn/
         Muub0rU0FMBcSn+bluealkYLj7m1gUhQSt3Xhar3dqIfcFkKADEOMZTZpkSILeHfwnXN
         TwJNt07f09lztfh0qqvE2JVZtl2XEd3lUmtcqrDNEVYwiLJxGH7IIA23ikhatWUeeWJ9
         wyWhGrvtOZj5GHc2OpbYSirVCO0/6FsRAfac+w8K6AC3kN8iOLATvCI/EFqtVxBpn5hH
         DneFDBH1VvhXBiWERES8CDPRGWPoyhFJX6iYDkQSMQx3jyzS6F+Gp9/JhNOOu4+rwokf
         Dm1A==
X-Gm-Message-State: APt69E3hjKzB76OXLW1lA7OZiiePnGUbzx+GKqK8VGPXuACIpje5dl0j
        p7s/YcGwTZPFE/o8ouJq0gSOBg==
X-Google-Smtp-Source: AAOMgpciWIP+cABmyIFcVNbcnTDtgRpV4uO+AXlIBzj0hkg/WctYrhLgVFwv1gnOfc12RZSg+h75uw==
X-Received: by 2002:a25:a08a:: with SMTP id y10-v6mr11075599ybh.219.1531157566525;
        Mon, 09 Jul 2018 10:32:46 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id s206-v6sm5885495ywc.55.2018.07.09.10.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:32:45 -0700 (PDT)
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
Subject: [PATCH 03/21] drm: Add support for pps and compression mode command packet
Date:   Mon,  9 Jul 2018 13:31:39 -0400
Message-Id: <20180709173200.238457-4-seanpaul@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180709173200.238457-1-seanpaul@chromium.org>
References: <20180709173200.238457-1-seanpaul@chromium.org>
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

