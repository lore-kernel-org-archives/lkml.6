Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F68C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496121479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107557;
	bh=MTLRkr0re1AlR6zo89GXQ4n+lckIwumSKxZKlPbAIKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LCep8PskVU1uZXXG9+3XE1oCzAHnCUAToShxfuE8H2/CUixQXAGFPPJ6c+v4CaBht
	 7FXIn22qrcHYNcWHhEgebdEUP5TmM7imo/EtQG24Yk1Rvdb3f78n3UoPG/22q+uW2C
	 Gdh32A+xMGBmFNHIhvWkJSoDzZ5Yw3he4Xb4vJjE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0496121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeLFOpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbeLFOpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770FB2146D;
        Thu,  6 Dec 2018 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107552;
        bh=MTLRkr0re1AlR6zo89GXQ4n+lckIwumSKxZKlPbAIKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ps7rqsIvINbH31PACFn5ziqYkvrj6DixZhpGcJ5aYgUgvcY9u9zMoiZnN6lMtFkyg
         qDfULz+rriL8w4UhgF+q3nu4rlxJGX5fOGPty7xUUbKt87ipR8ty15mhsVx7jCm26F
         g5Mmx9jIVz8I6vKTMsrwJ5uFjDWmg01Ra5OgfuBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 050/101] libceph: store ceph_auth_handshake pointer in ceph_connection
Date:   Thu,  6 Dec 2018 15:38:49 +0100
Message-Id: <20181206143014.434108260@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 262614c4294d33b1f19e0d18c0091d9c329b544a upstream.

We already copy authorizer_reply_buf and authorizer_reply_buf_len into
ceph_connection.  Factoring out __prepare_write_connect() requires two
more: authorizer_buf and authorizer_buf_len.  Store the pointer to the
handshake in con->auth rather than piling on.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ceph/messenger.h |    3 --
 net/ceph/messenger.c           |   54 +++++++++++++++++++----------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -200,9 +200,8 @@ struct ceph_connection {
 				 attempt for this connection, client */
 	u32 peer_global_seq;  /* peer's global seq for this connection */
 
+	struct ceph_auth_handshake *auth;
 	int auth_retry;       /* true if we need a newer authorizer */
-	void *auth_reply_buf;   /* where to put the authorizer reply */
-	int auth_reply_buf_len;
 
 	struct mutex mutex;
 
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1394,24 +1394,26 @@ static void prepare_write_keepalive(stru
  * Connection negotiation.
  */
 
-static struct ceph_auth_handshake *get_connect_authorizer(struct ceph_connection *con,
-						int *auth_proto)
+static int get_connect_authorizer(struct ceph_connection *con)
 {
 	struct ceph_auth_handshake *auth;
+	int auth_proto;
 
 	if (!con->ops->get_authorizer) {
+		con->auth = NULL;
 		con->out_connect.authorizer_protocol = CEPH_AUTH_UNKNOWN;
 		con->out_connect.authorizer_len = 0;
-		return NULL;
+		return 0;
 	}
 
-	auth = con->ops->get_authorizer(con, auth_proto, con->auth_retry);
+	auth = con->ops->get_authorizer(con, &auth_proto, con->auth_retry);
 	if (IS_ERR(auth))
-		return auth;
+		return PTR_ERR(auth);
 
-	con->auth_reply_buf = auth->authorizer_reply_buf;
-	con->auth_reply_buf_len = auth->authorizer_reply_buf_len;
-	return auth;
+	con->auth = auth;
+	con->out_connect.authorizer_protocol = cpu_to_le32(auth_proto);
+	con->out_connect.authorizer_len = cpu_to_le32(auth->authorizer_buf_len);
+	return 0;
 }
 
 /*
@@ -1431,8 +1433,7 @@ static int prepare_write_connect(struct
 {
 	unsigned int global_seq = get_global_seq(con->msgr, 0);
 	int proto;
-	int auth_proto;
-	struct ceph_auth_handshake *auth;
+	int ret;
 
 	switch (con->peer_name.type) {
 	case CEPH_ENTITY_TYPE_MON:
@@ -1459,20 +1460,15 @@ static int prepare_write_connect(struct
 	con->out_connect.protocol_version = cpu_to_le32(proto);
 	con->out_connect.flags = 0;
 
-	auth_proto = CEPH_AUTH_UNKNOWN;
-	auth = get_connect_authorizer(con, &auth_proto);
-	if (IS_ERR(auth))
-		return PTR_ERR(auth);
-
-	con->out_connect.authorizer_protocol = cpu_to_le32(auth_proto);
-	con->out_connect.authorizer_len = auth ?
-		cpu_to_le32(auth->authorizer_buf_len) : 0;
+	ret = get_connect_authorizer(con);
+	if (ret)
+		return ret;
 
 	con_out_kvec_add(con, sizeof (con->out_connect),
 					&con->out_connect);
-	if (auth && auth->authorizer_buf_len)
-		con_out_kvec_add(con, auth->authorizer_buf_len,
-					auth->authorizer_buf);
+	if (con->auth)
+		con_out_kvec_add(con, con->auth->authorizer_buf_len,
+				 con->auth->authorizer_buf);
 
 	con->out_more = 0;
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
@@ -1737,11 +1733,14 @@ static int read_partial_connect(struct c
 	if (ret <= 0)
 		goto out;
 
-	size = le32_to_cpu(con->in_reply.authorizer_len);
-	end += size;
-	ret = read_partial(con, end, size, con->auth_reply_buf);
-	if (ret <= 0)
-		goto out;
+	if (con->auth) {
+		size = le32_to_cpu(con->in_reply.authorizer_len);
+		end += size;
+		ret = read_partial(con, end, size,
+				   con->auth->authorizer_reply_buf);
+		if (ret <= 0)
+			goto out;
+	}
 
 	dout("read_partial_connect %p tag %d, con_seq = %u, g_seq = %u\n",
 	     con, (int)con->in_reply.tag,
@@ -1749,7 +1748,6 @@ static int read_partial_connect(struct c
 	     le32_to_cpu(con->in_reply.global_seq));
 out:
 	return ret;
-
 }
 
 /*
@@ -2033,7 +2031,7 @@ static int process_connect(struct ceph_c
 
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
-	if (con->auth_reply_buf) {
+	if (con->auth) {
 		/*
 		 * Any connection that defines ->get_authorizer()
 		 * should also define ->verify_authorizer_reply().


