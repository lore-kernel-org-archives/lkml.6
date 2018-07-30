Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B06FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656FC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvrmrOYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656FC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeG3JQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:16:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s5qFTvrlp2xuwEGoixxS8KCCtBL9o/gW6AzrxemXmNA=; b=lvrmrOYvOqAV27XUmvPBD4tmc
        IKZhgtAzWhWbWqjbSmCTHm5WMHKM3LwFHxJYpSZAZ8xJoTPZZi53pdC5Xm/kiVJnPke9m/VKCUYu4
        vzf5991iRp5RDQJ/E3PN4S1OPDT4resWdj1tPAHjkZyzt+/+qwRAyUzcFxpZCvC0JJgena+A47sZC
        P8JfNNBcetbd+stoONrHAo3hneGLdH5Sfq9gz4lLyWLH9qIG0fEbtjUxuPjowVnlbT0ZMLGVjvzWB
        0QCc4HTl/Hna2WcLyya3aegp6GHoM09YGF4576zgA8lJUnDSCny1Y99Zfl+eRua8/6jBgnT4bNeq4
        eiA5cMu7A==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2p9-0002LJ-PM; Mon, 30 Jul 2018 07:42:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] net: remove sock_poll_busy_flag
Date:   Mon, 30 Jul 2018 09:42:13 +0200
Message-Id: <20180730074213.16832-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730074213.16832-1-hch@lst.de>
References: <20180730074213.16832-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold it into the only caller to make the code simpler and easier to read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/busy_poll.h |  6 ------
 net/socket.c            | 16 +++++++++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 25d762cf47f2..71c72a939bf8 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -121,12 +121,6 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
 #endif
 }
 
-/* if this socket can poll_ll, tell the system call */
-static inline __poll_t sock_poll_busy_flag(struct socket *sock)
-{
-	return sk_can_busy_loop(sock->sk) ? POLL_BUSY_LOOP : 0;
-}
-
 /* used in the NIC receive handler to mark the skb */
 static inline void skb_mark_napi_id(struct sk_buff *skb,
 				    struct napi_struct *napi)
diff --git a/net/socket.c b/net/socket.c
index 674434127b3a..5b7df6695f4f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1130,15 +1130,21 @@ EXPORT_SYMBOL(sock_create_lite);
 static __poll_t sock_poll(struct file *file, poll_table *wait)
 {
 	struct socket *sock = file->private_data;
-	__poll_t events = poll_requested_events(wait);
+	__poll_t events = poll_requested_events(wait), flag = 0;
 
 	if (!sock->ops->poll)
 		return 0;
 
-	/* poll once if requested by the syscall */
-	if (sk_can_busy_loop(sock->sk) && (events & POLL_BUSY_LOOP))
-		sk_busy_loop(sock->sk, 1);
-	return sock->ops->poll(file, sock, wait) | sock_poll_busy_flag(sock);
+	if (sk_can_busy_loop(sock->sk)) {
+		/* poll once if requested by the syscall */
+		if (events & POLL_BUSY_LOOP)
+			sk_busy_loop(sock->sk, 1);
+
+		/* if this socket can poll_ll, tell the system call */
+		flag = POLL_BUSY_LOOP;
+	}
+
+	return sock->ops->poll(file, sock, wait) | flag;
 }
 
 static int sock_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.18.0

