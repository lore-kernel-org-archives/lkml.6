Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5912lOfz0MaowlqsuYWhE7zEJN8McWRsIg292vooUU+QXwpsrVYYvaYW8vXd73YbVBdlr
ARC-Seal: i=1; a=rsa-sha256; t=1523022099; cv=none;
        d=google.com; s=arc-20160816;
        b=dpuI/zisPprve98EpOJSU6N84uB+kuUsw8II13nGHegm2f8i8EZFcNSujyGVFVdBS5
         GLrU40mYpb9NyClPLuoD+bo/CksuBQlmlL9Tq0CfKGoEpATUTxZRTOD/xrFaseCbtvPe
         vOMHYrW6FZQDATKdM2wvVesi77qs3OUlZ4TEU0sgRV2jJe06Zv4WqdV7moozI8/Ifznd
         CzuR/ttO/sTq4dIcdRsI617tjgVjEi3WPg35Q3MU2yjg6Y0F7XEiAjpJAMkolWY7nSxi
         kuBiaBKmHwwFrkvC383cHQjJji+IAH4Ak5d6xtlehqCpsTjqw57Xs5jOGhHU2vAIPjfi
         6hpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jl3GWYuDPISO3sGYoQu48FhGHtPUjdcJ5gWa3RjLdaI=;
        b=k8vTC5M7fG/8JBdXEWFZwKMWa3z3HY4do/xQNK9wL3RXjko3iSLEYhyC02i7xLZskH
         8ogvJKh0wABBPM8/bG2eb6j4tU14WuTQNq+HhL5kaLzrmIiQAtsIKXRK2cDeEQOUjIda
         8v4++9cicO+wBIjSaWhnNmJ/q7U49MlDS/vXqbvHQ2nQw9kTVqPTi7SoljW6JP21DXWM
         lQie7utBZmGAJe608M3QTBlrAwDFAqHCrd77sbOqr4i98WYpJZdOpgrxuK5dSUj5Vajz
         3zcO3OgUCQgcWzBsLTbZzgEB3eUxxehlBvME9g6XKeH76GP4YANLK4BtJk4tzxYTAcWN
         BpxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+6800425d54ed3ed8135d@syzkaller.appspotmail.com,
	Roland Dreier <roland@purestorage.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 27/72] RDMA/ucma: Introduce safer rdma_addr_size() variants
Date: Fri,  6 Apr 2018 15:24:02 +0200
Message-Id: <20180406084351.618621527@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003728839634146?=
X-GMAIL-MSGID: =?utf-8?q?1597004420745396459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/addr.c |   16 ++++++++++++++++
 drivers/infiniband/core/ucma.c |   34 +++++++++++++++++-----------------
 include/rdma/ib_addr.h         |    2 ++
 3 files changed, 35 insertions(+), 17 deletions(-)

--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -207,6 +207,22 @@ int rdma_addr_size(struct sockaddr *addr
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
@@ -632,6 +632,9 @@ static ssize_t ucma_bind_ip(struct ucma_
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (!rdma_addr_size_in6(&cmd.addr))
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -645,22 +648,21 @@ static ssize_t ucma_bind(struct ucma_fil
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
@@ -670,23 +672,22 @@ static ssize_t ucma_resolve_ip(struct uc
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
@@ -696,24 +697,23 @@ static ssize_t ucma_resolve_addr(struct
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
@@ -1432,7 +1432,7 @@ static ssize_t ucma_join_ip_multicast(st
 	join_cmd.response = cmd.response;
 	join_cmd.uid = cmd.uid;
 	join_cmd.id = cmd.id;
-	join_cmd.addr_size = rdma_addr_size((struct sockaddr *) &cmd.addr);
+	join_cmd.addr_size = rdma_addr_size_in6(&cmd.addr);
 	if (!join_cmd.addr_size)
 		return -EINVAL;
 
@@ -1451,7 +1451,7 @@ static ssize_t ucma_join_multicast(struc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+	if (!rdma_addr_size_kss(&cmd.addr))
 		return -EINVAL;
 
 	return ucma_process_join(file, &cmd, out_len);
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -130,6 +130,8 @@ void rdma_copy_addr(struct rdma_dev_addr
 		    const unsigned char *dst_dev_addr);
 
 int rdma_addr_size(struct sockaddr *addr);
+int rdma_addr_size_in6(struct sockaddr_in6 *addr);
+int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr);
 
 int rdma_addr_find_smac_by_sgid(union ib_gid *sgid, u8 *smac, u16 *vlan_id);
 int rdma_addr_find_l2_eth_by_grh(const union ib_gid *sgid,
