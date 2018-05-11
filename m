Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbeEKBpV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:45:21 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40323 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKBpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:45:20 -0400
X-Google-Smtp-Source: AB8JxZo5hasCFCI9dxPMeBSu12eTsOBuv2iNqIgdESV2iRtrok3Bn3Jd/PRYGTMyL2at22CCj7mWrw==
Date: Fri, 11 May 2018 10:45:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        dvyukov@google.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180511014515.GA895@jagdpanzerIV>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
 <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
 <20180424013336.GA1376@jagdpanzerIV>
 <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
 <20180510042206.GA3426@jagdpanzerIV>
 <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/18 23:50), Tetsuo Handa wrote:
> What I meant is nothing but something like below (i.e. inject context ID before
> string to print)
> 
>   -sprintf(printk_buf + offset, "[ %s] %s", stamp, string_to_print);
>   +cpu = smp_processor_id()
>   +if (in_nmi())
>   +  sprintf(printk_buf + offset, "[ %s](N%u) %s", stamp, cpu, string_to_print);
>   +else if (in_irq())
>   +  sprintf(printk_buf + offset, "[ %s](I%u) %s", stamp, cpu, string_to_print);
>   +else if (in_serving_softirq())
>   +  sprintf(printk_buf + offset, "[ %s](S%u) %s", stamp, cpu, string_to_print);
>   +else
>   +  sprintf(printk_buf + offset, "[ %s](%u) %s", stamp, current->pid, string_to_print);
> 
> without touching any struct.

So you basically want to have one more con_msg_format_flags? Do
you want to track a context which prints out a messages or the
context which "generated" the message? A CPU/task that stores
a logbuf entry - vprintk_emit() - is not always the same as the
CPU/task that prints it to consoles - console_unlock().

	-ss
