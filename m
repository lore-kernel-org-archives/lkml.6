Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5412075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277083;
	bh=d5YQuquVD6bxthsKrHTAqERQo3z2Ph4R/n52/QWapoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jikt5hZywOBMYASOhg30q4nEOX87IK+AEocdj3BqRClp8Cijobt/ODnUWy1yq8DCF
	 CWbgQzv41ODwGbWUZ9hZn3l6u/Hy7OOuZu7KOoKyH1jRqbWpADLbMRuNeBnsdFb4zY
	 enis7gRfSA0LBs8Qp38wZcrSypHHpGo3pAHxrUfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfBDKom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfBDKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:44:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7B02070C;
        Mon,  4 Feb 2019 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277079;
        bh=d5YQuquVD6bxthsKrHTAqERQo3z2Ph4R/n52/QWapoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1JJqOelAG+sdky6gm/4UuxpY9/wKMaZdGhkiPBTkHvIlhIS3EBKaazlKYCqkDHSw
         vCrYQqdqRrfHmkapxEOOHdVUp7PKMg8vTs7mk5VCud6rvDnk/1BSHl9M8vh5NnJHWL
         Q7js/zORH3ynFy/g0zc4RqbiziaHC936V2Iv/H5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/46] sctp: improve the events for sctp stream adding
Date:   Mon,  4 Feb 2019 11:36:46 +0100
Message-Id: <20190204103611.296551145@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 8220c870cb0f4eaa4e335c9645dbd9a1c461c1dd ]

This patch is to improve sctp stream adding events in 2 places:

  1. In sctp_process_strreset_addstrm_out(), move up SCTP_MAX_STREAM
     and in stream allocation failure checks, as the adding has to
     succeed after reconf_timer stops for the in stream adding
     request retransmission.

  3. In sctp_process_strreset_addstrm_in(), no event should be sent,
     as no in or out stream is added here.

Fixes: 50a41591f110 ("sctp: implement receiver-side procedures for the Add Outgoing Streams Request Parameter")
Fixes: c5c4ebb3ab87 ("sctp: implement receiver-side procedures for the Add Incoming Streams Request Parameter")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -642,6 +642,16 @@ struct sctp_chunk *sctp_process_strreset
 	if (!(asoc->strreset_enable & SCTP_ENABLE_CHANGE_ASSOC_REQ))
 		goto out;
 
+	in = ntohs(addstrm->number_of_streams);
+	incnt = stream->incnt + in;
+	if (!in || incnt > SCTP_MAX_STREAM)
+		goto out;
+
+	streamin = krealloc(stream->in, incnt * sizeof(*streamin),
+			    GFP_ATOMIC);
+	if (!streamin)
+		goto out;
+
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
@@ -665,16 +675,6 @@ struct sctp_chunk *sctp_process_strreset
 		}
 	}
 
-	in = ntohs(addstrm->number_of_streams);
-	incnt = stream->incnt + in;
-	if (!in || incnt > SCTP_MAX_STREAM)
-		goto out;
-
-	streamin = krealloc(stream->in, incnt * sizeof(*streamin),
-			    GFP_ATOMIC);
-	if (!streamin)
-		goto out;
-
 	memset(streamin + stream->incnt, 0, in * sizeof(*streamin));
 	stream->in = streamin;
 	stream->incnt = incnt;
@@ -750,9 +750,6 @@ struct sctp_chunk *sctp_process_strreset
 
 	result = SCTP_STRRESET_PERFORMED;
 
-	*evp = sctp_ulpevent_make_stream_change_event(asoc,
-		0, 0, ntohs(addstrm->number_of_streams), GFP_ATOMIC);
-
 out:
 	sctp_update_strreset_result(asoc, result);
 err:


