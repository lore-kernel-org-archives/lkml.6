Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1630C20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1630C20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeJXIX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 04:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbeJXIX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 04:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A390A2027A;
        Tue, 23 Oct 2018 23:58:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E84E76586;
        Tue, 23 Oct 2018 23:58:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/25] iov_iter: Separate type from direction and use
 accessor functions [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 00:58:04 +0100
Message-ID: <154033908445.12041.10866927088960638632.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 23 Oct 2018 23:58:12 +0000 (UTC)
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

 drivers/block/drbd/drbd_main.c           |    2 +-
 drivers/block/drbd/drbd_receiver.c       |    2 +-
 drivers/block/loop.c                     |    9 ++++-----
 drivers/block/nbd.c                      |   12 +++++-------
 drivers/fsi/fsi-sbefifo.c                |    4 ++--
 drivers/isdn/mISDN/l1oip_core.c          |    3 +--
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |    6 +++---
 drivers/nvme/target/io-cmd-file.c        |    2 +-
 drivers/target/iscsi/iscsi_target_util.c |    6 ++----
 drivers/target/target_core_file.c        |    6 +++---
 drivers/usb/usbip/usbip_common.c         |    2 +-
 drivers/xen/pvcalls-back.c               |    8 ++++----
 fs/9p/vfs_addr.c                         |    4 ++--
 fs/9p/vfs_dir.c                          |    2 +-
 fs/9p/xattr.c                            |    4 ++--
 fs/afs/rxrpc.c                           |   15 +++++++--------
 fs/ceph/file.c                           |    5 ++---
 fs/cifs/connect.c                        |    4 ++--
 fs/cifs/misc.c                           |    2 +-
 fs/cifs/smb2ops.c                        |    4 ++--
 fs/cifs/transport.c                      |    8 +++-----
 fs/dlm/lowcomms.c                        |    2 +-
 fs/nfsd/vfs.c                            |    4 ++--
 fs/ocfs2/cluster/tcp.c                   |    2 +-
 fs/orangefs/inode.c                      |    2 +-
 fs/splice.c                              |    7 +++----
 include/linux/uio.h                      |   10 +++++-----
 lib/iov_iter.c                           |   28 +++++++++++++++-------------
 mm/page_io.c                             |    2 +-
 net/9p/client.c                          |    2 +-
 net/bluetooth/6lowpan.c                  |    2 +-
 net/bluetooth/a2mp.c                     |    2 +-
 net/bluetooth/smp.c                      |    2 +-
 net/ceph/messenger.c                     |    6 +++---
 net/netfilter/ipvs/ip_vs_sync.c          |    2 +-
 net/smc/smc_clc.c                        |    4 ++--
 net/socket.c                             |    6 +++---
 net/sunrpc/svcsock.c                     |    2 +-
 net/tipc/topsrv.c                        |    2 +-
 net/tls/tls_device.c                     |    4 ++--
 40 files changed, 96 insertions(+), 105 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index ef8212a4b73e..ded9735d44af 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1856,7 +1856,7 @@ int drbd_send(struct drbd_connection *connection, struct socket *sock,
 
 	/* THINK  if (signal_pending) return ... ? */
 
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iov, 1, size);
+	iov_iter_kvec(&msg.msg_iter, WRITE, &iov, 1, size);
 
 	if (sock == connection->data.socket) {
 		rcu_read_lock();
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 75f6b47169e6..fcc70642b004 100644
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
index ea9debf59b22..cb0cc8685076 100644
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
index 14a51254c3db..4d4d6129ff66 100644
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
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index ae861342626e..d92f5b87c251 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -638,7 +638,7 @@ static void sbefifo_collect_async_ffdc(struct sbefifo *sbefifo)
 	}
         ffdc_iov.iov_base = ffdc;
 	ffdc_iov.iov_len = SBEFIFO_MAX_FFDC_SIZE;
-        iov_iter_kvec(&ffdc_iter, WRITE | ITER_KVEC, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
+        iov_iter_kvec(&ffdc_iter, WRITE, &ffdc_iov, 1, SBEFIFO_MAX_FFDC_SIZE);
 	cmd[0] = cpu_to_be32(2);
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_SBE_FFDC);
 	rc = sbefifo_do_command(sbefifo, cmd, 2, &ffdc_iter);
@@ -735,7 +735,7 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
 	rbytes = (*resp_len) * sizeof(__be32);
 	resp_iov.iov_base = response;
 	resp_iov.iov_len = rbytes;
-        iov_iter_kvec(&resp_iter, WRITE | ITER_KVEC, &resp_iov, 1, rbytes);
+        iov_iter_kvec(&resp_iter, WRITE, &resp_iov, 1, rbytes);
 
 	/* Perform the command */
 	mutex_lock(&sbefifo->lock);
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
index bd52f29b4a4e..264f4ed8eef2 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -3030,7 +3030,7 @@ ssize_t vmci_qpair_enqueue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&from, WRITE | ITER_KVEC, &v, 1, buf_size);
+	iov_iter_kvec(&from, WRITE, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3074,7 +3074,7 @@ ssize_t vmci_qpair_dequeue(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &v, 1, buf_size);
+	iov_iter_kvec(&to, READ, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
@@ -3119,7 +3119,7 @@ ssize_t vmci_qpair_peek(struct vmci_qp *qpair,
 	if (!qpair || !buf)
 		return VMCI_ERROR_INVALID_ARGS;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &v, 1, buf_size);
+	iov_iter_kvec(&to, READ, &v, 1, buf_size);
 
 	qp_lock(qpair);
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 81a9dc5290a8..97f282eca3c2 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -101,7 +101,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		rw = READ;
 	}
 
-	iov_iter_bvec(&iter, ITER_BVEC | rw, req->f.bvec, nr_segs, count);
+	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
 
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 49be1e41290c..991482576417 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1258,8 +1258,7 @@ static int iscsit_do_rx_data(
 		return -1;
 
 	memset(&msg, 0, sizeof(struct msghdr));
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC,
-		      count->iov, count->iov_count, data);
+	iov_iter_kvec(&msg.msg_iter, READ, count->iov, count->iov_count, data);
 
 	while (msg_data_left(&msg)) {
 		rx_loop = sock_recvmsg(conn->sock, &msg, MSG_WAITALL);
@@ -1315,8 +1314,7 @@ int tx_data(
 
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
index 352abc39e891..ac8ff8ca4c11 100644
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
 	int retval, err;
 
-	iov_iter_kvec(&from, WRITE | ITER_KVEC, &kvec, 1, value_len);
+	iov_iter_kvec(&from, WRITE, &kvec, 1, value_len);
 
 	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu flags = %d\n",
 		 name, value_len, flags);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 77a83790a31f..639c16882e93 100644
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
@@ -825,7 +824,7 @@ void afs_send_empty_reply(struct afs_call *call)
 
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, NULL, 0, 0);
+	iov_iter_kvec(&msg.msg_iter, WRITE, NULL, 0, 0);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -864,7 +863,7 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 	iov[0].iov_len		= len;
 	msg.msg_name		= NULL;
 	msg.msg_namelen		= 0;
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iov, 1, len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, len);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= 0;
@@ -905,7 +904,7 @@ int afs_extract_data(struct afs_call *call, void *buf, size_t count,
 
 	iov.iov_base = buf + call->offset;
 	iov.iov_len = count - call->offset;
-	iov_iter_kvec(&iter, ITER_KVEC | READ, &iov, 1, count - call->offset);
+	iov_iter_kvec(&iter, READ, &iov, 1, count - call->offset);
 
 	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, &iter,
 				     want_more, &remote_abort,
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 524ecc95b04d..5dd433aa9b23 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -821,7 +821,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 				aio_req->total_len = rc + zlen;
 			}
 
