Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeCFCrk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752586AbeCFCrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:47:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114F820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Mar 2018 21:47:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180305214701.7434d030@gandalf.local.home>
In-Reply-To: <20180306020026.GB6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
        <20180304130151.GA483@tigerII.localdomain>
        <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
        <20180304104324.6bbbaa53@gandalf.local.home>
        <20180305021416.GA6202@jagdpanzerIV>
        <20180305154524.2056b773@gandalf.local.home>
        <20180306020026.GB6713@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 11:00:26 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (03/05/18 15:45), Steven Rostedt wrote:
> > On Mon, 5 Mar 2018 11:14:16 +0900
> > Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >   
> > > It can print more than "one full buffer worth". In theory and on practice.  
> > 
> > How so? As soon as another process adds to the buffer, it will take
> > over the printing.  
> 
> The very same CPU which holds the console_sem can add messages to the
> logbuf.
> 
> There are at least 3 cases I can easily think of.
> 
> 
> #1 preemption under console_sem
> 
> console_lock()
>  for (;;) {
>   local_irq_save()
>   call_console_drivers()
>   local_irq_restore()
>   << preemption >>

At this moment all watchdogs are working fine. And the continuing will
be done as if it was the first printk. No lockup eminent.

>        printk // from another task, same CPU
>  }
> 
> 
> #2 IRQ->printk under console_sem
> 
> console_lock()
>  for (;;) {
>   local_irq_save()
>   call_console_drivers()
>   local_irq_restore()
>   << IRQ >>
>        printk

So basically, the CPU is just printing what that CPU is printing. It
only becomes an issue if the system has an issue (one CPU spamming
printk). Which is another bug.

>  }
> 
> 
> #3 This, eventually, becomes #2. But the root cause and, thus,
> probability are completely different. printks from console drivers
> (some console drivers are really complex, with dependencies on timers,
> networking, etc. etc.). We currently handle those via
> printk_safe -> IRQ work. But I think we kinda should stop doing so.
> 
> console_lock()
>  for (;;) {
>   local_irq_save()
>   call_console_drivers()
>    printk()

Which is another issue as well. But this is due to issues with printk
having issues, and is a different category of bug.

#2 and #3 are more recursive bugs and not a "printk locks up due to
other CPUs" kind of bug.

-- Steve


>   local_irq_restore()
>  }
> 
> 	-ss
