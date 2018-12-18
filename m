Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64210C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3245021873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151361;
	bh=8c3bRHr4BfvG98z16aRpPa6XXm8hXswaJLFdCT7L9CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qhmt3ccc7bWVDZATcU9AM7SNsHtdMAMBpWQo32CeccXJh6dSoj6oYgEouLZ4o5qrC
	 IRoja2/KcyrbjGs35p/MjmXTKKh7et9CHE5owcgqRSi4ZwZ7abVKMc6Rfusi/AF1uE
	 2K5jgS6SeD7PtoKAc5MwzQ3fRuxyR60JBMNrWYXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeLRQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeLRQl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8AB218A3;
        Tue, 18 Dec 2018 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151316;
        bh=8c3bRHr4BfvG98z16aRpPa6XXm8hXswaJLFdCT7L9CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAEfm+XPorjy3CBsc42N78WI2o7tBHDG2fTo+coX1hc+/RC6fgIR3kKbyyygVJ5mI
         XcBmaqf0pWL1RKy/bD5viRbSUlbOQat8pdLWTpNnIJZUNhaex4dp2tYvshZaNxdL+N
         mVbDIGJM87YNOeSDUiEFyVE9jVUIgSPSFijCxOm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.19 34/44] drm/nouveau/kms/nv50-: also flush fb writes when rewinding push buffer
Date:   Tue, 18 Dec 2018 17:39:46 +0100
Message-Id: <20181218163931.437726462@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Skeggs <bskeggs@redhat.com>

commit 970a5ee41c72df46e3b0f307528c7d8ef7734a2e upstream.

Should hopefully fix a regression some people have been seeing since EVO
push buffers were moved to VRAM by default on Pascal GPUs.

Fixes: d00ddd9da ("drm/nouveau/kms/nv50-: allocate push buffers in vidmem on pascal")
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -197,6 +197,22 @@ nv50_dmac_create(struct nvif_device *dev
 /******************************************************************************
  * EVO channel helpers
  *****************************************************************************/
+static void
+evo_flush(struct nv50_dmac *dmac)
+{
+	/* Push buffer fetches are not coherent with BAR1, we need to ensure
+	 * writes have been flushed right through to VRAM before writing PUT.
+	 */
+	if (dmac->push.type & NVIF_MEM_VRAM) {
+		struct nvif_device *device = dmac->base.device;
+		nvif_wr32(&device->object, 0x070000, 0x00000001);
+		nvif_msec(device, 2000,
+			if (!(nvif_rd32(&device->object, 0x070000) & 0x00000002))
+				break;
+		);
+	}
+}
+
 u32 *
 evo_wait(struct nv50_dmac *evoc, int nr)
 {
@@ -207,6 +223,7 @@ evo_wait(struct nv50_dmac *evoc, int nr)
 	mutex_lock(&dmac->lock);
 	if (put + nr >= (PAGE_SIZE / 4) - 8) {
 		dmac->ptr[put] = 0x20000000;
+		evo_flush(dmac);
 
 		nvif_wr32(&dmac->base.user, 0x0000, 0x00000000);
 		if (nvif_msec(device, 2000,
@@ -229,17 +246,7 @@ evo_kick(u32 *push, struct nv50_dmac *ev
 {
 	struct nv50_dmac *dmac = evoc;
 
-	/* Push buffer fetches are not coherent with BAR1, we need to ensure
-	 * writes have been flushed right through to VRAM before writing PUT.
-	 */
-	if (dmac->push.type & NVIF_MEM_VRAM) {
-		struct nvif_device *device = dmac->base.device;
-		nvif_wr32(&device->object, 0x070000, 0x00000001);
-		nvif_msec(device, 2000,
-			if (!(nvif_rd32(&device->object, 0x070000) & 0x00000002))
-				break;
-		);
-	}
+	evo_flush(dmac);
 
 	nvif_wr32(&dmac->base.user, 0x0000, (push - dmac->ptr) << 2);
 	mutex_unlock(&dmac->lock);


