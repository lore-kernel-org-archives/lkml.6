Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BF0219ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BF0219ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeHFPZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:25:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFPZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:25:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C28808197010;
        Mon,  6 Aug 2018 13:16:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A00461010427;
        Mon,  6 Aug 2018 13:16:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/10] iov_iter: Separate type from direction and use
 accessor functions
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:16:45 +0100
Message-ID: <153356140509.1195.11512380128357403468.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 13:16:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 13:16:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the iov_iter struct, separate the iterator type from the iterator
direction and use accessor functions to access them in most places.

Convert a bunch of places to use switch-statements to access them rather
then chains of bitwise-AND statements.  This makes it easier to add further
iterator types.  Also, this can be more efficient as to implement a switch
of small contiguous integers, the compiler can use ~50% fewer compare
instructions than it has to use bitwise-and instructions.

Further, cease passing the iterator type into the iterator setup function.
The iterator function can set that itself.  Only the direction is required.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 block/bio.c                              |    2 
 drivers/block/drbd/drbd_main.c           |    2 
 drivers/block/drbd/drbd_receiver.c       |    2 
 drivers/block/loop.c                     |    9 +-
 drivers/block/nbd.c                      |   12 +-
 drivers/isdn/mISDN/l1oip_core.c          |    3 -
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |    6 +
 drivers/nvme/target/io-cmd-file.c        |    2 
 drivers/target/iscsi/iscsi_target_util.c |    6 -
 drivers/target/target_core_file.c        |    6 +
 drivers/usb/usbip/usbip_common.c         |    2 
 drivers/xen/pvcalls-back.c               |    8 +-
 fs/9p/vfs_addr.c                         |    4 -
 fs/9p/vfs_dir.c                          |    2 
 fs/9p/xattr.c                            |    4 -
 fs/afs/rxrpc.c                           |   15 +--
 fs/block_dev.c                           |    2 
 fs/ceph/file.c                           |    7 +
 fs/cifs/connect.c                        |    4 -
 fs/cifs/file.c                           |    4 -
 fs/cifs/misc.c                           |    4 -
 fs/cifs/smb2ops.c                        |    4 -
 fs/cifs/smbdirect.c                      |   17 +++
 fs/cifs/transport.c                      |    8 +-
 fs/direct-io.c                           |    2 
 fs/dlm/lowcomms.c                        |    2 
 fs/fuse/file.c                           |    2 
 fs/iomap.c                               |    2 
 fs/nfsd/vfs.c                            |    4 -
 fs/ocfs2/cluster/tcp.c                   |    2 
 fs/orangefs/inode.c                      |    2 
 fs/splice.c                              |    7 +
 include/linux/uio.h                      |   49 ++++++----
 lib/iov_iter.c                           |  154 ++++++++++++++++++------------
 mm/filemap.c                             |    2 
 mm/page_io.c                             |    2 
 net/9p/client.c                          |    2 
 net/9p/trans_virtio.c                    |    2 
 net/bluetooth/6lowpan.c                  |    2 
 net/bluetooth/a2mp.c                     |    2 
 net/bluetooth/smp.c                      |    2 
 net/ceph/messenger.c                     |    6 +
 net/netfilter/ipvs/ip_vs_sync.c          |    2 
 net/smc/smc_clc.c                        |    4 -
 net/socket.c                             |    6 +
 net/sunrpc/svcsock.c                     |    2 
 net/tipc/topsrv.c                        |    2 
 net/tls/tls_device.c                     |    4 -
 net/tls/tls_sw.c                         |    4 -
 49 files changed, 223 insertions(+), 182 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 047c5dca6d90..df999480c0f4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1330,7 +1330,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 	/*
 	 * success
 	 */
