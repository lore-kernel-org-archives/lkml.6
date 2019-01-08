Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D93C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4DA20675
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfAHVMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfAHVL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:11:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E8F736809;
        Tue,  8 Jan 2019 21:11:56 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 067F71992A;
        Tue,  8 Jan 2019 21:11:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Jerry Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()
Date:   Tue,  8 Jan 2019 16:11:29 -0500
Message-Id: <20190108211133.32564-4-lyude@redhat.com>
In-Reply-To: <20190108211133.32564-1-lyude@redhat.com>
References: <20190108211133.32564-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 08 Jan 2019 21:11:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've had to fix two cases of drivers not checking the return code
from this function, let's make the compiler complain so this doesn't
come up again in the future.

Changes since v1:
* Remove unneeded __must_check in function declaration - danvet

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 include/drm/drm_dp_mst_helper.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 371cc2816477..4355b55d0081 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -614,7 +614,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 			      struct drm_dp_mst_topology_mgr *mgr);
 
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
-int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
+int __must_check
+drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
 struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
 								    struct drm_dp_mst_topology_mgr *mgr);
 int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
-- 
2.20.1

