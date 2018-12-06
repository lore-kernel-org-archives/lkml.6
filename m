Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC2C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12B920850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107969;
	bh=oAbc86acppTaZVuUAg/mb9e1RwBuheDrnpjjmcDLD0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V57WhyM9Vegpndy+fvZuq0DOPy0R+xTy2Nag6Sa+D881Rbh02zTTCfHFv5dEG1xFw
	 G7MW1Jw1jHUP+/pbipGl1DMUNjK0PCbP/fz82MT+Reu2NOgsZPIkGlbEV8nqvWg1Og
	 UO1KEPrNEWx7gGntC/GGv9phvEsdZoQG7gd/aT1o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12B920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeLFOpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730611AbeLFOpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630B62082B;
        Thu,  6 Dec 2018 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107546;
        bh=oAbc86acppTaZVuUAg/mb9e1RwBuheDrnpjjmcDLD0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9UUELf86M57ZevT3Y9XHjX/u+Tpv0Ka39yx1Cy3YQTaMC8cXV64kqB0JSqrkoPHA
         P93i/y/baunvN6YPGsPfgSud/V984nfO4Tvyw5t1ib+rA/qOoOt0qmUGzgTYq4z+xO
         f0DMTH/ngtzDu86mwl4/GWRdW1HXqPbtZjZT0erg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 048/101] libceph: drop len argument of *verify_authorizer_reply()
Date:   Thu,  6 Dec 2018 15:38:47 +0100
Message-Id: <20181206143014.329343547@linuxfoundation.org>
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

commit 0dde584882ade13dc9708d611fbf69b0ae8a9e48 upstream.

The length of the reply is protocol-dependent - for cephx it's
ceph_x_authorize_reply.  Nothing sensible can be passed from the
messenger layer anyway.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/mds_client.c           |    4 ++--
 include/linux/ceph/auth.h      |    5 ++---
 include/linux/ceph/messenger.h |    2 +-
 net/ceph/auth.c                |    4 ++--
 net/ceph/auth_x.c              |    2 +-
 net/ceph/messenger.c           |    2 +-
 net/ceph/osd_client.c          |    4 ++--
 7 files changed, 11 insertions(+), 12 deletions(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3984,13 +3984,13 @@ static struct ceph_auth_handshake *get_a
 }
 
 
-static int verify_authorizer_reply(struct ceph_connection *con, int len)
+static int verify_authorizer_reply(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
 	struct ceph_auth_client *ac = mdsc->fsc->client->monc.auth;
 
-	return ceph_auth_verify_authorizer_reply(ac, s->s_auth.authorizer, len);
+	return ceph_auth_verify_authorizer_reply(ac, s->s_auth.authorizer);
 }
 
 static int invalidate_authorizer(struct ceph_connection *con)
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -64,7 +64,7 @@ struct ceph_auth_client_ops {
 	int (*update_authorizer)(struct ceph_auth_client *ac, int peer_type,
 				 struct ceph_auth_handshake *auth);
 	int (*verify_authorizer_reply)(struct ceph_auth_client *ac,
-				       struct ceph_authorizer *a, size_t len);
+				       struct ceph_authorizer *a);
 	void (*invalidate_authorizer)(struct ceph_auth_client *ac,
 				      int peer_type);
 
@@ -118,8 +118,7 @@ extern int ceph_auth_update_authorizer(s
 				       int peer_type,
 				       struct ceph_auth_handshake *a);
 extern int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
-					     struct ceph_authorizer *a,
-					     size_t len);
+					     struct ceph_authorizer *a);
 extern void ceph_auth_invalidate_authorizer(struct ceph_auth_client *ac,
 					    int peer_type);
 
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -30,7 +30,7 @@ struct ceph_connection_operations {
 	struct ceph_auth_handshake *(*get_authorizer) (
 				struct ceph_connection *con,
 			       int *proto, int force_new);
-	int (*verify_authorizer_reply) (struct ceph_connection *con, int len);
+	int (*verify_authorizer_reply) (struct ceph_connection *con);
 	int (*invalidate_authorizer)(struct ceph_connection *con);
 
 	/* there was some error on the socket (disconnect, whatever) */
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -315,13 +315,13 @@ int ceph_auth_update_authorizer(struct c
 EXPORT_SYMBOL(ceph_auth_update_authorizer);
 
 int ceph_auth_verify_authorizer_reply(struct ceph_auth_client *ac,
-				      struct ceph_authorizer *a, size_t len)
+				      struct ceph_authorizer *a)
 {
 	int ret = 0;
 
 	mutex_lock(&ac->mutex);
 	if (ac->ops && ac->ops->verify_authorizer_reply)
-		ret = ac->ops->verify_authorizer_reply(ac, a, len);
+		ret = ac->ops->verify_authorizer_reply(ac, a);
 	mutex_unlock(&ac->mutex);
 	return ret;
 }
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -623,7 +623,7 @@ static int ceph_x_update_authorizer(
 }
 
 static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
-					  struct ceph_authorizer *a, size_t len)
+					  struct ceph_authorizer *a)
 {
 	struct ceph_x_authorizer *au = (void *)a;
 	void *p = au->enc_buf;
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2045,7 +2045,7 @@ static int process_connect(struct ceph_c
 		 * should also define ->verify_authorizer_reply().
 		 * See get_connect_authorizer().
 		 */
-		ret = con->ops->verify_authorizer_reply(con, 0);
+		ret = con->ops->verify_authorizer_reply(con);
 		if (ret < 0) {
 			con->error_msg = "bad authorize reply";
 			return ret;
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4479,13 +4479,13 @@ static struct ceph_auth_handshake *get_a
 }
 
 
-static int verify_authorizer_reply(struct ceph_connection *con, int len)
+static int verify_authorizer_reply(struct ceph_connection *con)
 {
 	struct ceph_osd *o = con->private;
 	struct ceph_osd_client *osdc = o->o_osdc;
 	struct ceph_auth_client *ac = osdc->client->monc.auth;
 
-	return ceph_auth_verify_authorizer_reply(ac, o->o_auth.authorizer, len);
+	return ceph_auth_verify_authorizer_reply(ac, o->o_auth.authorizer);
 }
 
 static int invalidate_authorizer(struct ceph_connection *con)