-	if (((iter->type & WRITE) && (!map_data || !map_data->null_mapped)) ||
+	if ((iov_iter_rw(iter) == WRITE && (!map_data || !map_data->null_mapped)) ||
 	    (map_data && map_data->from_user)) {
 		ret = bio_copy_from_iter(bio, iter);
 		if (ret)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a80809bd3057..53d840ab1df2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1856,7 +1856,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 
 	/* THINK  if (signal_pending) return ... ? */
 
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, WRITE, &iov, 1, size);
 
 	if (sock == connection->data.socket) {
 		rcu_read_lock();
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index be9450f5ad1c..d1b05e124325 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -516,7 +516,7 @@ static int drbd_recv_short(struct socket *sock, void *buf, size_t size, int flag
 	struct msghdr msg = {
 		.msg_flags = (flags ? flags : MSG_WAITALL | MSG_NOSIGNAL)
 	};
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
 	return sock_recvmsg(sock, &msg, msg.msg_flags);
 }
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4cb1d1be3cfb..13598884a787 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -268,7 +268,7 @@ static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 	struct iov_iter i;
 	ssize_t bw;
 
-	iov_iter_bvec(&i, ITER_BVEC | WRITE, bvec, 1, bvec->bv_len);
+	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
 
 	file_start_write(file);
 	bw = vfs_iter_write(file, &i, ppos, 0);
@@ -346,7 +346,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	ssize_t len;
 
 	rq_for_each_segment(bvec, rq, iter) {
-		iov_iter_bvec(&i, ITER_BVEC, &bvec, 1, bvec.bv_len);
+		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0)
 			return len;
@@ -387,7 +387,7 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 		b.bv_offset = 0;
 		b.bv_len = bvec.bv_len;
 
-		iov_iter_bvec(&i, ITER_BVEC, &b, 1, b.bv_len);
+		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
 		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
 		if (len < 0) {
 			ret = len;
@@ -554,8 +554,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, ITER_BVEC | rw, bvec,
-		      segments, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, rw, bvec, segments, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3863c00372bb..3e5fb3decdce 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -473,7 +473,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
 
-	iov_iter_kvec(&from, WRITE | ITER_KVEC, &iov, 1, sizeof(request));
+	iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
 
 	switch (req_op(req)) {
 	case REQ_OP_DISCARD:
@@ -564,8 +564,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				req, bvec.bv_len);
-			iov_iter_bvec(&from, ITER_BVEC | WRITE,
-				      &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&from, WRITE, &bvec, 1, bvec.bv_len);
 			if (skip) {
 				if (skip >= iov_iter_count(&from)) {
 					skip -= iov_iter_count(&from);
@@ -624,7 +623,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 	int ret = 0;
 
 	reply.magic = 0;
-	iov_iter_kvec(&to, READ | ITER_KVEC, &iov, 1, sizeof(reply));
+	iov_iter_kvec(&to, READ, &iov, 1, sizeof(reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 	if (result <= 0) {
 		if (!nbd_disconnected(config))
@@ -678,8 +677,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		struct bio_vec bvec;
 
 		rq_for_each_segment(bvec, req, iter) {
-			iov_iter_bvec(&to, ITER_BVEC | READ,
-				      &bvec, 1, bvec.bv_len);
+			iov_iter_bvec(&to, READ, &bvec, 1, bvec.bv_len);
 			result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
 			if (result <= 0) {
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
@@ -1073,7 +1071,7 @@ static void send_disconnects(struct nbd_device *nbd)
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
 
-		iov_iter_kvec(&from, WRITE | ITER_KVEC, &iov, 1, sizeof(request));
+		iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
 		mutex_lock(&nsock->tx_lock);
 		ret = sock_xmit(nbd, i, 1, &from, 0, NULL);
 		if (ret <= 0)
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index b05022f94f18..072bb5e36c18 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -718,8 +718,7 @@ l1oip_socket_thread(void *data)
 		printk(KERN_DEBUG "%s: socket created and open\n",
 		       __func__);
 	while (!signal_pending(current)) {
-		iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &iov, 1,
-				recvbuf_size);
+		iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, recvbuf_size);
 		recvlen = sock_recvmsg(socket, &msg, 0);
 		if (recvlen > 0) {
 			l1oip_socket_parse(hc, &sin_rx, recvbuf, recvlen);
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index b4d7774cfe07..a7fb26246385 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -3035,7 +3035,7 @@ ssize_t vmci_qpair_enqueue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&from, WRITE | ITER_KVEC, &v, 1, buf_size);
+	iov_iter_kvec(&from, WRITE, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3079,7 +3079,7 @@ ssize_t vmci_qpair_dequeue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &v, 1, buf_size);
+	iov_iter_kvec(&to, READ, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3124,7 +3124,7 @@ ssize_t vmci_qpair_peek(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &v, 1, buf_size);
+	iov_iter_kvec(&to, READ, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 8c42b3a8c420..ba05278b21b2 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -96,7 +96,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		rw = READ;
 	}
 
-	iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, nr_segs, count);
+	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
 
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 4435bf374d2d..c86039c0fbc1 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1249,8 +1249,7 @@ static int iscsit_do_rx_data(
 		return -1;
 
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC,
-		      count->iov, count->iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, READ, count->iov, count->iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		rx_loop = sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
@@ -1306,8 +1305,7 @@ int tx_data(
 
 	memset(&msg, 0, sizeof(struct msghdr));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC,
-		      iov, iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, WRITE, iov, iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		int tx_loop = sock_sendmsg(conn->sock, &msg);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 16751ae55d7b..49b110d1b972 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -303,7 +303,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		len += sg->length;
 	}
 
-	iov_iter_bvec(&iter, ITER_BVEC | is_write, bvec, sgl_nents, len);
+	iov_iter_bvec(&iter, is_write, bvec, sgl_nents, len);
 
 	aio_cmd->cmd = cmd;
 	aio_cmd->len = len;
@@ -353,7 +353,7 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 		len += sg->length;
 	}
 
-	iov_iter_bvec(&iter, ITER_BVEC, bvec, sgl_nents, len);
+	iov_iter_bvec(&iter, READ, bvec, sgl_nents, len);
 	if (is_write)
 		ret = vfs_iter_write(fd, &iter, &pos, 0);
 	else
@@ -490,7 +490,7 @@ fd_execute_write_same(struct se_cmd *cmd)
 		len += se_dev->dev_attrib.block_size;
 	}
 
-	iov_iter_bvec(&iter, ITER_BVEC, bvec, nolb, len);
+	iov_iter_bvec(&iter, READ, bvec, nolb, len);
 	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
 
 	kfree(bvec);
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index 9756752c0681..45da3e01c7b0 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -309,7 +309,7 @@ int usbip_recv(struct socket *sock, void *buf, int size)
 	if (!sock || !buf || !size)
 		return -EINVAL;
 
-	iov_iter_kvec(&msg.msg_iter, READ|ITER_KVEC, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, size);
 
 	usbip_dbg_xmit("enter\n");
 
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index b1092fbefa63..2e5d845b5091 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -137,13 +137,13 @@ static void pvcalls_conn_back_read(void *opaque)
 	if (masked_prod < masked_cons) {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = wanted;
-		iov_iter_kvec(&msg.msg_iter, ITER_KVEC|WRITE, vec, 1, wanted);
+		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, wanted);
 	} else {
 		vec[0].iov_base = data->in + masked_prod;
 		vec[0].iov_len = array_size - masked_prod;
 		vec[1].iov_base = data->in;
 		vec[1].iov_len = wanted - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, ITER_KVEC|WRITE, vec, 2, wanted);
+		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 2, wanted);
 	}
 
 	atomic_set(&map->read, 0);
@@ -195,13 +195,13 @@ static void pvcalls_conn_back_write(struct sock_mapping *map)
 	if (pvcalls_mask(prod, array_size) > pvcalls_mask(cons, array_size)) {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = size;
-		iov_iter_kvec(&msg.msg_iter, ITER_KVEC|READ, vec, 1, size);
+		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, size);
 	} else {
 		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
 		vec[0].iov_len = array_size - pvcalls_mask(cons, array_size);
 		vec[1].iov_base = data->out;
 		vec[1].iov_len = size - vec[0].iov_len;
-		iov_iter_kvec(&msg.msg_iter, ITER_KVEC|READ, vec, 2, size);
+		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, size);
 	}
 
 	atomic_set(&map->write, 0);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index e1cbdfdb7c68..0bcbcc20f769 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -65,7 +65,7 @@ static int v9fs_fid_readpage(struct p9_fid *fid, struct page *page)
 	if (retval == 0)
 		return retval;
 
-	iov_iter_bvec(&to, ITER_BVEC | READ, &bvec, 1, PAGE_SIZE);
+	iov_iter_bvec(&to, READ, &bvec, 1, PAGE_SIZE);
 
 	retval = p9_client_read(fid, page_offset(page), &to, &err);
 	if (err) {
@@ -175,7 +175,7 @@ static int v9fs_vfs_writepage_locked(struct page *page)
 	bvec.bv_page = page;
 	bvec.bv_offset = 0;
 	bvec.bv_len = len;
-	iov_iter_bvec(&from, ITER_BVEC | WRITE, &bvec, 1, len);
+	iov_iter_bvec(&from, WRITE, &bvec, 1, len);
 
 	/* We should have writeback_fid always set */
 	BUG_ON(!v9inode->writeback_fid);
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index b0405d6aac85..d5db3c968a03 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -133,7 +133,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
 			int n;
-			iov_iter_kvec(&to, READ | ITER_KVEC, &kvec, 1, buflen);
+			iov_iter_kvec(&to, READ, &kvec, 1, buflen);
 			n = p9_client_read(file->private_data, ctx->pos, &to,
 					   &err);
 			if (err)
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index f329eee6dc93..92ed5ecfafd1 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -32,7 +32,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	struct iov_iter to;
 	int err;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &kvec, 1, buffer_size);
+	iov_iter_kvec(&to, READ, &kvec, 1, buffer_size);
 
 	attr_fid = p9_client_xattrwalk(fid, name, &attr_size);
 	if (IS_ERR(attr_fid)) {
@@ -107,7 +107,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 	struct iov_iter from;
 	int retval;
 
-	iov_iter_kvec(&from, WRITE | ITER_KVEC, &kvec, 1, value_len);
+	iov_iter_kvec(&from, WRITE, &kvec, 1, value_len);
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 19db5f672a9d..55441af2de53 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -286,7 +286,7 @@ static void afs_load_bvec(struct afs_call *call, struct msghdr *msg,
 		offset = 0;
 	}
 
-	iov_iter_bvec(&msg->msg_iter, WRITE | ITER_BVEC, bv, nr, bytes);
+	iov_iter_bvec(&msg->msg_iter, WRITE, bv, nr, bytes);
 }
 
 /*
@@ -401,8 +401,7 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iov, 1,
-		      call->request_size);
+	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->send_pages ? MSG_MORE : 0);
@@ -432,7 +431,7 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret, "KSD");
 	} else {
-		iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, NULL, 0, 0);
+		iov_iter_kvec(&msg.msg_iter, READ, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
 				       &msg.msg_iter, false,
 				       &call->abort_code, &call->service_id);
@@ -468,7 +467,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
 			struct iov_iter iter;
 
-			iov_iter_kvec(&iter, READ | ITER_KVEC, NULL, 0, 0);
+			iov_iter_kvec(&iter, READ, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
 						     call->rxcall, &iter, false,
 						     &remote_abort,
@@ -827,7 +826,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, NULL, 0, 0);
+	iov_iter_kvec(&msg.msg_iter, WRITE, NULL, 0, 0);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -866,7 +865,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	iov[0].iov_len		= len;
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -907,7 +906,7 @@ int afs_extract_data(struct afs_call *call, void *buf, size_t count,
 
 	iov.iov_base = buf + call->offset;
 	iov.iov_len = count - call->offset;
-	iov_iter_kvec(&iter, ITER_KVEC | READ, &iov, 1, count - call->offset);
+	iov_iter_kvec(&iter, READ, &iov, 1, count - call->offset);
 
 	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, &iter,
 				     want_more, &remote_abort,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7dc135204722..aa54c91df73e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	dio->size = 0;
 	dio->multi_bio = false;
-	dio->should_dirty = is_read && (iter->type == ITER_IOVEC);
+	dio->should_dirty = is_read && iter_is_iovec(iter);
 
 	blk_start_plug(&plug);
 	for (;;) {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ad0bed99b1d5..f0ddb0dc4f16 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -659,7 +659,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	if (ret < 0)
 		return ret;
 
-	if (unlikely(to->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(to))) {
 		size_t page_off;
 		ret = iov_iter_get_pages_alloc(to, &pages, len,
 					       &page_off);
@@ -822,7 +822,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 				aio_req->total_len = rc + zlen;
 			}
 
-			iov_iter_bvec(&i, ITER_BVEC, osd_data->bvec_pos.bvecs,
+			iov_iter_bvec(&i, READ, osd_data->bvec_pos.bvecs,
 				      osd_data->num_bvecs,
 				      osd_data->bvec_pos.iter.bi_size);
 			iov_iter_advance(&i, rc);
@@ -1045,8 +1045,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, ITER_BVEC, bvecs, num_pages,
-					      len);
+				iov_iter_bvec(&i, READ, bvecs, num_pages, len);
 				iov_iter_advance(&i, ret);
 				iov_iter_zero(zlen, &i);
 				ret += zlen;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 5df2c0698cda..b3feb2c6db5b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -589,7 +589,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 {
 	struct msghdr smb_msg;
 	struct kvec iov = {.iov_base = buf, .iov_len = to_read};
-	iov_iter_kvec(&smb_msg.msg_iter, READ | ITER_KVEC, &iov, 1, to_read);
+	iov_iter_kvec(&smb_msg.msg_iter, READ, &iov, 1, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -601,7 +601,7 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	struct msghdr smb_msg;
 	struct bio_vec bv = {
 		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
-	iov_iter_bvec(&smb_msg.msg_iter, READ | ITER_BVEC, &bv, 1, to_read);
+	iov_iter_bvec(&smb_msg.msg_iter, READ, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 8d41ca7bfcf1..dcdbcb6f09f8 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2990,7 +2990,7 @@ cifs_readdata_to_iov(struct cifs_readdata *rdata, struct iov_iter *iter)
 		size_t copy = min_t(size_t, remaining, PAGE_SIZE);
 		size_t written;
 
-		if (unlikely(iter->type & ITER_PIPE)) {
+		if (unlikely(iov_iter_is_pipe(iter))) {
 			void *addr = kmap_atomic(page);
 
 			written = copy_to_iter(addr, copy, iter);
@@ -3302,7 +3302,7 @@ ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
 
-	if (to->type == ITER_IOVEC)
+	if (iter_is_iovec(to))
 		ctx->should_dirty = true;
 
 	rc = setup_aio_ctx_iter(ctx, to, READ);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 53e8362cbc4a..65540d33993e 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -780,7 +780,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 	struct page **pages = NULL;
 	struct bio_vec *bv = NULL;
 
-	if (iter->type & ITER_KVEC) {
+	if (iov_iter_type(iter) == ITER_KVEC) {
 		memcpy(&ctx->iter, iter, sizeof(struct iov_iter));
 		ctx->len = count;
 		iov_iter_advance(iter, count);
@@ -851,7 +851,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 	ctx->bv = bv;
 	ctx->len = saved_len - count;
 	ctx->npages = npages;
-	iov_iter_bvec(&ctx->iter, ITER_BVEC | rw, ctx->bv, npages, ctx->len);
+	iov_iter_bvec(&ctx->iter, rw, ctx->bv, npages, ctx->len);
 	return 0;
 }
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index ea92a38b2f08..3e6fe3943591 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2769,13 +2769,13 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		iov_iter_bvec(&iter, WRITE | ITER_BVEC, bvec, npages, data_len);
+		iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(npages > 0, "read data can be either in buf or in pages");
 		iov.iov_base = buf + data_offset;
 		iov.iov_len = data_len;
-		iov_iter_kvec(&iter, WRITE | ITER_KVEC, &iov, 1, data_len);
+		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index c55ea4e6201b..10307b46222d 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2047,14 +2047,22 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 
 	info->smbd_recv_pending++;
 
-	switch (msg->msg_iter.type) {
-	case READ | ITER_KVEC:
+	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
+		/* It's a bug in upper layer to get there */
+		cifs_dbg(VFS, "CIFS: invalid msg iter dir %u\n",
+			 iov_iter_rw(&msg->msg_iter));
+		rc = -EINVAL;
+		goto out;
+	}
+	
+	switch (iov_iter_type(&msg->msg_iter)) {
+	case ITER_KVEC:
 		buf = msg->msg_iter.kvec->iov_base;
 		to_read = msg->msg_iter.kvec->iov_len;
 		rc = smbd_recv_buf(info, buf, to_read);
 		break;
 
-	case READ | ITER_BVEC:
+	case ITER_BVEC:
 		page = msg->msg_iter.bvec->bv_page;
 		page_offset = msg->msg_iter.bvec->bv_offset;
 		to_read = msg->msg_iter.bvec->bv_len;
@@ -2064,10 +2072,11 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 	default:
 		/* It's a bug in upper layer to get there */
 		cifs_dbg(VFS, "CIFS: invalid msg type %d\n",
-			msg->msg_iter.type);
+			 iov_iter_type(&msg->msg_iter));
 		rc = -EINVAL;
 	}
 
+out:
 	info->smbd_recv_pending--;
 	wake_up(&info->wait_smbd_recv_pending);
 
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index a341ec839c83..4781de558ab1 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -297,8 +297,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			.iov_base = &rfc1002_marker,
 			.iov_len  = 4
 		};
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE | ITER_KVEC, &hiov,
-			      1, 4);
+		iov_iter_kvec(&smb_msg.msg_iter, WRITE, &hiov, 1, 4);
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
 			goto uncork;
