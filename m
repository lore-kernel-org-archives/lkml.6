Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F23C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9921928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbeLVAAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbeLVAAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:00:43 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C22321928;
        Sat, 22 Dec 2018 00:00:41 +0000 (UTC)
Date:   Fri, 21 Dec 2018 19:00:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181221190039.73016323@gandalf.local.home>
In-Reply-To: <75e15c5d66ecd6964231be0f5b3cf702ac242bc1.camel@perches.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
        <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
        <20181221182507.2fdc756f@gandalf.local.home>
        <75e15c5d66ecd6964231be0f5b3cf702ac242bc1.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 15:44:41 -0800
Joe Perches <joe@perches.com> wrote:

> On Fri, 2018-12-21 at 18:25 -0500, Steven Rostedt wrote:
> > On Fri, 21 Dec 2018 15:19:33 -0800
> > Joe Perches <joe@perches.com> wrote:
> >   
> > > I believe this should be bool.
> > > 
> > > I don't find a use for non-zero assigned len value in the kernel
> > > for strncmp and I believe the function should simply be:
> > > 
> > > static inline bool str_has_prefix(const char *str, const char prefix[])
> > > {
> > > 	return !strncmp(str, prefix, strlen(prefix));
> > > }  
> > 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c  
> []
> > @@ -172,8 +172,8 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
> >  		 * it's not worth the risk */
> >  		return -EINVAL;
> >  
> > -	if (strncmp(buf, temp, sizeof(temp) - 1) == 0) {
> > -		buf += sizeof(temp) - 1;
> > +	if ((len = str_has_prefix(buf, temp))) {
> > +		buf += len;  
> 
> That's not really a use of the non-zero strncmp return value.
> 
> You are attempting an optimization not already done.
> I also wonder if it's actually an optimization as the
> return value may not be precomputed.

Note, temp is this:

	static const char temp[] = "temporary ";

> 
> Also the assignment in the test isn't preferred style.

We could have two helper functions:

static __always_inline bool
str_has_prefix(const char *str, const char *prefix)
{
	return strncmp(str, prefix, strlen(prefix));
}

and a 

static __always_inline bool
str_has_prefix_len(const char *str, const char *prefix, unsigned int *len)
{
	*len = strlen(prefix);
	return strncmp(str, prefix, *len);
}

This was my original thought with the first patches. But when Linus
suggested changing the style from the strncmp() I thought it was a way
to encapsulate the two.

Either way, but yes, I do want a way to do the compare and calculate
the length all in one function. That even makes checking options easier
to get to:

	if (str_has_prefix_len(cmdline, "param=", &len)) {
		value = cmdline + len;


> 
> > And there's more places like this.  
> 
> Any where the non-zero return value is actually used?
> 
> > > It's hard to believe __always_inline vs inline matters 
> > > for any single line function.  
> > 
> > I've been burnt by gcc deciding to not inline single functions before.  
> 
> Complex single functions sure, but single line inlines?
> I haven't seen that externed anywhere.
> 
> Today no inline function is marked __always_inline in
> string.h
> 
> I don't doubt there should be some standardization
> of inline vs __always_inline in the kernel, but this
> right now seems different just for difference sake.

I got burnt by some crazy gcc config options making local_irq_save()
become a out of line function, and that cause crazy crap to happen with
the function tracer.

Now inlining here is just for guaranteeing that strlen() gets turned
into a constant for constant strings and wont do anything harmful if
that doesn't happen (but slightly slow things down). But again, it
doesn't hurt to have the __always_inline. Why are you so dead against
it? You haven't stated your rational for that.

-- Steve

