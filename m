Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4076C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4F2206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OheGPe9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4F2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391075AbeKTDT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390092AbeKTDTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:19:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0F3206BA;
        Mon, 19 Nov 2018 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646539;
        bh=L1E909WxIcXSayRZ3T0aRVFfU4KWfpdsJkXvjeD47nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OheGPe9TXj4aYUGYG5SS1TM+2nL81sg4kgYCnEligHbNooU8XAIkfVU0ZPuM+9uYH
         pE8yKiFggMlwYe0tqZMQEz4kah3XH6dHDuCWC0VIK2d+03j028MQnd4uKyNNDSVr2J
         tZoFMookkwGROkbzvkobA0DSOL69Jm5LVsXLBLFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Clint Taylor <clinton.a.taylor@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.9 80/83] drm/i915/hdmi: Add HDMI 2.0 audio clock recovery N values
Date:   Mon, 19 Nov 2018 17:29:46 +0100
Message-Id: <20181119162627.307131772@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clint Taylor <clinton.a.taylor@intel.com>

commit 6503493145cba4413ecd3d4d153faeef4a1e9b85 upstream.

HDMI 2.0 594Mhz modes were incorrectly selecting 25.200Mhz Automatic N value
mode instead of HDMI specification values.

V2: Fix 88.2 Hz N value

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Clint Taylor <clinton.a.taylor@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1540493521-1746-2-git-send-email-clinton.a.taylor@intel.com
(cherry picked from commit 5a400aa3c562c4a726b4da286e63c96db905ade1)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_audio.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -76,6 +76,9 @@ static const struct {
 /* HDMI N/CTS table */
 #define TMDS_297M 297000
 #define TMDS_296M 296703
+#define TMDS_594M 594000
+#define TMDS_593M 593407
+
 static const struct {
 	int sample_rate;
 	int clock;
@@ -96,6 +99,20 @@ static const struct {
 	{ 176400, TMDS_297M, 18816, 247500 },
 	{ 192000, TMDS_296M, 23296, 281250 },
 	{ 192000, TMDS_297M, 20480, 247500 },
+	{ 44100, TMDS_593M, 8918, 937500 },
+	{ 44100, TMDS_594M, 9408, 990000 },
+	{ 48000, TMDS_593M, 5824, 562500 },
+	{ 48000, TMDS_594M, 6144, 594000 },
+	{ 32000, TMDS_593M, 5824, 843750 },
+	{ 32000, TMDS_594M, 3072, 445500 },
+	{ 88200, TMDS_593M, 17836, 937500 },
+	{ 88200, TMDS_594M, 18816, 990000 },
+	{ 96000, TMDS_593M, 11648, 562500 },
+	{ 96000, TMDS_594M, 12288, 594000 },
+	{ 176400, TMDS_593M, 35672, 937500 },
+	{ 176400, TMDS_594M, 37632, 990000 },
+	{ 192000, TMDS_593M, 23296, 562500 },
+	{ 192000, TMDS_594M, 24576, 594000 },
 };
 
 /* get AUD_CONFIG_PIXEL_CLOCK_HDMI_* value for mode */


