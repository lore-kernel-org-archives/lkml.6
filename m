Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CADC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69392214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1FsIJyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69392214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeLDLBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeLDLB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6A8214DA;
        Tue,  4 Dec 2018 11:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921288;
        bh=zIpY8F+JiG+m/864PA+hlhGCicXD0bDbzFX7XInSxAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1FsIJybUZnMr81tcT/MtqIkggNA5fooOKM5OsV436AopoRekAAbiF+O6G+XsqENI
         JJRi92oj6Lwz7hv8fqc8RuYH/WkIJ465tWkgklruuxzVg3nsrNuPywKItlPv4j/z/j
         Uq7zmnOAiWiNO2tNX1tSStatXG8w0Hjp6prxuXho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 014/146] libceph: factor out __prepare_write_connect()
Date:   Tue,  4 Dec 2018 11:48:20 +0100
Message-Id: <20181204103727.370612327@linuxfoundation.org>
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

commit c0f56b483aa09c99bfe97409a43ad786f33b8a5a upstream.

Will be used for sending ceph_msg_connect with an updated authorizer,
after the server challenges the initial authorizer.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ceph/messenger.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 3a82e6d2864b..0b121327d32f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1446,6 +1446,17 @@ static void prepare_write_banner(struct ceph_connection *con)
 	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }
 
+static void __prepare_write_connect(struct ceph_connection *con)
+{
+	con_out_kvec_add(con, sizeof(con->out_connect), &con->out_connect);
+	if (con->auth)
+		con_out_kvec_add(con, con->auth->authorizer_buf_len,
+				 con->auth->authorizer_buf);
+
+	con->out_more = 0;
+	con_flag_set(con, CON_FLAG_WRITE_PENDING);
+}
+
 static int prepare_write_connect(struct ceph_connection *con)
 {
 	unsigned int global_seq = get_global_seq(con->msgr, 0);
@@ -1481,15 +1492,7 @@ static int prepare_write_connect(struct ceph_connection *con)
 	if (ret)
 		return ret;
 
-	con_out_kvec_add(con, sizeof (con->out_connect),
-					&con->out_connect);
-	if (con->auth)
-		con_out_kvec_add(con, con->auth->authorizer_buf_len,
-				 con->auth->authorizer_buf);
-
-	con->out_more = 0;
-	con_flag_set(con, CON_FLAG_WRITE_PENDING);
-
+	__prepare_write_connect(con);
 	return 0;
 }
 
-- 
2.17.1



