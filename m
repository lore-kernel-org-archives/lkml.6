Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDABC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E1E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OhESBxDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E1E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeG3JQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:16:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sFQPrcmfh1Bqshuavg6FV/LLy/vWrEyjJdclmfofkiY=; b=OhESBxDmavmRO1nKsFjWDeBmq
        LhPWIjmtC7apJ09notdnNH38s2oXT606KAmXX8fDCKW+cOBFSI2l68v41wfJRPYsxJ0nd3KdpbNsR
        d2OEkgDGe2VoOVtfdQ6HrtS3sC0oYvl638iklgMlB0n3Jm5dYN+mfnM3AKsylRN6+ecLMo9jCfBvr
        VSbx2Xuw9xlttIuw5+fi0dn/d66o54lUs6NH5YPLQPAL7MaSbp6gkQSq0MqQ8csYXE9CzaVI8HN43
        sOV7V+ifqiSJb+HWZMrE9IARJkQiBJQPtnHsa4MHqEAdYJSHAi/OW792I5iBlopULWYRwWsLvn+0u
        1mfIsJoJQ==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2p0-0002K6-P2; Mon, 30 Jul 2018 07:42:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] net: don not detour through struct sock to find the poll waitqueue
Date:   Mon, 30 Jul 2018 09:42:11 +0200
Message-Id: <20180730074213.16832-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730074213.16832-1-hch@lst.de>
References: <20180730074213.16832-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For any open socket file descriptor sock->sk->sk_wq->wait will always
point to sock->wq->wait.  That means we can do the shorter dereference
and removal a NULL check and don't have to not worry about any RCU
protection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sock.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 762069bb0d8c..7927541101a8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2001,10 +2001,9 @@ static inline bool skwq_has_sleeper(struct socket_wq *wq)
 static inline void sock_poll_wait(struct file *filp, poll_table *p)
 {
 	struct socket *sock = filp->private_data;
-	wait_queue_head_t *wq = sk_sleep(sock->sk);
 
-	if (!poll_does_not_wait(p) && wq) {
-		poll_wait(filp, wq, p);
+	if (!poll_does_not_wait(p)) {
+		poll_wait(filp, &sock->wq->wait, p);
 		/* We need to be sure we are in sync with the
 		 * socket flags modification.
 		 *
-- 
2.18.0

