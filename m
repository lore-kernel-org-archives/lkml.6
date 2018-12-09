Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE43CC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE502081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE502081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeLIWWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35164 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726507AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0002ij-7U; Sun, 09 Dec 2018 21:55:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003Yi-HS; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Imre Deak" <imre.deak@intel.com>,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <ville.syrjala@linux.intel.com>,
        "Diego Viola" <diego.viola@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.684681102@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 229/328] drm/i915/bdw: Increase IPS disable timeout
 to 100ms
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 92a6803149465e2339f8f7f8f6415d75be80073d upstream.

During IPS disabling the current 42ms timeout value leads to occasional
timeouts, increase it to 100ms which seems to get rid of the problem.

References: https://bugs.freedesktop.org/show_bug.cgi?id=107494
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107562
Reported-by: Diego Viola <diego.viola@gmail.com>
Tested-by: Diego Viola <diego.viola@gmail.com>
Cc: Diego Viola <diego.viola@gmail.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180905100005.7663-1-imre.deak@intel.com
(cherry picked from commit acb3ef0ee40ea657280a4a11d9f60eb2937c0dca)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_display.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -3794,8 +3794,12 @@ void hsw_disable_ips(struct intel_crtc *
 		mutex_lock(&dev_priv->rps.hw_lock);
 		WARN_ON(sandybridge_pcode_write(dev_priv, DISPLAY_IPS_CONTROL, 0));
 		mutex_unlock(&dev_priv->rps.hw_lock);
-		/* wait for pcode to finish disabling IPS, which may take up to 42ms */
-		if (wait_for((I915_READ(IPS_CTL) & IPS_ENABLE) == 0, 42))
+		/*
+		 * Wait for PCODE to finish disabling IPS. The BSpec specified
+		 * 42ms timeout value leads to occasional timeouts so use 100ms
+		 * instead.
+		 */
+		if (wait_for((I915_READ(IPS_CTL) & IPS_ENABLE) == 0, 100))
 			DRM_ERROR("Timed out waiting for IPS disable\n");
 	} else {
 		I915_WRITE(IPS_CTL, 0);

