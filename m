Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F29C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11382184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfBLNfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:35:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbfBLNfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:35:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42C8AADED;
        Tue, 12 Feb 2019 13:35:39 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:35:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20190212133538.ja53v7743kgdtog3@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-8-pmladek@suse.com>
 <20190208172518.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208172518.GV9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-08 19:25:18, Andy Shevchenko wrote:
> On Fri, Feb 08, 2019 at 04:23:08PM +0100, Petr Mladek wrote:
> > There are few printk formats that make sense only with two or more
> > specifiers. Also some specifiers make sense only when a kernel feature
> > is enabled.
> > 
> > The handling of unknown specifiers is inconsistent and not helpful.
> > Using WARN() looks like an overkill for this type of error. pr_warn()
> > is not good either. It would by handled via printk_safe buffer and
> > it might be hard to match it with the problematic string.
> > 
> > A reasonable compromise seems to be writing the unknown format specifier
> > into the original string with a question mark, for example (%pC?).
> > It should be self-explaining enough. Note that it is in brackets
> > to follow the (null) style.
> > 
> 
> > Note that the changes in test_printf.c revert many changes made
> > by the commit 4d42c44727a062e233 ("lib/vsprintf: Print time and
> > date in human readable format via %pt\n"). The format %pt does
> > not longer produce a hashed pointer.
> 
> It seems in further patch you partially restore back what was brought by that patch.
> I would suggest not to touch at least changes for plain_pointer_to_buffer().

It is a matter of taste. plain_pointer_to_buffer() is not longer
really needed and makes the code more complicated from my POV.
On the other hand, the removal makes the patch more complicated
and harder to review.


> Also it would be nice to have a coverage for hashed pointers.

The hashing is still tested by plain_hash() and plain_format().

The only remaining format using ptr_to_id() is %pK. But this one
would be tricky to test.

Anyway, I am going to keep plain_pointer_to_buffer() in v7
to make the patch simple. We could clean this later.

Best Regards,
Petr
