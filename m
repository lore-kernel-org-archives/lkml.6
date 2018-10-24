Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744BCC7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B8C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B8C20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJXLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:15:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:41763 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeJXLPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:15:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 19:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="102098596"
Received: from jhli-desk1.jf.intel.com ([10.7.198.167])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2018 19:22:30 -0700
From:   Juston Li <juston.li@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     lyude@redhat.com, clinton.a.taylor@intel.com,
        nathan.d.ciobanu@intel.com, mario.limonciello@dell.com,
        jared_dominguez@dell.com, linux-kernel@vger.kernel.org,
        Lyude <cpaul@redhat.com>, stable@vger.kernel.org,
        Juston Li <juston.li@intel.com>
Subject: [RESEND PATCH v2 2/2] drm/i915/mst: Reset MST after resume when necessary
Date:   Tue, 23 Oct 2018 19:19:25 -0700
Message-Id: <20181024021925.27026-3-juston.li@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181024021925.27026-1-juston.li@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude <cpaul@redhat.com>

A follow-up to the previous commit, we skip checking the status of the
MST device and completely reprobe it if drm_dp_mst_topology_mgr_resume()
returns -EINVAL.

Cc: stable@vger.kernel.org
Signed-off-by: Lyude <cpaul@redhat.com>
Signed-off-by: Juston Li <juston.li@intel.com>
---
 drivers/gpu/drm/i915/intel_dp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
index 8c38efef77a1..cb5ffec73094 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -6793,7 +6793,12 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
 			continue;
 
 		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr);
-		if (ret)
+		/* A full reset is required */
+		if (ret == -EINVAL) {
+			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr, false);
+			intel_dp_configure_mst(intel_dp);
+		} else if (ret != 0) {
 			intel_dp_check_mst_status(intel_dp);
+		}
 	}
 }
-- 
2.17.2

