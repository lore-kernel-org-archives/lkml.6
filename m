Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40152C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BC3208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BC3208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeHAXC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:02:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeHAXC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A4EF819702B;
        Wed,  1 Aug 2018 21:15:15 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64E002026D68;
        Wed,  1 Aug 2018 21:15:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Sean Paul" <seanpaul@chromium.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Gustavo Padovan" <gustavo@padovan.org>
Subject: [PATCH v4 0/8] Fix connector probing deadlocks from RPM bugs
Date:   Wed,  1 Aug 2018 17:14:50 -0400
Message-Id: <20180801211459.7731-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 21:15:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 21:15:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest version of
https://patchwork.freedesktop.org/series/46815/

With a bunch of fixes to the new fb_helper to prevent it from breaking
module loading/unloading with nouveau. Also; lots of documentation
fixes and one fix in response to a kbuild bot.

Lyude Paul (8):
  drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
  drm/nouveau: Enable polling even if we have runtime PM
  drm/fb_helper: Introduce suspend/resume_hotplug()
  drm/nouveau: Fix deadlock with fb_helper using new helpers
  drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()
  drm/nouveau: Respond to HPDs by probing one conn at a time
  drm/nouveau: Fix deadlocks in nouveau_connector_detect()
  drm/nouveau: Call pm_runtime_get_noresume() from hpd handlers

 drivers/gpu/drm/drm_fb_helper.c             | 123 +++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_connector.c |  60 ++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_display.c   |   7 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c       |  16 ++-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     |   1 +
 include/drm/drm_fb_helper.h                 |  22 ++++
 7 files changed, 213 insertions(+), 17 deletions(-)

-- 
2.17.1

