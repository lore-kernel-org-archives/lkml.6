Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67978C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14724218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545332159;
	bh=efN69+5p2dcO6FoUhc9KcPkx48LPgxAZ3FUqguAKiVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RsYWfNtlkSrw0ReK+JE9F2dl+YoZuDSEHt5UTnx4iYOEfDA0fvenZHJiZg3H3jDNR
	 Tn2Qf34Jc9vWycsYjFe2bsL60fWcjhp4PS2RBi5GVb5ZlDg/zJrCCZgo9GED9zjXbK
	 Cm9ANJkYxVBydbKC2e8n6EzezhgYe0ZV+tWY2bV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeLTSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbeLTSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:55:57 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39A6218F0;
        Thu, 20 Dec 2018 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545332156;
        bh=efN69+5p2dcO6FoUhc9KcPkx48LPgxAZ3FUqguAKiVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uY6cK+nggvhq4uClMTzd5EvWgmZhyo37oM7Fa3udXHhefVikq4kNCGwLZ6pa346+a
         ZSZ8g6Sgb7we11rXQ+SRQ8pcdGpghGZS4uwByn3cj9DRdTSajsBVzrB17v8FPaNGAG
         ZVx91gYbJ/XVMDp+72cGHHx3jdwcWPgK6a+3RtqE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C515403A8; Thu, 20 Dec 2018 15:55:53 -0300 (-03)
Date:   Thu, 20 Dec 2018 15:55:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: perf: Use strcmp(str, "const") instead of strncmp(str, "const",
 sizeof("const"))
Message-ID: <20181220185553.GA22971@kernel.org>
References: <20181220122601.62bf8858@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220122601.62bf8858@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 20, 2018 at 12:26:01PM -0500, Steven Rostedt escreveu:
> As strncmp(str, "const", sizeof("const") is exactly the same as
> strcmp(str, "const") use that instead, otherwise it is confusing.
> 
> sizeof("const") includes the nul terminator ('\0') of the string
> "const", and that means strncmp() will only return a match if str and
> "const" are exactly the same, which is what strcmp() does.

There are more of those, that are there from time immemorial, lemme see
if the original intention can be found... 

commit 26d330226b9cf6208daae9b0b3697980c8fb51d8
Author: Jiri Olsa <jolsa@redhat.com>
Date:   Tue Aug 7 15:20:47 2012 +0200

    perf tools: Support for DWARF mode callchain

----------------

I thought this could be because at the time strchr was used and thus the
name would be in a buffer followed by ',' or other separator, but
strtok_r() was used, so your patch should simplify things.

- Arnaldo
 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 32ef7bdca1cf..eabf30f963a5 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -258,7 +258,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>  
>  	do {
>  		/* Framepointer style */
> -		if (!strncmp(name, "fp", sizeof("fp"))) {
> +		if (!strcmp(name, "fp")) {
>  			if (!strtok_r(NULL, ",", &saveptr)) {
>  				param->record_mode = CALLCHAIN_FP;
>  				ret = 0;
> @@ -268,7 +268,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>  			break;
>  
>  		/* Dwarf style */
> -		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
> +		} else if (!strcmp(name, "dwarf")) {
>  			const unsigned long default_stack_dump_size = 8192;
>  
>  			ret = 0;

-- 

- Arnaldo
