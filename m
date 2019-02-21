Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61724C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F012089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550708464;
	bh=kdFDe1h/LxsYUxxUCyEQ7rDuL5vpfwk/tzF6NmlEan8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K1FfIgRR6feiPsKNqpdAOhJ3WNMMKLsqUHgwqoxQKikXKyg7hKqrK41dD6D5uJacn
	 sxxK+wLEXWObHDwdEl/KdJP3Pk4yJZFZyXTOMn+vigRwgzwZkuQ8zML5gzanqw1rzg
	 0DDnJjLgTJIP/5YpZed/QA4BUCP5xZqrE+XDEANM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBUAVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfBUAVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:21:02 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BE120855;
        Thu, 21 Feb 2019 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550708461;
        bh=kdFDe1h/LxsYUxxUCyEQ7rDuL5vpfwk/tzF6NmlEan8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZqJehPOrVXLGasi+2K0691rjrJV4sAtLY77TJx0LdBQMIkZkDD+3TOssL51EWK4qT
         1E1LyK+rzJNezHO6dF1DPrKOnfoGQTGQqRl4MtmX3eQId6jRxwbPb+Ph4Piy7BwO92
         GAXAYcsvqtxh/TtnougYnIpoFECBlPu44WNMEgB4=
Date:   Thu, 21 Feb 2019 09:20:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2] perf/core: use strndup_user() instead of buggy
 open-coded version
Message-Id: <20190221092057.8c56fa4db9eb39b7b14cd0fe@kernel.org>
In-Reply-To: <20190220165443.152385-1-jannh@google.com>
References: <20190220165443.152385-1-jannh@google.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Wed, 20 Feb 2019 17:54:43 +0100
Jann Horn <jannh@google.com> wrote:

> The first version of this method was missing the check for
> `ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
> on error, so there was still a small memory leak in the error case.
> Fix it by using strndup_user() instead of open-coding it.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, for stable, this is good. For the long term, I think we should
fix strndup_user() to return -E2BUG when the user string is longer
than max.

Thank you,

> Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> v2:
>  - be compatible with existing error codes (Masami Hiramatsu)
> 
>  kernel/trace/trace_event_perf.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 76217bbef815..4629a6104474 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -299,15 +299,13 @@ int perf_uprobe_init(struct perf_event *p_event,
>  
>  	if (!p_event->attr.uprobe_path)
>  		return -EINVAL;
> -	path = kzalloc(PATH_MAX, GFP_KERNEL);
> -	if (!path)
> -		return -ENOMEM;
> -	ret = strncpy_from_user(
> -		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
> -	if (ret == PATH_MAX)
> -		return -E2BIG;
> -	if (ret < 0)
> -		goto out;
> +
> +	path = strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
> +			    PATH_MAX);
> +	if (IS_ERR(path)) {
> +		ret = PTR_ERR(path);
> +		return (ret == -EINVAL) ? -E2BIG : ret;
> +	}
>  	if (path[0] == '\0') {
>  		ret = -EINVAL;
>  		goto out;
> -- 
> 2.21.0.rc0.258.g878e2cd30e-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
