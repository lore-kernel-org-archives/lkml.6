Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C510DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DA821901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497624;
	bh=bCvGPZ5/sbehWgXAoNZ8XOe+N01LQXS6OGzhkIRt99w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IpvscgcLJ30HIHJZsH9+FSYC99y+g1YBNXVEPXnficuFcQjabT5kbfLSA6D8MGbY6
	 iEYj4+giU8AO0Uiay7luQsDt6LzPON65cXgSsrUlVrji068K+3RyuGtU0ym+Weyz4E
	 pR65HhfJYhza9eObhftTNmm3XcQvpo0uulOJ7QFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfBRNrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbfBRNqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E3921901;
        Mon, 18 Feb 2019 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497614;
        bh=bCvGPZ5/sbehWgXAoNZ8XOe+N01LQXS6OGzhkIRt99w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fG9V6lgrhBBzTdcDC/jW2mYMeo8TtjKkVKN1Ao7vV43ZdYCOaW9QBcc+NGWbkVrhc
         Du1zPP0FU7x/7fFHm/aKQkhhJJcNFQh+t2Blp/m0uiuqPC/giE720RgKNgYybpcTcY
         FPQmvZj3Su/X8TRFwXeJfcBeKrDXDf+qCb9bv7o8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 47/92] CIFS: Do not assume one credit for async responses
Date:   Mon, 18 Feb 2019 14:42:50 +0100
Message-Id: <20190218133459.115314463@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0fd1d37b0501efc6e295f56ab55cdaff784aa50c ]

If we don't receive a response we can't assume that the server
granted one credit. Assume zero credits in such cases.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index c393ac255af7..28712080add9 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2826,9 +2826,10 @@ smb2_echo_callback(struct mid_q_entry *mid)
 {
 	struct TCP_Server_Info *server = mid->callback_data;
 	struct smb2_echo_rsp *rsp = (struct smb2_echo_rsp *)mid->resp_buf;
-	unsigned int credits_received = 1;
+	unsigned int credits_received = 0;
 
-	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+	if (mid->mid_state == MID_RESPONSE_RECEIVED
+	    || mid->mid_state == MID_RESPONSE_MALFORMED)
 		credits_received = le16_to_cpu(rsp->sync_hdr.CreditRequest);
 
 	DeleteMidQEntry(mid);
@@ -3085,7 +3086,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb2_sync_hdr *shdr =
 				(struct smb2_sync_hdr *)rdata->iov[0].iov_base;
-	unsigned int credits_received = 1;
+	unsigned int credits_received = 0;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
 				 .rq_pages = rdata->pages,
@@ -3124,6 +3125,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		task_io_account_read(rdata->got_bytes);
 		cifs_stats_bytes_read(tcon, rdata->got_bytes);
 		break;
+	case MID_RESPONSE_MALFORMED:
+		credits_received = le16_to_cpu(shdr->CreditRequest);
+		/* fall through */
 	default:
 		if (rdata->result != -ENODATA)
 			rdata->result = -EIO;
@@ -3317,7 +3321,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
 	unsigned int written;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)mid->resp_buf;
-	unsigned int credits_received = 1;
+	unsigned int credits_received = 0;
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -3345,6 +3349,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	case MID_RETRY_NEEDED:
 		wdata->result = -EAGAIN;
 		break;
+	case MID_RESPONSE_MALFORMED:
+		credits_received = le16_to_cpu(rsp->sync_hdr.CreditRequest);
+		/* fall through */
 	default:
 		wdata->result = -EIO;
 		break;
-- 
2.19.1



