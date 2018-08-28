Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D800C20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D800C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeH1VD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:03:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbeH1VD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD68D8D685;
        Tue, 28 Aug 2018 17:10:49 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72ED810EE6DE;
        Tue, 28 Aug 2018 17:10:46 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Stone <daniel@fooishbar.org>,
        "David Airlie" <airlied@linux.ie>,
        "Sean Paul" <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo Padovan" <gustavo@padovan.org>,
        "Andrey Grodzovsky" <andrey.grodzovsky@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Roman Li" <roman.li@amd.com>, "Ben Skeggs" <bskeggs@redhat.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        intel-gfx@lists.freedesktop.org, "Shirish S" <shirish.s@amd.com>,
        "Tony Cheng" <tony.cheng@amd.com>,
        "Jerry (Fangzhi) Zuo" <jerry.zuo@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 0/4] drm/dp_mst: Add DP MST debugfs nodes for all drivers
Date:   Tue, 28 Aug 2018 13:10:26 -0400
Message-Id: <20180828171036.25943-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 28 Aug 2018 17:10:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 28 Aug 2018 17:10:50 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next version of my patch series for teaching DRM how to
automatically create debugfs nodes for drivers with MST topologies. This
was originally intended just for nouveau, but has since been expanded to
all DRM drivers.

Changes since previous version:
 - Fix documentation error that got noticed by the kbuild bot in
   "drm/dp_mst: Pass entire connector to drm_dp_mst_topology_mgr_init()"

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Stone <daniel@fooishbar.org>

Lyude Paul (4):
  drm/debugfs: Add support for dynamic debugfs initialization
  drm/dp_mst: Pass entire connector to drm_dp_mst_topology_mgr_init()
  drm/dp_mst: Add dp_mst_status debugfs node for all drivers
  drm/i915: Remove i915_drm_dp_mst_status

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 drivers/gpu/drm/drm_debugfs.c                 | 173 +++++++++++++++++-
 drivers/gpu/drm/drm_dp_mst_topology.c         | 116 +++++++++++-
 drivers/gpu/drm/drm_drv.c                     |   3 +
 drivers/gpu/drm/drm_internal.h                |   5 +
 drivers/gpu/drm/i915/i915_debugfs.c           |  32 ----
 drivers/gpu/drm/i915/intel_dp.c               |   2 +-
 drivers/gpu/drm/i915/intel_dp_mst.c           |   6 +-
 drivers/gpu/drm/i915/intel_drv.h              |   3 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   6 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c        |   2 +-
 include/drm/drm_debugfs.h                     |  27 +++
 include/drm/drm_dp_mst_helper.h               |  17 +-
 include/drm/drm_file.h                        |   4 +
 14 files changed, 343 insertions(+), 55 deletions(-)

-- 
2.17.1

