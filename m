Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB57BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BF020894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BF020894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeHBCJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:09:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44072 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeHBCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:09:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fl1Mo-0004KG-5B; Thu, 02 Aug 2018 00:21:22 +0000
Date:   Thu, 2 Aug 2018 01:21:22 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Message-ID: <20180802002121.GU30522@ZenIV.linux.org.uk>
References: <20180730071544.23998-1-hch@lst.de>
 <20180730071544.23998-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730071544.23998-4-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:15:43AM +0200, Christoph Hellwig wrote:

> +static void aio_poll_complete_work(struct work_struct *work)
> +{
> +	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
> +	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
> +	struct poll_table_struct pt = { ._key = req->events };
> +	struct kioctx *ctx = iocb->ki_ctx;
> +	__poll_t mask;
> +
> +	if (READ_ONCE(req->cancelled)) {
....
> +	}
> +
> +	mask = vfs_poll(req->file, &pt) & req->events;
> +	if (!mask) {
> +		add_wait_queue(req->head, &req->wait);
> +		return;
> +	}
....
> +}

> +/* assumes we are called with irqs disabled */
> +static int aio_poll_cancel(struct kiocb *iocb)
> +{
> +	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
> +	struct poll_iocb *req = &aiocb->poll;
> +
> +	spin_lock(&req->head->lock);
> +	if (!list_empty(&req->wait.entry)) {
> +		WRITE_ONCE(req->cancelled, true);
> +		list_del_init(&req->wait.entry);
> +		schedule_work(&aiocb->poll.work);
> +	}
> +	spin_unlock(&req->head->lock);
> +
> +	return 0;
> +}

> +static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
> +		void *key)
> +{
> +	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
> +	__poll_t mask = key_to_poll(key);
> +
> +	/* for instances that support it check for an event match first: */
> +	if (mask && !(mask & req->events))
> +		return 0;
> +
> +	list_del_init(&req->wait.entry);
> +	schedule_work(&req->work);
> +	return 1;
> +}

> +static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
> +{
> +	struct kioctx *ctx = aiocb->ki_ctx;
> +	struct poll_iocb *req = &aiocb->poll;
> +	struct aio_poll_table apt;
> +	__poll_t mask;

> +	mask = vfs_poll(req->file, &apt.pt) & req->events;
> +	if (mask || apt.error) {

> +	} else {
> +		spin_lock_irq(&ctx->ctx_lock);
> +		if (!req->done) {
> +			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
> +			aiocb->ki_cancel = aio_poll_cancel;
> +		}
> +		spin_unlock_irq(&ctx->ctx_lock);
> +	}

So what happens if
	* we call aio_poll(), add the sucker to queue and see that we need
to wait
	* add to ->active_refs just as the wakeup comes
	* wakeup removes from queue and hits schedule_work()
	* io_cancel() is called, triggering aio_poll_cancel(), which sees that
we are not from queue and buggers off.  We are gone from ->active_refs.
	* aio_poll_complete_work() is called, sees no ->cancelled
	* aio_poll_complete_work() calls vfs_poll(), sees nothing interesting
and puts us back on the queue.

Unless I'm misreading it, cancel will end up with iocb still around and now
impossible to cancel...  What am I missing?
