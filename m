Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E76C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63EF20841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63EF20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeHWFHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:07:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeHWFHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:07:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1AC526353;
        Thu, 23 Aug 2018 01:40:18 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-163.rdu2.redhat.com [10.10.124.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF24210DCF6A;
        Thu, 23 Aug 2018 01:40:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH 0/3] drm/nouveau: Fixup module probe to add ->shutdown()
Date:   Wed, 22 Aug 2018 21:40:05 -0400
Message-Id: <20180823014009.21532-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 01:40:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 01:40:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is intended to add support for shutting down the GPU on
kernel shutdown/reboot using the ->shutdown() hook, similar to what
amdgpu does. This is mainly intended to workaround a bios issue on the
P50 that was preventing nouveau from initializing the dedicated GM107
GPU on that system properly. You can find more details on this issue in
the patch labeled "Shut down GPU on kernel shutdown".

Doing this so that it wouldn't race with userspace took a
little bit of work (and uncovered one small bug in the process). Mainly,
I had to convert nouveau to use the new drm_dev_alloc() and
drm_dev_register() helpers to ensure that there isn't any chance that we
can race with userspace during shutdown. This also involved removing
->load() and ->unload() and moving their work into nouveau_drm_probe().

============================== IMPORTANT ===============================
This patch series WILL NOT WORK PROPERLY unless you also apply the
following patches which fix some leftover device removal issues:

https://patchwork.freedesktop.org/series/48596/
This fixes kernel panics on removal on systems with nvidia controlled
backlights

https://patchwork.freedesktop.org/series/47843/
This fixes issues with DRM connectors getting leaked on device removal,
due to hpd_work still being active when unloading nouveau.

============================== IMPORTANT ===============================

This also uncovered one small bug in nouveau_drm_load().

Lyude Paul (3):
  drm/nouveau: Fix potential memory leak in nouveau_drm_load()
  drm/nouveau: Start using new drm_dev initialization helpers
  drm/nouveau: Shut down GPU on kernel shutdown

 drivers/gpu/drm/nouveau/nouveau_drm.c | 180 +++++++++++++++-----------
 1 file changed, 106 insertions(+), 74 deletions(-)

-- 
2.17.1

