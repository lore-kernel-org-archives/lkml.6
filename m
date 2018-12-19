Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66627C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C16B20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeLSUev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeLSUeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:34:50 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF7220866;
        Wed, 19 Dec 2018 20:34:48 +0000 (UTC)
Date:   Wed, 19 Dec 2018 15:34:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org, vedang.patel@intel.com,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Message-ID: <20181219153447.3684100d@gandalf.local.home>
In-Reply-To: <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
        <20181219144047.49fabfa6@gandalf.local.home>
        <1545248809.2396.2.camel@kernel.org>
        <1545250591.4161.2.camel@kernel.org>
        <af216c227fa3ec310d8c4271485dd6c7f829174f.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 12:22:38 -0800
Joe Perches <joe@perches.com> wrote:

> On Wed, 2018-12-19 at 14:16 -0600, Tom Zanussi wrote:
> > 
> > How's this?
> > 
> > [PATCH] tracing: Introduce and use strcmp_const() for hist triggers
> > 
> > Provide a new strcmp_const() macro and make use of it instead of the
> > longer and more error-prone strncmp(str, "str", sizeof("str") - 1).  
> []
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c  
> []
> > @@ -22,6 +22,9 @@
> >  
> >  #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
> >  
> > +#define strcmp_const(str, str_const) \
> > +	strncmp(str, str_const, sizeof(str_const) - 1)  
> 
> Not good as it's too easy to pass a pointer as str_const
> and sizeof(pointer) - 1 isn't likely the string length.

Agreed. And I noticed that this is used all over the kernel, so I'm not
going to add this patch. I'm going to add a:

#define strncmp_prefix(str, prefix) \
	strncmp(str, prefix, strlen(prefix))

in include/linux/string.h

And go around and use that throughout the kernel. By doing a quick
grep, I already spotted a few bugs.

-- Steve
