Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BE5218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545248814;
	bh=MFfY2+h9R6Hle9DGIlpTb12Xmk3GHV78z5DfEQIszdE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=ScX1ldb6IYKuJROlPUllq9vosqqkPKXp2KpVcyZwryeJxnw+MA/HSe5wOC5ldpvAY
	 A1TL3Mu/ecN+171P9E5eWFIqgc8lwRT+/0pcDLoC4excm3K4M0ByVFihiYlitTH0ae
	 yBAA2u9j7ZKxZgjKes4k7UnBQ2tlNTE3jkhBwYkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeLSTqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeLSTqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:46:52 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358CF20874;
        Wed, 19 Dec 2018 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545248811;
        bh=MFfY2+h9R6Hle9DGIlpTb12Xmk3GHV78z5DfEQIszdE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CXargDrmHC/mq8FH6P/xOOUa7scZZqEanOrGj2Z12YG5icgyvnJBX+y58xh5Z66AF
         9wyy/oxAPWniMQcCLlNzOAIx/SRni5E2rfHJ6RxPIl1/JNAMtsRXpBaYUJqqX/xOv6
         g1Ge/PRtytucJOTt1fUYOQPGyn2z01CagSOhWPeQ=
Message-ID: <1545248809.2396.2.camel@kernel.org>
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 13:46:49 -0600
In-Reply-To: <20181219144047.49fabfa6@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219144047.49fabfa6@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2018-12-19 at 14:40 -0500, Steven Rostedt wrote:
> On Tue, 18 Dec 2018 14:33:21 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > There's no need to use strlen() for static strings when the length
> > is
> > already known, so update trace_events_hist.c with sizeof() for
> > those
> > cases.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 38 +++++++++++++++++++---------
> > ----------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index d29bf8a8e1dd..25d06b3ae1f6 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -507,7 +507,7 @@ static int synth_field_string_size(char *type)
> >  	start = strstr(type, "char[");
> >  	if (start == NULL)
> >  		return -EINVAL;
> > -	start += strlen("char[");
> > +	start += sizeof("char[") - 1;
> >  
> >  	end = strchr(type, ']');
> >  	if (!end || end < start)
> > @@ -1843,8 +1843,8 @@ static int parse_action(char *str, struct
> > hist_trigger_attrs *attrs)
> >  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
> >  		return ret;
> >  
> > -	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
> > -	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
> > +	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) ==
> > 0) ||
> > +	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
> >  		attrs->action_str[attrs->n_actions] = kstrdup(str,
> > GFP_KERNEL);
> >  		if (!attrs->action_str[attrs->n_actions]) {
> >  			ret = -ENOMEM;
> > @@ -1861,34 +1861,34 @@ static int parse_assignment(char *str,
> > struct hist_trigger_attrs *attrs)
> >  {
> >  	int ret = 0;
> >  
> > -	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
> > -	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
> > +	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
> > +	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
> >  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> 
> I'll apply this as is, but since there's a lot of these, I wonder if
> we
> should make a marcro for this:
> 
> #define strcmp_const(str, str_const) strncmp(str, str_const,
> sizeof(str_const) - 1)
> 
> ?
> 
> This would help prevent bugs due to typos and bad cut and paste.
> 

Yeah, I had considered it but wasn't sure it was worth it.  Since
you're suggesting it is, I can send another patch on top of these, or
feel free if you want to too.  ;-)

Tom

