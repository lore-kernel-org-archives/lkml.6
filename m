Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F73C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D4721852
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691262;
	bh=NthfVLmFK4e51EX0vCEjH2dF1Fxphnp2dyblMH1Fims=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0AjRXtiEJ3H/We8dtm2Nv4ds5N/NTIdpjmyD2Sl4aNt3xNPFmUr908N0+yWjY7QZ
	 LELTd18uDsLXdY1WaCx/WxZneLzVZw2x3xPvEzPIAfm2U0JDwIB7bwXw1FuJ3hYDkQ
	 ATu9/gdjtmMPzlsFapM/zdMpt4KfQYLDjr6kQk7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfA1QBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730525AbfA1QA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F121321848;
        Mon, 28 Jan 2019 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691255;
        bh=NthfVLmFK4e51EX0vCEjH2dF1Fxphnp2dyblMH1Fims=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0Nj0afq3laPzK4gymDQs/58jcOORWhwNvGrC0SBMZ9eQZOY6I92wThrr34ta/mbL
         2cUI3BPpCYBrPaXmgRv1lxXKtX215ip4ow/uVD7kj147MESYgGybrUldcbuACjOAL1
         dd0ifpWdLsa9YBIgog6EJoeWzKSQm7pqZJtpGkUA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 034/258] sctp: Fix SKB list traversal in sctp_intl_store_reasm().
Date:   Mon, 28 Jan 2019 10:55:40 -0500
Message-Id: <20190128155924.51521-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 348bbc25c40844c5efa083a3842c7f53d70a815e ]

To be fully correct, an iterator has an undefined value when something
like skb_queue_walk() naturally terminates.

This will actually matter when SKB queues are converted over to
list_head.

Formalize what this code ends up doing with the current
implementation.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/stream_interleave.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 500449b72eca..2b499a85db0e 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -140,7 +140,7 @@ static void sctp_intl_store_reasm(struct sctp_ulpq *ulpq,
 				  struct sctp_ulpevent *event)
 {
 	struct sctp_ulpevent *cevent;
-	struct sk_buff *pos;
+	struct sk_buff *pos, *loc;
 
 	pos = skb_peek_tail(&ulpq->reasm);
 	if (!pos) {
@@ -166,23 +166,30 @@ static void sctp_intl_store_reasm(struct sctp_ulpq *ulpq,
 		return;
 	}
 
+	loc = NULL;
 	skb_queue_walk(&ulpq->reasm, pos) {
 		cevent = sctp_skb2event(pos);
 
 		if (event->stream < cevent->stream ||
 		    (event->stream == cevent->stream &&
-		     MID_lt(event->mid, cevent->mid)))
+		     MID_lt(event->mid, cevent->mid))) {
+			loc = pos;
 			break;
-
+		}
 		if (event->stream == cevent->stream &&
 		    event->mid == cevent->mid &&
 		    !(cevent->msg_flags & SCTP_DATA_FIRST_FRAG) &&
 		    (event->msg_flags & SCTP_DATA_FIRST_FRAG ||
-		     event->fsn < cevent->fsn))
+		     event->fsn < cevent->fsn)) {
+			loc = pos;
 			break;
+		}
 	}
 
-	__skb_queue_before(&ulpq->reasm, pos, sctp_event2skb(event));
+	if (!loc)
+		__skb_queue_tail(&ulpq->reasm, sctp_event2skb(event));
+	else
+		__skb_queue_before(&ulpq->reasm, loc, sctp_event2skb(event));
 }
 
 static struct sctp_ulpevent *sctp_intl_retrieve_partial(
-- 
2.19.1

