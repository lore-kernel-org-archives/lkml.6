Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeDFXwT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 19:52:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38868 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDFXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 19:52:18 -0400
X-Google-Smtp-Source: AIpwx49ChiiBSwvrH7CY4Jsu9x1zpA0tMOPW1G+FNyMSqZ9c7gXDzIsDA4SQjLnTsTAXlDpe5rnV6w==
Date: Sat, 7 Apr 2018 08:52:14 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180406235214.GA386@tigerII.localdomain>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
 <1522971908.11185.46.camel@perches.com>
 <1522972535.11185.49.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522972535.11185.49.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/05/18 16:55), Joe Perches wrote:
> On Thu, 2018-04-05 at 16:45 -0700, Joe Perches wrote:
> > On Thu, 2018-04-05 at 16:25 +0200, Rasmus Villemoes wrote:
> > > Even just git grep -1 -E '%p"$' finds %pt and %po
> > > which should get fixed before somebody claims those extensions.
> > 
> > Neither %pt nor %po is used in a vsprintf
> > in the kernel.
> 
> Nope, you are right, both are defectively used in the
> kernel via string concatenation.
> 
> Also there's a missing space in a concatenation adjacent.

Can we tweak checkpatch to catch such things?


Hm... *Probably* also wouldn't hurt if checkpatch can require at least
one character after pointer format specifiers:

	printk("string %p"          vs       printk("string %p "
	       " Object\n", ptr);                   "Object\n", ptr);

Especially if we can have a "potential" %px, like here

               dev_vdbg(&md->input->dev,
                       "%s: *axis=%02X(%d) size=%d max=%08X xy_data=%p"
                       " xy_data[%d]=%02X(%d) bofs=%d\n",

or here

       dev_vdbg(&md->input->dev,
               "%s: *axis=%02X(%d) size=%d max=%08X xy_data=%p"
               " xy_data[%d]=%02X(%d)\n",

Opinions?

	-ss
