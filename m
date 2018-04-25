Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AB8JxZpJxLX0EZS1eMBsxZvn+AjnnXe+/ioNbhXfPn5u6ny+1Eu7Am1koTLZPOlAS8N8fdOBgQFT
ARC-Seal: i=1; a=rsa-sha256; t=1524667192; cv=none;
        d=google.com; s=arc-20160816;
        b=pHsLhpjm+65hYFqQyQQE8viwU52HUDLqbF3nz/15TH3fIFyxvpU9QnoFrFMuWTmRmV
         wrpPpFWSTk9JehrbUDw5QAYzl3Iz31A/pECilHct6NOCI7mj54qEzgDu1bY1WawafEdG
         INhzuQNdi8kCo61pK9le52hFO1ZrWxQOT2PGZqsF5x2QkqGXelyG1gKNPG0OeKB31Wva
         knHDLqjL7jgc7HJqa0cETRZZl406Vrm9iTofOkUh0KRUqbzMRl4dyIbXVgLE5X+DTMOt
         vIof5igmOs+79gGcgsQEByh6Qc+f2xZxSXsedmTnzQxjuDnp8pia7lrINKwfDflUZV+V
         eeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=VkYFyjaKEO6ycwZ1P9TKjfsZKSVjq+ymwcQ5AumqZgc=;
        b=gHRaqt0SuW0mwH9w+tg60T5VGBKuxqPJmJ5oi2xuDXSN/8HAe0XjcYvm7U9wWWdS5n
         EYSnNP5Y0NCZ8wccZPb6y9e/QN3kLPIFZN5m+qt/8Vkgx/yAh8bE3Szv4pMAVERB7xpu
         FINpvaqa9QoCecUVc4tdYC2Gcei/9ZCCDaaL0mEolk+XlKjsIJ8FTsW9Ym6QTBEqikbZ
         1A7TYviROID4hYI+OHd4S/ku36b/fXkQMY4Sgt1to6pblmRNq/EimmtkHFFCz+sX/13U
         ADGg8wiUrNCJu56OMM3MNOcEqNzhtn9zrftd5dsZJh76jv7DVMivmFh4ntwNuia9jCIJ
         5FWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Wed, 25 Apr 2018 15:39:48 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, byoungyoung@purdue.edu,
        kt0755@gmail.com, bammanag@purdue.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Fix data race in tty_insert_flip_string_fixed_flag
Message-ID: <20180425153948.7be2bc57@alans-desktop>
In-Reply-To: <20180425132047.GA20337@dragonet.kaist.ac.kr>
References: <20180425132047.GA20337@dragonet.kaist.ac.kr>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598724459634518298?=
X-GMAIL-MSGID: =?utf-8?q?1598729425412121115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018 22:20:50 +0900
DaeRyong Jeong <threeearcat@gmail.com> wrote:

> tty_insert_flip_string_fixed_flag() copies chars to the buffer indicated
> by th->used and updates tb->used.
> But tty_insert_flip_string_fixed_flag() can be executed concurrently and
> tb->used can be updated improperly.

The tty input layer does not work if it can be executed concurrently. If
that is happening in the pty code then the pty code is buggy and that
needs serializing on the inbound path.


> -static void tty_write_unlock(struct tty_struct *tty)
> +void tty_write_unlock(struct tty_struct *tty, int wakeup)
>  {
>  	mutex_unlock(&tty->atomic_write_lock);
> -	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
> +	if (wakeup) {
> +		wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
> +	}

And this may cause deadlocks.

You don't actually need any of the wakeup changes in your code

> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index d9b561d89432..a54ab91aec90 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -911,12 +911,17 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
>  			spin_unlock_irq(&tty->flow_lock);
>  			break;
>  		case TCOON:
> +			if (tty_write_lock(tty, 0) < 0)
> +				return -ERESTARTSYS;
> +
>  			spin_lock_irq(&tty->flow_lock);
>  			if (tty->flow_stopped) {
>  				tty->flow_stopped = 0;
>  				__start_tty(tty);
>  			}
>  			spin_unlock_irq(&tty->flow_lock);
> +
> +			tty_write_unlock(tty, 0);

If you just used these unmodified it would be simpler and as good,
however it won't actually fix anything. The pty layer is broken not this
code.

The tty layer rule for all the input buffer handling is that you may not
call *any* of it from multiple threads at once. This works fine for
normal serial because the IRQ layer or the polling logic has that
property.

The bug looks real, your diagnosis looks right, your fix sort of works
but isn't sufficient.

So NAK.

Alan
