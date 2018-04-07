Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeDGAdG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 20:33:06 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:34255 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeDGAdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 20:33:05 -0400
X-Google-Smtp-Source: AIpwx49tjYALqlf1XIJ9rIrcAY0x5jjw9Lq33VRNx21ECCKHY2hXI07siwovOJr1oM1MtykOGE/LkQ==
Date: Sat, 7 Apr 2018 09:33:01 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180407003301.GB386@tigerII.localdomain>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <0fa5a3ec-6002-670b-0470-f523584149de@rasmusvillemoes.dk>
 <1522971908.11185.46.camel@perches.com>
 <1522972535.11185.49.camel@perches.com>
 <20180406235214.GA386@tigerII.localdomain>
 <1523059179.6127.45.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523059179.6127.45.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On (04/06/18 16:59), Joe Perches wrote:
> > 
> > Can we tweak checkpatch to catch such things?
> 
> Not really, no.
> 
> Adding regex logic for this is tricky at best
> and probably not worth the effort because of
> the various bits of patch contexts aren't
> necessarily visible.

Agreed. I was more thinking about catching "... %p" and saying
that we'd rather prefer either "... %p," or "... %p " or "... %p\n".
Doesn't sound so complex, can probably catch something fishy one day
(or may be not), and more or less is visible to checkpatch. Well,
more or less...

> There are also concatenations like
> 	"foo" DEFINE "bar"
> where DEFINE may not be visible in the patch
> context and checkpatch is and likely will
> remain just a limited regex checker.

Right. One example might be XFS

	alert("%s: Bad regular inode %Lu, ptr "PTR_FMT,
				__func__, ip->i_ino, ip);

where PTR_FMT is

#ifdef DEBUG
# define PTR_FMT "%px"
#else
# define PTR_FMT "%p"
#endif

	-ss
