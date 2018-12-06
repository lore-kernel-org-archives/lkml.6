Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD2C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894D920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107960;
	bh=AUC7K+ItJMmQFmhNeVp7Er8dv2isWWXEMJa/ASKCqWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fw+mj94mJg3vbZ0TGYl24Fx5VC+HqeMVmgusWU7abzy/mEiMX1atHX2TfuaqUYrGL
	 FcFs7TBURmgZrNeP1sre713cp7/6tjeMfXghEvDSxQAbPEMBa43sTGEnrwFvF0/9Os
	 Ti0P3evCreoFTWTPOooFFD1JkTKa96+5riorYXNU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894D920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLFOwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731163AbeLFOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32289214DE;
        Thu,  6 Dec 2018 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107554;
        bh=AUC7K+ItJMmQFmhNeVp7Er8dv2isWWXEMJa/ASKCqWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hluVsbMQhUu8sVEXIQT7aAJ6snnr0BT4VkwG+aQs+IGkL4V3ZvqmtehdYo7cbW9KY
         i/MDr3LxrliQp8uojnWnINSJULdtHgQQQ8h+YxKKvh5NWRCSEyv8RrSC8iw8Cmj/XO
         pp9ye5u9WdcL/QhnWsRtEV9uwToNJbI99l+1bMrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 051/101] libceph: factor out __prepare_write_connect()
Date:   Thu,  6 Dec 2018 15:38:50 +0100
Message-Id: <20181206143014.490007108@linuxfoundation.org>
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

commit c0f56b483aa09c99bfe97409a43ad786f33b8a5a upstream.

Will be used for sending ceph_msg_connect with an updated authorizer,
after the server challenges the initial authorizer.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1429,6 +1429,17 @@ static void prepare_write_banner(struct
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
@@ -1464,15 +1475,7 @@ static int prepare_write_connect(struct
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
 


