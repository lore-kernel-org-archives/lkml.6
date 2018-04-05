Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeDEOqG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:47539 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeDEOqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:46:05 -0400
Date: Thu, 5 Apr 2018 16:46:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 2/9] vsprintf: Consistent %pK handling for
 kptr_restrict == 0
Message-ID: <20180405144602.qnpwoxinepgnjhds@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-3-pmladek@suse.com>
 <1522933485.21176.353.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522933485.21176.353.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-04-05 16:04:45, Andy Shevchenko wrote:
> On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> > restricted_pointer() pretends that it prints the address when
> > kptr_restrict
> > is set to zero. But it is never called in this situation. Instead,
> > pointer() falls back to ptr_to_id() and hashes the pointer.
> > 
> > This patch removes the potential confusion. klp_restrict is checked
> > only
> > in restricted_pointer().
> > 
> 
> 
> >  /* Maps a pointer to a 32 bit unique identifier. */
> > -static char *ptr_to_id(char *buf, char *end, void *ptr, struct
> > printf_spec spec)
> > +static char *ptr_to_id(char *buf, char *end,
> > +		       const void *ptr, struct printf_spec spec)
> 
> I don't think this change belongs to the patch.

The const should have been there from the beginning. I have found it
because this patch added a call to ptr_to_id() which had the const
and compiler warned about cast problems.

IMHO, it is rather cosmetic change.

Best Regards,
Petr
