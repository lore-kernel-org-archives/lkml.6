Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD842146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBTKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:24:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbfBTKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:24:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33287AE60;
        Wed, 20 Feb 2019 10:24:15 +0000 (UTC)
Date:   Wed, 20 Feb 2019 11:24:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20190220102414.6rlwc77q7flxfjnp@pathway.suse.cz>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-9-pmladek@suse.com>
 <20190219033003.GA2284@jagdpanzerIV>
 <CAHp75VfeNvThbue+v1VHK_zxw9N82AkOQZUL=nH6xy21WXX7sg@mail.gmail.com>
 <20190219125115.GA19910@tigerII.localdomain>
 <20190219134956.GM9224@smile.fi.intel.com>
 <20190219141516.GA15836@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219141516.GA15836@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-19 23:15:16, Sergey Senozhatsky wrote:
> On (02/19/19 15:49), Andy Shevchenko wrote:
> > > On (02/19/19 13:02), Andy Shevchenko wrote:
> > > [..]
> > > > And if it's not? You will get in either case incomplete information,
> > > > but at least with "(e" (or even "(") you might get a clue that it
> > > > errornous conditions.
> > > 
> > > The thing I'm signaling here is that in some cases we still can
> > > crash the kernel; with the difference that invalid dereference
> > > can now be a memory corruption. Just saying.
> > 
> > Wouldn't that mean that the culprit in the caller, not in the callee?
> > 
> > (As far as I got your another example with badly called sprintf() which may
> >  overwrite stack, etc).
> 
> ipv4 printout case does not look like a caller bug to me: we expect a 15
> bytes ipv4 address, allocate a 16 bytes buffer, sprintf() voluntarily
> writes 18 bytes. This error reporting is a bit of a dangerous practice;
> next year someone might add another specifier and another
> 
> 	return string(buf, end, "(this data does not look right)", spec);

I hope that this would never pass a review.

> We probably would want to do something about it. For instance, mandating
> that "(error)" string cannot be larger than 8 bytes can be a good starting
> point.

All the warnings are printed by string_nocheck(). We could add one
more variant for printing the warnings, for example:

static int error_string(char **buf, char *end, const char *err_msg,
			     struct printf_spec spec)
{
	/*
	 * Limit the error message when the buffer size is unknown.
	 * It is not full proof but it looks like a reasonable
	 * compromise. The (null) error string never caused a problem.
	 */
	if ((end - *buf > INT_MAX / 2) && !spec.precision) {
		if (spec.field_width)
			spec.precision = spec.field_width;
		else
			spec.precision = 8;
	}

	*buf = string_nocheck(*buf, end, err_msg, spec);
		return -EFAULT;
	}

	return 0;
}

Well, I am not sure that it is worth it. I guess that "(null)"
never caused a problem. And all the new error messages have
8 characters at maximum.

Best Regards,
Petr
