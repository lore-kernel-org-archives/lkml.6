Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C00D20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C00D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409749AbeKWWxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:53:06 -0500
Received: from www.osadl.org ([62.245.132.105]:57932 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388020AbeKWWxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:53:06 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wANC4eM0032110;
        Fri, 23 Nov 2018 13:04:40 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Andrew F. Davis" <afd@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] drm/omap: dss: do not allow devm_kasprintf() to fail
Date:   Fri, 23 Nov 2018 13:01:35 +0100
Message-Id: <1542974495-12387-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omapdss_display_init() is called by multiple drivers and does not expect
a return value so without changing all call-sites the low-probability
failure of devm_kasprintf() can not be reported up the call stack. As
the amount allocated here is very small (<= 16 bytes) and it is an
initialization function that most likely will be called during system
initialization it should be OK to use __GFP_NOFAIL here to prevent
devm_kasprintf() from returning NULL.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 36c61ae2b755 ("drm/omap: dss: Remove display ordering from dss/display.c")
---

Problem located with experimental coccinelle script

While the use of __GFP_NOFAIL is to be limited (small infrequent 
allocations) this case does seems suitable as it is rare and small
(initialization) .As all the current drivers using 
omapdss_display_init() currently seem not to initialize dssdev->name
prior to calling omapdss_display_init() and the unlikely failure
case can not be reasonably responded (returns void) not allowing
a allocation failure here should be acceptable.

Patch was compile tested with: omap2plus_defconfig (implies OMAP_DSS_BASE=m)

Patch is against 4.20-rc3 (localversion-next is next-20181123)

 drivers/gpu/drm/omapdrm/dss/display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/display.c b/drivers/gpu/drm/omapdrm/dss/display.c
index 34b2a4e..7dbe874 100644
--- a/drivers/gpu/drm/omapdrm/dss/display.c
+++ b/drivers/gpu/drm/omapdrm/dss/display.c
@@ -45,7 +45,8 @@ void omapdss_display_init(struct omap_dss_device *dssdev)
 	of_property_read_string(dssdev->dev->of_node, "label", &dssdev->name);
 
 	if (dssdev->name == NULL)
-		dssdev->name = devm_kasprintf(dssdev->dev, GFP_KERNEL,
+		dssdev->name = devm_kasprintf(dssdev->dev,
+					      GFP_KERNEL | __GFP_NOFAIL,
 					      "display%u", id);
 }
 EXPORT_SYMBOL_GPL(omapdss_display_init);
-- 
2.1.4

