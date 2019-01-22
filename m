Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A1521019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548162880;
	bh=wpHWv2lBjNuRU9K6Mk5iFFQNy7G/c5VNAaGQMGFgIRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o6q8E3tndiYVbx5LTsyr/4UcoO0FkQ0W4QycSEVN3h2GUhGEXTr7nmlUpWKayDu/3
	 cmQzUc40p4JemYPzp4ltu/4oyW6BvvlZCP+7zrsNF52hLn3lM5xGkhZSoh+fe1vwEF
	 9irMYinqR3/U6AWcGayHr0V50/WlYYICZWNrVPA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfAVNOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbfAVNOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:14:37 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFC720870;
        Tue, 22 Jan 2019 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548162877;
        bh=wpHWv2lBjNuRU9K6Mk5iFFQNy7G/c5VNAaGQMGFgIRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VgH457gCrpGftArMLenkq8xaCM4t58C9uHBjViCaxIEtdL5TL71xmDH6SdPcy8cn5
         FvICiNZO7oU2yxP4Ix5EZe0qRwMTKUTRnQfFxRgePw5DOtn8UswvcuBG0jIvftg94v
         7JcC8+BpcOjtc3LUJGQdyNxKQUGJAz2GFKxobcuA=
Date:   Tue, 22 Jan 2019 22:14:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probeevent: Correctly update remaining space
 in dynamic area
Message-Id: <20190122221434.419e956dd91da0516ff4cc04@kernel.org>
In-Reply-To: <20190122124848.17774-1-andreas.ziegler@fau.de>
References: <20190122124848.17774-1-andreas.ziegler@fau.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 13:48:48 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> Commit 9178412ddf5a ("tracing: probeevent: Return consumed
> bytes of dynamic area") improved the string fetching
> mechanism by returning the number of required bytes after
> copying the argument to the dynamic area. However, this
> return value is now only used to increment the pointer
> inside the dynamic area but misses updating the 'maxlen'
> variable which indicates the remaining space in the dynamic
> area.

Oops! Good catch! :)

> 
> This means that fetch_store_string() always reads the *total*
> size of the dynamic area from the data_loc pointer instead of
> the *remaining* size (and passes it along to
> strncpy_from_{user,unsafe}) even if we're already about to
> copy data into the middle of the dynamic area.
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!!

> Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
> ---
>  kernel/trace/trace_probe_tmpl.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 5c56afc17cf8..0cf953e47584 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -182,8 +182,10 @@ store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
>  		ret = process_fetch_insn(arg->code, regs, dl, base);
>  		if (unlikely(ret < 0 && arg->dynamic))
>  			*dl = make_data_loc(0, dyndata - base);
> -		else
> +		else {
>  			dyndata += ret;
> +			maxlen -= ret;
> +		}
>  	}
>  }
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