@@ -319,8 +318,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			size += iov[i].iov_len;
 		}
 
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE | ITER_KVEC,
-			      iov, n_vec, size);
+		iov_iter_kvec(&smb_msg.msg_iter, WRITE, iov, n_vec, size);
 
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
@@ -336,7 +334,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
 					     &bvec.bv_offset);
 
-			iov_iter_bvec(&smb_msg.msg_iter, WRITE | ITER_BVEC,
+			iov_iter_bvec(&smb_msg.msg_iter, WRITE,
 				      &bvec, 1, bvec.bv_len);
 			rc = smb_send_kvec(server, &smb_msg, &sent);
 			if (rc < 0)
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 093fb54cd316..989f30cc0d09 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1313,7 +1313,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	spin_lock_init(&dio->bio_lock);
 	dio->refcount = 1;
 
-	dio->should_dirty = (iter->type == ITER_IOVEC);
+	dio->should_dirty = iter_is_iovec(iter);
 	sdio.iter = iter;
 	sdio.final_block_in_request = end >> blkbits;
 
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index a5e4a221435c..76976d6e50f9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -674,7 +674,7 @@ static int receive_from_sock(struct connection *con)
 		nvec = 2;
 	}
 	len = iov[0].iov_len + iov[1].iov_len;
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, iov, nvec, len);
+	iov_iter_kvec(&msg.msg_iter, READ, iov, nvec, len);
 
 	r = ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT | MSG_NOSIGNAL);
 	if (ret <= 0)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a201fb0ac64f..fd01af7664e8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1269,7 +1269,7 @@ static int fuse_get_user_pages(struct fuse_req *req, struct iov_iter *ii,
 	ssize_t ret = 0;
 
 	/* Special case for kernel I/O: can copy directly into the buffer */
-	if (ii->type & ITER_KVEC) {
+	if (iov_iter_type(ii) == ITER_KVEC) {
 		unsigned long user_addr = fuse_get_user_addr(ii);
 		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
 
diff --git a/fs/iomap.c b/fs/iomap.c
index 0d0bd8845586..ad374c9530c3 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1143,7 +1143,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (pos >= dio->i_size)
 			goto out_free_dio;
 
-		if (iter->type == ITER_IOVEC)
+		if (iter_is_iovec(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
 		flags |= IOMAP_WRITE;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b0555d7d8200..ad61520c8078 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -922,7 +922,7 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int host_err;
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, READ | ITER_KVEC, vec, vlen, *count);
+	iov_iter_kvec(&iter, READ, vec, vlen, *count);
 	host_err = vfs_iter_read(file, &iter, &offset, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, host_err);
 }
@@ -998,7 +998,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 	if (stable && !use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, WRITE | ITER_KVEC, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0)
 		goto out_nfserr;
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 1296f78ae966..04b651c8309c 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -918,7 +918,7 @@ static int o2net_recv_tcp_msg(struct socket *sock, void *data, size_t len)
 {
 	struct kvec vec = { .iov_len = len, .iov_base = data, };
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT, };
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, len);
+	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, len);
 	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 6e4d2af8f5bc..90815360075a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -25,7 +25,7 @@ static int read_one_page(struct page *page)
 	struct iov_iter to;
 	struct bio_vec bv = {.bv_page = page, .bv_len = PAGE_SIZE};
 
-	iov_iter_bvec(&to, ITER_BVEC | READ, &bv, 1, PAGE_SIZE);
+	iov_iter_bvec(&to, READ, &bv, 1, PAGE_SIZE);
 
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		    "orangefs_readpage called with page %p\n",
diff --git a/fs/splice.c b/fs/splice.c
index b3daa971f597..3553f1956508 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -301,7 +301,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	int idx, ret;
 
-	iov_iter_pipe(&to, ITER_PIPE | READ, pipe, len);
+	iov_iter_pipe(&to, READ, pipe, len);
 	idx = to.idx;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
@@ -386,7 +386,7 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	 */
 	offset = *ppos & ~PAGE_MASK;
 
-	iov_iter_pipe(&to, ITER_PIPE | READ, pipe, len + offset);
+	iov_iter_pipe(&to, READ, pipe, len + offset);
 
 	res = iov_iter_get_pages_alloc(&to, &pages, len + offset, &base);
 	if (res <= 0)
@@ -745,8 +745,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 			left -= this_len;
 		}
 
