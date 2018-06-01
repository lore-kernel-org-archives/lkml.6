Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeFAJeO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:34:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39557 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeFAJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:34:08 -0400
X-Google-Smtp-Source: ADUXVKISf3IbcsaQalo4iwapSljgdoxPqJxE2oGzJaLfG5MZcPYE+BMmISwoELy/jQLhUFE4UmqH8g==
Date: Fri, 1 Jun 2018 18:34:02 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Vaneet Narang <v.narang@samsung.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180601093402.GB1841@jagdpanzerIV>
References: <20180601044050.GA5687@jagdpanzerIV>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
 <20180531105215.GF477@jagdpanzerIV>
 <20180531122112.bfeqtmwpl2qc67a5@pathway.suse.cz>
 <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcms5p5>
 <20180601084236epcms5p5063cd250524f105a334d8d553302ab51@epcms5p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601084236epcms5p5063cd250524f105a334d8d553302ab51@epcms5p5>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (06/01/18 14:12), Vaneet Narang wrote:
> > CPU0                            CPU1
> >
> > set console verbose
> >
> > dump_backtrace()
> > {
> >  // for (;;)  print frames
> >  printk("%pS\n", frame0);
> >  printk("%pS\n", frame1);
> >  printk("%pS\n", frame2);
> >  printk("%pS\n", frame3);
> >  ...                            console_loglevel = CONSOLE_LOGLEVEL_SILENT;
> >  printk("%pS\n", frame12);
> >  printk("%pS\n", frame13);
> > }
> >
> 
> This is not printk issue, its printk usage issue. User need to handle this part using some protection.
> 
> What we highlighted is issue related to printk, Where usage is correct 
> but still printk can miss some logs due to printk design of asynchronous printing.

Yeah, I understand your example from the commit message. What I said was
"the patch does not fully address the problem". One way or another we still
can miss logs due to the very same problem: either console_loglevel
manipulation on another CPU, or printk_safe(), etc. May be there other
scenarios that are broken.

So if we are going to apply the patch [I don't have real objections, and
Petr seems to be fine], then I'd probably ask for a better commit messages.
Namely, I really want to document cases that are not addressed and are
still known to be broken.

	-ss
