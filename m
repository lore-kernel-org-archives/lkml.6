Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0BBC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857FB206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857FB206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeKTUcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:32:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:50133 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbeKTUcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:32:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0319BC6FB5;
        Tue, 20 Nov 2018 11:04:12 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sMqsq8mWoE3f; Tue, 20 Nov 2018 11:03:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 18910C6FB4;
        Tue, 20 Nov 2018 11:03:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qoxQOdHjuYFx; Tue, 20 Nov 2018 11:03:42 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A60FEC6FB6;
        Tue, 20 Nov 2018 11:03:40 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Subject: [PATCH v3 06/14] [media] marvell-ccic: fix DMA s/g desc number calculation
Date:   Tue, 20 Nov 2018 11:03:11 +0100
Message-Id: <20181120100318.367987-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120100318.367987-1-lkundrak@v3.sk>
References: <20181120100318.367987-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d790b7eda953 ("[media] vb2-dma-sg: move dma_(un)map_sg here")
left dma_desc_nent unset. It previously contained the number of DMA
descriptors as returned from dma_map_sg().

We can now (since the commit referred to above) obtain the same value fro=
m
the sg_table and drop dma_desc_nent altogether.

Tested on OLPC XO-1.75 machine. Doesn't affect the OLPC XO-1's Cafe
driver, since that one doesn't do DMA.

Fixes: d790b7eda953df474f470169ebdf111c02fa7a2d
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/media/platform/marvell-ccic/mcam-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/me=
dia/platform/marvell-ccic/mcam-core.c
index f1b301810260..d97f39bde9bd 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -200,7 +200,6 @@ struct mcam_vb_buffer {
 	struct list_head queue;
 	struct mcam_dma_desc *dma_desc;	/* Descriptor virtual address */
 	dma_addr_t dma_desc_pa;		/* Descriptor physical address */
-	int dma_desc_nent;		/* Number of mapped descriptors */
 };
=20
 static inline struct mcam_vb_buffer *vb_to_mvb(struct vb2_v4l2_buffer *v=
b)
@@ -608,9 +607,11 @@ static void mcam_dma_contig_done(struct mcam_camera =
*cam, int frame)
 static void mcam_sg_next_buffer(struct mcam_camera *cam)
 {
 	struct mcam_vb_buffer *buf;
+	struct sg_table *sg_table;
=20
 	buf =3D list_first_entry(&cam->buffers, struct mcam_vb_buffer, queue);
 	list_del_init(&buf->queue);
+	sg_table =3D vb2_dma_sg_plane_desc(&buf->vb_buf.vb2_buf, 0);
 	/*
 	 * Very Bad Not Good Things happen if you don't clear
 	 * C1_DESC_ENA before making any descriptor changes.
@@ -618,7 +619,7 @@ static void mcam_sg_next_buffer(struct mcam_camera *c=
am)
 	mcam_reg_clear_bit(cam, REG_CTRL1, C1_DESC_ENA);
 	mcam_reg_write(cam, REG_DMA_DESC_Y, buf->dma_desc_pa);
 	mcam_reg_write(cam, REG_DESC_LEN_Y,
-			buf->dma_desc_nent*sizeof(struct mcam_dma_desc));
+			sg_table->nents*sizeof(struct mcam_dma_desc));
 	mcam_reg_write(cam, REG_DESC_LEN_U, 0);
 	mcam_reg_write(cam, REG_DESC_LEN_V, 0);
 	mcam_reg_set_bit(cam, REG_CTRL1, C1_DESC_ENA);
--=20
2.19.1

