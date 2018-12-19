Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35322C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F8B2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeLSUwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:52:04 -0500
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:41302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728448AbeLSUwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:52:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id EC1C35009;
        Wed, 19 Dec 2018 20:52:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coil13_68ed283180843
X-Filterd-Recvd-Size: 2907
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 20:52:00 +0000 (UTC)
Message-ID: <426609d1a7c8217187f18011add87ca4fdd54f1e.camel@perches.com>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org, vedang.patel@intel.com,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 12:51:59 -0800
In-Reply-To: <20181219153447.3684100d@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219144047.49fabfa6@gandalf.local.home>
         <1545248809.2396.2.camel@kernel.org> <1545250591.4161.2.camel@kernel.org>
         <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
         <20181219153447.3684100d@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 15:34 -0500, Steven Rostedt wrote:
> On Wed, 19 Dec 2018 12:22:38 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > On Wed, 2018-12-19 at 14:16 -0600, Tom Zanussi wrote:
> > > How's this?
> > > 
> > > [PATCH] tracing: Introduce and use strcmp_const() for hist triggers
> > > 
> > > Provide a new strcmp_const() macro and make use of it instead of the
> > > longer and more error-prone strncmp(str, "str", sizeof("str") - 1).  
> > []
> > > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c  
> > []
> > > @@ -22,6 +22,9 @@
> > >  
> > >  #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
> > >  
> > > +#define strcmp_const(str, str_const) \
> > > +	strncmp(str, str_const, sizeof(str_const) - 1)  
> > 
> > Not good as it's too easy to pass a pointer as str_const
> > and sizeof(pointer) - 1 isn't likely the string length.
> 
> Agreed. And I noticed that this is used all over the kernel, so I'm not
> going to add this patch. I'm going to add a:
> 
> #define strncmp_prefix(str, prefix) \
> 	strncmp(str, prefix, strlen(prefix))
> 
> in include/linux/string.h
> 
> And go around and use that throughout the kernel. By doing a quick
> grep, I already spotted a few bugs.

I hope you also convert the existing uses like

	strncmp(str1, "str2", 4)

where the length value is precalculated to the strlen
of the const string

But there seem to be _a lot_ of those...

$ git grep -P "\bstrncmp\s*\([^,]+,[^,]+,\s*\d+\s*\)" | wc -l
1681


