Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbeDRO3z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753975AbeDRO3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:29:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95824204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 10:29:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180418102943.5aa0ffc4@gandalf.local.home>
In-Reply-To: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2018 12:01:45 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1888,6 +1888,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
>  
> +	wake_up_klogd();
>  	logbuf_unlock_irqrestore(flags);

You can't do this, because the scheduler can call printk_deferred()
with the rq lock held, and printk_deferred() will grab the logbuf lock.

Calling wake_up_klogd() will grab the rq lock and give us a A-B<->B-A
locking order.

-- Steve
