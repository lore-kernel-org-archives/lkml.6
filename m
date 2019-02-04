Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D0C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD852073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278166;
	bh=GHoJbBvwnkYInhAK6C/yH0SqjY9KE3dew3GE0HYNPSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMKy4LDslrJ9paHE3xFKfl/3xT2ZJOB59BQlIi9jmJZfB+9rdDrUlSUiiwbHy50Xu
	 5Q0/Y/Ucp+sfAdLwJMJacdXj42G1mdEP2HZy5SA2Q1EHcmyCkDCK8dU1JByU/woVGJ
	 PHhL+MMxaORuYdLqryiE0/nxHBrBiLpEtv232rpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfBDKrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731532AbfBDKrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B732070C;
        Mon,  4 Feb 2019 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277220;
        bh=GHoJbBvwnkYInhAK6C/yH0SqjY9KE3dew3GE0HYNPSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05oT0k2uT9wEvrUmW5d0nqmf9xM44U+JXPhh9qsHsOGpdUk964GA1QXHKV5kDGJiQ
         KmtM0NLUEpI622/wQIso5nA6UBYmBQqO3bNm1iXbTdaGZLyZ39CPD9H1zfMlT9Zm+x
         Pef9rEn4SRIprWSN6n/9NYbR7IYVrbxhgj5pSEeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 15/74] sctp: improve the events for sctp stream reset
Date:   Mon,  4 Feb 2019 11:36:28 +0100
Message-Id: <20190204103621.504265742@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 2e6dc4d95110becfe0ff4c3d4749c33ea166e9e7 ]

This patch is to improve sctp stream reset events in 4 places:

  1. In sctp_process_strreset_outreq(), the flag should always be set with
     SCTP_STREAM_RESET_INCOMING_SSN instead of OUTGOING, as receiver's in
     stream is reset here.
  2. In sctp_process_strreset_outreq(), move up SCTP_STRRESET_ERR_WRONG_SSN
     check, as the reset has to succeed after reconf_timer stops for the
     in stream reset request retransmission.
  3. In sctp_process_strreset_inreq(), no event should be sent, as no in
     or out stream is reset here.
  4. In sctp_process_strreset_resp(), SCTP_STREAM_RESET_INCOMING_SSN or
     OUTGOING event should always be sent for stream reset requests, no
     matter it fails or succeeds to process the request.

Fixes: 810544764536 ("sctp: implement receiver-side procedures for the Outgoing SSN Reset Request Parameter")
Fixes: 16e1a91965b0 ("sctp: implement receiver-side procedures for the Incoming SSN Reset Request Parameter")
Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Reconf Response Parameter")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -585,9 +585,9 @@ struct sctp_chunk *sctp_process_strreset
 	struct sctp_strreset_outreq *outreq = param.v;
 	struct sctp_stream *stream = &asoc->stream;
 	__u32 result = SCTP_STRRESET_DENIED;
-	__u16 i, nums, flags = 0;
 	__be16 *str_p = NULL;
 	__u32 request_seq;
+	__u16 i, nums;
 
 	request_seq = ntohl(outreq->request_seq);
 
@@ -615,6 +615,15 @@ struct sctp_chunk *sctp_process_strreset
 	if (!(asoc->strreset_enable & SCTP_ENABLE_RESET_STREAM_REQ))
 		goto out;
 
+	nums = (ntohs(param.p->length) - sizeof(*outreq)) / sizeof(__u16);
+	str_p = outreq->list_of_streams;
+	for (i = 0; i < nums; i++) {
+		if (ntohs(str_p[i]) >= stream->incnt) {
+			result = SCTP_STRRESET_ERR_WRONG_SSN;
+			goto out;
+		}
+	}
+
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 				asoc, outreq->response_seq,
@@ -637,32 +646,19 @@ struct sctp_chunk *sctp_process_strreset
 			sctp_chunk_put(asoc->strreset_chunk);
 			asoc->strreset_chunk = NULL;
 		}
-
-		flags = SCTP_STREAM_RESET_INCOMING_SSN;
 	}
 
-	nums = (ntohs(param.p->length) - sizeof(*outreq)) / sizeof(__u16);
-	if (nums) {
-		str_p = outreq->list_of_streams;
-		for (i = 0; i < nums; i++) {
-			if (ntohs(str_p[i]) >= stream->incnt) {
-				result = SCTP_STRRESET_ERR_WRONG_SSN;
-				goto out;
-			}
-		}
-
+	if (nums)
 		for (i = 0; i < nums; i++)
 			SCTP_SI(stream, ntohs(str_p[i]))->mid = 0;
-	} else {
+	else
 		for (i = 0; i < stream->incnt; i++)
 			SCTP_SI(stream, i)->mid = 0;
-	}
 
 	result = SCTP_STRRESET_PERFORMED;
 
 	*evp = sctp_ulpevent_make_stream_reset_event(asoc,
-		flags | SCTP_STREAM_RESET_OUTGOING_SSN, nums, str_p,
-		GFP_ATOMIC);
+		SCTP_STREAM_RESET_INCOMING_SSN, nums, str_p, GFP_ATOMIC);
 
 out:
 	sctp_update_strreset_result(asoc, result);
@@ -738,9 +734,6 @@ struct sctp_chunk *sctp_process_strreset
 
 	result = SCTP_STRRESET_PERFORMED;
 
-	*evp = sctp_ulpevent_make_stream_reset_event(asoc,
-		SCTP_STREAM_RESET_INCOMING_SSN, nums, str_p, GFP_ATOMIC);
-
 out:
 	sctp_update_strreset_result(asoc, result);
 err:
@@ -1036,10 +1029,10 @@ struct sctp_chunk *sctp_process_strreset
 					sout->mid_uo = 0;
 				}
 			}
-
-			flags = SCTP_STREAM_RESET_OUTGOING_SSN;
 		}
 
+		flags |= SCTP_STREAM_RESET_OUTGOING_SSN;
+
 		for (i = 0; i < stream->outcnt; i++)
 			SCTP_SO(stream, i)->state = SCTP_STREAM_OPEN;
 
@@ -1058,6 +1051,8 @@ struct sctp_chunk *sctp_process_strreset
 		nums = (ntohs(inreq->param_hdr.length) - sizeof(*inreq)) /
 		       sizeof(__u16);
 
+		flags |= SCTP_STREAM_RESET_INCOMING_SSN;
+
 		*evp = sctp_ulpevent_make_stream_reset_event(asoc, flags,
 			nums, str_p, GFP_ATOMIC);
 	} else if (req->type == SCTP_PARAM_RESET_TSN_REQUEST) {


