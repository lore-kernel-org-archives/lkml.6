Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75321C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317BC23F4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317BC23F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753314AbeGFJNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:13:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751185AbeGFJNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03937E9000;
        Fri,  6 Jul 2018 09:13:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 941382026D68;
        Fri,  6 Jul 2018 09:13:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D4D4231EEC; Fri,  6 Jul 2018 11:13:08 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/cirrus: flip default to 32bpp
Date:   Fri,  6 Jul 2018 11:12:49 +0200
Message-Id: <20180706091249.25086-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 09:13:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 09:13:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cirrus can handle 1024x768 (and slightly higher) with 24bpp depth.
cirrus can handle up to 800x600 with 32bpp.

The problem with 24bpp is that it is a rather unusual depth these days,
cirrus is pretty much the only relevant device still using that, and it
is a endless source of issues.  Wayland doesn't support it at all.  Bugs
in Xorg keep showing up.

So using 32bpp by default is the better choice IMO, even if it comes
with the drawback that the resolution is 800x600 only.  But hey, better
a working 800x600 display than a broken 1024x768 display ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index 69c4e352dd..e9e5a92a36 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -16,11 +16,11 @@
 #include "cirrus_drv.h"
 
 int cirrus_modeset = -1;
-int cirrus_bpp = 24;
+int cirrus_bpp = 32;
 
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, cirrus_modeset, int, 0400);
-MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:24)");
+MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:32)");
 module_param_named(bpp, cirrus_bpp, int, 0400);
 
 /*
-- 
2.9.3

