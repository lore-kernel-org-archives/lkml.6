Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DEC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BDB20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497914;
	bh=xK7dIq6F+BdDvqjpvghMfsgAYdeQj2scHNq9zYtiWcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPWK5F887ehH+AgxDOEdOX08u6DinzUK3L3mVkrJbGIDK8r8MU/mNNFi8MSr1NGPJ
	 TEWhKbDo06D0HZMRtTqUcXTKsQvRF2k0iflpEPCdjCSMmpXCY28+lp/SCIlXQoq2Lj
	 Tsc20h0+LMUrvnjbNHSerOcfvwnSK/y0pPeoGOOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfBRNvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbfBRNvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6B420842;
        Mon, 18 Feb 2019 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497910;
        bh=xK7dIq6F+BdDvqjpvghMfsgAYdeQj2scHNq9zYtiWcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZW4Isw8j9VlxeHZhlvReVAzFsg5qlk08902mrXw4ixg3fRnQLiwhVeWY/hPX5t/aP
         RwRQjSyIqzdzVaJ+2x3cm3Min7UHn8UPcEcwcWjpkDOQ5AmveV/biZEsUx0DZW273l
         vkZ4DP2cNfJvTGgCel22eMaZclyHEd7mblNdw0T4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/85] CIFS: Do not assume one credit for async responses
Date:   Mon, 18 Feb 2019 14:43:15 +0100
Message-Id: <20190218133504.904673208@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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
index 8a01e89ff827..1e5a1171212f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2814,9 +2814,10 @@ smb2_echo_callback(struct mid_q_entry *mid)
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
@@ -3073,7 +3074,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb2_sync_hdr *shdr =
 				(struct smb2_sync_hdr *)rdata->iov[0].iov_base;
-	unsigned int credits_received = 1;
+	unsigned int credits_received = 0;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
 				 .rq_pages = rdata->pages,
@@ -3112,6 +3113,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		task_io_account_read(rdata->got_bytes);
 		cifs_stats_bytes_read(tcon, rdata->got_bytes);
 		break;
+	case MID_RESPONSE_MALFORMED:
+		credits_received = le16_to_cpu(shdr->CreditRequest);
+		/* fall through */
 	default:
 		if (rdata->result != -ENODATA)
 			rdata->result = -EIO;
@@ -3305,7 +3309,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
 	unsigned int written;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)mid->resp_buf;
-	unsigned int credits_received = 1;
+	unsigned int credits_received = 0;
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -3333,6 +3337,9 @@ smb2_writev_callback(struct mid_q_entry *mid)
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



