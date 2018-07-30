Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B728220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fo+SeFKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B728220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeG3JQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:16:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeG3JQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Es8QPWQAyjo+SskOgIb8yvM4bVL2nHpALV+JLLCGPSY=; b=fo+SeFKyr9OH+ZUP6uHyR1eBK
        SGAh0sAul/4cxHYhzWC+KvgNkMf9Xk4E2CAZVR86nh81Bcco5C6Od1bBzEZD+Nz5U80fXXDTNEN2Q
        LRIfZlcBo/05G25o4V0guE5QVhH2i/edKNCeEEaohR7zLPPgrpXI/xJHdGlSCpZsPVEPi6vGeE3tO
        NzWK8ES1MecvXQKLYsqBEUeAu9emMCdPz4f1rGzT2IW9W8T5u9OOAAAIwnuOu7+kFNXBQhfbHn3lx
        3DWQWubf7iFn5OWVvaYLd2UxQhMQcTSfS+2kwdCKEEKXZ42Qyyu1mnQ9HO5E08pgjkwH9xnQAJa4H
        8FZekLnzw==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2p5-0002Kn-9r; Mon, 30 Jul 2018 07:42:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] net: remove sock_poll_busy_loop
Date:   Mon, 30 Jul 2018 09:42:12 +0200
Message-Id: <20180730074213.16832-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730074213.16832-1-hch@lst.de>
References: <20180730074213.16832-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in hiding this logic in a helper.  Also remove the
useless events != 0 check and only busy loop once we know we actually
have a poll method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/busy_poll.h | 9 ---------
 net/socket.c            | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index c5187438af38..25d762cf47f2 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -121,15 +121,6 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
-static inline void sock_poll_busy_loop(struct socket *sock, __poll_t events)
-{
-	if (sk_can_busy_loop(sock->sk) &&
-	    events && (events & POLL_BUSY_LOOP)) {
-		/* once, only if requested by syscall */
-		sk_busy_loop(sock->sk, 1);
-	}
-}
-
 /* if this socket can poll_ll, tell the system call */
 static inline __poll_t sock_poll_busy_flag(struct socket *sock)
 {
diff --git a/net/socket.c b/net/socket.c
index 85633622c94d..674434127b3a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1132,9 +1132,12 @@ static __poll_t sock_poll(struct file *file, poll_table *wait)
 	struct socket *sock = file->private_data;
 	__poll_t events = poll_requested_events(wait);
 
-	sock_poll_busy_loop(sock, events);
 	if (!sock->ops->poll)
 		return 0;
+
+	/* poll once if requested by the syscall */
+	if (sk_can_busy_loop(sock->sk) && (events & POLL_BUSY_LOOP))
+		sk_busy_loop(sock->sk, 1);
 	return sock->ops->poll(file, sock, wait) | sock_poll_busy_flag(sock);
 }
 
-- 
2.18.0

