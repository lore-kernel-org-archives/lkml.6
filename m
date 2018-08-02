Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA53C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A35214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A35214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeHBLIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:08:10 -0400
Received: from verein.lst.de ([213.95.11.211]:38731 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbeHBLIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:08:10 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3564D68D64; Thu,  2 Aug 2018 11:22:34 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:22:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Message-ID: <20180802092234.GA13797@lst.de>
References: <20180730071544.23998-1-hch@lst.de> <20180730071544.23998-4-hch@lst.de> <20180802002121.GU30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802002121.GU30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 01:21:22AM +0100, Al Viro wrote:
> So what happens if
> 	* we call aio_poll(), add the sucker to queue and see that we need
> to wait
> 	* add to ->active_refs just as the wakeup comes

active_reqs I guess..

> 	* wakeup removes from queue and hits schedule_work()
> 	* io_cancel() is called, triggering aio_poll_cancel(), which sees that
> we are not from queue and buggers off.  We are gone from ->active_refs.
> 	* aio_poll_complete_work() is called, sees no ->cancelled
> 	* aio_poll_complete_work() calls vfs_poll(), sees nothing interesting
> and puts us back on the queue.

So let me draw this up, we start with the following:

THREAD 1					THREAD 2

aio_poll
  vfs_poll(...)
    add_wait_queue()

  (no pending mask)

  spin_lock_irq(&ctx->ctx_lock);
  list_add_tail(..., &ctx->active_reqs)		aio_poll_wake
  spin_unlock_irq(&ctx->ctx_lock);

						(spin_trylock failed)
						list_del_init(&req->wait.entry);
						schedule_work(&req->work);

Now switching to two new threads:

io_cancel thread			worker thread

					vfs_poll()
					  (mask = 0)

aio_poll_cancel
  (not on waitqueue, done)
  remove from active_reqs

					  add_wait_queue()
					  iocb still around

> 
> Unless I'm misreading it, cancel will end up with iocb still around and now
> impossible to cancel...  What am I missing?

Yes, I think you are right. I'll see how I could handle that case.
One of the easiest options would be to just support aio poll on
file ops that support keyed wakeups, we'd just need to pass that
information up.
