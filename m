Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEEAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC7221848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130344;
	bh=eA8J34EKROU0G8wvTI3P1IbXT+bdO8OciHK5AYZ05EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K5XE1V0z2m2vQKgWSYoDwV3peYDkioxrh5d6p2kHv8Hi25T9JNVi816k9MWj4UJRK
	 COE0Bui7xgwA8XiRE9aE48Zl681Egg58ddZ6zWX+v0GoJ2x0Fd8y1ap1AlsE/R46Y+
	 KJzfAyUFWnmX5Cfztz1pQO21EMWQedAU7dv0rOYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfBYVcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbfBYVcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1474321848;
        Mon, 25 Feb 2019 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130340;
        bh=eA8J34EKROU0G8wvTI3P1IbXT+bdO8OciHK5AYZ05EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9s4PPj2tqGwVwV9tWInmPvZvAaO0kDG5hJ/REZMZ8M8ukIUX19YI4IWnRHeeZKWt
         QAKuKApWMP9dlNr3dWXZ0t4RDPygLxpfaN3M6yBQRTRAPmeNOW+8Tj+baJMxaV1eE4
         QvpotlQaXT8fBloWhdVF3ipXBwFnxZF5GRCr3ET4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 089/183] vhost/scsi: Use copy_to_iter() to send control queue response
Date:   Mon, 25 Feb 2019 22:11:02 +0100
Message-Id: <20190225195109.588662602@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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
index 73a4adeab096b..11bd8b6422ebf 100644
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



