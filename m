Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDFAECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380642150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380642150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbeITEtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeITEtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:49:35 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B864C072278;
        Wed, 19 Sep 2018 23:09:23 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-250.rdu2.redhat.com [10.10.122.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A20E62010D69;
        Wed, 19 Sep 2018 23:09:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Gustavo Padovan" <gustavo@padovan.org>,
        "Thierry Reding" <treding@nvidia.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Andrey Grodzovsky" <andrey.grodzovsky@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Roman Li" <roman.li@amd.com>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Shirish S" <shirish.s@amd.com>, "Tony Cheng" <tony.cheng@amd.com>,
        "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>
Subject: [PATCH v2 0/6] Fix legacy DPMS changes with MST
Date:   Wed, 19 Sep 2018 19:08:57 -0400
Message-Id: <20180919230913.16894-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 19 Sep 2018 23:09:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's two major things this patchset does:
 - Add drm_dp_mst_connector_atomic_check() so drivers don't need to use
   ->best_encoder() to prevent modesets on zombie MST connectors. We'll
   use this later for implementing MST fallback retraining as well.
 - Fix DPMS on->off changes failing with legacy modesetting users after
   an MST connector's topology has disappeared, which resulted in CRTCs
   being left on when they shouldn't have been

Lyude Paul (6):
  drm/dp_mst: Introduce drm_dp_mst_connector_atomic_check()
  drm/nouveau: Unbreak nv50_mstc->best_encoder()
  drm/i915: Leave intel_conn->mst_port set, use mst_port_gone instead
  drm/i915: Skip vcpi allocation for MSTB ports that are gone
  drm/i915: Fix intel_dp_mst_best_encoder()
  drm/amdgpu/dm/mst: Use drm_dp_mst_connector_atomic_check()

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 12 +++
 drivers/gpu/drm/drm_dp_mst_topology.c         | 76 +++++++++++++++++++
 drivers/gpu/drm/i915/intel_dp_mst.c           | 46 ++++++-----
 drivers/gpu/drm/i915/intel_drv.h              |  1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 25 +++---
 include/drm/drm_dp_mst_helper.h               |  3 +
 6 files changed, 132 insertions(+), 31 deletions(-)

-- 
2.17.1

