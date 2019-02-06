Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6ADC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E52175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfBFSbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:31:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfBFSbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:31:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBAE080F99;
        Wed,  6 Feb 2019 18:31:10 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78E9757AE;
        Wed,  6 Feb 2019 18:31:05 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Remove rebase-detritus in VCPI helper kernel-docs
Date:   Wed,  6 Feb 2019 13:31:01 -0500
Message-Id: <20190206183101.9867-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 06 Feb 2019 18:31:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like when making the final revision of:

022debad063e ("drm/atomic: Add drm_atomic_state->duplicated")

I forgot to remove some of the comments that I had added to
drm_dp_atomic_find_vcpi_slots() and drm_dp_atomic_release_vcpi_slots()
that were no longer valid due to us having removed the state->duplicated
checks from each function. This also introduced an error while building
the docs with sphinx:

./drivers/gpu/drm/drm_dp_mst_topology.c:3100: WARNING: Inline literal
start-string without end-string.

So, fix that by just removing the kerneldoc comments.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 022debad063e ("drm/atomic: Add drm_atomic_state->duplicated")
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 5a99135d39cd..dc7ac0c60547 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3097,10 +3097,6 @@ static int drm_dp_init_vcpi(struct drm_dp_mst_topology_mgr *mgr,
  * @port as needed. It is not OK however, to call this function and
  * drm_dp_atomic_release_vcpi_slots() in the same atomic check phase.
  *
- * When &drm_atomic_state.duplicated is set to %true%, this function will not
- * perform any error checking and will instead simply return the previously
- * recorded VCPI allocations.
- *
  * See also:
  * drm_dp_atomic_release_vcpi_slots()
  * drm_dp_mst_atomic_check()
@@ -3185,11 +3181,6 @@ EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
  * drm_dp_atomic_find_vcpi_slots() on the same @port in a single atomic check
  * phase.
  *
- * When &drm_atomic_state.duplicated is set, this function will not
- * modify the VCPI allocations in &drm_dp_mst_topology_state.vcpis, so that
- * those VCPI allocations may be restored as-is from the duplicated state. In
- * this scenario, this function will always return 0.
- *
  * See also:
  * drm_dp_atomic_find_vcpi_slots()
  * drm_dp_mst_atomic_check()
-- 
2.20.1

