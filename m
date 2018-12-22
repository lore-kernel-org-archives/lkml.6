Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0007CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B950921773
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545501826;
	bh=g3H3tshLXYkBtGbeyRZYyA8LQXghena3BBcFSibSwwE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=C9MW+9oogAmsE0F49j3Ys5rZIIwsiWC+BqW49/1wLHa47KsVzLLjimyUubmNtNERZ
	 6rApaP2H1kaeZ3rCZDPtJKSQrBfp06PEXkjEv7Eah5JQhcw1F2O4caH7svuYYZd8mf
	 Io4NfLQaLrLNx1Qb5BJH7JAoPQMxmhb/2bk4iw2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbeLVSDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:03:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbeLVSDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:03:45 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 117B820874;
        Sat, 22 Dec 2018 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545501823;
        bh=g3H3tshLXYkBtGbeyRZYyA8LQXghena3BBcFSibSwwE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o7knIhlAbF67HNyEJrtAp6gCdUvgyb1FYm1Mx7ENmF183LdPaI5pmhbDO9bL9YQqX
         g4yGhtW6e4PGTOyOINXCzqekbZo1M/QXFFEAJAwxCHAzXePznjkkJpv917SYtnJa41
         EuXau7iz2n26tm5tjf1twTKN6eSMO74mck5sImQo=
Message-ID: <1545501821.4383.2.camel@kernel.org>
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for
 histogram code
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Sat, 22 Dec 2018 12:03:41 -0600
In-Reply-To: <20181222130107.43aaac9c@gandalf.local.home>
References: <20181222162007.697862256@goodmis.org>
         <20181222162856.666843139@goodmis.org>
         <20181222130107.43aaac9c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sat, 2018-12-22 at 13:01 -0500, Steven Rostedt wrote:
> On Sat, 22 Dec 2018 11:20:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The tracing histogram code contains a lot of instances of the
> > construct:
> > 
> >  strncmp(str, "const", sizeof("const") - 1)
> > 
> > This can be prone to bugs due to typos or bad cut and paste. Use
> > the
> > str_has_prefix() helper macro instead that removes the need for
> > having two
> > copies of the constant string.
> > 
> > Cc: Tom Zanussi <zanussi@linux.intel.com>
> 
> I have no idea why I copied your intel email. The linux.intel.com
> appears to be no longer active. I'm going to rebase to fix this email
> address.

linux.intel.com is active, but there's no zanussi there, just
tom.zanussi ;-)

So tom.zanussi@linux.intel.com should work fine.

Tom

> 
> -- Steve
> 
> 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/trace_events_hist.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index c5448c103770..9d590138f870 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1881,8 +1881,8 @@ static int parse_action(char *str, struct
> > hist_trigger_attrs *attrs)
> >  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
> >  		return ret;
> >  
> > -	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) ==
> > 0) ||
> > -	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
> > +	if ((str_has_prefix(str, "onmatch(")) ||
> > +	    (str_has_prefix(str, "onmax("))) {
> >  		attrs->action_str[attrs->n_actions] = kstrdup(str,
> > GFP_KERNEL);
> >  		if (!attrs->action_str[attrs->n_actions]) {
> >  			ret = -ENOMEM;
> > @@ -1899,34 +1899,34 @@ static int parse_assignment(char *str,
> > struct hist_trigger_attrs *attrs)
> >  {
> >  	int ret = 0;
> >  
> > -	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
> > -	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
> > +	if ((str_has_prefix(str, "key=")) ||
> > +	    (str_has_prefix(str, "keys="))) {
> >  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> >  		if (!attrs->keys_str) {
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0)
> > ||
> > -		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0)
> > ||
> > -		 (strncmp(str, "values=", sizeof("values=") - 1)
> > == 0)) {
> > +	} else if ((str_has_prefix(str, "val=")) ||
> > +		   (str_has_prefix(str, "vals=")) ||
> > +		   (str_has_prefix(str, "values="))) {
> >  		attrs->vals_str = kstrdup(str, GFP_KERNEL);
> >  		if (!attrs->vals_str) {
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) ==
> > 0) {
> > +	} else if (str_has_prefix(str, "sort=")) {
> >  		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
> >  		if (!attrs->sort_key_str) {
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (strncmp(str, "name=", sizeof("name=") - 1) ==
> > 0) {
> > +	} else if (str_has_prefix(str, "name=")) {
> >  		attrs->name = kstrdup(str, GFP_KERNEL);
> >  		if (!attrs->name) {
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) ==
> > 0) {
> > +	} else if (str_has_prefix(str, "clock=")) {
> >  		strsep(&str, "=");
> >  		if (!str) {
> >  			ret = -EINVAL;
> > @@ -1939,7 +1939,7 @@ static int parse_assignment(char *str, struct
> > hist_trigger_attrs *attrs)
> >  			ret = -ENOMEM;
> >  			goto out;
> >  		}
> > -	} else if (strncmp(str, "size=", sizeof("size=") - 1) ==
> > 0) {
> > +	} else if (str_has_prefix(str, "size=")) {
> >  		int map_bits = parse_map_size(str);
> >  
> >  		if (map_bits < 0) {
> > @@ -3558,7 +3558,7 @@ static struct action_data *onmax_parse(char
> > *str)
> >  	if (!onmax_fn_name || !str)
> >  		goto free;
> >  
> > -	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) ==
> > 0) {
> > +	if (str_has_prefix(onmax_fn_name, "save")) {
> >  		char *params = strsep(&str, ")");
> >  
> >  		if (!params) {
> > @@ -4346,7 +4346,7 @@ static int parse_actions(struct
> > hist_trigger_data *hist_data)
> >  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
> >  		str = hist_data->attrs->action_str[i];
> >  
> > -		if (strncmp(str, "onmatch(", sizeof("onmatch(") -
> > 1) == 0) {
> > +		if (str_has_prefix(str, "onmatch(")) {
> >  			char *action_str = str +
> > sizeof("onmatch(") - 1;
> >  
> >  			data = onmatch_parse(tr, action_str);
> > @@ -4355,7 +4355,7 @@ static int parse_actions(struct
> > hist_trigger_data *hist_data)
> >  				break;
> >  			}
> >  			data->fn = action_trace;
> > -		} else if (strncmp(str, "onmax(", sizeof("onmax(")
> > - 1) == 0) {
> > +		} else if (str_has_prefix(str, "onmax(")) {
> >  			char *action_str = str + sizeof("onmax(")
> > - 1;
> >  
> >  			data = onmax_parse(action_str);
> 
> 
