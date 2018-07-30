Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A5FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436CD20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jD3g3Ron"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436CD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeG3Itc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:49:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeG3Itb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ALI25aMQxkllk3JebdVfnhKX+zJBphTEhy43gAvxda0=; b=jD3g3Rons9+GdqQWaktHyiYBJ
        0g3z5M22HzdmNh/Ye7lhXL/gphIKnw68MgJJBHUILwSG/k+SBAoAPmkbIYuYOnY/fmB6A3sMn899v
        U3icotnbgrxq9khKSIHOZUhWSFSNwbh7PSpvCB6CNcti4w7iwSFraT6HUjidQMQA1GRUYb7LPTICB
        abcL/q7Rskimc5+QEtFqb6x34Xjmjrv2BqABXpS7Tjrs4BxvUkp4HaVpvBsz7a/LeysJdM+dXdAbN
        8VbT9TIVHSOC27JfTVpJs/GNCtZ9LXJRXkeJu2LYJtcrrBgGVLJY6PPIT9IQBp1NsRnkB2VgtCqzW
        xwAuhDebA==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2PL-0008Ij-88; Mon, 30 Jul 2018 07:15:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] timerfd: add support for keyed wakeups
Date:   Mon, 30 Jul 2018 09:15:41 +0200
Message-Id: <20180730071544.23998-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730071544.23998-1-hch@lst.de>
References: <20180730071544.23998-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares timerfd for use with aio poll.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/timerfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index cdad49da3ff7..f6c54fd56645 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -66,7 +66,7 @@ static void timerfd_triggered(struct timerfd_ctx *ctx)
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
 	ctx->expired = 1;
 	ctx->ticks++;
-	wake_up_locked(&ctx->wqh);
+	wake_up_locked_poll(&ctx->wqh, EPOLLIN);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 }
 
@@ -107,7 +107,7 @@ void timerfd_clock_was_set(void)
 		if (ctx->moffs != moffs) {
 			ctx->moffs = KTIME_MAX;
 			ctx->ticks++;
-			wake_up_locked(&ctx->wqh);
+			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
 		}
 		spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 	}
@@ -345,7 +345,7 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		spin_lock_irq(&ctx->wqh.lock);
 		if (!timerfd_canceled(ctx)) {
 			ctx->ticks = ticks;
-			wake_up_locked(&ctx->wqh);
+			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
 		} else
 			ret = -ECANCELED;
 		spin_unlock_irq(&ctx->wqh.lock);
-- 
2.18.0

