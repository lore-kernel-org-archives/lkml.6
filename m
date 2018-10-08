Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ABFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2734C20645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKDFwpce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2734C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbeJICFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6DB204FD;
        Mon,  8 Oct 2018 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024760;
        bh=t9MJBqq3xErjUVwe3uxmIy3MJr5tKgzOZG3ZmN/yG50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKDFwpceMmVtRuYsjgz0lsgtnaPdnCFsnqqlAVTGLVdMFs2nwXFFkcxsbTYphBw1X
         PAKmYUpxLZN6qEyo5wWbo72MQeDfLvh9SQzxfbH3TgTIYRm/Rlhx8uPEJwL0uDGtKj
         FdFIqK45U4ZnxLg/8vOPHHW4Fzbx9nKBjEuuZePc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 111/168] drm/nouveau/disp: fix DP disable race
Date:   Mon,  8 Oct 2018 20:31:31 +0200
Message-Id: <20181008175624.267549622@linuxfoundation.org>
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

[ Upstream commit e04cfdc9b7398c60dbc70212415ea63b6c6a93ae ]

If a HPD pulse signalling the need to retrain the link occurs between
the KMS driver releasing the output and the supervisor interrupt that
finishes the teardown, it was possible get a NULL-ptr deref.

Avoid this by marking the link as inactive earlier.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c   |   17 ++++++++++++-----
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c |    6 +++---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c |    2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h |    3 ++-
 4 files changed, 19 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
@@ -412,14 +412,10 @@ nvkm_dp_train(struct nvkm_dp *dp, u32 da
 }
 
 static void
-nvkm_dp_release(struct nvkm_outp *outp, struct nvkm_ior *ior)
+nvkm_dp_disable(struct nvkm_outp *outp, struct nvkm_ior *ior)
 {
 	struct nvkm_dp *dp = nvkm_dp(outp);
 
-	/* Prevent link from being retrained if sink sends an IRQ. */
-	atomic_set(&dp->lt.done, 0);
-	ior->dp.nr = 0;
-
 	/* Execute DisableLT script from DP Info Table. */
 	nvbios_init(&ior->disp->engine.subdev, dp->info.script[4],
 		init.outp = &dp->outp.info;
@@ -428,6 +424,16 @@ nvkm_dp_release(struct nvkm_outp *outp,
 	);
 }
 
+static void
+nvkm_dp_release(struct nvkm_outp *outp)
+{
+	struct nvkm_dp *dp = nvkm_dp(outp);
+
+	/* Prevent link from being retrained if sink sends an IRQ. */
+	atomic_set(&dp->lt.done, 0);
+	dp->outp.ior->dp.nr = 0;
+}
+
 static int
 nvkm_dp_acquire(struct nvkm_outp *outp)
 {
@@ -576,6 +582,7 @@ nvkm_dp_func = {
 	.fini = nvkm_dp_fini,
 	.acquire = nvkm_dp_acquire,
 	.release = nvkm_dp_release,
+	.disable = nvkm_dp_disable,
 };
 
 static int
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -501,11 +501,11 @@ nv50_disp_super_2_0(struct nv50_disp *di
 	nv50_disp_super_ied_off(head, ior, 2);
 
 	/* If we're shutting down the OR's only active head, execute
-	 * the output path's release function.
+	 * the output path's disable function.
 	 */
 	if (ior->arm.head == (1 << head->id)) {
-		if ((outp = ior->arm.outp) && outp->func->release)
-			outp->func->release(outp, ior);
+		if ((outp = ior->arm.outp) && outp->func->disable)
+			outp->func->disable(outp, ior);
 	}
 }
 
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
@@ -93,6 +93,8 @@ nvkm_outp_release(struct nvkm_outp *outp
 	if (ior) {
 		outp->acquired &= ~user;
 		if (!outp->acquired) {
+			if (outp->func->release && outp->ior)
+				outp->func->release(outp);
 			outp->ior->asy.outp = NULL;
 			outp->ior = NULL;
 		}
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -41,7 +41,8 @@ struct nvkm_outp_func {
 	void (*init)(struct nvkm_outp *);
 	void (*fini)(struct nvkm_outp *);
 	int (*acquire)(struct nvkm_outp *);
-	void (*release)(struct nvkm_outp *, struct nvkm_ior *);
+	void (*release)(struct nvkm_outp *);
+	void (*disable)(struct nvkm_outp *, struct nvkm_ior *);
 };
 
 #define OUTP_MSG(o,l,f,a...) do {                                              \


