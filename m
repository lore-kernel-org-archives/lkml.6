Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDDC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8F82077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8F82077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeJNXel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37471 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727864AbeJNXek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:34:40 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cm-Ec; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000Pc-ST; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "" <syzbot+6800425d54ed3ed8135d@syzkaller.appspotmail.com>,
        "Roland Dreier" <roland@purestorage.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.591320996@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 200/366] RDMA/ucma: Introduce safer rdma_addr_size()
 variants
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Roland Dreier <roland@purestorage.com>

commit 84652aefb347297aa08e91e283adf7b18f77c2d5 upstream.

There are several places in the ucma ABI where userspace can pass in a
sockaddr but set the address family to AF_IB.  When that happens,
rdma_addr_size() will return a size bigger than sizeof struct sockaddr_in6,
and the ucma kernel code might end up copying past the end of a buffer
not sized for a struct sockaddr_ib.

Fix this by introducing new variants

    int rdma_addr_size_in6(struct sockaddr_in6 *addr);
    int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr);

that are type-safe for the types used in the ucma ABI and return 0 if the
size computed is bigger than the size of the type passed in.  We can use
these new variants to check what size userspace has passed in before
copying any addresses.

Reported-by: <syzbot+6800425d54ed3ed8135d@syzkaller.appspotmail.com>
Signed-off-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/addr.c | 16 ++++++++++++++++
 drivers/infiniband/core/ucma.c | 34 +++++++++++++++++-----------------
 include/rdma/ib_addr.h         |  2 ++
 3 files changed, 35 insertions(+), 17 deletions(-)

--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -86,6 +86,22 @@ int rdma_addr_size(struct sockaddr *addr
 }
 EXPORT_SYMBOL(rdma_addr_size);
 
+int rdma_addr_size_in6(struct sockaddr_in6 *addr)
+{
+	int ret = rdma_addr_size((struct sockaddr *) addr);
+
+	return ret <= sizeof(*addr) ? ret : 0;
+}
+EXPORT_SYMBOL(rdma_addr_size_in6);
+
+int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr)
+{
+	int ret = rdma_addr_size((struct sockaddr *) addr);
+
+	return ret <= sizeof(*addr) ? ret : 0;
+}
+EXPORT_SYMBOL(rdma_addr_size_kss);
+
 static struct rdma_addr_client self;
 
 void rdma_addr_register_client(struct rdma_addr_client *client)
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -528,6 +528,9 @@ static ssize_t ucma_bind_ip(struct ucma_
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (!rdma_addr_size_in6(&cmd.addr))
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -541,22 +544,21 @@ static ssize_t ucma_bind(struct ucma_fil
 			 int in_len, int out_len)
 {
 	struct rdma_ucm_bind cmd;
-	struct sockaddr *addr;
 	struct ucma_context *ctx;
 	int ret;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	addr = (struct sockaddr *) &cmd.addr;
-	if (cmd.reserved || !cmd.addr_size || (cmd.addr_size != rdma_addr_size(addr)))
+	if (cmd.reserved || !cmd.addr_size ||
+	    cmd.addr_size != rdma_addr_size_kss(&cmd.addr))
 		return -EINVAL;
 
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ret = rdma_bind_addr(ctx->cm_id, addr);
+	ret = rdma_bind_addr(ctx->cm_id, (struct sockaddr *) &cmd.addr);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -566,23 +568,22 @@ static ssize_t ucma_resolve_ip(struct uc
 			       int in_len, int out_len)
 {
 	struct rdma_ucm_resolve_ip cmd;
-	struct sockaddr *src, *dst;
 	struct ucma_context *ctx;
 	int ret;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	src = (struct sockaddr *) &cmd.src_addr;
-	dst = (struct sockaddr *) &cmd.dst_addr;
-	if (!rdma_addr_size(src) || !rdma_addr_size(dst))
+	if (!rdma_addr_size_in6(&cmd.src_addr) ||
+	    !rdma_addr_size_in6(&cmd.dst_addr))
 		return -EINVAL;
 
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ret = rdma_resolve_addr(ctx->cm_id, src, dst, cmd.timeout_ms);
+	ret = rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
+				(struct sockaddr *) &cmd.dst_addr, cmd.timeout_ms);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -592,24 +593,23 @@ static ssize_t ucma_resolve_addr(struct
 				 int in_len, int out_len)
 {
 	struct rdma_ucm_resolve_addr cmd;
-	struct sockaddr *src, *dst;
 	struct ucma_context *ctx;
 	int ret;
 
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	src = (struct sockaddr *) &cmd.src_addr;
-	dst = (struct sockaddr *) &cmd.dst_addr;
-	if (cmd.reserved || (cmd.src_size && (cmd.src_size != rdma_addr_size(src))) ||
-	    !cmd.dst_size || (cmd.dst_size != rdma_addr_size(dst)))
+	if (cmd.reserved ||
+	    (cmd.src_size && (cmd.src_size != rdma_addr_size_kss(&cmd.src_addr))) ||
+	    !cmd.dst_size || (cmd.dst_size != rdma_addr_size_kss(&cmd.dst_addr)))
 		return -EINVAL;
 
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ret = rdma_resolve_addr(ctx->cm_id, src, dst, cmd.timeout_ms);
+	ret = rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
+				(struct sockaddr *) &cmd.dst_addr, cmd.timeout_ms);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1324,7 +1324,7 @@ static ssize_t ucma_join_ip_multicast(st
 	join_cmd.response = cmd.response;
 	join_cmd.uid = cmd.uid;
 	join_cmd.id = cmd.id;
-	join_cmd.addr_size = rdma_addr_size((struct sockaddr *) &cmd.addr);
+	join_cmd.addr_size = rdma_addr_size_in6(&cmd.addr);
 	if (!join_cmd.addr_size)
 		return -EINVAL;
 
@@ -1343,7 +1343,7 @@ static ssize_t ucma_join_multicast(struc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+	if (!rdma_addr_size_kss(&cmd.addr))
 		return -EINVAL;
 
 	return ucma_process_join(file, &cmd, out_len);
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -109,6 +109,8 @@ int rdma_copy_addr(struct rdma_dev_addr
 	      const unsigned char *dst_dev_addr);
 
 int rdma_addr_size(struct sockaddr *addr);
+int rdma_addr_size_in6(struct sockaddr_in6 *addr);
+int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr);
 
 int rdma_addr_find_smac_by_sgid(union ib_gid *sgid, u8 *smac, u16 *vlan_id);
 int rdma_addr_find_dmac_by_grh(union ib_gid *sgid, union ib_gid *dgid, u8 *smac,

