Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5796A2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576708;
	bh=fEsRg9RSs9/omN7Q1KYLreyd754jaecg+/8vfU3s/cI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VkkMAL9IFT+3NNkQ+94KEb7L7jhJG1KDQBWh1qP8Lcg9BqwVZwN7tb2tT4tsTrKTB
	 bzKrPZbDFsRdD9vAwbFXdVAH31eaJ87ip1tH0se87skwy4VxoeytVtPGXnxMRG0req
	 pi7eHpbmtqKOhLAhAWRIZYOP9HCD13wa2v1popl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfBSLpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBSLpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:45:06 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E4421479;
        Tue, 19 Feb 2019 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550576705;
        bh=fEsRg9RSs9/omN7Q1KYLreyd754jaecg+/8vfU3s/cI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l0BDXVUfphtkzPpFKvnh+Ns0/iXB88om4xmf7EV3t9KreDDfce8cKUXbi1YrZMOzn
         rEBKT2zGrbQsGlIy8qHVih86SpJyM9MXnSJ1JUaji7/imkd6AweYb/pRXmD7fVvCoB
         QCzvqqlPLmsAHsOD8RBIFhbXnWGh2MqXpVnAO++M=
Date:   Tue, 19 Feb 2019 20:45:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf/core: use strndup_user() instead of buggy
 open-coded version
Message-Id: <20190219204502.d0c4f95d1cda533990d96cd9@kernel.org>
In-Reply-To: <20190218220723.176737-1-jannh@google.com>
References: <20190218220723.176737-1-jannh@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 23:07:23 +0100
Jann Horn <jannh@google.com> wrote:

> The first version of this method was missing the check for
> `ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
> on error, so there was still a small memory leak in the error case.
> Fix it by using strndup_user() instead of open-coding it.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> compile-tested only
> 
>  kernel/trace/trace_event_perf.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 76217bbef815..c744b02081c3 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -299,15 +299,11 @@ int perf_uprobe_init(struct perf_event *p_event,
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
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
>  	if (path[0] == '\0') {
>  		ret = -EINVAL;
>  		goto out;
> -- 
> 2.21.0.rc0.258.g878e2cd30e-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
