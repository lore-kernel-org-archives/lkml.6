Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9488C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7119720863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfBBAUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:20:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfBBAUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:20:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D630A7AE95;
        Sat,  2 Feb 2019 00:20:34 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-16.rdu2.redhat.com [10.10.120.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF441608C8;
        Sat,  2 Feb 2019 00:20:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, "David Airlie" <airlied@linux.ie>,
        "Maxime Ripard" <maxime.ripard@bootlin.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Karol Herbst" <karolherbst@gmail.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        intel-gfx@lists.freedesktop.org,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 0/4] drm/dp_mst: Fix regressions from new atomic VCPI helpers
Date:   Fri,  1 Feb 2019 19:20:00 -0500
Message-Id: <20190202002023.29665-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 02 Feb 2019 00:20:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the extra issues I discovered upstream after the introduction
of my rework of the atomic VCPI helpers that occur during
suspend/resume.

This time around, we use a slightly different but much less complicated
approach for fixing said issues.

Cc: Daniel Vetter <daniel@ffwll.ch>

Lyude Paul (4):
  drm/dp_mst: Fix unbalanced malloc ref in drm_dp_mst_deallocate_vcpi()
  drm/dp_mst: Remove port validation in drm_dp_atomic_find_vcpi_slots()
  drm/atomic: Add drm_atomic_state->duplicated
  drm/nouveau: Move PBN and VCPI allocation into nv50_head_atom

 drivers/gpu/drm/drm_atomic_helper.c     | 10 +++++++-
 drivers/gpu/drm/drm_dp_mst_topology.c   | 32 +++++++++++++------------
 drivers/gpu/drm/i915/intel_dp_mst.c     | 17 +++++--------
 drivers/gpu/drm/nouveau/dispnv50/atom.h |  6 +++++
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 31 ++++++++++++++----------
 drivers/gpu/drm/nouveau/dispnv50/head.c |  1 +
 include/drm/drm_atomic.h                |  9 +++++++
 7 files changed, 66 insertions(+), 40 deletions(-)

-- 
2.20.1

