Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9974720645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9974720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeJSE6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:58:22 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:42414 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:58:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 137301812B800;
        Thu, 18 Oct 2018 22:55:30 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com,
        hare@suse.de, keescook@chromium.org, bvanassche@acm.org,
        axboe@kernel.dk, jdike@addtoit.com, Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH v2] ubd: remove use of blk_rq_map_sg
Date:   Thu, 18 Oct 2018 22:55:03 +0200
Message-Id: <20181018205503.6206-1-richard@nod.at>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

There is no good reason to create a scatterlist in the ubd driver,
it can just iterate the request directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[rw: Folded in improvements as discussed with hch and jens]
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/ubd_kern.c | 158 +++++++++++++------------------------
 1 file changed, 54 insertions(+), 104 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 9cb0cabb4e02..74c002ddc0ce 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -160,12 +160,6 @@ struct ubd {
 	spinlock_t lock;
 };
=20
-struct ubd_pdu {
-	struct scatterlist sg[MAX_SG];
-	int start_sg, end_sg;
-	sector_t rq_pos;
-};
-
 #define DEFAULT_COW { \
 	.file =3D			NULL, \
 	.fd =3D			-1,	\
@@ -197,9 +191,6 @@ static struct proc_dir_entry *proc_ide =3D NULL;
=20
 static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd);
