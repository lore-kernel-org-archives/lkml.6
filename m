Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A129C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FFA20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FFA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeI0P3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:29:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeI0P3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:35 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 551B31116;
        Thu, 27 Sep 2018 09:12:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diego Viola <diego.viola@gmail.com>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.18 61/88] drm/i915/bdw: Increase IPS disable timeout to 100ms
Date:   Thu, 27 Sep 2018 11:03:42 +0200
Message-Id: <20180927090308.146168233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180905100005.7663-1-imre.deak@intel.com
(cherry picked from commit acb3ef0ee40ea657280a4a11d9f60eb2937c0dca)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -5062,10 +5062,14 @@ void hsw_disable_ips(const struct intel_
 		mutex_lock(&dev_priv->pcu_lock);
 		WARN_ON(sandybridge_pcode_write(dev_priv, DISPLAY_IPS_CONTROL, 0));
 		mutex_unlock(&dev_priv->pcu_lock);
-		/* wait for pcode to finish disabling IPS, which may take up to 42ms */
+		/*
+		 * Wait for PCODE to finish disabling IPS. The BSpec specified
+		 * 42ms timeout value leads to occasional timeouts so use 100ms
+		 * instead.
+		 */
 		if (intel_wait_for_register(dev_priv,
 					    IPS_CTL, IPS_ENABLE, 0,
-					    42))
+					    100))
 			DRM_ERROR("Timed out waiting for IPS disable\n");
 	} else {
 		I915_WRITE(IPS_CTL, 0);


