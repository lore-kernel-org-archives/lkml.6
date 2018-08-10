Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179C6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB800223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xm+G1Lod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB800223FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeHJQfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJQfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:35:09 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33FB223FE;
        Fri, 10 Aug 2018 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533909905;
        bh=5LuEVhbye21cbjBtxu9TXr7+HoHnBo+q5T9TwrvR7P8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xm+G1Lodzs3yO+47n+0tSc7tZB7ZyG2v1cTYhVlvOB2ws12vD9Tb08FOR1AEZQ+NG
         tO7lnchfNEEdDyxFeNoPi5urSlwoZFdrzvtEHfJ9KrwTnTjpAClkcSwaa/fMC0zE3M
         yOqopwOPHLBFEK/P5GTnsY8wUkmlGqrV7MZZ5tY0=
Message-ID: <1533909903.1918.9.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] tracing: Refactor hist trigger action code
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Fri, 10 Aug 2018 09:05:03 -0500
In-Reply-To: <20180810065858.GB479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
         <9d8aaf30dc0c8d48885b0936a038ddd770a55caa.1533753152.git.tom.zanussi@linux.intel.com>
         <20180810065858.GB479@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Fri, 2018-08-10 at 15:58 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Thu, Aug 09, 2018 at 09:34:11AM -0500, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > The hist trigger action code currently implements two essentially
> > hard-coded pairs of 'actions' - onmax(), which tracks a variable
> > and
> > saves some event fields when a max is hit, and onmatch(), which is
> > hard-coded to generate a synthetic event.
> > 
> > These hardcoded pairs (track max/save fields and detect
> > match/generate
> > synthetic event) should really be decoupled into separate
> > components
> > that can then be arbitrarily combined.  The first component of each
> > pair (track max/detect match) is called a 'handler' in the new
> > code,
> > while the second component (save fields/generate synthetic event)
> > is
> > called an 'action' in this scheme.
> > 
> > This change refactors the action code to reflect this split by
> > adding
> > two handlers, HANDLER_ONMATCH and HANDLER_ONMAX, along with two
> > actions, ACTION_SAVE and ACTION_TRACE.
> > 
> > The new code combines them to produce the existing ONMATCH/TRACE
> > and
> > ONMAX/SAVE functionality, but doesn't implement the other
> > combinations
> > now possible.  Future patches will expand these to further useful
> > cases, such as ONMAX/TRACE, as well as add additional handlers and
> > actions such as ONCHANGE and SNAPSHOT.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> 
> [SNIP]
> > @@ -3421,10 +3419,69 @@ static int parse_action_params(char
> > *params, struct action_data *data)
> >  	return ret;
> >  }
> >  
> > -static struct action_data *onmax_parse(char *str)
> > +static int action_parse(char *str, struct action_data *data,
> > +			enum handler_id handler)
> > +{
> > +	char *action_name;
> > +	int ret = 0;
> > +
> > +	strsep(&str, ".");
> > +	if (!str) {
> > +		hist_err("action parsing: No action found", "");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	action_name = strsep(&str, "(");
> > +	if (!action_name || !str) {
> > +		hist_err("action parsing: No action found", "");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (strncmp(action_name, "save", strlen("save")) == 0) {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (!params) {
> > +			hist_err("action parsing: No params found
> > for %s", "save");
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		ret = parse_action_params(params, data);
> > +		if (ret)
> > +			goto out;
> > +
> > +		if (handler == HANDLER_ONMAX)
> > +			data->fn = onmax_save;
> > +
> > +		data->action = ACTION_SAVE;
> > +	} else {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (params) {
> > +			ret = parse_action_params(params, data);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +
> > +		data->fn = action_trace;
> > +		data->action = ACTION_TRACE;
> 
> This will set action name as (synthetic) event name, right?  I think

Right.

> it's natural to have "trace" for it with this change.  Maybe it's
> time
> to change the syntax like below?
> 
>   onmatch(SYS.EVENT).trace(EVENT, FIELD, ...)
> 
> Of course it should support old syntax too..
> 

Yeah, I can easily add this variant while keeping the original syntax. 
Will do that in v4.

Thanks,

Tom
