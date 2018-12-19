Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E415D2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeLSUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:20:24 -0500
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:58492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727151AbeLSUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:20:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6CDD618020002;
        Wed, 19 Dec 2018 20:20:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: duck39_7765deed8c144
X-Filterd-Recvd-Size: 4339
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 20:20:20 +0000 (UTC)
Message-ID: <baf7e7af61873fc8bb3833d6bb0501d684a92bf2.camel@perches.com>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
From:   Joe Perches <joe@perches.com>
To:     Tom Zanussi <zanussi@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 12:20:19 -0800
In-Reply-To: <1545248809.2396.2.camel@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219144047.49fabfa6@gandalf.local.home>
         <1545248809.2396.2.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 13:46 -0600, Tom Zanussi wrote:
> Hi Steve,
> 
> On Wed, 2018-12-19 at 14:40 -0500, Steven Rostedt wrote:
> > On Tue, 18 Dec 2018 14:33:21 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > There's no need to use strlen() for static strings when the length
> > > is
> > > already known, so update trace_events_hist.c with sizeof() for
> > > those
> > > cases.
> > > 
> > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > ---
> > >  kernel/trace/trace_events_hist.c | 38 +++++++++++++++++++---------
> > > ----------
> > >  1 file changed, 19 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace_events_hist.c
> > > b/kernel/trace/trace_events_hist.c
> > > index d29bf8a8e1dd..25d06b3ae1f6 100644
> > > --- a/kernel/trace/trace_events_hist.c
> > > +++ b/kernel/trace/trace_events_hist.c
> > > @@ -507,7 +507,7 @@ static int synth_field_string_size(char *type)
> > >  	start = strstr(type, "char[");
> > >  	if (start == NULL)
> > >  		return -EINVAL;
> > > -	start += strlen("char[");
> > > +	start += sizeof("char[") - 1;
> > >  
> > >  	end = strchr(type, ']');
> > >  	if (!end || end < start)
> > > @@ -1843,8 +1843,8 @@ static int parse_action(char *str, struct
> > > hist_trigger_attrs *attrs)
> > >  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
> > >  		return ret;
> > >  
> > > -	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
> > > -	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
> > > +	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) ==
> > > 0) ||
> > > +	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
> > >  		attrs->action_str[attrs->n_actions] = kstrdup(str,
> > > GFP_KERNEL);
> > >  		if (!attrs->action_str[attrs->n_actions]) {
> > >  			ret = -ENOMEM;
> > > @@ -1861,34 +1861,34 @@ static int parse_assignment(char *str,
> > > struct hist_trigger_attrs *attrs)
> > >  {
> > >  	int ret = 0;
> > >  
> > > -	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
> > > -	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
> > > +	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
> > > +	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
> > >  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> > 
> > I'll apply this as is, but since there's a lot of these, I wonder if
> > we
> > should make a marcro for this:
> > 
> > #define strcmp_const(str, str_const) strncmp(str, str_const,
> > sizeof(str_const) - 1)
> > 
> > ?
> > 
> > This would help prevent bugs due to typos and bad cut and paste.
> > 
> 
> Yeah, I had considered it but wasn't sure it was worth it.  Since
> you're suggesting it is, I can send another patch on top of these, or
> feel free if you want to too.  ;-)

I believe the 'strlen("foo") -> sizeof("foo") - 1'
conversions do not change objects at all.

strlen("constant") is already optimized by gcc to a
constant value when fed a constant string.

the strcmp_const macro does seem to make sense as
the copy/paste/typo possibility is real.


