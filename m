Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6841DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173B920883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LhZ+pgHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173B920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeGZJpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:45:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGZJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ALI25aMQxkllk3JebdVfnhKX+zJBphTEhy43gAvxda0=; b=LhZ+pgHBy0NURTyYzZXu9Lway
        ORv8sD5T3V3sHzISM8qCW1SYrp5qhW/by75rLh3BGdhYRIfXufd2tyz0C6SYOhdOkpwf1oOX7q+Nw
        d7lxNVCvAcGAksuZJMVRKI8MUJdE3bpq4noZsjqNBtMVMKWAKzJShzGPZOsK5livoc6NayijyG3k5
        wQZSN0VG7eDZK9ZoefkBZ4nykHJOUjYCfgJsu+pTLjvDhbTU4YK5DYym3O420LUDkRnr3zzfHPQ1R
        XuG2N/5sVA3ZsjQrcRliqt9pwNATpwWLqsLvfQtZQ3bTS6Ge/1wpWZ9qmuvZfyCy7fSeXILOZIHPh
        DjGb1P6ow==;
Received: from 089144199017.atnat0008.highway.a1.net ([89.144.199.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fibe6-0007xZ-Ue; Thu, 26 Jul 2018 08:29:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] timerfd: add support for keyed wakeups
Date:   Thu, 26 Jul 2018 10:29:00 +0200
Message-Id: <20180726082903.30273-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726082903.30273-1-hch@lst.de>
References: <20180726082903.30273-1-hch@lst.de>
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

