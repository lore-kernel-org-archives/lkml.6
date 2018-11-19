Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F053221104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFiFo6Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F053221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbeKTDCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732373AbeKTDCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33252206BA;
        Mon, 19 Nov 2018 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645482;
        bh=2xtWJ3b6nfKnlpEVHhj1GMQTE3eLbVILL+TAVJyTp2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFiFo6FeKrN/+au5yZQSAEoK6ZvQuYEGBKm/ifMvJ5aQR5IySxSGol+8XKW/BsB+Q
         gYIieHP72fuZ9q9dQHBhMs6zMPvhxssH+VM66SpUwOqOXYknJIo1fdQfi9jT6KoI/2
         UXIKt7870EdFzmycQ5SIS6LVndZoq5WExOfOKa3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 178/205] drm/nouveau: Fix nv50_mstc->best_encoder()
Date:   Mon, 19 Nov 2018 17:28:05 +0100
Message-Id: <20181119162641.024010256@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 7b0f61e91b6056c71649efa3204112a4b6cf5fc8 upstream.

As mentioned in the previous commit, we currently prevent new modesets
on recently-removed MST connectors by returning no encoder from our
->best_encoder() callback once the MST port has disappeared. This is
wrong however, because it prevents legacy modesetting users from being
able to disable CRTCs on MST connectors after the connector's respective
topology has disappeared.

So, fix this by instead by just always returning a valid encoder.

Changes since v2:
- Remove usage of atomic MST helper for now, since that got replaced
  with a much simpler solution

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20181008232437.5571-3-lyude@redhat.com
(cherry picked from commit e87b0bbc9f0380d403f8f2f6abba0d51c74d944f)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -843,22 +843,16 @@ nv50_mstc_atomic_best_encoder(struct drm
 {
 	struct nv50_head *head = nv50_head(connector_state->crtc);
 	struct nv50_mstc *mstc = nv50_mstc(connector);
-	if (mstc->port) {
-		struct nv50_mstm *mstm = mstc->mstm;
-		return &mstm->msto[head->base.index]->encoder;
-	}
-	return NULL;
+
+	return &mstc->mstm->msto[head->base.index]->encoder;
 }
 
 static struct drm_encoder *
 nv50_mstc_best_encoder(struct drm_connector *connector)
 {
 	struct nv50_mstc *mstc = nv50_mstc(connector);
-	if (mstc->port) {
-		struct nv50_mstm *mstm = mstc->mstm;
-		return &mstm->msto[0]->encoder;
-	}
-	return NULL;
+
+	return &mstc->mstm->msto[0]->encoder;
 }
 
 static enum drm_mode_status


