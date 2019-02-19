Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E22C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CCB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550587889;
	bh=IF88uaAexNPXcn6h6tTFa8UBfKJhFLbWoCvjruc4xzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dMEgR6BjhYctjK/WQ3wwJvOCVfKKqFVy+PF5sKD/DPrMpKPR1ZLkuzM38+6aopVI5
	 albTeTDHqN70NG2DlpkpIuCOwp9YN4bT4yTZv5rQSzUz+3jxDUzWpNR4b2I5oLd+zD
	 0IuRldR5h+bPaH8RoyAiQvXRnFS2tBxBZSQ8IMME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfBSOv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfBSOv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:51:27 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302012146E;
        Tue, 19 Feb 2019 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550587886;
        bh=IF88uaAexNPXcn6h6tTFa8UBfKJhFLbWoCvjruc4xzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wm4AfbHT4yeXaGFDKM7vVqA3M9qKNX9cULcbRed6Ot7n7Hm0do9vIOagxhiLRvUpW
         b8kM32lQrrlx69oS0ltun2qVcUI2W+RrGB+T93wuQ6L+d8NTTnOlFud7Chn7bIo2OD
         L92nD8jerxGLFdv/fEInGX6SBs4R+dMTJwpUOMkM=
Date:   Tue, 19 Feb 2019 23:51:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] perf/core: use strndup_user() instead of buggy
 open-coded version
Message-Id: <20190219235122.b9f8c6c47392a27131526018@kernel.org>
In-Reply-To: <20190219204502.d0c4f95d1cda533990d96cd9@kernel.org>
References: <20190218220723.176737-1-jannh@google.com>
        <20190219204502.d0c4f95d1cda533990d96cd9@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 20:45:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 18 Feb 2019 23:07:23 +0100
> Jann Horn <jannh@google.com> wrote:
> 
> > The first version of this method was missing the check for
> > `ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
> > on error, so there was still a small memory leak in the error case.
> > Fix it by using strndup_user() instead of open-coding it.
> > 
> 
> This looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, I think it should note that if the string is longer than PATH_MAX.
caller will receive -EINVAL instead of -E2BIG with this fix.

Thank you,

> 
> Thank you!
> 
> > Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > compile-tested only
> > 
> >  kernel/trace/trace_event_perf.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> > index 76217bbef815..c744b02081c3 100644
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -299,15 +299,11 @@ int perf_uprobe_init(struct perf_event *p_event,
> >  
> >  	if (!p_event->attr.uprobe_path)
> >  		return -EINVAL;
> > -	path = kzalloc(PATH_MAX, GFP_KERNEL);
> > -	if (!path)
> > -		return -ENOMEM;
> > -	ret = strncpy_from_user(
> > -		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
> > -	if (ret == PATH_MAX)
> > -		return -E2BIG;
> > -	if (ret < 0)
> > -		goto out;
> > +
> > +	path = strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
> > +			    PATH_MAX);
> > +	if (IS_ERR(path))
> > +		return PTR_ERR(path);
> >  	if (path[0] == '\0') {
> >  		ret = -EINVAL;
> >  		goto out;
> > -- 
> > 2.21.0.rc0.258.g878e2cd30e-goog
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
