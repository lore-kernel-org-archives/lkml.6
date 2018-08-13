Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA178C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02F92177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02F92177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeHMVun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:50:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730352AbeHMVun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:50:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 834A087A78;
        Mon, 13 Aug 2018 19:07:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE8D010073B7;
        Mon, 13 Aug 2018 19:07:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Thierry Reding" <treding@nvidia.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v6 0/5] Fix connector probing deadlocks from RPM bugs
Date:   Mon, 13 Aug 2018 15:06:58 -0400
Message-Id: <20180813190706.24172-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 13 Aug 2018 19:07:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 13 Aug 2018 19:07:12 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest version of https://patchwork.freedesktop.org/series/46815/ with
some significant improvements:

 - I finally figured out a clean way to do this entirely with runtime PM
   helpers, no avoiding grabbing refs required!
 - Since this new method removes the need for a lot of the other changes
   I made (although we probably still want those changes, but not for
   fixing these deadlocks) I've removed those now irrelevant patches from
   the series and will resend them on their own to make reviewing this
   go faster.

Lyude Paul (5):
  drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
  drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
  drm/nouveau: Fix deadlock with fb_helper with async RPM requests
  drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()
  drm/nouveau: Fix deadlocks in nouveau_connector_detect()

 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 42 +++++++++---
 drivers/gpu/drm/nouveau/nouveau_display.c   |  9 ++-
 drivers/gpu/drm/nouveau/nouveau_drm.c       |  1 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     | 72 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h     |  7 ++
 6 files changed, 119 insertions(+), 14 deletions(-)

-- 
2.17.1

