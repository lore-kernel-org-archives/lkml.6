Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AAF2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MOqqdI9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AAF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeLLP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:29:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37491 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeLLP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:29:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so15898396edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtlTE84oxlmz5yQs1GoQVX0Sm34zBTIdf418AO8syUM=;
        b=MOqqdI9nDuT9ad7w+VR9/sxvpOLBJde/JsBD4IW4pE01/u+hpQzIEynBaALniXZ82C
         L6Cd8Lj+SxrZrHENfz7jOrL2Ee9cVdbXkeBgJr/0rts9B2TgRiuba0MTu0negKyF5/QL
         P8qQvFA4PwmfGkNLpf6vEDry83/LQIFNU6i/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtlTE84oxlmz5yQs1GoQVX0Sm34zBTIdf418AO8syUM=;
        b=QeRb/zERYmRyXcuprz7UCIThHBASrwwroyGkYDtqwixXgt3FNTSqTTYO/D/H1xXMYI
         uPq1GQhjbuDS1AZQhdeQvns4V5F8Fg8go4erIbZHLv4OUiyiqitxjdKV2TwOV66XcRAv
         ar0PuR3qwcMsmFE1Zk+0mekZZOvlQBxkaN9IwYmh89az1eJqOdPk6/gy/hmkABnZWHKO
         TdU5dJnXAWafaoccp6Mlc7GfaoWBFATpyiV7zOadltiGsEmSSmHdWFLYBnXjf6vdREny
         EzMzrAR/HB+EZB6p/UXD+i3Tw9z5cKmF5yF74+p65Sgv6J/qtTpMbcLfkVjEEt/l3mLF
         WJXQ==
X-Gm-Message-State: AA+aEWbZlk7OKDtFEkLQIM7EebtHE6UpAs+CDpe7nNYmOW0Ks+BacRpZ
        3mfnYt9ueb2RjG2P+3X4MPCq6w==
X-Google-Smtp-Source: AFSGD/VUFuanLy72eGwp9dySug0w/mDcQwuVW5Ut3bktdkVSWQ8NwoYuxGFB6IqSY/mj8DWjXRswSg==
X-Received: by 2002:a50:9770:: with SMTP id d45mr18112786edb.49.1544628546008;
        Wed, 12 Dec 2018 07:29:06 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id z40sm4927322edz.86.2018.12.12.07.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 07:29:05 -0800 (PST)
Date:   Wed, 12 Dec 2018 16:28:52 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     peterz@infradead.org, mingo@redhat.com, dbueso@suse.de,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
Subject: Re: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
Message-ID: <20181212152852.GA11111@andrea>
References: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:40:56PM +0530, Prateek Sood wrote:
> In a scenario where cpu_hotplug_lock percpu_rw_semaphore is already
> acquired for read operation by P1 using percpu_down_read().
> 
> Now we have P1 in the path of releaseing the cpu_hotplug_lock and P2
> is in the process of acquiring cpu_hotplug_lock.
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
> Since load of task can result in NULL. This can lead to missed wakeup
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

I know this is going to sound ridiculous (coming from me or from
the Italian that I am), but it looks like we could both work on
our English. ;-)

But the fix seems correct to me:

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

It might be a good idea to integrate this fix with fixes to the
inline comments/annotations: for example, I see that the comment
in rcuwait_wake_up() mentions a non-existing rcuwait_trywake();
moreover, the memory-barrier annotation "B" is used also for the
smp_mb() preceding the __this_cpu_dec() in __percpu_up_read().

  Andrea


> ---
>  kernel/exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f1d74f0..a10820d 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
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
