Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB328C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666A020833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqRQrkvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666A020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIJNjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:39:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38325 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeIJNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:39:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so20447443wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ocSuCVg8DwJaPrMf1cyYwOBEvIRPETLChes5qqzp6W4=;
        b=gqRQrkvr/4OmdxjTV3+aZGl5wbr5lutIFqqXq0WTNul3iFBWN66P2or7adCPkcOzai
         04soVk03gwQdf8GsOa7snI9JZPKQG3bDvP4Y9pg4jwYfMMgPRGK7zq8WC1Kf52pMwvS4
         aycVgCQd1GtI1sIpZjjjvHe736JttW/emcetHBjxrQsN6eJUNktrzkkT7LrB4kLKtEs+
         p3HbMvPhvIc6rYwV6O/yy87va23ogTRQENKu25yws7X4I2jtAuxFD7AGEhFjoFW97+YX
         LJUkhAOlj51ya1JnfeG/K+m524V85wfn/NmjgvBjRIUviWqxqUDXbfekPSuuywmLUuxn
         ozsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocSuCVg8DwJaPrMf1cyYwOBEvIRPETLChes5qqzp6W4=;
        b=pRC9irz//Q1Phi4/6r8LMh8iyzlAVtoIFSC2J1U0Fu7rzxHjEMPY5tVcDH39VIpvHx
         WsW2OcqlSxGB5v9TiHICoVuMofY0n00oddasSvGDYq/UJWlhUsBFoc0gTZBOBljvHVIc
         Xp4IPZd8nymgg+iwMyNiFBRVX4g97qHZ7KmJsx3Y4EWwCxucVcJ867BAkcxIuA4UiDVr
         6Iwq5D9ohBjSrAJg7PBRRkgNhOea3n8f7dieIJTxoTIdyQ5uQsVk/XTSQa/7my8F+qLS
         a5agsGR8OfX1q1BFCm7ITI8hx5tFuYXoZZKKMdquhxcd2fZBmC7yspDDB8pK5aFT5r//
         b8nw==
X-Gm-Message-State: APzg51AFAAm8s4jm3LCOoIp8GU8cCaP1u7y/HTwcr2t/aMSDESwxcT45
        ZKMGwGJf2QPjnLZccPCEuME=
X-Google-Smtp-Source: ANB0VdYHeetkDN13xU561ek0ZXd3v8XnmkJJwCDArZm/1O1SAFVtDZa0EHL1vEIFMjclJd4ZGSYKmA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24-v6mr12495703wmc.33.1536569196427;
        Mon, 10 Sep 2018 01:46:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u7-v6sm18218961wmd.46.2018.09.10.01.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 01:46:35 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:46:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/6] sched/numa: Avoid task migration for small numa
 improvement
Message-ID: <20180910084633.GD48257@gmail.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> If numa improvement from the task migration is going to be very
> minimal, then avoid task migration.
> 
> specjbb2005 / bops/JVM / higher bops are better
> on 2 Socket/2 Node Intel
> JVMS  Prev    Current  %Change
> 4     200892  210118   4.59252
> 1     325766  313171   -3.86627
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> JVMS  Prev     Current  %Change
> 8     89011.9  91027.5  2.26442
> 1     211338   216460   2.42361
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> JVMS  Prev    Current  %Change
> 4     190261  191918   0.870909
> 1     195305  207043   6.01009
> 
> 
> on 4 Socket/4 Node Power7
> JVMS  Prev     Current  %Change
> 8     57651.1  58462.1  1.40674
> 1     111351   108334   -2.70945
> 
> 
> dbench / transactions / higher numbers are better
> on 2 Socket/2 Node Intel
> count  Min      Max      Avg      Variance  %Change
> 5      12254.7  12331.9  12297.8  28.1846
> 5      11851.8  11937.3  11890.9  33.5169   -3.30872
> 
> 
> on 2 Socket/4 Node Power8 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      4997.83  5030.14  5015.54  12.947
> 5      4791     5016.08  4962.55  85.9625   -1.05652
> 
> 
> on 2 Socket/2 Node Power9 (PowerNV)
> count  Min      Max      Avg      Variance  %Change
> 5      9331.84  9375.11  9352.04  16.0703
> 5      9353.43  9380.49  9369.6   9.04361   0.187767
> 
> 
> on 4 Socket/4 Node Power7
> count  Min      Max      Avg      Variance  %Change
> 5      147.55   181.605  168.963  11.3513
> 5      149.518  215.412  179.083  21.5903   5.98948
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
> Changelog v1->v2:
>  - Handle trivial changes due to variable name change. (Rik Van Riel)
>  - Drop changes where subsequent better cpu find was rejected for
>    small numa improvement (Rik Van Riel).
> 
>  kernel/sched/fair.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5cf921a..a717870 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1568,6 +1568,13 @@ static bool load_too_imbalanced(long src_load, long dst_load,
>  }
>  
>  /*
> + * Maximum numa importance can be 1998 (2*999);
> + * SMALLIMP @ 30 would be close to 1998/64.
> + * Used to deter task migration.
> + */
> +#define SMALLIMP	30
> +
> +/*
>   * This checks if the overall compute and NUMA accesses of the system would
>   * be improved if the source tasks was migrated to the target dst_cpu taking
>   * into account that it might be best if task running on the dst_cpu should
> @@ -1600,7 +1607,7 @@ static void task_numa_compare(struct task_numa_env *env,
>  		goto unlock;
>  
>  	if (!cur) {
> -		if (maymove || imp > env->best_imp)
> +		if (maymove && moveimp >= env->best_imp)
>  			goto assign;
>  		else
>  			goto unlock;
> @@ -1643,16 +1650,22 @@ static void task_numa_compare(struct task_numa_env *env,
>  			       task_weight(cur, env->dst_nid, dist);
>  	}
>  
> -	if (imp <= env->best_imp)
> -		goto unlock;
> -
>  	if (maymove && moveimp > imp && moveimp > env->best_imp) {
> -		imp = moveimp - 1;
> +		imp = moveimp;
>  		cur = NULL;
>  		goto assign;
>  	}
>  
>  	/*
> +	 * If the numa importance is less than SMALLIMP,
> +	 * task migration might only result in ping pong
> +	 * of tasks and also hurt performance due to cache
> +	 * misses.
> +	 */
> +	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
> +		goto unlock;
> +
> +	/*
>  	 * In the overloaded case, try and keep the load balanced.
>  	 */
>  	load = task_h_load(env->p) - task_h_load(cur);

So what is this 'NUMA importance'? Seems just like a random parameter which generally isn't a 
good idea.

Also, same review feedback as I gave for the previous patches.

Thanks,

	Ingo
