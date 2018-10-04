Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26ACC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515A820854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515A820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJEG3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEG3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68AAF32B66D;
        Thu,  4 Oct 2018 23:34:03 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28F6C6836F;
        Thu,  4 Oct 2018 23:33:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Gustavo Padovan" <gustavo@padovan.org>,
        "Sean Paul" <seanpaul@chromium.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v3 0/5] Fix legacy DPMS changes with MST
Date:   Thu,  4 Oct 2018 19:33:45 -0400
Message-Id: <20181004233353.5388-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Oct 2018 23:34:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next version of https://patchwork.freedesktop.org/series/49877/

This fixes some rather silly bugs regarding DPMS On->Off changes failing
for connectors which were just recently destroyed.

Lyude Paul (5):
  drm/atomic_helper: Disallow new modesets on unregistered connectors
  drm/nouveau: Fix nv50_mstc->best_encoder()
  drm/i915: Leave intel_conn->mst_port set, use mst_port_gone instead
  drm/i915: Skip vcpi allocation for MSTB ports that are gone
  drm/i915: Fix intel_dp_mst_best_encoder()

 drivers/gpu/drm/drm_atomic_helper.c     | 21 ++++++++++++++++-
 drivers/gpu/drm/i915/intel_dp_mst.c     | 31 ++++++++++++++-----------
 drivers/gpu/drm/i915/intel_drv.h        |  6 +++++
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 14 ++++-------
 4 files changed, 47 insertions(+), 25 deletions(-)

-- 
2.17.1