-			iov_iter_bvec(&i, ITER_BVEC, osd_data->bvec_pos.bvecs,
+			iov_iter_bvec(&i, READ, osd_data->bvec_pos.bvecs,
 				      osd_data->num_bvecs,
 				      osd_data->bvec_pos.iter.bi_size);
 			iov_iter_advance(&i, rc);
@@ -1044,8 +1044,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, ITER_BVEC, bvecs, num_pages,
-					      len);
+				iov_iter_bvec(&i, READ, bvecs, num_pages, len);
 				iov_iter_advance(&i, ret);
 				iov_iter_zero(zlen, &i);
 				ret += zlen;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 52d71b64c0c6..11bcd2fb90b1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -588,7 +588,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 {
 	struct msghdr smb_msg;
 	struct kvec iov = {.iov_base = buf, .iov_len = to_read};
-	iov_iter_kvec(&smb_msg.msg_iter, READ | ITER_KVEC, &iov, 1, to_read);
+	iov_iter_kvec(&smb_msg.msg_iter, READ, &iov, 1, to_read);
 
 	return cifs_readv_from_socket(server, &smb_msg);
 }
@@ -600,7 +600,7 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	struct msghdr smb_msg;
 	struct bio_vec bv = {
 		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
-	iov_iter_bvec(&smb_msg.msg_iter, READ | ITER_BVEC, &bv, 1, to_read);
+	iov_iter_bvec(&smb_msg.msg_iter, READ, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 7b5b960a04b8..10cff44832d8 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -857,7 +857,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 	ctx->bv = bv;
 	ctx->len = saved_len - count;
 	ctx->npages = npages;
-	iov_iter_bvec(&ctx->iter, ITER_BVEC | rw, ctx->bv, npages, ctx->len);
+	iov_iter_bvec(&ctx->iter, rw, ctx->bv, npages, ctx->len);
 	return 0;
 }
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 89985a0a6819..26f8a65b8722 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2962,13 +2962,13 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
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
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index b48f43963da6..146b618802a5 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -307,8 +307,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			.iov_base = &rfc1002_marker,
 			.iov_len  = 4
 		};
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE | ITER_KVEC, &hiov,
-			      1, 4);
+		iov_iter_kvec(&smb_msg.msg_iter, WRITE, &hiov, 1, 4);
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
 			goto uncork;
