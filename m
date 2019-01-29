Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAD4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F146E2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762293;
	bh=Cv3Sj+gQSTHsvNqo6qDvLj7U+IddWqA9QArsABqZYAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVykNbAvRPneURGGk8PFkqS+D1dNQlMj0OIg4YP1yDTplxObIpffkOQr9nG7RlWiU
	 YIr/qXhCtrHsxkOfGi8KPeOoqZAjYieAZdjbsMJWkM53qRTLruEauLKT+VBnOhzd4o
	 8OXx/dNtj8/eFTTxxxWx59L+SgKe1m87cuRTMAtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfA2Lov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbfA2Lot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723702083B;
        Tue, 29 Jan 2019 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762287;
        bh=Cv3Sj+gQSTHsvNqo6qDvLj7U+IddWqA9QArsABqZYAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOQTyb+JnHxORR4bhLGabdjxAiKWokiXdiZc0HWJHfGR6dTdYK31vxBWCzvd1hczx
         PvqLz5fouxitKzjcNoLBSLWVyxG2DdU526ZpddHPm5WF7HXtHdB8meWPOBnJelWMIE
         Bxb8vlQ60XhcTjx5VqiKkylCcvJLn73gWloDQaEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 054/103] CIFS: Fix credits calculations for reads with errors
Date:   Tue, 29 Jan 2019 12:35:31 +0100
Message-Id: <20190129113203.674301548@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit 8004c78c68e894e4fd5ac3c22cc22eb7dc24cabc upstream.

Currently we mark MID as malformed if we get an error from server
in a read response. This leads to not properly processing credits
in the readv callback. Fix this by marking such a response as
normal received response and process it appropriately.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifssmb.c |   35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1458,18 +1458,26 @@ cifs_discard_remaining_data(struct TCP_S
 }
 
 static int
-cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+__cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
+		     bool malformed)
 {
 	int length;
-	struct cifs_readdata *rdata = mid->callback_data;
 
 	length = cifs_discard_remaining_data(server);
-	dequeue_mid(mid, rdata->result);
+	dequeue_mid(mid, malformed);
 	mid->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
 }
 
+static int
+cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+{
+	struct cifs_readdata *rdata = mid->callback_data;
+
+	return  __cifs_readv_discard(server, mid, rdata->result);
+}
+
 int
 cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
@@ -1511,12 +1519,23 @@ cifs_readv_receive(struct TCP_Server_Inf
 		return -1;
 	}
 
+	/* set up first two iov for signature check and to get credits */
+	rdata->iov[0].iov_base = buf;
+	rdata->iov[0].iov_len = 4;
+	rdata->iov[1].iov_base = buf + 4;
+	rdata->iov[1].iov_len = server->total_read - 4;
+	cifs_dbg(FYI, "0: iov_base=%p iov_len=%zu\n",
+		 rdata->iov[0].iov_base, rdata->iov[0].iov_len);
+	cifs_dbg(FYI, "1: iov_base=%p iov_len=%zu\n",
+		 rdata->iov[1].iov_base, rdata->iov[1].iov_len);
+
 	/* Was the SMB read successful? */
 	rdata->result = server->ops->map_error(buf, false);
 	if (rdata->result != 0) {
 		cifs_dbg(FYI, "%s: server returned error %d\n",
 			 __func__, rdata->result);
-		return cifs_readv_discard(server, mid);
+		/* normal error on read response */
+		return __cifs_readv_discard(server, mid, false);
 	}
 
 	/* Is there enough to get to the rest of the READ_RSP header? */
@@ -1560,14 +1579,6 @@ cifs_readv_receive(struct TCP_Server_Inf
 		server->total_read += length;
 	}
 
-	/* set up first iov for signature check */
-	rdata->iov[0].iov_base = buf;
-	rdata->iov[0].iov_len = 4;
-	rdata->iov[1].iov_base = buf + 4;
-	rdata->iov[1].iov_len = server->total_read - 4;
-	cifs_dbg(FYI, "0: iov_base=%p iov_len=%u\n",
-		 rdata->iov[0].iov_base, server->total_read);
-
 	/* how much data is in the response? */
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	use_rdma_mr = rdata->mr;