-		iov_iter_bvec(&from, ITER_BVEC | WRITE, array, n,
-			      sd.total_len - left);
+		iov_iter_bvec(&from, WRITE, array, n, sd.total_len - left);
 		ret = vfs_iter_write(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 409c845d4cd3..48e7fa36f923 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -21,7 +21,7 @@ struct kvec {
 	size_t iov_len;
 };
 
-enum {
+enum iter_type {
 	ITER_IOVEC = 0,
 	ITER_KVEC = 2,
 	ITER_BVEC = 4,
@@ -29,7 +29,8 @@ enum {
 };
 
 struct iov_iter {
-	int type;
+	enum iter_type iter_type:8;
+	u8 iter_dir;
 	size_t iov_offset;
 	size_t count;
 	union {
@@ -47,6 +48,26 @@ struct iov_iter {
 	};
 };
 
+static inline enum iter_type iov_iter_type(const struct iov_iter *i)
+{
+	return i->iter_type;
+}
+
+static inline bool iov_iter_is_pipe(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_PIPE;
+}
+
+static inline bool iter_is_iovec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_IOVEC;
+}
+
+static inline unsigned char iov_iter_rw(const struct iov_iter *i)
+{
+	return i->iter_dir;
+}
+
 /*
  * Total number of bytes covered by an iovec.
  *
@@ -74,7 +95,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 }
 
 #define iov_for_each(iov, iter, start)				\
-	if (!((start).type & (ITER_BVEC | ITER_PIPE)))		\
+	if (iov_iter_type(start) == ITER_IOVEC ||		\
+	    iov_iter_type(start) == ITER_KVEC)			\
 	for (iter = (start);					\
 	     (iter).count &&					\
 	     ((iov = iov_iter_iovec(&(iter))), 1);		\
@@ -181,13 +203,13 @@ size_t copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i)
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
-void iov_iter_init(struct iov_iter *i, int direction, const struct iovec *iov,
+void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
 			unsigned long nr_segs, size_t count);
-void iov_iter_kvec(struct iov_iter *i, int direction, const struct kvec *kvec,
+void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_bvec(struct iov_iter *i, int direction, const struct bio_vec *bvec,
+void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_pipe(struct iov_iter *i, int direction, struct pipe_inode_info *pipe,
+void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
 			size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
@@ -202,19 +224,6 @@ static inline size_t iov_iter_count(const struct iov_iter *i)
 	return i->count;
 }
 
-static inline bool iter_is_iovec(const struct iov_iter *i)
-{
-	return !(i->type & (ITER_BVEC | ITER_KVEC | ITER_PIPE));
-}
-
-/*
- * Get one of READ or WRITE out of iter->type without any other flags OR'd in
- * with it.
- *
- * The ?: is just for type safety.
- */
-#define iov_iter_rw(i) ((0 ? (struct iov_iter *)0 : (i))->type & (READ | WRITE))
-
 /*
  * Cap the iov_iter by given limit; note that the second argument is
  * *not* the new size - it's upper limit for such.  Passing it a value
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8be175df3075..bd828591afb0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -75,11 +75,11 @@
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (unlikely(i->iter_type & ITER_BVEC)) {	\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
 			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (unlikely(i->iter_type & ITER_KVEC)) { \
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
@@ -96,7 +96,7 @@
 		n = i->count;					\
 	if (i->count) {						\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (unlikely(i->iter_type & ITER_BVEC)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
@@ -104,7 +104,7 @@
 			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
 			i->nr_segs -= i->bvec - bvec;		\
 			skip = __bi.bi_bvec_done;		\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (unlikely(i->iter_type & ITER_KVEC)) {	\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
@@ -417,28 +417,35 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 	int err;
 	struct iovec v;
 
-	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
+	switch (iov_iter_type(i)) {
+	case ITER_IOVEC:
+	case ITER_PIPE:
 		iterate_iovec(i, bytes, v, iov, skip, ({
 			err = fault_in_pages_readable(v.iov_base, v.iov_len);
 			if (unlikely(err))
 			return err;
 		0;}))
+		break;
+	case ITER_KVEC:
+	case ITER_BVEC:
+		break;
 	}
 	return 0;
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
-void iov_iter_init(struct iov_iter *i, int direction,
+void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
 {
 	/* It will get better.  Eventually... */
 	if (uaccess_kernel()) {
-		direction |= ITER_KVEC;
-		i->type = direction;
+		i->iter_type = ITER_KVEC;
+		i->iter_dir = direction;
 		i->kvec = (struct kvec *)iov;
 	} else {
-		i->type = direction;
+		i->iter_type = ITER_IOVEC;
+		i->iter_dir = direction;
 		i->iov = iov;
 	}
 	i->nr_segs = nr_segs;
@@ -558,7 +565,7 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
@@ -658,7 +665,7 @@ size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 	const char *from = addr;
 	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter_mcsafe(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
@@ -692,7 +699,7 @@ EXPORT_SYMBOL_GPL(_copy_to_iter_mcsafe);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -712,7 +719,7 @@ EXPORT_SYMBOL(_copy_from_iter);
 bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -739,7 +746,7 @@ EXPORT_SYMBOL(_copy_from_iter_full);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -773,7 +780,7 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -794,7 +801,7 @@ EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -831,15 +838,20 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	switch (iov_iter_type(i)) {
+	case ITER_BVEC:
+	case ITER_KVEC: {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else if (likely(!(i->type & ITER_PIPE)))
+	}
+	case ITER_IOVEC:
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
-	else
+	case ITER_PIPE:
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	}
+	BUG();
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
@@ -848,17 +860,21 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (unlikely(i->type & ITER_PIPE)) {
-		WARN_ON(1);
-		return 0;
-	}
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE:
+		break;
+	case ITER_BVEC:
+	case ITER_KVEC: {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else
+	}
+	case ITER_IOVEC:
 		return copy_page_from_iter_iovec(page, offset, bytes, i);
+	}
+	WARN_ON(1);
+	return 0;
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
@@ -888,7 +904,7 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 
 size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
@@ -908,7 +924,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		kunmap_atomic(kaddr);
 		WARN_ON(1);
 		return 0;
@@ -972,7 +988,7 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		pipe_advance(i, size);
 		return;
 	}
@@ -987,7 +1003,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	if (WARN_ON(unroll > MAX_RW_COUNT))
 		return;
 	i->count += unroll;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
 		int idx = i->idx;
 		size_t off = i->iov_offset;
@@ -1016,7 +1032,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (i->type & ITER_BVEC) {
+	switch (iov_iter_type(i)) {
+	case ITER_BVEC: {
 		const struct bio_vec *bvec = i->bvec;
 		while (1) {
 			size_t n = (--bvec)->bv_len;
@@ -1028,7 +1045,10 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			}
 			unroll -= n;
 		}
-	} else { /* same logics for iovec and kvec */
+	}
+	case ITER_IOVEC:
+	case ITER_KVEC: {
+		/* same logics for iovec and kvec */
 		const struct iovec *iov = i->iov;
 		while (1) {
 			size_t n = (--iov)->iov_len;
@@ -1041,6 +1061,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			unroll -= n;
 		}
 	}
+	case ITER_PIPE:
+		BUG();
+	}
 }
 EXPORT_SYMBOL(iov_iter_revert);
 
@@ -1049,23 +1072,28 @@ EXPORT_SYMBOL(iov_iter_revert);
  */
 size_t iov_iter_single_seg_count(const struct iov_iter *i)
 {
-	if (unlikely(i->type & ITER_PIPE))
-		return i->count;	// it is a silly place, anyway
 	if (i->nr_segs == 1)
 		return i->count;
-	else if (i->type & ITER_BVEC)
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE:
+		return i->count;	// it is a silly place, anyway
+	case ITER_BVEC:
 		return min(i->count, i->bvec->bv_len - i->iov_offset);
-	else
+	case ITER_KVEC:
+	case ITER_IOVEC:
 		return min(i->count, i->iov->iov_len - i->iov_offset);
+	}
+	BUG();
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
 
-void iov_iter_kvec(struct iov_iter *i, int direction,
+void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 			const struct kvec *kvec, unsigned long nr_segs,
 			size_t count)
 {
-	BUG_ON(!(direction & ITER_KVEC));
-	i->type = direction;
+	BUG_ON(direction & ~1);
+	i->iter_dir = direction;
+	i->iter_type = ITER_KVEC;
 	i->kvec = kvec;
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
@@ -1073,12 +1101,13 @@ void iov_iter_kvec(struct iov_iter *i, int direction,
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
-void iov_iter_bvec(struct iov_iter *i, int direction,
+void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 			const struct bio_vec *bvec, unsigned long nr_segs,
 			size_t count)
 {
-	BUG_ON(!(direction & ITER_BVEC));
-	i->type = direction;
+	BUG_ON(direction & ~1);
+	i->iter_dir = direction;
+	i->iter_type = ITER_BVEC;
 	i->bvec = bvec;
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
@@ -1086,13 +1115,14 @@ void iov_iter_bvec(struct iov_iter *i, int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
-void iov_iter_pipe(struct iov_iter *i, int direction,
+void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 			struct pipe_inode_info *pipe,
 			size_t count)
 {
-	BUG_ON(direction != ITER_PIPE);
+	BUG_ON(direction != READ);
 	WARN_ON(pipe->nrbufs == pipe->buffers);
-	i->type = direction;
+	i->iter_dir = READ;
+	i->iter_type = ITER_PIPE;
 	i->pipe = pipe;
 	i->idx = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
 	i->iov_offset = 0;
@@ -1106,7 +1136,7 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->idx]))
 			return size | i->iov_offset;
 		return size;
@@ -1125,7 +1155,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return ~0U;
 	}
@@ -1193,7 +1223,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
@@ -1205,7 +1235,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 			len = maxpages * PAGE_SIZE;
 		addr &= ~(PAGE_SIZE - 1);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n, (i->type & WRITE) != WRITE, pages);
+		res = get_user_pages_fast(addr, n, iov_iter_rw(i) != WRITE, pages);
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1270,7 +1300,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
@@ -1283,7 +1313,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, (i->type & WRITE) != WRITE, p);
+		res = get_user_pages_fast(addr, n, iov_iter_rw(i) != WRITE, p);
 		if (unlikely(res < 0)) {
 			kvfree(p);
 			return res;
@@ -1313,7 +1343,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -1355,7 +1385,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -1400,7 +1430,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
@@ -1443,7 +1473,7 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	if (!size)
 		return 0;
 
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
 		size_t off;
 		int idx;
@@ -1481,19 +1511,23 @@ EXPORT_SYMBOL(iov_iter_npages);
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
-	if (unlikely(new->type & ITER_PIPE)) {
-		WARN_ON(1);
-		return NULL;
-	}
-	if (new->type & ITER_BVEC)
+	switch (iov_iter_type(new)) {
+	case ITER_PIPE:
+		break;
+	case ITER_BVEC:
 		return new->bvec = kmemdup(new->bvec,
 				    new->nr_segs * sizeof(struct bio_vec),
 				    flags);
-	else
+	case ITER_IOVEC:
+	case ITER_KVEC:
 		/* iovec and kvec have identical layout */
 		return new->iov = kmemdup(new->iov,
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
+	}
+
+	WARN_ON(1);
+	return NULL;
 }
 EXPORT_SYMBOL(dup_iter);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f28e6f4..bdeee0168ea7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2122,7 +2122,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					!mapping->a_ops->is_partially_uptodate)
 				goto page_not_up_to_date;
 			/* pipes can't handle partially uptodate pages */
