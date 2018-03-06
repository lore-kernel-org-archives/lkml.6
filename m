Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeCFBwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 20:52:33 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37301 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbeCFBw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 20:52:28 -0500
X-Google-Smtp-Source: AG47ELskMG5xe5xAE+K/jbM690vvR45xIghbfM29+4Io8fDcjU55IEz3SBuolAJqAKykjK/d6B/umA==
Date: Tue, 6 Mar 2018 10:52:22 +0900
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
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180306015222.GA6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
 <20180304130151.GA483@tigerII.localdomain>
 <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
 <20180304104324.6bbbaa53@gandalf.local.home>
 <20180305021416.GA6202@jagdpanzerIV>
 <20180305155802.5c0f73fc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305155802.5c0f73fc@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

Let me Cc Tejun

On (03/05/18 15:58), Steven Rostedt wrote:
> On Mon, 5 Mar 2018 11:14:16 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> 
> > But I still think that it makes sense to change that "print it all" approach.
> > With more clear/explicit watchdog-dependent limits - we do direct printk for
> > 1/2 (or 2/3) of a current watchdog threshold value and offload if there is
> > more stuff in the logbuf. Implicit "logbuf size * console throughput" is
> > harder to understand. Disabling watchdog because of printk is a bit too much
> > of a compromise, probably.
> 
> If you know the baud rate, logbuf size * console throughput is actually
> trivial to calculate.
> 
> Let's see. CONFIG_LOG_BUF_SHIFT defaults to 18 (2^18 = 262144).
> Lets say we have a slow 9600 baud serial, which would give us:
>
>  262144 * 8 / 9600 = 219 (rounded up).
> 
> Thus, the worse case scenario would be 219 seconds to output the entire
> buffer. Add 10 seconds more for extra overhead, and then you have 229
> second watchdog that should never trigger because of a very slow
> console.
>
> (A more common 151200 baud modem would empty the buffer in 14 seconds).

Right. And when you register one more console (e.g. net console), you need
to re-calculate and re-adjust watchdog. When you set kernel log_buf_len
param (e.g. you might do log_buf_len=32G to store ftrace dumps from NMI)
you need to re-calculate and re-adjust watchdog, etc.

> > IOW, is logbuf worth of messages so critically important after all that we
> > are ready to jeopardize the system stability?
> 
> The stability is only in jeopardy if the watchdogs trigger, right?

Not limited to, watchdog threshold is at least deterministic.
Unlike, for instance, this guy

	rcu_read_lock()
	 printk()
	rcu_read_unlock()

It will block RCU grace periods. In the worst case this can become a
full-blown RCU stall and even OOM. In a less dramatic case this can
increase memory pressure, cause reclaimer activities, etc, which is not
a very good development, whether you have a small embedded device or a
server under high load, especially given that all you did was a bunch
of printks.

	-ss
