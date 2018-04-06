Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+yQgzSBZFT4Yglg1W4wFUVPVTChHnmnf5BSmc/LSNkrmvQR3IrkoKdGhuxq2EklvrYHh7M
ARC-Seal: i=1; a=rsa-sha256; t=1523021439; cv=none;
        d=google.com; s=arc-20160816;
        b=XbLJRc8YDCHr5h+mkSSMtLcmtCOniBsMFtkLYK/VChTyMCCkd7f21bvvqeLG5fYJZx
         Xds8D0t8+rzXs0JAgMv7ln+86Mq9+HNA0xWIs5Q1nHwfnAcwbBNNxGJtGHSACz2RY6Az
         kyMOXym/8FupitVfgjw1JYhiXRFWLs89QRp3MgjMhFhAujfabfkR6JSsUrgOO22yyJpo
         zCA3qz8SBvy/Nxu9/YlBMGLmfgFKQzA8DbxtCpI0zllaezriJSZ+cPRwVCYHetR4dNsO
         N2w5Sj3kr1Lru9oEAyVMm+Vk+uiHWhBuO1SiJjImzxOQnwe5IqUWsANiKLqh2B6JZggu
         Sh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+0q28z4Bm0wRk8TuqcXo3wQA5i0bVISq62IuRfZJKVc=;
        b=BubifrDlTHp9m60UWmJpq0wjAU51LOBZHY1Dxm6BXOqw7fUM5WfoCymQCTY8NDRKjq
         yr+J+PK7DWRU32VI7bxykiMSmw56ZJXFPNaze4YsVqzh4EXqAo+BrxlUINQ6xw9SE7n2
         /77AP/LLUQWNTnyl95Tkb6acgzDnKII0VK9dgUZMLEWFvNL80klBwjqxsP/w5Ovai53Q
         h9Q+3gR+xHjP82R7p+F79iWhYVzDcdL3WlbgnrhrAY6+X7I4acRoFU8LDyKB1C7R/c5e
         RzxAKcpp/yoHFYRt6Ly59OyUR9G6TIskTbvs7K3A7cmwjjmcgO86Pq0McA8G+c+zqIfO
         Usxg==
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
Subject: [PATCH 4.4 36/72] RDMA/ucma: Introduce safer rdma_addr_size() variants
Date: Fri,  6 Apr 2018 15:23:37 +0200
Message-Id: <20180406084308.154948337@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003728839634146?=
X-GMAIL-MSGID: =?utf-8?q?1597003728839634146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -629,6 +629,9 @@ static ssize_t ucma_bind_ip(struct ucma_
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (!rdma_addr_size_in6(&cmd.addr))
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -642,22 +645,21 @@ static ssize_t ucma_bind(struct ucma_fil
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
@@ -667,23 +669,22 @@ static ssize_t ucma_resolve_ip(struct uc
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
@@ -693,24 +694,23 @@ static ssize_t ucma_resolve_addr(struct
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
@@ -1404,7 +1404,7 @@ static ssize_t ucma_join_ip_multicast(st
 	join_cmd.response = cmd.response;
 	join_cmd.uid = cmd.uid;
 	join_cmd.id = cmd.id;
-	join_cmd.addr_size = rdma_addr_size((struct sockaddr *) &cmd.addr);
+	join_cmd.addr_size = rdma_addr_size_in6(&cmd.addr);
 	if (!join_cmd.addr_size)
 		return -EINVAL;
 
@@ -1423,7 +1423,7 @@ static ssize_t ucma_join_multicast(struc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
-	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+	if (!rdma_addr_size_kss(&cmd.addr))
 		return -EINVAL;
 
 	return ucma_process_join(file, &cmd, out_len);
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -123,6 +123,8 @@ int rdma_copy_addr(struct rdma_dev_addr
 	      const unsigned char *dst_dev_addr);
 
 int rdma_addr_size(struct sockaddr *addr);
+int rdma_addr_size_in6(struct sockaddr_in6 *addr);
+int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr);
 
 int rdma_addr_find_smac_by_sgid(union ib_gid *sgid, u8 *smac, u16 *vlan_id);
 int rdma_addr_find_dmac_by_grh(const union ib_gid *sgid, const union ib_gid *dgid,
