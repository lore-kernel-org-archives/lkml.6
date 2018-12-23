Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6042FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6E821971
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545583259;
	bh=DjpUopLRs1VFx6wJuAe2NmyyjoN0K+3YLLk6st51BFU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=N57HUcJMs2nlaNyNCNmsQ1YgjJx8duKteU0i0vs1dPGMnq2rbAW/Ta8jqfpOQdc7l
	 R5LQdw7CY4de+vQ0xD7fS5t5joO6XN9Ewg4C4easSC748NymcCSpH6bZgJ/b6lISHs
	 GA70ycy5xGUDfXHzSoBtrKs60zBtY4N117HaAkWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeLWQk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbeLWQk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:40:57 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43EFF21920;
        Sun, 23 Dec 2018 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545583257;
        bh=DjpUopLRs1VFx6wJuAe2NmyyjoN0K+3YLLk6st51BFU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rUiciqV59vHtkkKWYuinDyTjOIMHTtb+xsWBureRCqYwtuUmBx1l2OpUFtNfnDSPc
         DeEmq4BDCCWkx+rrpiBH0AXTdiLKQCbkSDGxGJTKiaT3Hl1Gl1STK+ZgONcv/iIWH/
         9jNkyzdRcV3jFLkcq8VAyIHXQnuuvruQC4tjstks=
Message-ID: <1545583255.4383.6.camel@kernel.org>
Subject: Re: [for-next][PATCH 4/5] tracing: Have the historgram use the
 result of str_has_prefix() for len of prefix
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Sun, 23 Dec 2018 10:40:55 -0600
In-Reply-To: <20181222162856.972056232@goodmis.org>
References: <20181222162007.697862256@goodmis.org>
         <20181222162856.972056232@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

In the subject line, s/historgram/histogram...

On Sat, 2018-12-22 at 11:20 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As str_has_prefix() returns the length on match, we can use that for
> the
> updating of the string pointer instead of recalculating the prefix
> size.
> 
> Cc: Tom Zanussi  <zanussi@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 0d878dcd1e4b..449d90cfa151 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4342,12 +4342,13 @@ static int parse_actions(struct
> hist_trigger_data *hist_data)
>  	unsigned int i;
>  	int ret = 0;
>  	char *str;
> +	int len;
>  
>  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
>  		str = hist_data->attrs->action_str[i];
>  
> -		if (str_has_prefix(str, "onmatch(")) {
> -			char *action_str = str + sizeof("onmatch(")
> - 1;
> +		if ((len = str_has_prefix(str, "onmatch("))) {
> +			char *action_str = str + len;
>  
>  			data = onmatch_parse(tr, action_str);
>  			if (IS_ERR(data)) {
> @@ -4355,8 +4356,8 @@ static int parse_actions(struct
> hist_trigger_data *hist_data)
>  				break;
>  			}
>  			data->fn = action_trace;
> -		} else if (str_has_prefix(str, "onmax(")) {
> -			char *action_str = str + sizeof("onmax(") -
> 1;
> +		} else if ((len = str_has_prefix(str, "onmax("))) {
> +			char *action_str = str + len;
>  
>  			data = onmax_parse(action_str);
>  			if (IS_ERR(data)) {

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>


