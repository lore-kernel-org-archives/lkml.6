Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F93ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C1B20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C1B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeGQAic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:38:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729466AbeGQAib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:38:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0D704022414;
        Mon, 16 Jul 2018 23:59:54 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB7C02026D65;
        Mon, 16 Jul 2018 23:59:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/5] drm/nouveau: Fix a lot of nasty RPM bugs and deadlocks
Date:   Mon, 16 Jul 2018 19:59:24 -0400
Message-Id: <20180716235936.11268-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 16 Jul 2018 23:59:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 16 Jul 2018 23:59:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes quite a number of runtime PM bugs I found that have been
causing some pretty nasty issues such as:
 - Deadlocking on boot
 - Connector probing potentially not working while the GPU is in runtime
   suspend
 - i2c char dev not working while the GPU is in runtime suspend
 - aux char dev not working while the GPU is in runtime suspend

There's definitely more parts of nouveau that need to be fixed to use
runtime power management correctly, such as the hwmon portions, but this
series just handles the more important fixes that should get into stable
for the time being.

Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org

Lyude Paul (5):
  drm/nouveau: Prevent RPM callback recursion in suspend/resume paths
  drm/nouveau: Grab RPM ref while probing outputs
  drm/nouveau: Add missing RPM get/put() when probing connectors
  drm/nouveau: Grab RPM ref when i2c bus is in use
  drm/nouveau: Grab RPM ref when aux bus is in use

 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 12 +++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 21 +++++++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h   |  3 +++
 drivers/gpu/drm/nouveau/nouveau_drm.c         | 10 ++++++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 12 ++++++++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c | 12 ++++++++++-
 6 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.17.1

