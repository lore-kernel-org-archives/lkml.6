Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5021F20672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeLTBno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLTBnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:43:43 -0500
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C8320672;
        Thu, 20 Dec 2018 01:43:41 +0000 (UTC)
Date:   Wed, 19 Dec 2018 20:43:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RFC][PATCH] string.h: Add strncmp_prefix() helper macro
Message-ID: <20181220014339.f32q6duwein53bfd@home.goodmis.org>
References: <20181219163207.792e0f97@gandalf.local.home>
 <b6cc5327509148fb26bfba2ca34f9c2927437707.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6cc5327509148fb26bfba2ca34f9c2927437707.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sending now as myself and not my daughter :-p ]

On Wed, Dec 19, 2018 at 01:54:57PM -0800, Joe Perches wrote:
> On Wed, 2018-12-19 at 16:32 -0500, Bryana Rostedt wrote:
> >  
> > +/*
> > + * A common way to test a prefix of a string is to do:
> > + *  strncmp(str, prefix, sizeof(prefix) - 1)
> > + *
> > + * But this can lead to bugs due to typos, or if prefix is a pointer
> > + * and not a constant. Instead use strncmp_prefix().
> > + */
> > +#define strncmp_prefix(str, prefix)					\e
> > +	({								\
> > +		int ____strcmp_prefix_ret____;				\
> > +		char *____strcmp_prefix____ = prefix;			\
> 
> This creates a warning and discards any const from prefix when used like
> 
> 	static const char foo[] = "bar";
> 
> 	strncmp_prefix(str, foo);
> 
> > +		if (__builtin_constant_p(&prefix))			\
> > +			____strcmp_prefix_ret____ =			\
> > +				strncmp(str, prefix, sizeof(prefix) - 1); \
> > +		else							\
> > +			____strcmp_prefix_ret____ =			\
> > +				strncmp(str, ____strcmp_prefix____,	\
> > +					strlen(____strcmp_prefix____));	\
> > +		____strcmp_prefix_ret____;				\
> > +	})
> > +
> 
> Perhaps
> 
> #define strncmp_prefix(str, prefix)					\
> ({									\
> 	typeof(prefix) p = (prefix);					\
> 	strncmp(str, p, strlen(p));					\


I'll have to see how all supported  gcc optimizes that.

I could just move the prefix assignment in the else part, which gets compiled
out on constants anyway, just to be safe, and also shows exactly what is
happening and not worrying about gcc doing the "right" thing.

-- Steve


> })
> 
