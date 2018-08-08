Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75433C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3760021722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3760021722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeHHMKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:10:48 -0400
Received: from verein.lst.de ([213.95.11.211]:37070 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbeHHMKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:10:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4229F68D60; Wed,  8 Aug 2018 11:57:19 +0200 (CEST)
Date:   Wed, 8 Aug 2018 11:57:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] aio: allow direct aio poll comletions for keyed
        wakeups
Message-ID: <20180808095719.GA20653@lst.de>
References: <20180806083058.14724-1-hch@lst.de> <20180806083058.14724-5-hch@lst.de> <20180806152705.37809e16c02543cc24626607@linux-foundation.org> <20180807072555.GA678@lst.de> <20180807090441.67f7e281f502ce448de849c1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807090441.67f7e281f502ce448de849c1@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:04:41AM -0700, Andrew Morton wrote:
> > Because it is faster obviously.  I can update the comment.
> 
> I meant the comment could explain why it's a trylock instead of a
> spin_lock().

We could something like this the patch below.

Al, do you want me to resend or can you just fold it in?

diff --git a/fs/aio.c b/fs/aio.c
index 5943098a87c6..84df2c2bf80b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1684,7 +1684,8 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 		/*
 		 * Try to complete the iocb inline if we can to avoid a costly
-		 * context switch.
+		 * context switch.  As the waitqueue lock nests inside the ctx
+		 * lock we can only do that if we can get it without waiting.
 		 */
 		if (spin_trylock(&iocb->ki_ctx->ctx_lock)) {
 			list_del(&iocb->ki_list);


