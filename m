Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0596C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A13221848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691258;
	bh=Gu/bul+kriYcN94uMrAWo0kYYB3ZX3NjGr/JJYtEsAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFi9JoMLtzseN5mKbTsynu/QUZkWua06Dyb5kITv8kaM8YLHEWcDtt3OlDKWGIV/1
	 s13LApvkohLp9vF++bYiMKHqLjzrChW0CdenvWfQlMxWqwEJMf80dHr0zzbuldQi0d
	 Z5XPzSXDVafUsnYp3Ih6A9chIC8Sw/SHMABuY5I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfA1QA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbfA1QAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1F82175B;
        Mon, 28 Jan 2019 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691253;
        bh=Gu/bul+kriYcN94uMrAWo0kYYB3ZX3NjGr/JJYtEsAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6/fSta1O/uUeoo6huvfrICdD77myvzd/8Pe0Np2Z0yh+AB1dOvE3P4v7/2oDTkQ4
         NbPkOHK6NN2MXNIbXPALkZ1Dn5rbCAMKEDxZi75GA0Naws7/scR/km08eFlBoW883D
         SOFgvl0AZ1K0d/oCom8ovZZ5UbQo5jVb1W9WU1FQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 033/258] sctp: Fix SKB list traversal in sctp_intl_store_ordered().
Date:   Mon, 28 Jan 2019 10:55:39 -0500
Message-Id: <20190128155924.51521-33-sashal@kernel.org>
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

[ Upstream commit e15e067d0656625c77c52b4e5f0cfbf0c0c3583f ]

Same change as made to sctp_intl_store_reasm().

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
index 0a78cdf86463..500449b72eca 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -383,7 +383,7 @@ static void sctp_intl_store_ordered(struct sctp_ulpq *ulpq,
 				    struct sctp_ulpevent *event)
 {
 	struct sctp_ulpevent *cevent;
-	struct sk_buff *pos;
+	struct sk_buff *pos, *loc;
 
 	pos = skb_peek_tail(&ulpq->lobby);
 	if (!pos) {
@@ -403,18 +403,25 @@ static void sctp_intl_store_ordered(struct sctp_ulpq *ulpq,
 		return;
 	}
 
+	loc = NULL;
 	skb_queue_walk(&ulpq->lobby, pos) {
 		cevent = (struct sctp_ulpevent *)pos->cb;
 
-		if (cevent->stream > event->stream)
+		if (cevent->stream > event->stream) {
+			loc = pos;
 			break;
-
+		}
 		if (cevent->stream == event->stream &&
-		    MID_lt(event->mid, cevent->mid))
+		    MID_lt(event->mid, cevent->mid)) {
+			loc = pos;
 			break;
+		}
 	}
 
-	__skb_queue_before(&ulpq->lobby, pos, sctp_event2skb(event));
+	if (!loc)
+		__skb_queue_tail(&ulpq->lobby, sctp_event2skb(event));
+	else
+		__skb_queue_before(&ulpq->lobby, loc, sctp_event2skb(event));
 }
 
 static void sctp_intl_retrieve_ordered(struct sctp_ulpq *ulpq,
-- 
2.19.1

