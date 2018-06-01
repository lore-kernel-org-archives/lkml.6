Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeFAJSe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:18:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43777 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFAJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:18:28 -0400
X-Google-Smtp-Source: ADUXVKIQdVa8iK1ITSfxhNPrIWPqQkrd7OXEmDdkIuwnhneEQLuDPcgptX0PqIySDRmh9IK1q+UzUw==
Date: Fri, 1 Jun 2018 18:18:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180601091823.GA1841@jagdpanzerIV>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
 <20180531105215.GF477@jagdpanzerIV>
 <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
 <20180601044050.GA5687@jagdpanzerIV>
 <20180601085356.kncuat7epkbtythv@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601085356.kncuat7epkbtythv@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/01/18 10:53), Petr Mladek wrote:
> [...]
> 
> > So I'd say that most likely the following scenarios can suffer:
> > 
> > - NMI comes in, sets loglevel to X, printk-s some data, restores the
> >   loglevel back to Y
> > - IRQ comes in [like sysrq, etc] comes in and does the same thing
> > - software exception comes in and does the same thing [e.g. bust_spinlocks()
> >   at arch/s390/mm/fault.c]
> 
> 
> My view is:
> 
> The race with another printk() (console_lock owner) is much more
> likely than a race between two CPUs manipulating console_loglevel.

The race with console_loglevel manipulation from another CPU was not
the main point [it is unlikely, like I said in my "nitpick"].
The point was

	NMI / printk_safe section

	saved_console_loglevel = console_loglevel
	console_loglevel = A

	printk
	printk
	printk

	console_loglevel = saved_console_loglevel
	iret

Is not handled.

> The proposed patch seems to be in the right direction. It is supposed
> to fix the most likely scenario.

Could be.

> I am personally fine with this partial solution for now. We could
> always make it better if people meet the other scenarios.

I don't have objections. But I'd prefer to see real uses cases and
to know why partial solution is good enough in this case, even though
we know that NMI / printk_safe() messages may be lost due to very same
problem.

	-ss
