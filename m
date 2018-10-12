Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC0C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35B82098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f/VJO2W3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35B82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJMDvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43184 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJMDvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:23 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKH7aW119979;
        Fri, 12 Oct 2018 15:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375427;
        bh=CAC6e6eZQtezCtxSWx6hJuqk1oeAtJ+87XZ1ArKs4IY=;
        h=From:To:CC:Subject:Date;
        b=f/VJO2W3iuw8026lLT8Xr88/ifaV1lQMBbwRQhYlazzHKLxhAu3S5wNvqsXsJEPOU
         TduyVk82G2dYRQY7nvxXRem8DKQxB3ZUzXE+/WL623piRAljADqq9m+IAmHHyV4uw+
         wXQ78WnzBTze9hPmRKVQh9fUwMslMoFPme2EVWEQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7ha030092;
        Fri, 12 Oct 2018 15:17:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:07 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:07 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7EU000402;
        Fri, 12 Oct 2018 15:17:07 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 0/8] drm/omap: Add virtual-planes support
Date:   Fri, 12 Oct 2018 15:16:55 -0500
Message-ID: <20181012201703.29065-1-bparrot@ti.com>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds virtual-plane support to omapdrm driver to allow the use
of display wider than 2048 pixels.

In order to do so we introduce the concept of hw_overlay which can then be
dynamically allocated to a plane. When the requested output width exceed what
be supported by one overlay a second is then allocated if possible to handle
display wider then 2048.

This series replaces an earlier series which was DT based and using statically
allocated resources. 

This implementation is inspired from the work done in msm/disp/mdp5
driver.

Benoit Parrot (8):
  drm/omap: Add ability to check if requested plane modes can be
    supported
  drm/omap: Add ovl checking funcs to dispc_ops
  drm/omap: introduce omap_hw_overlay
  drm/omap: omap_plane: subclass drm_plane_state
  drm/omap: Add global state as a private atomic object
  drm/omap: dynamically assign hw overlays to planes
  drm/omap: add plane_atomic_print_state support
  drm/omap: Add a 'right overlay' to plane state

 drivers/gpu/drm/omapdrm/Makefile       |   1 +
 drivers/gpu/drm/omapdrm/dss/dispc.c    |  32 +++
 drivers/gpu/drm/omapdrm/dss/omapdss.h  |   6 +
 drivers/gpu/drm/omapdrm/omap_drv.c     | 196 ++++++++++++++++-
 drivers/gpu/drm/omapdrm/omap_drv.h     |  30 +++
 drivers/gpu/drm/omapdrm/omap_fb.c      |  33 ++-
 drivers/gpu/drm/omapdrm/omap_fb.h      |   4 +-
 drivers/gpu/drm/omapdrm/omap_overlay.c | 257 ++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_overlay.h |  41 ++++
 drivers/gpu/drm/omapdrm/omap_plane.c   | 374 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/omapdrm/omap_plane.h   |   1 +
 11 files changed, 922 insertions(+), 53 deletions(-)
 create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.c
 create mode 100644 drivers/gpu/drm/omapdrm/omap_overlay.h

-- 
2.9.0

