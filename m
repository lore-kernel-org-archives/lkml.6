Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeDABbU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:31:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42161 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751163AbeDABbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:31:18 -0400
X-ME-Sender: <xms:YzbAWqRMLpcO7euSX-g1rRNpzxwVNAqRNtgY8ob39F0cfCdSsLMiKQ>
Subject: Re: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
To: Andrei Vagin <avagin@openvz.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20180331022839.21277-1-avagin@openvz.org>
From: Ian Kent <raven@themaw.net>
Message-ID: <ebdc431d-cea8-378c-aae5-3b7441bb93c0@themaw.net>
Date: Sun, 1 Apr 2018 09:31:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180331022839.21277-1-avagin@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/18 10:28, Andrei Vagin wrote:
> In "autofs4: use wait_event_killable",  wait_event_interruptible() was
> replaced by wait_event_killable(), but in this case we have to use
> wake_up() instead of wake_up_interruptible().

Why do you believe wake_up() is needed rather than wake_up_interruptible()?

Now that I'm thinking about the wake up I'm wondering if this is in fact
what's needed. Rather, I think maybe wake_up_all() is probably the only
one that will actually do what's needed.

There's an individual wait queue for each mount, there can be multiple
waiters for a mount, they all should be woken up when the daemon signals
mount completion.

> 
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ian Kent <raven@themaw.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> ---
>  fs/autofs4/waitq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index c160e9b3aa0f..be9c3dc048ab 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
>  	kfree(wq->name.name);
>  	wq->name.name = NULL;	/* Do not wait on this queue */
>  	wq->status = status;
> -	wake_up_interruptible(&wq->queue);
> +	wake_up(&wq->queue);
>  	if (!--wq->wait_ctr)
>  		kfree(wq);
>  	mutex_unlock(&sbi->wq_mutex);
> 
