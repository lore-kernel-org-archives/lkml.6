Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4CEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4BC2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xg+N7yjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfBEQmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:42:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43468 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfBEQmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:42:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id c6so2787238qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3MyYNZ94U9kqmUXktPbHyDE74mj5HBGwqxo8XES1UFM=;
        b=xg+N7yjNoKJSNqVLa2/6pA6Csz5s2U78FTevPT3oa56BbbUfr0t/G9jcDBu3JcprcQ
         HAGdpTHcZpeidDOvusxRLYiA1MV+UmRKp6MtErO63Hb79mCn7PVYKI/OPArvc6E5+UBD
         ChIsLI68seujV/sSMHHETMHlF3237Ep/umbts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3MyYNZ94U9kqmUXktPbHyDE74mj5HBGwqxo8XES1UFM=;
        b=HEQ2iHx4/5yV/3QYUa188sbtGSl4uhzXk6AQqklDgSEr/r5Mk4Gatc+NmiEPXbZetm
         HEoguzrn1CYRIB/2JVPDmowOXPdD9tmRE+jlTUe3p84Rqx91XVBPBuNCiduAMUNlEPTl
         3flR+a3G4fdY2YlT0B7Nteygex0livP2N1HhTu6+iS3+1nxd9chQT/ft6uJT/Xbk/Pfs
         YJULE19Dl+fz1bM2JZ0VcBxAkOux3k0I4KcRfQTChVKr50SeXDETIb5misgv42X/pt8k
         /kaMZ2EL4cUPoLByh22ZJqOf/ucmmBimRmd9Amx0M764Uy/P9QEqMaSS8fM7UidHWlsy
         VpAw==
X-Gm-Message-State: AHQUAuZvwT6VZ85oEtPOaU8aGR2HKfT6+CozpVjdgH7thO8PA+GT9B6u
        meEnqCnP+3US9L5L8HmvD5u4Pg==
X-Google-Smtp-Source: AHgI3IakOGu3CbHEEL/w25y9CmntyqLNzdxEB5+AyFO5lFuRpjsdeJNHTdT1YA9H/kL7CbdIkc9rvA==
X-Received: by 2002:a0c:b988:: with SMTP id v8mr479976qvf.54.1549384935353;
        Tue, 05 Feb 2019 08:42:15 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id f33sm8889074qta.91.2019.02.05.08.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 08:42:13 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:42:13 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190205164213.GE46829@google.com>
References: <cover.1548998323.git.hle@owl.eu.com>
 <647b057e1fef497c591d5009cbb20692e7df9785.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647b057e1fef497c591d5009cbb20692e7df9785.1548998323.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:38:35AM +0100, Hugo Lefeuvre wrote:
> introduce wait_event_freezable_hrtimeout, an interruptible and freezable
> version of wait_event_hrtimeout.
> 
> Among others this helper will allow for simplifications in
> staging/android/vsoc.c.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

>  include/linux/wait.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 5f3efabc36f4..c4cf5113f58a 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -483,7 +483,7 @@ do {										\
>  	__ret;									\
>  })
>  
> -#define __wait_event_hrtimeout(wq_head, condition, timeout, state)		\
> +#define __wait_event_hrtimeout(wq_head, condition, timeout, state, cmd)		\
>  ({										\
>  	int __ret = 0;								\
>  	struct hrtimer_sleeper __t;						\
> @@ -500,7 +500,7 @@ do {										\
>  			__ret = -ETIME;						\
>  			break;							\
>  		}								\
> -		schedule());							\
> +		cmd);							        \
>  										\
>  	hrtimer_cancel(&__t.timer);						\
>  	destroy_hrtimer_on_stack(&__t.timer);					\
> @@ -529,7 +529,23 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
> -					       TASK_UNINTERRUPTIBLE);		\
> +					       TASK_UNINTERRUPTIBLE,		\
> +					       schedule());			\
> +	__ret;									\
> +})
> +
> +/*
> + * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to avoid
> + * increasing load and is freezable.
> + */
> +#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\
> +({										\
> +	int __ret = 0;								\
> +	might_sleep();								\
> +	if (!(condition))							\
> +		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
> +					       TASK_INTERRUPTIBLE,		\
> +					       freezable_schedule());		\
>  	__ret;									\
>  })
>  
> @@ -555,7 +571,8 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq, condition, timeout,		\
> -					       TASK_INTERRUPTIBLE);		\
> +					       TASK_INTERRUPTIBLE,		\
> +					       schedule());			\
>  	__ret;									\
>  })
>  
> -- 
> 2.20.1
