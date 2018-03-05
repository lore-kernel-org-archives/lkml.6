Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeCECOY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:14:24 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:46955 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeCECOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:14:21 -0500
X-Google-Smtp-Source: AG47ELs40h7/nCy+6VFBdTZTPK2ZgNSUFIIdNB+OvWprbmIyFRQfgDwl4u9HwB6gMHkYCY8SwN0yBA==
Date: Mon, 5 Mar 2018 11:14:16 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20180305021416.GA6202@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
 <20180304130151.GA483@tigerII.localdomain>
 <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
 <20180304104324.6bbbaa53@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304104324.6bbbaa53@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/04/18 10:43), Steven Rostedt wrote:
> On Sun, 04 Mar 2018 23:08:23 +0800
> "Qixuan.Wu" <qixuan.wu@linux.alibaba.com> wrote:
> 
> > Suppose there is one scenario that the system has 100 CPU(0~99). While CPU 0 is 
> > calling slow console, CPU 1~99 are calling printk at the same time. And suppose 
> > CPU 1 will be waiter, as per the patch, 2~99 will return directly. After CPU 0 finish 
> > it's log to console, it will return when it finds CPU 1 are waiting. Then CPU 1 need 
> > flush all logs of CPU(1~99) to the console, which may cause  softlockup or rcu 
> > stall. Above scenario is very unusual and it's very unlikely to happen. 
> 
> Yes, people keep bringing up this scenario.

Yeah.

> It would require a single burst of printks to all CPUs.

That's one possibility. The other one is - console_sem locked by a
preemptible context which gets scheduled out.

> And then no more printks after that. The last one will end up printing
> the entire buffer out the slow console. The thing is, this is a bounded
> time, and no printk will print more than one full buffer worth.

It can print more than "one full buffer worth". In theory and on practice.

> If this is a worry, then set the timeouts for the lockup detection to
> be longer than the time it takes to print one full buffer with the
> slowest console.

I see your point.
But I still think that it makes sense to change that "print it all" approach.
With more clear/explicit watchdog-dependent limits - we do direct printk for
1/2 (or 2/3) of a current watchdog threshold value and offload if there is
more stuff in the logbuf. Implicit "logbuf size * console throughput" is
harder to understand. Disabling watchdog because of printk is a bit too much
of a compromise, probably.

IOW, is logbuf worth of messages so critically important after all that we
are ready to jeopardize the system stability?

	-ss