@@ -329,8 +328,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			size += iov[i].iov_len;
 		}
 
-		iov_iter_kvec(&smb_msg.msg_iter, WRITE | ITER_KVEC,
-			      iov, n_vec, size);
+		iov_iter_kvec(&smb_msg.msg_iter, WRITE, iov, n_vec, size);
 
 		rc = smb_send_kvec(server, &smb_msg, &sent);
 		if (rc < 0)
@@ -346,7 +344,7 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 			rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
 					     &bvec.bv_offset);
 
-			iov_iter_bvec(&smb_msg.msg_iter, WRITE | ITER_BVEC,
+			iov_iter_bvec(&smb_msg.msg_iter, WRITE,
 				      &bvec, 1, bvec.bv_len);
 			rc = smb_send_kvec(server, &smb_msg, &sent);
 			if (rc < 0)
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
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b53e76391e52..8b90f5480904 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -923,7 +923,7 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int host_err;
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, READ | ITER_KVEC, vec, vlen, *count);
+	iov_iter_kvec(&iter, READ, vec, vlen, *count);
 	host_err = vfs_iter_read(file, &iter, &offset, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, host_err);
 }
@@ -999,7 +999,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
 	if (stable && !use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, WRITE | ITER_KVEC, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0)
 		goto out_nfserr;
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 7d9eea7d4a87..e9f236af1927 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -916,7 +916,7 @@ static int o2net_recv_tcp_msg(struct socket *sock, void *data, size_t len)
 {
 	struct kvec vec = { .iov_len = len, .iov_base = data, };
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT, };
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &vec, 1, len);
+	iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, len);
 	return sock_recvmsg(sock, &msg, MSG_DONTWAIT);
 }
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 31932879b716..136a8bdc1d91 100644
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
index fcabc959c794..3d8f1acc142c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,7 +29,7 @@ enum iter_type {
 };
 
 struct iov_iter {
-	int type;
+	unsigned int type;
 	size_t iov_offset;
 	size_t count;
 	union {
@@ -212,13 +212,13 @@ size_t copy_to_iter_mcsafe(void *addr, size_t bytes, struct iov_iter *i)
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
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 42d39116a556..c42b928b15ef 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -428,17 +428,19 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
-void iov_iter_init(struct iov_iter *i, int direction,
+void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
 {
+	WARN_ON(direction & ~(READ | WRITE));
+	direction &= READ | WRITE;
+
 	/* It will get better.  Eventually... */
 	if (uaccess_kernel()) {
-		direction |= ITER_KVEC;
-		i->type = direction;
+		i->type = ITER_KVEC | direction;
 		i->kvec = (struct kvec *)iov;
 	} else {
-		i->type = direction;
+		i->type = ITER_IOVEC | direction;
 		i->iov = iov;
 	}
 	i->nr_segs = nr_segs;
@@ -1060,12 +1062,12 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
 
-void iov_iter_kvec(struct iov_iter *i, int direction,
+void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 			const struct kvec *kvec, unsigned long nr_segs,
 			size_t count)
 {
-	BUG_ON(!(direction & ITER_KVEC));
-	i->type = direction;
+	WARN_ON(direction & ~(READ | WRITE));
+	i->type = ITER_KVEC | (direction & (READ | WRITE));
 	i->kvec = kvec;
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
@@ -1073,12 +1075,12 @@ void iov_iter_kvec(struct iov_iter *i, int direction,
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
-void iov_iter_bvec(struct iov_iter *i, int direction,
+void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 			const struct bio_vec *bvec, unsigned long nr_segs,
 			size_t count)
 {
-	BUG_ON(!(direction & ITER_BVEC));
-	i->type = direction;
+	WARN_ON(direction & ~(READ | WRITE));
+	i->type = ITER_BVEC | (direction & (READ | WRITE));
 	i->bvec = bvec;
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
@@ -1086,13 +1088,13 @@ void iov_iter_bvec(struct iov_iter *i, int direction,
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
+	i->type = ITER_PIPE | READ;
 	i->pipe = pipe;
 	i->idx = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
 	i->iov_offset = 0;
diff --git a/mm/page_io.c b/mm/page_io.c
index aafd19ec1db4..86de453a60cf 100644
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
index deae53a7dffc..a9cd1401bd09 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -2070,7 +2070,7 @@ int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset)
 	struct kvec kv = {.iov_base = data, .iov_len = count};
 	struct iov_iter to;
 
-	iov_iter_kvec(&to, READ | ITER_KVEC, &kv, 1, count);
+	iov_iter_kvec(&to, READ, &kv, 1, count);
 
 	p9_debug(P9_DEBUG_9P, ">>> TREADDIR fid %d offset %llu count %d\n",
 				fid->fid, (unsigned long long) offset, count);
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
index a1c1b7e8a45c..c822e626761b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -622,7 +622,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	memset(&msg, 0, sizeof(msg));
 
-	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iv, 2, 1 + len);
+	iov_iter_kvec(&msg.msg_iter, WRITE, iv, 2, 1 + len);
 
 	l2cap_chan_send(chan, &msg, 1 + len);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 0a187196aeed..e493ff77b378 100644
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
index 52241d679cc9..89c3a8c7859a 100644
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
index b68801c7d0ab..fae408abea54 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -635,7 +635,7 @@ EXPORT_SYMBOL(sock_sendmsg);
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
 		   struct kvec *vec, size_t num, size_t size)
 {
-	iov_iter_kvec(&msg->msg_iter, WRITE | ITER_KVEC, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
 	return sock_sendmsg(sock, msg);
 }
 EXPORT_SYMBOL(kernel_sendmsg);
@@ -648,7 +648,7 @@ int kernel_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	if (!sock->ops->sendmsg_locked)
 		return sock_no_sendmsg_locked(sk, msg, size);
 
-	iov_iter_kvec(&msg->msg_iter, WRITE | ITER_KVEC, vec, num, size);
+	iov_iter_kvec(&msg->msg_iter, WRITE, vec, num, size);
 
 	return sock->ops->sendmsg_locked(sk, msg, msg_data_left(msg));
 }
@@ -823,7 +823,7 @@ int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
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
index d8956f7daac4..afa02eeec403 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -394,7 +394,7 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *con)
 	iov.iov_base = &s;
 	iov.iov_len = sizeof(s);
 	msg.msg_name = NULL;
-	iov_iter_kvec(&msg.msg_iter, READ | ITER_KVEC, &iov, 1, iov.iov_len);
+	iov_iter_kvec(&msg.msg_iter, READ, &iov, 1, iov.iov_len);
 	ret = sock_recvmsg(con->sock, &msg, MSG_DONTWAIT);
 	if (ret == -EWOULDBLOCK)
 		return -EWOULDBLOCK;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 276edbc04f38..d753e362d2d9 100644
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
 

