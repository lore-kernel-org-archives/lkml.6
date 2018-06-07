Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Jm++NjEQGVtmFgAAmS7hNA
	; Thu, 07 Jun 2018 11:00:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CEC14608B8; Thu,  7 Jun 2018 11:00:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2EB57607DC;
	Thu,  7 Jun 2018 11:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EB57607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeFGLAj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:00:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36177 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932251AbeFGLAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:00:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF345ACAE;
        Thu,  7 Jun 2018 11:00:34 +0000 (UTC)
Date: Thu, 7 Jun 2018 13:00:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in console_unlock
Message-ID: <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607051019.GA10406@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-06-07 14:10:19, Sergey Senozhatsky wrote:
> Cc-ing more people
> Link: lkml.kernel.org/r/00000000000087008b056df8fbb3@google.com
> 
> On (06/06/18 06:17), syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    af6c5d5e01ad Merge branch 'for-4.18' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=173d93ef800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=12ff770540994680
> > dashboard link: https://syzkaller.appspot.com/bug?extid=43e93968b964e369db0b
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > userspace arch: i386
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16e00bb7800000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com
> 
> IOW
> 
>     tty ioctl
>     tty_port->lock		IRQ
>     printk			uart_port->lock
>     console_owner
>     uart_port->lock		tty_port->rlock

Great analyze!


> The simplest thing to do [not necessarily the right one, tho]
> would be to break the IOCTL ==> tty_port->lock ==> printk ==> uart_port->lock
> chain.
> 
> E.g. by adding __GFP_NOWARN
> 
> ---
> 
>  drivers/tty/tty_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index c996b6859c5e..71958ef6a831 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>  	   have queued and recycle that ? */
>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>  		return NULL;
> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
> +			GFP_ATOMIC | __GFP_NOWARN);
>  	if (p == NULL)
>  		return NULL;
> 
> ---

This looks like the most simple solution for this particular problem.
I am just afraid that there are many other locations like this.


> Another way could be - switch to printk_safe mode around that
> kmalloc():
> 
> 	__printk_safe_enter();
> 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> 	__printk_safe_exit();
> 
> Or, may be, we even can switch to printk_safe mode every time we grab
> tty_port lock.
 
> Perhaps something like this should be done for uart_port->lock
> as well. Because, technically, we can have the following

Yeah, we would need this basically around any lock that can be taken
from console write() callbacks. Well, this would be needed even
around locks that might be in a chain with a lock used in these
callbacks (as shown by this report).

BTW: printk_safe context might be too strict. In fact,
printk_deferred() would be enough. We might think about
introducing also printk_deferred context.

Best Regards,
Petr
