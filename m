Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64645C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E740214DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/QtY6at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E740214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeLDLB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeLDLB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D1CD214DB;
        Tue,  4 Dec 2018 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921285;
        bh=La+zjfgQNhJVu72zUzQWQBTF14Wof2GaLd+eVTNWoLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/QtY6atCBa4IX+yvT6OkyZlPOWWC3k4kW38AZmRymdewDYtOzc6kc25KiFDBnU6Q
         i+VKcQQMap+C4GLu9df9cCOu74U2sGJdALAmMu2EdKK8kAbxLHLnkUw1dchsDTjBDc
         83Q53XJvvK5oUVugQnv8c18bnorb6Touk/tS8tZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 013/146] libceph: store ceph_auth_handshake pointer in ceph_connection
Date:   Tue,  4 Dec 2018 11:48:19 +0100
Message-Id: <20181204103727.334279597@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 262614c4294d33b1f19e0d18c0091d9c329b544a upstream.

We already copy authorizer_reply_buf and authorizer_reply_buf_len into
ceph_connection.  Factoring out __prepare_write_connect() requires two
more: authorizer_buf and authorizer_buf_len.  Store the pointer to the
handshake in con->auth rather than piling on.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ceph/messenger.h |  3 +-
 net/ceph/messenger.c           | 54 ++++++++++++++++------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index ead9d85f1c11..9056077c023f 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -203,9 +203,8 @@ struct ceph_connection {
 				 attempt for this connection, client */
 	u32 peer_global_seq;  /* peer's global seq for this connection */
 
+	struct ceph_auth_handshake *auth;
 	int auth_retry;       /* true if we need a newer authorizer */
-	void *auth_reply_buf;   /* where to put the authorizer reply */
-	int auth_reply_buf_len;
 
 	struct mutex mutex;
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5281da82371a..3a82e6d2864b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1411,24 +1411,26 @@ static void prepare_write_keepalive(struct ceph_connection *con)
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
@@ -1448,8 +1450,7 @@ static int prepare_write_connect(struct ceph_connection *con)
 {
 	unsigned int global_seq = get_global_seq(con->msgr, 0);
 	int proto;
-	int auth_proto;
-	struct ceph_auth_handshake *auth;
+	int ret;
 
 	switch (con->peer_name.type) {
 	case CEPH_ENTITY_TYPE_MON:
@@ -1476,20 +1477,15 @@ static int prepare_write_connect(struct ceph_connection *con)
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
@@ -1753,11 +1749,14 @@ static int read_partial_connect(struct ceph_connection *con)
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
@@ -1765,7 +1764,6 @@ static int read_partial_connect(struct ceph_connection *con)
 	     le32_to_cpu(con->in_reply.global_seq));
 out:
 	return ret;
-
 }
 
 /*
@@ -2048,7 +2046,7 @@ static int process_connect(struct ceph_connection *con)
 
 	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
 
-	if (con->auth_reply_buf) {
+	if (con->auth) {
 		/*
 		 * Any connection that defines ->get_authorizer()
 		 * should also define ->verify_authorizer_reply().
-- 
2.17.1



