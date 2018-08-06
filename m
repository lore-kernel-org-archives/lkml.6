Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4A1219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uI6C9yNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4A1219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeHFKjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:39:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1G96aVFaZFl36Z/5Y41sYbs81BsoMI/LAX/3IqVeoJc=; b=uI6C9yNguYzhnwNjmzRy+HWty
        8nWFvGmVPgYr8vcccz/bzQCdFkH3aHkxWfg9MMzaTpcUctAAzVw5jgjXe+lla564mJ86Wg7aKpaew
        sRG4kUSNuIz7BlEN7AQDT+RF8PRFnkOsE3pGRcP3Qsj6mOI/dD6d+EtTg34YpSFoNtrVwdLJ9t6y2
        7Ep4zL1O8c9EIRRpCffjZD9ckDAa8OIuCQoNVmKHaUiGxgGNgKbgF0mGAdv8MzUZMbsdG0UX3hIN/
        f0OnrI0rJ+bOOoU77hoqBIuFGQuqJli7PKTPh18+7wk0l/rOY/iPxHFKsziK/a+cN0m6KAqmKbN4Q
        /GnLmUjEQ==;
Received: from 212095005054.public.telering.at ([212.95.5.54] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmauv-0001Na-EQ; Mon, 06 Aug 2018 08:31:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] timerfd: add support for keyed wakeups
Date:   Mon,  6 Aug 2018 10:30:55 +0200
Message-Id: <20180806083058.14724-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806083058.14724-1-hch@lst.de>
References: <20180806083058.14724-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares timerfd for use with aio poll.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Avi Kivity <avi@scylladb.com>
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

