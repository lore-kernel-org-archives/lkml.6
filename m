Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A495C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCF520878
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ANFjChqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCF520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeGDPIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:08:31 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36555 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeGDPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:08:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id s14-v6so6270930wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qV8UipTxNFiWaN4KK1AqOiSrjjmt4Pf9FZwx8Hfx/N0=;
        b=ANFjChqXB9EnLKmX+rhtX/xTMY1qAClPLlYr2SAJu8eua8mMQmY8MZX/l8A6vDTgeu
         Ii+7wLZy8d8pmSxZLUUau8h3eWs239G1WcS3tkYfUu1XcwKBHbmFTvkUKJblo8aTwL8b
         tgQl9ncqfEcOEG5XRA3XEBNO8M/kpg1Z0A4T2HVZ7PcxOQeefqFzJjm3n7cIKZ2SnlZS
         dXkxJR4O/c2pOYCJbBM5gBTE6gOMGYSsFOcmFsqk9YkVpIC0qxGiCyzgMdGVDX9EGx6Y
         luu1/3nu1Y3Vx8uU/gQyzAYj8BA7R6xiUI0tRvKfx5wl07tH9vpjsYHKx/m/j01X1RO2
         KsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qV8UipTxNFiWaN4KK1AqOiSrjjmt4Pf9FZwx8Hfx/N0=;
        b=jboVXeAdIPf/uQVsIu33Ix3JAkIpGDlQaHfFpaPA25H8LlrR/82HVa91SdPRNh83m6
         XsJqt+c+fh3d643yr00XIudevkJUtvYnuFHOM+FPd1uPiYXl1VCrV5i84bnhLK7Uz1Ea
         h0CW1aUgXwDLxWRgjX1AmKUaKQ43GAwtf+OztVi/mvbAkiKsnD9GfC4aFNnlZNdOZJ2a
         T6qb3JLEQmEIvA1W+p3mhv6Yk1ngU0t13ONvCg1t5Pu55U1RgjMvP9IY8z1PsD+rwjN7
         ZfvhhxKxYU707Zq/9WPFci+uGz+Ehxor3/Ce7PPljo+MvMMhhIQYNf70+M+d2SEmuCnV
         86fw==
X-Gm-Message-State: APt69E1Nc4aKGhPerFyFwNlbBCm4SUdpZBjPnb8Z4vOpCmqZsFGxGFMe
        DCMdgmI7tzGTIxCotIGz9cGHBw==
X-Google-Smtp-Source: AAOMgpeBiW0cyGH/cKlwZgXGbhAvH+tNKbbmBdCgDOq3WdJx1B2K0YCDIbyJ2sDQzDdDg43Jo6kA7g==
X-Received: by 2002:adf:dc52:: with SMTP id m18-v6mr2004444wrj.84.1530716906765;
        Wed, 04 Jul 2018 08:08:26 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l7-v6sm9607737wmh.1.2018.07.04.08.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:08:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ville.syrjala@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v8 2/6] drm/i915: hdmi: add CEC notifier to intel_hdmi
Date:   Wed,  4 Jul 2018 17:08:17 +0200
Message-Id: <1530716901-30164-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs adds the cec_notifier feature to the intel_hdmi part
of the i915 DRM driver. It uses the HDMI DRM connector name to differentiate
between each HDMI ports.
The changes will allow the i915 HDMI code to notify EDID and HPD changes
to an eventual CEC adapter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/i915/Kconfig         |  1 +
 drivers/gpu/drm/i915/intel_display.h | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_drv.h     |  2 ++
 drivers/gpu/drm/i915/intel_hdmi.c    | 13 +++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index dfd9588..2d65d56 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -23,6 +23,7 @@ config DRM_I915
 	select SYNC_FILE
 	select IOSF_MBI
 	select CRC32
+	select CEC_CORE if CEC_NOTIFIER
 	help
 	  Choose this option if you have a system that has "Intel Graphics
 	  Media Accelerator" or "HD Graphics" integrated graphics,
diff --git a/drivers/gpu/drm/i915/intel_display.h b/drivers/gpu/drm/i915/intel_display.h
index 2ef3161..1f176a71 100644
--- a/drivers/gpu/drm/i915/intel_display.h
+++ b/drivers/gpu/drm/i915/intel_display.h
@@ -126,6 +126,30 @@ enum port {
 
 #define port_name(p) ((p) + 'A')
 
+/*
+ * Ports identifier referenced from other drivers.
+ * Expected to remain stable over time
+ */
+static inline const char *port_identifier(enum port port)
+{
+	switch (port) {
+	case PORT_A:
+		return "Port A";
+	case PORT_B:
+		return "Port B";
+	case PORT_C:
+		return "Port C";
+	case PORT_D:
+		return "Port D";
+	case PORT_E:
+		return "Port E";
+	case PORT_F:
+		return "Port F";
+	default:
+		return "<invalid>";
+	}
+}
+
 enum dpio_channel {
 	DPIO_CH0,
 	DPIO_CH1
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 0361130..cfbeee1 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -39,6 +39,7 @@
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_atomic.h>
+#include <media/cec-notifier.h>
 
 /**
  * __wait_for - magic wait macro
@@ -1017,6 +1018,7 @@ struct intel_hdmi {
 	bool has_audio;
 	bool rgb_quant_range_selectable;
 	struct intel_connector *attached_connector;
+	struct cec_notifier *cec_notifier;
 };
 
 struct intel_dp_mst_encoder;
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index ee929f3..c21b7dd 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -1868,6 +1868,8 @@ intel_hdmi_set_edid(struct drm_connector *connector)
 		connected = true;
 	}
 
+	cec_notifier_set_phys_addr_from_edid(intel_hdmi->cec_notifier, edid);
+
 	return connected;
 }
 
@@ -1876,6 +1878,7 @@ intel_hdmi_detect(struct drm_connector *connector, bool force)
 {
 	enum drm_connector_status status;
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
+	struct intel_hdmi *intel_hdmi = intel_attached_hdmi(connector);
 
 	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
 		      connector->base.id, connector->name);
@@ -1891,6 +1894,9 @@ intel_hdmi_detect(struct drm_connector *connector, bool force)
 
 	intel_display_power_put(dev_priv, POWER_DOMAIN_GMBUS);
 
+	if (status != connector_status_connected)
+		cec_notifier_phys_addr_invalidate(intel_hdmi->cec_notifier);
+
 	return status;
 }
 
@@ -2031,6 +2037,8 @@ static void chv_hdmi_pre_enable(struct intel_encoder *encoder,
 
 static void intel_hdmi_destroy(struct drm_connector *connector)
 {
+	if (intel_attached_hdmi(connector)->cec_notifier)
+		cec_notifier_put(intel_attached_hdmi(connector)->cec_notifier);
 	kfree(to_intel_connector(connector)->detect_edid);
 	drm_connector_cleanup(connector);
 	kfree(connector);
@@ -2350,6 +2358,11 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
 		u32 temp = I915_READ(PEG_BAND_GAP_DATA);
 		I915_WRITE(PEG_BAND_GAP_DATA, (temp & ~0xf) | 0xd);
 	}
+
+	intel_hdmi->cec_notifier = cec_notifier_get_conn(dev->dev,
+							 port_identifier(port));
+	if (!intel_hdmi->cec_notifier)
+		DRM_DEBUG_KMS("CEC notifier get failed\n");
 }
 
 void intel_hdmi_init(struct drm_i915_private *dev_priv,
-- 
2.7.4

