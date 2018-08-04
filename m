Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4701C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C84217C5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C84217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbeHDLKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:10:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeHDLKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:10:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C314389C;
        Sat,  4 Aug 2018 09:10:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 083/124] drm/gma500: fix psb_intel_lvds_mode_valid()s return type
Date:   Sat,  4 Aug 2018 11:01:12 +0200
Message-Id: <20180804082705.605304776@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 2ea009095c6e7396915a1d0dd480c41f02985f79 ]

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method, psb_intel_lvds_mode_valid(), uses an 'int' for it.

Fix this by using 'enum drm_mode_status' for psb_intel_lvds_mode_valid().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180424131458.2060-1-luc.vanoostenryck@gmail.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/gma500/psb_intel_drv.h  |    2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -252,7 +252,7 @@ extern int intelfb_remove(struct drm_dev
 extern bool psb_intel_lvds_mode_fixup(struct drm_encoder *encoder,
 				      const struct drm_display_mode *mode,
 				      struct drm_display_mode *adjusted_mode);
-extern int psb_intel_lvds_mode_valid(struct drm_connector *connector,
+extern enum drm_mode_status psb_intel_lvds_mode_valid(struct drm_connector *connector,
 				     struct drm_display_mode *mode);
 extern int psb_intel_lvds_set_property(struct drm_connector *connector,
 					struct drm_property *property,
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -343,7 +343,7 @@ static void psb_intel_lvds_restore(struc
 	}
 }
 
-int psb_intel_lvds_mode_valid(struct drm_connector *connector,
+enum drm_mode_status psb_intel_lvds_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
 	struct drm_psb_private *dev_priv = connector->dev->dev_private;


