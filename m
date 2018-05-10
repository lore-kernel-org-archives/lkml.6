Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965413AbeEJOuu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:50:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64066 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964881AbeEJOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:50:49 -0400
To: sergey.senozhatsky.work@gmail.com, pmladek@suse.com
Cc: dvyukov@google.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
        <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
        <20180424013336.GA1376@jagdpanzerIV>
        <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
        <20180510042206.GA3426@jagdpanzerIV>
In-Reply-To: <20180510042206.GA3426@jagdpanzerIV>
Message-Id: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Thu, 10 May 2018 23:50:44 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky wrote:
> On (04/26/18 12:06), Petr Mladek wrote:
> > 
> > > Petr, Steven, Fengguang, what do you think? Do you have any objections?
> > > Ideas?
> > 
> > I wonder if we could create some mechanism that would help to extend
> > struct printk_log easier in the future.
> 
> Hm, interesting idea.
> 
> > I know only about crash tool implementation. It uses information provided
> > by log_buf_vmcoreinfo_setup(). The size of the structure is already
> > public. Therefore crash should be able to find all existing information
> > even if we increase the size of the structure.
> > 
> > log_buf_vmcoreinfo_setup() even allows to inform about newly added
> > structure items. We could probably extend it to inform also about
> > the offset of the new optional elements.
> 
> I vaguely remember that the last time Thomas Gleixner modified
> printk_log you managed to find a case that broke crash tool.
> ... Or may be I'm mistaken.
> 
> > I am not sure about other tools. But I think that it should be
> > doable.
> 
> Good. So there are no objections, so far.
> 
> Tetsuo, Dmitry, care to send a patch?
> 
> 	-ss
> 

What I meant is nothing but something like below (i.e. inject context ID before
string to print)

  -sprintf(printk_buf + offset, "[ %s] %s", stamp, string_to_print);
  +cpu = smp_processor_id()
  +if (in_nmi())
  +  sprintf(printk_buf + offset, "[ %s](N%u) %s", stamp, cpu, string_to_print);
  +else if (in_irq())
  +  sprintf(printk_buf + offset, "[ %s](I%u) %s", stamp, cpu, string_to_print);
  +else if (in_serving_softirq())
  +  sprintf(printk_buf + offset, "[ %s](S%u) %s", stamp, cpu, string_to_print);
  +else
  +  sprintf(printk_buf + offset, "[ %s](%u) %s", stamp, current->pid, string_to_print);

without touching any struct.