-			if (unlikely(iter->type & ITER_PIPE))
+			if (unlikely(iov_iter_is_pipe(iter)))
 				goto page_not_up_to_date;
 			if (!trylock_page(page))
 				goto page_not_up_to_date;
diff --git a/mm/page_io.c b/mm/page_io.c
index b41cf9644585..23c5756142bb 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -294,7 +294,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		};
 		struct iov_iter from;
 
-		iov_iter_bvec(&from, ITER_BVEC | WRITE, &bv, 1, PAGE_SIZE);
+		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
 		init_sync_kiocb(&kiocb, swap_file);
 		kiocb.ki_pos = page_file_offset(page);
 
diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1343195292..1e853e2a62bb 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -2089,7 +2089,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 	struct kvec kv = {.iov_base = data, .iov_len = count};
 	struct iov_iter to;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &kv, 1, count);
+	iov_iter_kvec(&to, READ, &kv, 1, count);
 
 	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
 				fid->fid, (unsigned long long) offset, count);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cbb3361..457cd9fcdd4f 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -320,7 +320,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;
 
-	if (!(data->type & ITER_KVEC)) {
+	if (iov_iter_type(data) != ITER_KVEC) {
 		int n;
 		/*
 		 * We allow only p9_max_pages pinned. We wait for the
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4e2576fc0c59..828e87fe8027 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -467,7 +467,7 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 	iv.iov_len = skb->len;
 
 	memset(&msg, 0, sizeof(msg));
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, skb->len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, skb->len);
 
 	err = l2cap_chan_send(chan, &msg, skb->len);
 	if (err > 0) {
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 51c2cf2d8923..58fc6333d412 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -63,7 +63,7 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *dat
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, total_len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, &iv, 1, total_len);
 
 	l2cap_chan_send(chan, &msg, total_len);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ae91e2d40056..5f4c9f8333fd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -622,7 +622,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iv, 2, 1 + len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, iv, 2, 1 + len);
 
 	l2cap_chan_send(chan, &msg, 1 + len);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c6413c360771..fcbe49f5b704 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -526,7 +526,7 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 	if (!buf)
 		msg.msg_flags |= MSG_TRUNC;
 
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, len);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
@@ -545,7 +545,7 @@ static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
 	int r;
 
 	BUG_ON(page_offset + length > PAGE_SIZE);
-	iov_iter_bvec(&msg.msg_iter, READ | ITER_BVEC, &bvec, 1, length);
+	iov_iter_bvec(&msg.msg_iter, READ, &bvec, 1, length);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
 		r = 0;
@@ -607,7 +607,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
 	else
 		msg.msg_flags |= MSG_EOR;  /* superfluous, but what the hell */
 
-	iov_iter_bvec(&msg.msg_iter, WRITE | ITER_BVEC, &bvec, 1, size);
+	iov_iter_bvec(&msg.msg_iter, WRITE, &bvec, 1, size);
 	ret = sock_sendmsg(sock, &msg);
 	if (ret == -EAGAIN)
 		ret = 0;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index d4020c5e831d..2526be6b3d90 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1616,7 +1616,7 @@ ip_vs_receive(struct socket *sock, char *buffer, const size_t buflen)
 	EnterFunction(7);
 
 	/* Receive a packet */
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &iov, 1, buflen);
+	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, buflen);
 	len = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 	if (len < 0)
 		return len;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 83aba9ade060..f27a298f3498 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -286,7 +286,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	 */
 	krflags = MSG_PEEK | MSG_WAITALL;
 	smc->clcsock->sk->sk_rcvtimeo = CLC_WAIT_TIME;
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1,
+	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1,
 			sizeof(struct smc_clc_msg_hdr));
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (signal_pending(current)) {
@@ -325,7 +325,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 
 	/* receive the complete CLC message */
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, datlen);
+	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, datlen);
 	krflags = MSG_WAITALL;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < datlen || !smc_clc_msg_hdr_valid(clcm)) {
diff --git a/net/socket.c b/net/socket.c
index 0d8cfc0c9b2a..52ea48a2e601 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -655,7 +655,7 @@ EXPORT_SYMBOL(sock_sendmsg);
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE | ITER_KVEC, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
 	return sock_sendmsg(sock, msg);
 }
 EXPORT_SYMBOL(kernel_sendmsg);
