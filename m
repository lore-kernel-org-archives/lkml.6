Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0D21569
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B0D21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeHGWzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:55:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeHGWzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E070C40241C3;
        Tue,  7 Aug 2018 20:39:26 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 565D11C700;
        Tue,  7 Aug 2018 20:39:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 00/13] Fix connector probing deadlocks from RPM bugs
Date:   Tue,  7 Aug 2018 16:38:57 -0400
Message-Id: <20180807203914.2192-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 20:39:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 20:39:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest version of https://patchwork.freedesktop.org/series/46815/

I moved everything out of fb_helper and back into nouveau, because it
seems that other drivers actually do have this handled already as far as
I can tell.

Lyude Paul (13):
  drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
  drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
  drm/nouveau: Remove useless poll_enable() call in
    switcheroo_set_state()
  drm/nouveau: Remove useless poll_disable() call in
    switcheroo_set_state()
  drm/nouveau: Remove useless poll_enable() call in drm_load()
  drm/nouveau: Call optimus_dsm functions after nouveau_do_suspend()
  drm/nouveau: Add missing unroll functions in nouveau_do_suspend()
  drm/nouveau: Don't ignore nouveau_do_suspend() ret value
  drm/nouveau: Fix deadlock with fb_helper by inhibiting it's HPD
  drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()
  drm/nouveau: Respond to HPDs by probing one conn at a time
  drm/nouveau: Fix deadlocks in nouveau_connector_detect()
  drm/nouveau: Call pm_runtime_get_noresume() from hpd handlers

 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 60 +++++++++++---
 drivers/gpu/drm/nouveau/nouveau_connector.h |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c   | 55 +++++++++----
 drivers/gpu/drm/nouveau/nouveau_drm.c       | 23 ++++--
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     | 90 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h     |  9 +++
 drivers/gpu/drm/nouveau/nouveau_vga.c       |  2 -
 8 files changed, 209 insertions(+), 33 deletions(-)

-- 
2.17.1

