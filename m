Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeCFCAc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:00:32 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:43152 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeCFCAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:00:31 -0500
X-Google-Smtp-Source: AG47ELudaUX4O448KEf2t67XbKi+t+5LeNcGhps/fbZLoMNA6IILGoD80DTfiYrImMD3mrXrPwHE0Q==
Date: Tue, 6 Mar 2018 11:00:26 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180306020026.GB6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
 <20180304130151.GA483@tigerII.localdomain>
 <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
 <20180304104324.6bbbaa53@gandalf.local.home>
 <20180305021416.GA6202@jagdpanzerIV>
 <20180305154524.2056b773@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305154524.2056b773@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/05/18 15:45), Steven Rostedt wrote:
> On Mon, 5 Mar 2018 11:14:16 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > It can print more than "one full buffer worth". In theory and on practice.
> 
> How so? As soon as another process adds to the buffer, it will take
> over the printing.

The very same CPU which holds the console_sem can add messages to the
logbuf.

There are at least 3 cases I can easily think of.


#1 preemption under console_sem

console_lock()
 for (;;) {
  local_irq_save()
  call_console_drivers()
  local_irq_restore()
  << preemption >>
       printk // from another task, same CPU
 }


#2 IRQ->printk under console_sem

console_lock()
 for (;;) {
  local_irq_save()
  call_console_drivers()
  local_irq_restore()
  << IRQ >>
       printk
 }


#3 This, eventually, becomes #2. But the root cause and, thus,
probability are completely different. printks from console drivers
(some console drivers are really complex, with dependencies on timers,
networking, etc. etc.). We currently handle those via
printk_safe -> IRQ work. But I think we kinda should stop doing so.

console_lock()
 for (;;) {
  local_irq_save()
  call_console_drivers()
   printk()
  local_irq_restore()
 }

	-ss
