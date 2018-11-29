Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17573C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE91721479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqfUSyDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE91721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbeK3Bh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389450AbeK3Bh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47645214C1;
        Thu, 29 Nov 2018 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501944;
        bh=hsL57PSzPb0icCVt8Nhtl1CfIqJ3TuJphvjussWfR1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqfUSyDfXijCfJ3opO2P5tFP6Jwz+xMjOVWCszZvQemuPJyHbmgdgGO5F/j2w83Di
         88GhNIX0XA+ihhcWf0IXgz4ScOdu6chm8tEywtz/KQT1ILC3ScwtEpyizlqEXkwPJ6
         m+uMp3Vclj8dF9UtG7NIArFM39n54dPablAObR/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Bobrowicz <sam@elite-embedded.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 106/110] media: ov5640: Fix timings setup code
Date:   Thu, 29 Nov 2018 15:13:17 +0100
Message-Id: <20181129135925.551220583@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacopo Mondi <jacopo@jmondi.org>

commit bad1774ed41e98a43074e50e7d5ac9e1e848d99a upstream.

As of: commit 476dec012f4c ("media: ov5640: Add horizontal and vertical
totals") the timings parameters gets programmed separately from the
static register values array.

When changing capture mode, the vertical and horizontal totals gets
inspected by the set_mode_exposure_calc() functions, and only later
programmed with the new values. This means exposure, light banding
filter and shutter gain are calculated using the previous timings, and
are thus not correct.

Fix this by programming timings right after the static register value
table has been sent to the sensor in the ov5640_load_regs() function.

Fixes: 476dec012f4c ("media: ov5640: Add horizontal and vertical totals")

Tested-by: Steve Longerbeam <slongerbeam@gmail.com> # i.MX6q SabreSD, CSI-2
Tested-by: Loic Poulain <loic.poulain@linaro.org> # Dragonboard-410c, CSI-2
Signed-off-by: Samuel Bobrowicz <sam@elite-embedded.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |   50 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -910,6 +910,26 @@ static int ov5640_mod_reg(struct ov5640_
 }
 
 /* download ov5640 settings to sensor through i2c */
+static int ov5640_set_timings(struct ov5640_dev *sensor,
+			      const struct ov5640_mode_info *mode)
+{
+	int ret;
+
+	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_DVPHO, mode->hact);
+	if (ret < 0)
+		return ret;
+
+	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_DVPVO, mode->vact);
+	if (ret < 0)
+		return ret;
+
+	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_HTS, mode->htot);
+	if (ret < 0)
+		return ret;
+
+	return ov5640_write_reg16(sensor, OV5640_REG_TIMING_VTS, mode->vtot);
+}
+
 static int ov5640_load_regs(struct ov5640_dev *sensor,
 			    const struct ov5640_mode_info *mode)
 {
@@ -937,7 +957,7 @@ static int ov5640_load_regs(struct ov564
 			usleep_range(1000 * delay_ms, 1000 * delay_ms + 100);
 	}
 
-	return ret;
+	return ov5640_set_timings(sensor, mode);
 }
 
 /* read exposure, in number of line periods */
@@ -1400,30 +1420,6 @@ static int ov5640_set_virtual_channel(st
 	return ov5640_write_reg(sensor, OV5640_REG_DEBUG_MODE, temp);
 }
 
-static int ov5640_set_timings(struct ov5640_dev *sensor,
-			      const struct ov5640_mode_info *mode)
-{
-	int ret;
-
-	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_DVPHO, mode->hact);
-	if (ret < 0)
-		return ret;
-
-	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_DVPVO, mode->vact);
-	if (ret < 0)
-		return ret;
-
-	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_HTS, mode->htot);
-	if (ret < 0)
-		return ret;
-
-	ret = ov5640_write_reg16(sensor, OV5640_REG_TIMING_VTS, mode->vtot);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static const struct ov5640_mode_info *
 ov5640_find_mode(struct ov5640_dev *sensor, enum ov5640_frame_rate fr,
 		 int width, int height, bool nearest)
@@ -1667,10 +1663,6 @@ static int ov5640_set_mode(struct ov5640
 	if (ret < 0)
 		return ret;
 
-	ret = ov5640_set_timings(sensor, mode);
-	if (ret < 0)
-		return ret;
-
 	ret = ov5640_set_binning(sensor, dn_mode != SCALING);
 	if (ret < 0)
 		return ret;


