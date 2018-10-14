Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88FAC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD2A20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD2A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJNXr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:47:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35585 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbeJNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cC-D4; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00008R-3C; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "=?UTF-8?q?Stefan=20Br=C3=BCns?=" <stefan.bruens@rwth-aachen.de>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.913721882@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/366] drm/i915: Try EDID bitbanging on HDMI after
 failed read
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Brüns <stefan.bruens@rwth-aachen.de>

commit cfb926e148e99acc02351d72e8b85e32b5f786ef upstream.

The ACK/NACK implementation as found in e.g. the G965 has the falling
clock edge and the release of the data line after the ACK for the received
byte happen at the same time.

This is conformant with the I2C specification, which allows a zero hold
time, see footnote [3]: "A device must internally provide a hold time of
at least 300 ns for the SDA signal (with respect to the V IH(min) of the
SCL signal) to bridge the undefined region of the falling edge of SCL."

Some HDMI-to-VGA converters apparently fail to adhere to this requirement
and latch SDA at the falling clock edge, so instead of an ACK
sometimes a NACK is read and the slave (i.e. the EDID ROM) ends the
transfer.

The bitbanging releases the data line for the ACK only 1/4 bit time after
the falling clock edge, so a slave will see the correct value no matter
if it samples at the rising or the falling clock edge or in the center.

Fallback to bitbanging is already done for the CRT connector.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92685
Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/a39f080b-81a5-4c93-b3f7-7cb0a58daca3@rwthex-w2-a.rwth-ad.de
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_hdmi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -971,6 +971,7 @@ intel_hdmi_detect(struct drm_connector *
 	struct edid *edid;
 	enum intel_display_power_domain power_domain;
 	enum drm_connector_status status = connector_status_disconnected;
+	struct i2c_adapter *i2c;
 
 	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
 		      connector->base.id, connector->name);
@@ -981,9 +982,16 @@ intel_hdmi_detect(struct drm_connector *
 	intel_hdmi->has_hdmi_sink = false;
 	intel_hdmi->has_audio = false;
 	intel_hdmi->rgb_quant_range_selectable = false;
-	edid = drm_get_edid(connector,
-			    intel_gmbus_get_adapter(dev_priv,
-						    intel_hdmi->ddc_bus));
+	i2c = intel_gmbus_get_adapter(dev_priv, intel_hdmi->ddc_bus);
+
+	edid = drm_get_edid(connector, i2c);
+
+	if (!edid && !intel_gmbus_is_forced_bit(i2c)) {
+		DRM_DEBUG_KMS("HDMI GMBUS EDID read failed, retry using GPIO bit-banging\n");
+		intel_gmbus_force_bit(i2c, true);
+		edid = drm_get_edid(connector, i2c);
+		intel_gmbus_force_bit(i2c, false);
+	}
 
 	if (edid) {
 		if (edid->input & DRM_EDID_INPUT_DIGITAL) {

