Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E78C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5805A2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5805A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeH1VDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:03:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeH1VDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:03:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67D9C40241CB;
        Tue, 28 Aug 2018 17:10:58 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0891C1010435;
        Tue, 28 Aug 2018 17:10:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/i915: Remove i915_drm_dp_mst_status
Date:   Tue, 28 Aug 2018 13:10:30 -0400
Message-Id: <20180828171036.25943-5-lyude@redhat.com>
In-Reply-To: <20180828171036.25943-1-lyude@redhat.com>
References: <20180828171036.25943-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 28 Aug 2018 17:10:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 28 Aug 2018 17:10:58 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that DRM can create these debugfs nodes automatically; this isn't
needed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Stone <daniel@fooishbar.org>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 32 -----------------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index f9ce35da4123..5014828ca022 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -3534,37 +3534,6 @@ static int i915_drrs_status(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int i915_dp_mst_info(struct seq_file *m, void *unused)
-{
-	struct drm_i915_private *dev_priv = node_to_i915(m->private);
-	struct drm_device *dev = &dev_priv->drm;
-	struct intel_encoder *intel_encoder;
-	struct intel_digital_port *intel_dig_port;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
-
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
-			continue;
-
-		intel_encoder = intel_attached_encoder(connector);
-		if (!intel_encoder || intel_encoder->type == INTEL_OUTPUT_DP_MST)
-			continue;
-
-		intel_dig_port = enc_to_dig_port(&intel_encoder->base);
-		if (!intel_dig_port->dp.can_mst)
-			continue;
-
-		seq_printf(m, "MST Source Port %c\n",
-			   port_name(intel_dig_port->base.port));
-		drm_dp_mst_dump_topology(m, &intel_dig_port->dp.mst_mgr);
-	}
-	drm_connector_list_iter_end(&conn_iter);
-
-	return 0;
-}
-
 static ssize_t i915_displayport_test_active_write(struct file *file,
 						  const char __user *ubuf,
 						  size_t len, loff_t *offp)
@@ -4733,7 +4702,6 @@ static const struct drm_info_list i915_debugfs_list[] = {
 	{"i915_rcs_topology", i915_rcs_topology, 0},
 	{"i915_shrinker_info", i915_shrinker_info, 0},
 	{"i915_shared_dplls_info", i915_shared_dplls_info, 0},
-	{"i915_dp_mst_info", i915_dp_mst_info, 0},
 	{"i915_wa_registers", i915_wa_registers, 0},
 	{"i915_ddb_info", i915_ddb_info, 0},
 	{"i915_sseu_status", i915_sseu_status, 0},
-- 
2.17.1

