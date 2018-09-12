Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF9C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AFF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeILThA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:37:00 -0400
Received: from gateway30.websitewelcome.com ([192.185.152.11]:16031 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727670AbeILThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:37:00 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 839534341
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:32:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 06BRgqw7MBcCX06BagHP7T; Wed, 12 Sep 2018 09:32:13 -0500
X-Authority-Reason: nr=8
Received: from [189.250.106.191] (port=46028 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g06BQ-002trA-Mf; Wed, 12 Sep 2018 09:31:57 -0500
Date:   Wed, 12 Sep 2018 09:31:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/dp: fix shifting by a negative number of bits
Message-ID: <20180912143153.GA27564@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.191
X-Source-L: No
X-Exim-ID: 1g06BQ-002trA-Mf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.191]:46028
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function intel_port_to_tc() returns PORT_TC_NONE on error, which is
a negative value -1. In case PORT_TC_NONE is returned, there is an
undefined behavior when shifting by a negative number of bits in
both DP_PHY_MODE_STATUS_NOT_SAFE and P_PHY_MODE_STATUS_COMPLETED
macros.

Fix this by adding sanity checks on intel_port_to_tc return value, before
using macros DP_PHY_MODE_STATUS_NOT_SAFE and P_PHY_MODE_STATUS_COMPLETED.

Addresses-Coverity-ID: 1473324 ("Bad bit shift operation")
Addresses-Coverity-ID: 1473325 ("Bad bit shift operation")
Fixes: 39d1e234e1e1 ("drm/i915/icl: implement the tc/legacy HPD {dis,}connect flows")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/intel_dp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index 436c22d..e34b7b1 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -4811,6 +4811,11 @@ static bool icl_tc_phy_connect(struct drm_i915_private *dev_priv,
 	    dig_port->tc_type != TC_PORT_TYPEC)
 		return true;
 
+	if (tc_port < 0) {
+		DRM_DEBUG_KMS("Bad TC port %d\n", tc_port);
+		return false;
+	}
+
 	val = I915_READ(PORT_TX_DFLEXDPPMS);
 	if (!(val & DP_PHY_MODE_STATUS_COMPLETED(tc_port))) {
 		DRM_DEBUG_KMS("DP PHY for TC port %d not ready\n", tc_port);
@@ -4857,6 +4862,10 @@ static void icl_tc_phy_disconnect(struct drm_i915_private *dev_priv,
 	    dig_port->tc_type != TC_PORT_TYPEC)
 		return;
 
+	if (tc_port < 0) {
+		DRM_DEBUG_KMS("Bad TC port %d\n", tc_port);
+		return;
+	}
 	/*
 	 * This function may be called many times in a row without an HPD event
 	 * in between, so try to avoid the write when we can.
-- 
2.7.4

