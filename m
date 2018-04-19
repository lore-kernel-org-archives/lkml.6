Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDSBXR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:23:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33897 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:23:15 -0400
X-Google-Smtp-Source: AIpwx48zFz+Igsa6QIeCN5P+mJSm+y0/WBAvAl0r6x6ko/Z4G9Ubi5RMFhht8hkymX0tByBkjjS1yA==
Date: Thu, 19 Apr 2018 10:23:11 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180419012311.GB2700@jagdpanzerIV>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
 <20180418140409.6hvkbip4skfs4x7y@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418140409.6hvkbip4skfs4x7y@pathway.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/18/18 16:04), Petr Mladek wrote:
[..]
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 2f4af216bd6e..86f0b337cbf6 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1888,6 +1888,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  
> >  	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
> >  
> > +	wake_up_klogd();
> >  	logbuf_unlock_irqrestore(flags);
> 
> The change makes perfect sense and I am fine with the idea. I just
> wonder if there is a strong reason to do the wake_up before
> releasing the logbuf_lock. It makes an assumption that it needs
> to be synchronized by logbuf_lock.

No, not really, just wanted to wakeup klogd from the same CPU which
called printk().

> In fact, I would feel more comfortable if we move this to the end
> of vprintk_emit() right before return printk_len. This will be
> more close to the current behavior (console first). But it will
> still wakeup klogd much earlier and regularly if there is
> a flood of messages.

Hm, the idea of the patch is that the existing "push everything to slow
consoles first, then wakeup syslog" is not very robust. But probably we
can do what you suggested, yes.

	-ss
