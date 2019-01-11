Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5482C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAD021848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217856;
	bh=wuTBWD5JbgWVURhR6Ne/e2HC1A8jRCMIci7r/TjY0FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfMvsniNhaaohIxMsAQiUlhSw/SwCW9oo2Q5qzPiC29pfCJmrTDn2068Ha5FexB/m
	 qJlnkL61yis/oaYJz00/VuTgRx3Nej4uUk0CMd1pu6IM1zI0LZ6aPaLeQedL6D6gv2
	 rlAa5SXw09Y12gcuYHsowV6dpkTXEonJwkbh6L5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbfAKOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404563AbfAKOoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69A520872;
        Fri, 11 Jan 2019 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217851;
        bh=wuTBWD5JbgWVURhR6Ne/e2HC1A8jRCMIci7r/TjY0FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJ2d3WeSDpGAzkDU9izpVTWixkNrRECTZB8XbozicLzryuX1Vdf5fTo12ikTn/oSa
         MwKNNVgjaqUx3Uu0lwTOji5OJ6G0XeWIkRwn2iDRS5091sXzgUw/GN2oTh7NQohOMZ
         8E/pX8OGoSZEqyuaxhef/Cvb4A/kjkuBZPC5omlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.20 63/65] drm/nouveau/drm/nouveau: Check rc from drm_dp_mst_topology_mgr_resume()
Date:   Fri, 11 Jan 2019 15:15:49 +0100
Message-Id: <20190111131104.402491566@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit b89fdf7ae8500feae1100d8b283176a44d31d698 upstream.

We need to actually make sure we check this on resume since otherwise we
won't know whether or not the topology is still there once we've
resumed, which will cause us to still think the topology is connected
even after it's been removed if the removal happens mid-suspend.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1262,8 +1262,16 @@ nv50_mstm_fini(struct nv50_mstm *mstm)
 static void
 nv50_mstm_init(struct nv50_mstm *mstm)
 {
-	if (mstm && mstm->mgr.mst_state)
-		drm_dp_mst_topology_mgr_resume(&mstm->mgr);
+	int ret;
+
+	if (!mstm || !mstm->mgr.mst_state)
+		return;
+
+	ret = drm_dp_mst_topology_mgr_resume(&mstm->mgr);
+	if (ret == -1) {
+		drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, false);
+		drm_kms_helper_hotplug_event(mstm->mgr.dev);
+	}
 }
 
 static void


