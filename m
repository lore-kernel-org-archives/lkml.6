Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D9C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0530B223D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0530B223D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeHJJ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:27:31 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:36293 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeHJJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:27:30 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 10 Aug 2018 15:58:58 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 10 Aug 2018 15:58:58 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 10 Aug 2018 15:58:58 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3 1/7] tracing: Refactor hist trigger action code
Message-ID: <20180810065858.GB479@sejong>
References: <cover.1533753152.git.tom.zanussi@linux.intel.com>
 <9d8aaf30dc0c8d48885b0936a038ddd770a55caa.1533753152.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d8aaf30dc0c8d48885b0936a038ddd770a55caa.1533753152.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, Aug 09, 2018 at 09:34:11AM -0500, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> The hist trigger action code currently implements two essentially
> hard-coded pairs of 'actions' - onmax(), which tracks a variable and
> saves some event fields when a max is hit, and onmatch(), which is
> hard-coded to generate a synthetic event.
> 
> These hardcoded pairs (track max/save fields and detect match/generate
> synthetic event) should really be decoupled into separate components
> that can then be arbitrarily combined.  The first component of each
> pair (track max/detect match) is called a 'handler' in the new code,
> while the second component (save fields/generate synthetic event) is
> called an 'action' in this scheme.
> 
> This change refactors the action code to reflect this split by adding
> two handlers, HANDLER_ONMATCH and HANDLER_ONMAX, along with two
> actions, ACTION_SAVE and ACTION_TRACE.
> 
> The new code combines them to produce the existing ONMATCH/TRACE and
> ONMAX/SAVE functionality, but doesn't implement the other combinations
> now possible.  Future patches will expand these to further useful
> cases, such as ONMAX/TRACE, as well as add additional handlers and
> actions such as ONCHANGE and SNAPSHOT.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

[SNIP]
> @@ -3421,10 +3419,69 @@ static int parse_action_params(char *params, struct action_data *data)
>  	return ret;
>  }
>  
> -static struct action_data *onmax_parse(char *str)
> +static int action_parse(char *str, struct action_data *data,
> +			enum handler_id handler)
> +{
> +	char *action_name;
> +	int ret = 0;
> +
> +	strsep(&str, ".");
> +	if (!str) {
> +		hist_err("action parsing: No action found", "");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	action_name = strsep(&str, "(");
> +	if (!action_name || !str) {
> +		hist_err("action parsing: No action found", "");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (strncmp(action_name, "save", strlen("save")) == 0) {
> +		char *params = strsep(&str, ")");
> +
> +		if (!params) {
> +			hist_err("action parsing: No params found for %s", "save");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = parse_action_params(params, data);
> +		if (ret)
> +			goto out;
> +
> +		if (handler == HANDLER_ONMAX)
> +			data->fn = onmax_save;
> +
> +		data->action = ACTION_SAVE;
> +	} else {
> +		char *params = strsep(&str, ")");
> +
> +		if (params) {
> +			ret = parse_action_params(params, data);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		data->fn = action_trace;
> +		data->action = ACTION_TRACE;

This will set action name as (synthetic) event name, right?  I think
it's natural to have "trace" for it with this change.  Maybe it's time
to change the syntax like below?

  onmatch(SYS.EVENT).trace(EVENT, FIELD, ...)

Of course it should support old syntax too..


> +	}
> +
> +	data->action_name = kstrdup(action_name, GFP_KERNEL);
> +	if (!data->action_name) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> + out:
> +	return ret;
> +}
