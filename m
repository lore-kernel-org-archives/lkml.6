Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC96C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307B3205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391778AbeLVRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390244AbeLVRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:15 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E7421A4D;
        Sat, 22 Dec 2018 12:22:09 +0000 (UTC)
Date:   Sat, 22 Dec 2018 07:22:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181222072207.1fe78930@vmware.local.home>
In-Reply-To: <20181222092818.GA7610@danjae.aot.lge.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
        <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
        <20181221182507.2fdc756f@gandalf.local.home>
        <20181221183817.5b3eecdd@gandalf.local.home>
        <20181222092818.GA7610@danjae.aot.lge.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 18:28:18 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> >  
> >  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
> >  		str = hist_data->attrs->action_str[i];
> >  
> > -		if (str_has_prefix(str, "onmatch(")) {
> > -			char *action_str = str + sizeof("onmatch(") - 1;
> > +		if ((len = str_has_prefix(str, "onmatch("))) {
> > +			char *action_str = str + len;  
> 
> IMHO, returning (match) length might confuse people that it might
> support partial match and returns the length actually matched rather
> than full match.  If I knew it always returns the length of prefix (or
> 0) why it matters?  Using strlen() in the next line will have same
> effect of compiler optimization for the constant strings, no?
> 
> 		if (str_has_prefix(str, "onmatch(")) {
> 			char *action_str = str + strlen("onmatch(");

The reason to return the length was to get rid of the need for
duplicating the strlen("xxxx") because it's a burden to keep the two
the same. Not only that, a lot of places just do "str + 7" because it's
easier to type.

Yes, it has the same effect on the compiler, but that's not what we are
trying to solve. We are trying to get rid of the duplication, because
that requires humans to get it right, and humans are not good at that.

-- Steve
