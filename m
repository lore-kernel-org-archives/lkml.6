Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAABC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D73E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjxlU2GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D73E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbeFRGhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:37:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43632 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754488AbeFRGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:37:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so8458458plj.10;
        Sun, 17 Jun 2018 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UU9wh6H1HxCu4gGng/TPG2e9TfsdTYFS9ti4DmNN3KY=;
        b=NjxlU2GY37Hgz2p54syrKrj7CGlWCZyCt6KnPI6VFVoks83ufsmqgPoH5bXXSVsZ7o
         tNt8R0CAyaueiPsKuXdg49qxSysFoY0vm9ay87XqmfMEoPjIrEOmVqtvju09DShtMgM+
         lXqBQqeXePbyverY4R19/yWFICvn7xGkFKjJNJtOvI5B9SgiZQ0CJaSNXT1MG4wLl1jf
         j7mVqRbcuByvzmcoK8jti5SPO+l43jJCOChfNjmd7ZP/diOYThbUadQYKw+E8uAPRlNp
         yavq44s5zvYgdF5B/9d9t+4QQ67ox1U8DHV+B0kcIO2E1uTYa3MT0AZF4aVufFzs+RL0
         2NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UU9wh6H1HxCu4gGng/TPG2e9TfsdTYFS9ti4DmNN3KY=;
        b=BEWpHr030VbuPh/g1dknOvqGrpEgMiQmdzz/OhMsqMBafcMHU4djCfr0wqTGcJGPAE
         5elanqwGs/3AP66/R+WeQeeiqu+9p1tTLu8F5yFpsY2xpIj+9ws1A15+aTO3P4FvR2/w
         5KY9eoxOQtQY9zxWeP/GaqHFbAJisSjqU7hM29H3Zy77yIDXGcBjLzm5an3QPjit1Rxv
         LLL0Q9lP76cpUuLrHZQeIRr9CvGyTJtt18pj9HVMamA0VKCzo+HAEX5p7lBJKFyba3QB
         XRAoCyVqmQOAH8bCwjkKXTtOlb4l7zKquWpOVAY+mnCv5iZjkoEiV4Sgwkox1R2LaThh
         LdGA==
X-Gm-Message-State: APt69E2j2bs9zT3F7chUxBqTmfiLdJhmI2XEL4OzLl6h6VPOKsZvT+Yg
        rS2qn+hpsxrk8FUxu+aGOm4=
X-Google-Smtp-Source: ADUXVKJ+KIpmqbHt6OIZqVbZDfyyNpt3BO9DILLOSRllcH6FzCXAXYYfvPSKZ1p3rvBnMMOhP6GVDw==
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr12585766plk.96.1529303863116;
        Sun, 17 Jun 2018 23:37:43 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id q9-v6sm16733795pgv.84.2018.06.17.23.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:37:41 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:37:38 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180618063738.GC27996@jagdpanzerIV>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
 <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/08/18 12:48), Petr Mladek wrote:
[..]
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 6d7e800affd8..872fbdf8df26 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -148,9 +148,13 @@ void early_printk(const char *s, ...) { }
>  #ifdef CONFIG_PRINTK_NMI
>  extern void printk_nmi_enter(void);
>  extern void printk_nmi_exit(void);
> +extern void printk_nmi_direct_enter(void);
> +extern void printk_nmi_direct_exit(void);
>  #else
>  static inline void printk_nmi_enter(void) { }
>  static inline void printk_nmi_exit(void) { }
> +static void printk_nmi_direct_enter(void) { }
> +static void printk_nmi_direct_exit(void) { }

Can we have better names may be? Since direct printk_nmi is not
in fact always `direct'.

> +#ifdef CONFIG_PRINTK_NMI
> +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args);
> +#else
> +__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args) { return 0; }
> +#endif

Hmm, printk_safe.c knows about printk.c, printk.c knows about
printk_safe.c.

>  __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
>  __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
>  __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..cf55bece43d9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1845,7 +1845,13 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	printk_delay();
>  
>  	/* This stops the holder of console_sem just where we want him */
> -	logbuf_lock_irqsave(flags);
> +	printk_safe_enter_irqsave(flags);
> +	if (in_nmi() && !raw_spin_trylock(&logbuf_lock)) {
> +		printed_len = vprintk_nmi(fmt, args);
> +		printk_safe_exit_irqrestore(flags);
> +		return printed_len;
> +	} else
> +		raw_spin_lock(&logbuf_lock);

OK... Can we do this in vprintk_func()? The race window should be super
tiny [if matters at all], but in exchange we don't have to mix nmi, printk,
printk_mni, etc.

So over all I understand why you did it this way. May be I'd prefer to
have less universal but shorter solution (e.g. modify only nmi_backtrace
function and put there "printk_nmi_restricted_buffer"), but I won't really
object your patch [unless I see some real issues with it].

	-ss
