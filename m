Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C70C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B102083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762531;
	bh=O1oML94p9jdakQP/mcPiKy/t7hYH/AenvUIDAnOxxKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTF535pD7WZdBA9rs9Lj778Mxa251wMZulfoIR6SFmln98Gp65lWgeUJBwg7AG663
	 dBv0ChIl41hj2Gq2hfTIN9oZ5Hok4VGvNx9kemFee4mhgeTaj47fyoh8xHiUnH8GVz
	 /+mde7s4xbVJpMchM3zYSPi+vAKwOXWeEJA15HC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfA2Lst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730846AbfA2Lsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E472083B;
        Tue, 29 Jan 2019 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762520;
        bh=O1oML94p9jdakQP/mcPiKy/t7hYH/AenvUIDAnOxxKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jqfanum13ZOdD5lc5JyaeMDV5LiEqtAilPkwPxIu8E02reCyxChnLyW17vKDazWCT
         Lgx1Z1FPxEs4lD7ZY1wdBbCSEif+GRK8luatGBzxoq+ZzA5W7t2zTP88VmezKH+hvg
         Jq0Uqz/HIuX4zSAlt7NYX6Cf2KuH0Kj/0th/oUxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.14 32/68] CIFS: Fix credit calculation for encrypted reads with errors
Date:   Tue, 29 Jan 2019 12:35:54 +0100
Message-Id: <20190129113134.258089600@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

From: Pavel Shilovsky <pshilov@microsoft.com>

commit ec678eae746dd25766a61c4095e2b649d3b20b09 upstream.

We do need to account for credits received in error responses
to read requests on encrypted sessions.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2531,11 +2531,23 @@ handle_read_data(struct TCP_Server_Info
 			server->ops->is_status_pending(buf, server, 0))
 		return -1;
 
-	rdata->result = server->ops->map_error(buf, false);
+	/* set up first two iov to get credits */
+	rdata->iov[0].iov_base = buf;
+	rdata->iov[0].iov_len = 4;
+	rdata->iov[1].iov_base = buf + 4;
+	rdata->iov[1].iov_len =
+		min_t(unsigned int, buf_len, server->vals->read_rsp_size) - 4;
+	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
+		 rdata->iov[0].iov_base, rdata->iov[0].iov_len);
+	cifs_dbg(FYI, "1: iov_base=%p iov_len=%zu\n",
+		 rdata->iov[1].iov_base, rdata->iov[1].iov_len);
+
+	rdata->result = server->ops->map_error(buf, true);
 	if (rdata->result != 0) {
 		cifs_dbg(FYI, "%s: server returned error %d\n",
 			 __func__, rdata->result);
-		dequeue_mid(mid, rdata->result);
+		/* normal error on read response */
+		dequeue_mid(mid, false);
 		return 0;
 	}
 
@@ -2605,14 +2617,6 @@ handle_read_data(struct TCP_Server_Info
 		return 0;
 	}
 
-	/* set up first iov for signature check */
-	rdata->iov[0].iov_base = buf;
-	rdata->iov[0].iov_len = 4;
-	rdata->iov[1].iov_base = buf + 4;
-	rdata->iov[1].iov_len = server->vals->read_rsp_size - 4;
-	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
-		 rdata->iov[0].iov_base, server->vals->read_rsp_size);
-
 	length = rdata->copy_into_pages(server, rdata, &iter);
 
 	kfree(bvec);


