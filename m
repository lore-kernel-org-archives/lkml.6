Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B8BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2232087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjVpwHC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2232087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbeJICEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbeJICE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C5E204FD;
        Mon,  8 Oct 2018 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024681;
        bh=p2eE073QLsrISJydFj2tCOu5x8YAhwEhlAvolOW3iGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjVpwHC5IaSrd4UFSx2EWq8UwCLYDinFLk2A8o0e89o4ieAoG4ru+9Rp9lTM5GZeh
         w668bjMiErsCmJ9gZR0g5GN89FUOooNlSTFoNaxWrBwCHsJy5dgGq7BcNyKN2cKWpt
         oIgI8Zv+Bw/4KsDorVWWTRCkpg+I2em3pmyPGnxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 112/168] drm/nouveau/disp/gm200-: enforce identity-mapped SOR assignment for LVDS/eDP panels
Date:   Mon,  8 Oct 2018 20:31:32 +0200
Message-Id: <20181008175624.307211801@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 53b0cc46f27cfc2cadca609b503a7d92b5185a47 ]

Fixes eDP backlight issues on more recent laptops.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c |   14 ++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h  |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c |   15 ++++++++++++---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h |    1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
@@ -275,6 +275,7 @@ nvkm_disp_oneinit(struct nvkm_engine *en
 	struct nvkm_outp *outp, *outt, *pair;
 	struct nvkm_conn *conn;
 	struct nvkm_head *head;
+	struct nvkm_ior *ior;
 	struct nvbios_connE connE;
 	struct dcb_output dcbE;
 	u8  hpd = 0, ver, hdr;
@@ -399,6 +400,19 @@ nvkm_disp_oneinit(struct nvkm_engine *en
 			return ret;
 	}
 
+	/* Enforce identity-mapped SOR assignment for panels, which have
+	 * certain bits (ie. backlight controls) wired to a specific SOR.
+	 */
+	list_for_each_entry(outp, &disp->outp, head) {
+		if (outp->conn->info.type == DCB_CONNECTOR_LVDS ||
+		    outp->conn->info.type == DCB_CONNECTOR_eDP) {
+			ior = nvkm_ior_find(disp, SOR, ffs(outp->info.or) - 1);
+			if (!WARN_ON(!ior))
+				ior->identity = true;
+			outp->identity = true;
+		}
+	}
+
 	i = 0;
 	list_for_each_entry(head, &disp->head, head)
 		i = max(i, head->id + 1);
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -16,6 +16,7 @@ struct nvkm_ior {
 	char name[8];
 
 	struct list_head head;
+	bool identity;
 
 	struct nvkm_ior_state {
 		struct nvkm_outp *outp;
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
@@ -129,17 +129,26 @@ nvkm_outp_acquire(struct nvkm_outp *outp
 	if (proto == UNKNOWN)
 		return -ENOSYS;
 
+	/* Deal with panels requiring identity-mapped SOR assignment. */
+	if (outp->identity) {
+		ior = nvkm_ior_find(outp->disp, SOR, ffs(outp->info.or) - 1);
+		if (WARN_ON(!ior))
+			return -ENOSPC;
+		return nvkm_outp_acquire_ior(outp, user, ior);
+	}
+
 	/* First preference is to reuse the OR that is currently armed
 	 * on HW, if any, in order to prevent unnecessary switching.
 	 */
 	list_for_each_entry(ior, &outp->disp->ior, head) {
-		if (!ior->asy.outp && ior->arm.outp == outp)
+		if (!ior->identity && !ior->asy.outp && ior->arm.outp == outp)
 			return nvkm_outp_acquire_ior(outp, user, ior);
 	}
 
 	/* Failing that, a completely unused OR is the next best thing. */
 	list_for_each_entry(ior, &outp->disp->ior, head) {
-		if (!ior->asy.outp && ior->type == type && !ior->arm.outp &&
+		if (!ior->identity &&
+		    !ior->asy.outp && ior->type == type && !ior->arm.outp &&
 		    (ior->func->route.set || ior->id == __ffs(outp->info.or)))
 			return nvkm_outp_acquire_ior(outp, user, ior);
 	}
@@ -148,7 +157,7 @@ nvkm_outp_acquire(struct nvkm_outp *outp
 	 * but will be released during the next modeset.
 	 */
 	list_for_each_entry(ior, &outp->disp->ior, head) {
-		if (!ior->asy.outp && ior->type == type &&
+		if (!ior->identity && !ior->asy.outp && ior->type == type &&
 		    (ior->func->route.set || ior->id == __ffs(outp->info.or)))
 			return nvkm_outp_acquire_ior(outp, user, ior);
 	}
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -17,6 +17,7 @@ struct nvkm_outp {
 
 	struct list_head head;
 	struct nvkm_conn *conn;
+	bool identity;
 
 	/* Assembly state. */
 #define NVKM_OUTP_PRIV 1