@@ -668,7 +668,7 @@ int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!sock->ops->sendmsg_locked)
 		return sock_no_sendmsg_locked(sk, msg, size);
 
-	iov_iter_kvec(&msg->msg_iter, WRITE | ITER_KVEC, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
 
 	return sock->ops->sendmsg_locked(sk, msg, msg_data_left(msg));
 }
@@ -843,7 +843,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
 	mm_segment_t oldfs = get_fs();
 	int result;
 
-	iov_iter_kvec(&msg->msg_iter, READ | ITER_KVEC, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, READ, vec, num, size);
 	set_fs(KERNEL_DS);
 	result = sock_recvmsg(sock, msg, flags);
 	set_fs(oldfs);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 5445145e639c..0b46ec0bf74e 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -338,7 +338,7 @@ static int svc_recvfrom(struct svc_rqst *rqstp, struct kvec *iov, int nr,
 	rqstp->rq_xprt_hlen = 0;
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, iov, nr, buflen);
+	iov_iter_kvec(&msg.msg_iter, READ, iov, nr, buflen);
 	len = sock_recvmsg(svsk->sk_sock, &msg, msg.msg_flags);
 	/* If we read a full record, then assume there may be more
 	 * data to read (stream based sockets only!)
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index c8e34ef22c30..7e0f8df6b79d 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -400,7 +400,7 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 	iov.iov_base = &s;
 	iov.iov_len = sizeof(s);
 	msg.msg_name = NULL;
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, iov.iov_len);
 	ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT);
 	if (ret == -EWOULDBLOCK)
 		return -EWOULDBLOCK;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 292742e50bfa..fcf50375cd05 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -489,7 +489,7 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
 
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
-	iov_iter_kvec(&msg_iter, WRITE | ITER_KVEC, &iov, 1, size);
+	iov_iter_kvec(&msg_iter, WRITE, &iov, 1, size);
 	rc = tls_push_data(sk, &msg_iter, size,
 			   flags, TLS_RECORD_TYPE_DATA);
 	kunmap(page);
@@ -538,7 +538,7 @@ static int tls_device_push_pending_record(struct sock *sk, int flags)
 {
 	struct iov_iter	msg_iter;
 
-	iov_iter_kvec(&msg_iter, WRITE | ITER_KVEC, NULL, 0, 0);
+	iov_iter_kvec(&msg_iter, WRITE, NULL, 0, 0);
 	return tls_push_data(sk, &msg_iter, 0, flags, TLS_RECORD_TYPE_DATA);
 }
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 83d67df33f0c..0047e75ac4db 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -365,7 +365,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int record_room;
 	bool full_record;
 	int orig_size;
-	bool is_kvec = msg->msg_iter.type & ITER_KVEC;
+	bool is_kvec = iov_iter_type(&msg->msg_iter) == ITER_KVEC;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
 		return -ENOTSUPP;
@@ -778,7 +778,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	bool cmsg = false;
 	int target, err = 0;
 	long timeo;
-	bool is_kvec = msg->msg_iter.type & ITER_KVEC;
+	bool is_kvec = iov_iter_type(&msg->msg_iter) == ITER_KVEC;
 
 	flags |= nonblock;
 

