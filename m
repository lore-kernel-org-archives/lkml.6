Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935977AbeCST0L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:26:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33450 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935964AbeCST0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:26:00 -0400
X-Google-Smtp-Source: AG47ELv/IJe9OgRj6N5l3L4SIKYv5AMPOIGSCK/OnIEQLlhY2XHQ3/mth+HveURApbzRW09Y7MWscQ==
Date: Mon, 19 Mar 2018 12:25:58 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Matthew Wilcox <willy@infradead.org>
cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
In-Reply-To: <20180319191609.23880-1-willy@infradead.org>
Message-ID: <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
References: <20180319191609.23880-1-willy@infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Matthew Wilcox wrote:

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
>  	status = wq->status;
>  
>  	/*

I understand converting the wait_event_interruptible() to 
wait_event_killable(), but why was the above wait_event_interruptible() 
only called when wq->name.name != NULL?  

wait_event_{killable,interruptible}() will return without sleeping when 
wq->name.name == NULL, so I suppose it has something to do with the 
comment above it.
