Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935102173C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Apm9NhOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbeLUJpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:45:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43623 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733247AbeLUJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:45:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so4118540eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NhD3iKAIKpmO3OXekjBxkYrlMQxXxTpXmOu23KoWWM=;
        b=Apm9NhOykmsfFpkEtJ7mkMv4jz/eB1qlFqzY8L6pCpx61FmZYC47M+AACI72S8uXKn
         cX2PusVpt2+XsVGF3+9DdY1vY0lQ8tUO/JjQxpUDM73MIt6IpNKJ387FWJnFIv4xScJN
         2rnO20RrrLLOj1Ns4KZcb6wSkiMAphV608Pc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NhD3iKAIKpmO3OXekjBxkYrlMQxXxTpXmOu23KoWWM=;
        b=B7Y3OLyC1W6U7PmCIpMzvusTuwcL924yruLjwcXxMkaMlM4CIDKolwk0dW+ZrBBj94
         0Cfc12o0da4uMgAtnUoW6HKFKnamLNIRxI6PFQoYQgxmAssAeur3fqBRj0vGW5lsTHp7
         SlbS1n2rxMhyB2dvB8xPwNi+O9wA8ayN4tznFYXyDEcI29IxsdaBYam2fB2uR8uI3R02
         XKJsAvo1httjsGOSkiCKBZ7DcFLDw3yzwPml9iSo+3AMBBC4Rfa703X81oIiidsm6Vc8
         o5X5hmSVR4GlYEkm9PMy6/nhcu1AOq5V2gUTQTC8Z/bYiAl0+80Hr7CCiarYhuvt9dNQ
         iBFA==
X-Gm-Message-State: AA+aEWaEXmat1qWKgW7J0bkDQ0pLJrgmVOmoyJH98L+DH6hkgPHbrHV/
        Mnt7WQMVWYN6Ih0cQvzPxHgpDg==
X-Google-Smtp-Source: AFSGD/UNs2O9/i/2p+vk8Ei4hhGj2aVLUCCEhM6umalEcLzHqpIiKNGIGgsTFDEbdSXrwCq40FbaKw==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr1879284edq.30.1545385522857;
        Fri, 21 Dec 2018 01:45:22 -0800 (PST)
Received: from andrea (host250-139-dynamic.26-79-r.retail.telecomitalia.it. [79.26.139.250])
        by smtp.gmail.com with ESMTPSA id b46sm6882975edd.94.2018.12.21.01.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 01:45:22 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:45:15 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     dbueso@suse.de, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
Subject: Re: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
Message-ID: <20181221094515.GA3740@andrea>
References: <aa864e194ee4c987b7e2025d1fe6e88b@suse.de>
 <1545377353-30441-1-git-send-email-prsood@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545377353-30441-1-git-send-email-prsood@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:59:13PM +0530, Prateek Sood wrote:
> P1 is releaseing the cpu_hotplug_lock and P2 is acquiring
> cpu_hotplug_lock.
> 
> P1                                               P2
> percpu_up_read() path                      percpu_down_write() path
> 
>                                           rcu_sync_enter() //gp_state=GP_PASSED
> 
> rcu_sync_is_idle() //returns false        down_write(rw_sem)
> 
> __percpu_up_read()
> 
> [L] task = rcu_dereference(w->task) //NULL
> 
> smp_rmb()                                  [S] w->task = current
> 
>                                             smp_mb()
> 
>                                            [L] readers_active_check() //fails
> 					     schedule()
> 
> [S] __this_cpu_dec(read_count)
> 
> Since load of task can result in NULL, it can lead to missed wakeup
> in rcuwait_wake_up(). Above sequence violated the following constraint
> in rcuwait_wake_up():
> 
> 	 WAIT                WAKE
> [S] tsk = current	  [S] cond = true
> MB (A)	                    MB (B)
> [L] cond		  [L] tsk
> 
> This can happen as smp_rmb() in rcuwait_wake_up() will provide ordering
> of load before barrier with load and store after barrier for arm64
> architecture. Here the requirement is to order store before smp_rmb()
> with load after the smp_rmb().
> 
> For the usage of rcuwait_wake_up() in __percpu_up_read() full barrier
> (smp_mb) is required to complete the constraint of rcuwait_wake_up().
> 
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>

It looks like Peter has already queued this, c.f.,

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=locking/core&id=73685b8af253cf32b1b41b3045f2828c6fb2439e

with a modified changelog and my Reviewed-by (that I confirm).

I can't tell how/when this is going to be upstreamed (guess via -tip),
Peter?

  Andrea


> 
> ---
>  kernel/exit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index ac1a814..696e0e1 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -298,7 +298,7 @@ void rcuwait_wake_up(struct rcuwait *w)
>  	/*
>  	 * Order condition vs @task, such that everything prior to the load
>  	 * of @task is visible. This is the condition as to why the user called
> -	 * rcuwait_trywake() in the first place. Pairs with set_current_state()
> +	 * rcuwait_wake_up() in the first place. Pairs with set_current_state()
>  	 * barrier (A) in rcuwait_wait_event().
>  	 *
>  	 *    WAIT                WAKE
> @@ -306,7 +306,7 @@ void rcuwait_wake_up(struct rcuwait *w)
>  	 *        MB (A)	      MB (B)
>  	 *    [L] cond		  [L] tsk
>  	 */
> -	smp_rmb(); /* (B) */
> +	smp_mb(); /* (B) */
>  
>  	/*
>  	 * Avoid using task_rcu_dereference() magic as long as we are careful,
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
