Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE143C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A62F25957
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4gkwCGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A62F25957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeF1CQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:16:10 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42637 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeF1CQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:16:08 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so1744718pgu.9;
        Wed, 27 Jun 2018 19:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKp3Et98aJs8H10OXwDuB6rx9WCFjGV65JzLT6m6omw=;
        b=m4gkwCGIM727MOVyeOJW3uUTym0/+crcthe3KlaLYyJ1hDVKUZDrgJ3upt8cKP3ir0
         RLt6OYrPPZPSt/mp8vHXRTru/+4fAWHzeRzvOYk5xwzCBDve822vyC5UnLA3ZliJhH4a
         r3j2B1j4nZB5ikx+GtpFHWusCu7GRlieXqKNRu1gN/SnsZPFxk4TJ4i+8L9NPe5oUQ56
         tFWvGwyt0K44uP79Ha4G/KDOuAB4siZdrdlbtpZIoPW4mWEAcNOw38uDO2IMzFOvLj1R
         Um6RooMCcEhH/GVaPihrh/roiEYpVwHhifXDAnO9/MMDDaJ8nomnxUUa++yYySxIIr/X
         fY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKp3Et98aJs8H10OXwDuB6rx9WCFjGV65JzLT6m6omw=;
        b=jHHJhcq6Med5/vcLDnWZOopjIyFkGmdGIdLVe6dYBRYAZ/1/e3rcEUvhFnAYNvK/GS
         eT/u3U2pUNpDgNauCBgdkqAQ2jqUobi3Lgs7r3yr75fovj5UaL5nda0rAZ91c3EcjW0e
         0l6fTwRg06okPpShp3plIdkfnWWv9hSxvtvxxJS/CrYhE40ggvNvdz1ydFavOzZJn8UQ
         qumbffG07cmt5Aq612WFO9xTOnLEl8caMg8BRrMmtIc6UZnndQ813Qo8AU73YAtRIZxF
         vqynORybztBPjAnModjWOX0MQLOlj6N8vS3prlyNj9jTCismMaOk8uo9mPHsFfgIKT4s
         GycQ==
X-Gm-Message-State: APt69E3OflKXxBYbqw81mPwS5oFP0HTbUqfyftOiBClXWJx8T69K3qW/
        P6VTmyiPaXIt55bvRuZ/xqA=
X-Google-Smtp-Source: AAOMgpdwLF5eEG5tUwCHxH5XURVO3aW1wN3bOctREr7ZxQ4G8g5ylr/jnBTV2n6ZN9fRgu/QNIZX2g==
X-Received: by 2002:a62:9419:: with SMTP id m25-v6mr8183100pfe.120.1530152167781;
        Wed, 27 Jun 2018 19:16:07 -0700 (PDT)
Received: from localhost ([110.70.27.221])
        by smtp.gmail.com with ESMTPSA id t6-v6sm7344304pgp.3.2018.06.27.19.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 19:16:06 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:16:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] printk: Create helper function to queue deferred
 console handling
Message-ID: <20180628021603.GB481@jagdpanzerIV>
References: <20180627140817.27764-1-pmladek@suse.com>
 <20180627140817.27764-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627140817.27764-3-pmladek@suse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 16:08), Petr Mladek wrote:
> -int vprintk_deferred(const char *fmt, va_list args)
> +void defer_console(void)
>  {
> -	int r;
> -
> -	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
> -
>  	preempt_disable();
>  	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
>  	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
>  	preempt_enable();
> +}
> +
> +int vprintk_deferred(const char *fmt, va_list args)
> +{
> +	int r;
> +
> +	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
> +	defer_console();
>  
>  	return r;


You can just call vprintk_emit(LOGLEVEL_SCHED) from vprintk_func(),
then you don't need to factor out vprintk_deferred() and vprintk_emit().
Any reason for that split?

I'd also may be prefer to have a bit different name. I'm talking
about defer_console().

Other than that

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