-static int ubd_init_request(struct blk_mq_tag_set *set,
-			    struct request *req, unsigned int hctx_idx,
-			    unsigned int numa_node);
=20
 static void make_proc_ide(void)
 {
@@ -895,7 +886,6 @@ static int ubd_disk_register(int major, u64 size, int=
 unit,
=20
 static const struct blk_mq_ops ubd_mq_ops =3D {
 	.queue_rq =3D ubd_queue_rq,
-	.init_request =3D ubd_init_request,
 };
=20
 static int ubd_add(int n, char **error_out)
@@ -918,7 +908,6 @@ static int ubd_add(int n, char **error_out)
 	ubd_dev->tag_set.queue_depth =3D 64;
 	ubd_dev->tag_set.numa_node =3D NUMA_NO_NODE;
 	ubd_dev->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
-	ubd_dev->tag_set.cmd_size =3D sizeof(struct ubd_pdu);
 	ubd_dev->tag_set.driver_data =3D ubd_dev;
 	ubd_dev->tag_set.nr_hw_queues =3D 1;
=20
@@ -1300,123 +1289,84 @@ static void cowify_req(struct io_thread_req *req=
, unsigned long *bitmap,
 			   req->bitmap_words, bitmap_len);
 }
=20
-/* Called with dev->lock held */
-static void prepare_request(struct request *req, struct io_thread_req *i=
o_req,
-			    unsigned long long offset, int page_offset,
-			    int len, struct page *page)
+static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request =
*req,
+		u64 off, struct bio_vec *bvec)
 {
-	struct gendisk *disk =3D req->rq_disk;
-	struct ubd *ubd_dev =3D disk->private_data;
-
-	io_req->req =3D req;
-	io_req->fds[0] =3D (ubd_dev->cow.file !=3D NULL) ? ubd_dev->cow.fd :
-		ubd_dev->fd;
-	io_req->fds[1] =3D ubd_dev->fd;
-	io_req->cow_offset =3D -1;
-	io_req->offset =3D offset;
-	io_req->length =3D len;
-	io_req->error =3D 0;
-	io_req->sector_mask =3D 0;
-
-	io_req->op =3D (rq_data_dir(req) =3D=3D READ) ? UBD_READ : UBD_WRITE;
-	io_req->offsets[0] =3D 0;
-	io_req->offsets[1] =3D ubd_dev->cow.data_offset;
-	io_req->buffer =3D page_address(page) + page_offset;
-	io_req->sectorsize =3D 1 << 9;
-
-	if(ubd_dev->cow.file !=3D NULL)
-		cowify_req(io_req, ubd_dev->cow.bitmap,
-			   ubd_dev->cow.bitmap_offset, ubd_dev->cow.bitmap_len);
-
-}
+	struct ubd *dev =3D hctx->queue->queuedata;
+	struct io_thread_req *io_req;
+	int ret;
=20
-/* Called with dev->lock held */
-static void prepare_flush_request(struct request *req,
-				  struct io_thread_req *io_req)
-{
-	struct gendisk *disk =3D req->rq_disk;
-	struct ubd *ubd_dev =3D disk->private_data;
+	io_req =3D kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
+	if (!io_req)
+		return -ENOMEM;
=20
 	io_req->req =3D req;
-	io_req->fds[0] =3D (ubd_dev->cow.file !=3D NULL) ? ubd_dev->cow.fd :
-		ubd_dev->fd;
-	io_req->op =3D UBD_FLUSH;
-}
-
-static void submit_request(struct io_thread_req *io_req, struct ubd *dev=
)
-{
-	int n =3D os_write_file(thread_fd, &io_req,
-			     sizeof(io_req));
+	if (dev->cow.file)
+		io_req->fds[0] =3D dev->cow.fd;
+	else
+		io_req->fds[0] =3D dev->fd;
=20
-	if (n !=3D sizeof(io_req)) {
-		if (n !=3D -EAGAIN)
-			pr_err("write to io thread failed: %d\n", -n);
+	if (req_op(req) =3D=3D REQ_OP_FLUSH) {
+		io_req->op =3D UBD_FLUSH;
+	} else {
+		io_req->fds[1] =3D dev->fd;
+		io_req->cow_offset =3D -1;
+		io_req->offset =3D off;
+		io_req->length =3D bvec->bv_len;
+		io_req->error =3D 0;
+		io_req->sector_mask =3D 0;
+
+		io_req->op =3D rq_data_dir(req) =3D=3D READ ? UBD_READ : UBD_WRITE;
+		io_req->offsets[0] =3D 0;
+		io_req->offsets[1] =3D dev->cow.data_offset;
+		io_req->buffer =3D page_address(bvec->bv_page) + bvec->bv_offset;
+		io_req->sectorsize =3D 1 << 9;
+
+		if (dev->cow.file) {
+			cowify_req(io_req, dev->cow.bitmap,
+				   dev->cow.bitmap_offset, dev->cow.bitmap_len);
+		}
+	}
=20
-		blk_mq_requeue_request(io_req->req, true);
+	ret =3D os_write_file(thread_fd, &io_req, sizeof(io_req));
+	if (ret !=3D sizeof(io_req)) {
+		if (ret !=3D -EAGAIN)
+			pr_err("write to io thread failed: %d\n", -ret);
 		kfree(io_req);
 	}
+
+	return ret;
 }
=20
 static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd)
 {
 	struct request *req =3D bd->rq;
-	struct ubd *dev =3D hctx->queue->queuedata;
-	struct ubd_pdu *pdu =3D blk_mq_rq_to_pdu(req);
-	struct io_thread_req *io_req;
+	int ret =3D 0;
=20
 	blk_mq_start_request(req);
=20
-	pdu->rq_pos =3D blk_rq_pos(req);
-	pdu->start_sg =3D 0;
-	pdu->end_sg =3D blk_rq_map_sg(req->q, req, pdu->sg);
-
 	if (req_op(req) =3D=3D REQ_OP_FLUSH) {
-		io_req =3D kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
-		if (io_req =3D=3D NULL) {
-			blk_mq_requeue_request(req, true);
-			goto done;
+		ret =3D ubd_queue_one_vec(hctx, req, 0, NULL);
+	} else {
+		struct req_iterator iter;
+		struct bio_vec bvec;
+		u64 off =3D (u64)blk_rq_pos(req) << 9;
+
+		rq_for_each_segment(bvec, req, iter) {
+			ret =3D ubd_queue_one_vec(hctx, req, off, &bvec);
+			if (ret < 0)
+				goto out;
+			off +=3D bvec.bv_len;
 		}
-		prepare_flush_request(req, io_req);
-		submit_request(io_req, dev);
-
-		goto done;
 	}
-
-	while (pdu->start_sg < pdu->end_sg) {
-		struct scatterlist *sg =3D &pdu->sg[pdu->start_sg];
-
-		io_req =3D kmalloc(sizeof(struct io_thread_req),
-				 GFP_ATOMIC);
-		if (io_req =3D=3D NULL) {
-			blk_mq_requeue_request(req, true);
-			goto done;
-		}
-		prepare_request(req, io_req,
-				(unsigned long long)pdu->rq_pos << 9,
-				sg->offset, sg->length, sg_page(sg));
-
-		submit_request(io_req, dev);
-
-		pdu->rq_pos +=3D sg->length >> 9;
-		pdu->start_sg++;
+out:
+	if (ret < 0) {
+		blk_mq_requeue_request(req, true);
 	}
-
-done:
 	return BLK_STS_OK;
 }
=20
-static int ubd_init_request(struct blk_mq_tag_set *set,
-			    struct request *req, unsigned int hctx_idx,
-			    unsigned int numa_node)
-{
-	struct ubd_pdu *pdu =3D blk_mq_rq_to_pdu(req);
-
-	sg_init_table(pdu->sg, MAX_SG);
-
-	return 0;
-}
-
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo=
)
 {
 	struct ubd *ubd_dev =3D bdev->bd_disk->private_data;
--=20
2.19.1

