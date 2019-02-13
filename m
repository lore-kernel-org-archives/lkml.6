Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D04C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4285B222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025341;
	bh=YoR5e4lPthnzep3LK3awfAmL8snpqLSWQ9DzAlV3ROg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vcG5Sf5CQ6pCzfUX/fjAgLQqtWubWZdQND1Vmf4o4pLCvSX7Ox56oiwwR2Jw/Lqa2
	 W/cl+orqqP53cSocPCKLwdEtDyEVcqDZ5UIS3FcyzYvC5d70PmfMSEzSKjrNFq4oF6
	 9dPMU68gVsx18HEj/OitSBb4MYFcI4D//8/A66jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbfBMCfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388015AbfBMCf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B95222C9;
        Wed, 13 Feb 2019 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025327;
        bh=YoR5e4lPthnzep3LK3awfAmL8snpqLSWQ9DzAlV3ROg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTFtc7WuxSMqMV2umwku2JLFEmp2g/TCJSdSLKVebd/lSPgBVbdREMY65Y09qnDkQ
         6DVKOa6JYHncDSWn4Ev7A2KnDiraLazyt2ZHBgZX+65OOem/Q6/vtnaAlB0biaSJEQ
         NX+EknBKTrl1KpQzw/8g0+ClkV3LtwoH2QHKO/gY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 071/105] vhost/scsi: Use copy_to_iter() to send control queue response
Date:   Tue, 12 Feb 2019 21:33:02 -0500
Message-Id: <20190213023336.19019-71-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>

[ Upstream commit 8e5dadfe76cf2862ebf3e4f22adef29982df7766 ]

Uses copy_to_iter() instead of __copy_to_user() in order to ensure we
support arbitrary layouts and an input buffer split across iov entries.

Fixes: 0d02dbd68c47b ("vhost/scsi: Respond to control queue operations")
Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 73a4adeab096..11bd8b6422eb 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1132,16 +1132,18 @@ vhost_scsi_send_tmf_reject(struct vhost_scsi *vs,
 			   struct vhost_virtqueue *vq,
 			   struct vhost_scsi_ctx *vc)
 {
-	struct virtio_scsi_ctrl_tmf_resp __user *resp;
 	struct virtio_scsi_ctrl_tmf_resp rsp;
+	struct iov_iter iov_iter;
 	int ret;
 
 	pr_debug("%s\n", __func__);
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
-	resp = vq->iov[vc->out].iov_base;
-	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
-	if (!ret)
+
+	iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp));
+
+	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
+	if (likely(ret == sizeof(rsp)))
 		vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
 	else
 		pr_err("Faulted on virtio_scsi_ctrl_tmf_resp\n");
@@ -1152,16 +1154,18 @@ vhost_scsi_send_an_resp(struct vhost_scsi *vs,
 			struct vhost_virtqueue *vq,
 			struct vhost_scsi_ctx *vc)
 {
-	struct virtio_scsi_ctrl_an_resp __user *resp;
 	struct virtio_scsi_ctrl_an_resp rsp;
+	struct iov_iter iov_iter;
 	int ret;
 
 	pr_debug("%s\n", __func__);
 	memset(&rsp, 0, sizeof(rsp));	/* event_actual = 0 */
 	rsp.response = VIRTIO_SCSI_S_OK;
-	resp = vq->iov[vc->out].iov_base;
-	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
-	if (!ret)
+
+	iov_iter_init(&iov_iter, READ, &vq->iov[vc->out], vc->in, sizeof(rsp));
+
+	ret = copy_to_iter(&rsp, sizeof(rsp), &iov_iter);
+	if (likely(ret == sizeof(rsp)))
 		vhost_add_used_and_signal(&vs->dev, vq, vc->head, 0);
 	else
 		pr_err("Faulted on virtio_scsi_ctrl_an_resp\n");
-- 
2.19.1

