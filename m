Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629DDC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D6A2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277907;
	bh=BI1EpIr3cndYRavDDNAuRiHeFQu4v7/2sYRGC4VEZoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lf3T8Bkyj5A8IBPe2JsGjn9/bzxnYXArozf4xVZqCeh3d66/o9jHsZMPm6geF6ve7
	 TZpETrXUVpHOdhRFmsDAltenQdAlGCix6tVM8Dp36SM6e6FjuFN1ftVx9Z9UYBnre+
	 +IWx4SLFIebzYY59EtxyOVV2Adrnb9Bx5oRuAP6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbfBDK6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfBDKu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45ED3217D6;
        Mon,  4 Feb 2019 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277458;
        bh=BI1EpIr3cndYRavDDNAuRiHeFQu4v7/2sYRGC4VEZoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjdYPU5D0gc8B8bGBw7dnnU6L05VSESYV8dX0BmcRjCgnbMXtI10T/OzeWuYiNBPL
         pZAx5Eilvz3Jg08oDMC7W6ae5X3UHcFCuhszH7mAYAmW55sRzLmDH9srlYcUAjN2Uy
         VEqsKT7W9UG31JjaAGsR4U5AX9OGU7Fxv0kn9ggU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 19/80] sctp: improve the events for sctp stream adding
Date:   Mon,  4 Feb 2019 11:36:39 +0100
Message-Id: <20190204103622.924632496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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
 net/sctp/stream.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -866,6 +866,14 @@ struct sctp_chunk *sctp_process_strreset
 	if (!(asoc->strreset_enable & SCTP_ENABLE_CHANGE_ASSOC_REQ))
 		goto out;
 
+	in = ntohs(addstrm->number_of_streams);
+	incnt = stream->incnt + in;
+	if (!in || incnt > SCTP_MAX_STREAM)
+		goto out;
+
+	if (sctp_stream_alloc_in(stream, incnt, GFP_ATOMIC))
+		goto out;
+
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
@@ -889,14 +897,6 @@ struct sctp_chunk *sctp_process_strreset
 		}
 	}
 
-	in = ntohs(addstrm->number_of_streams);
-	incnt = stream->incnt + in;
-	if (!in || incnt > SCTP_MAX_STREAM)
-		goto out;
-
-	if (sctp_stream_alloc_in(stream, incnt, GFP_ATOMIC))
-		goto out;
-
 	stream->incnt = incnt;
 
 	result = SCTP_STRRESET_PERFORMED;
@@ -966,9 +966,6 @@ struct sctp_chunk *sctp_process_strreset
 
 	result = SCTP_STRRESET_PERFORMED;
 
-	*evp = sctp_ulpevent_make_stream_change_event(asoc,
-		0, 0, ntohs(addstrm->number_of_streams), GFP_ATOMIC);
-
 out:
 	sctp_update_strreset_result(asoc, result);
 err:


