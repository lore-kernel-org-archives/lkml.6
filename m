Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeCTB7N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:59:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55739 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750999AbeCTB7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:59:07 -0400
X-ME-Sender: <xms:6mqwWpyEI1z-tO4pIck94h5lxOZWU4qhJFg6TkT6KMSmqmh16Y0_vA>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180319191609.23880-1-willy@infradead.org>
From: Ian Kent <raven@themaw.net>
Message-ID: <7dae3cc8-bad1-ec18-bcf1-ae91a87f74fa@themaw.net>
Date: Tue, 20 Mar 2018 09:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319191609.23880-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/18 03:16, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>

Hi Matthew,

> 
> This playing with signals to allow only fatal signals appears to predate
> the introduction of wait_event_killable(), and I'm fairly sure that
> wait_event_killable is what was meant to happen here.

Predates is an understatement, this is really, really old code.
Do I need to forward this to Al or Andrew?

> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs4/waitq.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index a0c57c37fa21..c160e9b3aa0f 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -19,9 +19,6 @@
>   */
>  static autofs_wqt_t autofs4_next_wait_queue = 1;
>  
> -/* These are the signals we allow interrupting a pending mount */
> -#define SHUTDOWN_SIGS	(sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))
> -
>  void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
>  {
>  	struct autofs_wait_queue *wq, *nwq;
> @@ -486,29 +483,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
>  	 * wq->name.name is NULL iff the lock is already released
>  	 * or the mount has been made catatonic.
>  	 */
> -	if (wq->name.name) {
> -		/* Block all but "shutdown" signals while waiting */
> -		unsigned long shutdown_sigs_mask;
> -		unsigned long irqflags;
> -		sigset_t oldset;
> -
> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
> -		oldset = current->blocked;
> -		shutdown_sigs_mask = SHUTDOWN_SIGS & ~oldset.sig[0];
> -		siginitsetinv(&current->blocked, shutdown_sigs_mask);
> -		recalc_sigpending();
> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> -
> -		wait_event_interruptible(wq->queue, wq->name.name == NULL);
> -
> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
> -		current->blocked = oldset;
> -		recalc_sigpending();
> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
> -	} else {
> -		pr_debug("skipped sleeping\n");
> -	}
> -
> +	wait_event_killable(wq->queue, wq->name.name == NULL);

The wait event code looks like this will wake up on most any unmasked signal.
But my assumption is that TASK_KILLABLE tasks are only forwarded specific
signals ...

Is that right or am I missing something?

>  	status = wq->status;
>  
>  	/*
> 
