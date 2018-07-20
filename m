Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995ACECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271BC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BzgstcEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271BC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGTOES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:04:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbeGTOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H6K01RcLJt8ZqcfOt/Pzn3b4o8lh4P/UfHwyYAxDD/0=; b=BzgstcEAD/x+1YeVG1ZMEahKa
        h+KeGi7OKLm9NzE6YEa0XX3Cnp7a1sMs1e7kAS+qW7c+yf2gOz2Vp5DxCllhY0Xc+wzke666hZsp6
        Vkac+GslBGg8auDwpsMv87ttxYKq4XgSayFiCYMV9mu+6YDn3KlVq5P+b2C1eADW58Eo1CDDXzHJw
        hnwFJenJDaNP7qJdWCifxvegNqH/vwWBNILwvVoiXj+Q3AU8diyr1kCtqUnPXAQTD4G323v0bqP8z
        4WBkw+ZKa7XA8t2yycTZWlg3RM5fTnX5DrwiTaVYEdVG1Fjq+/DNyi67Tcp8Wm9coL1ytsfUVKZBO
        7aWWDr3lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgVGG-0001CC-T3; Fri, 20 Jul 2018 13:15:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A00920275F4C; Fri, 20 Jul 2018 15:15:55 +0200 (CEST)
Date:   Fri, 20 Jul 2018 15:15:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiexiangyou <xiexiangyou@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pjt@google.com" <pjt@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "efault@gmx.de" <efault@gmx.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "weiqi (C)" <weiqi4@huawei.com>, longpeng <longpeng2@huawei.com>
Subject: Re: [PATCH] sched/fair: cfs quota cause large schedule latency
Message-ID: <20180720131555.GN2476@hirez.programming.kicks-ass.net>
References: <7A2C95E1327F7148AB122F200A3EFA408068ADA6@dggema521-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A2C95E1327F7148AB122F200A3EFA408068ADA6@dggema521-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:08:41AM +0000, Xiexiangyou wrote:
> Virtual machine has cgroup hierarchies as follow:
> 
>                root
> 
>                 |
> 
>               vm_tg
> 
>               (cfs_rq)
> 
>               /    \
> 
>             (se)    (se)
> 
>             tg_A    tg_B
> 
>           (cfs_rq)    (cfs_rq)
> 
>             /          \
> 
>           (se)          (se)
> 
>           a              b
> 
> A and B are two vcpus of the VM.
> 
> 
> 
> We set cfs quota on vm_tg, and the schedule latency of vcpu(a/b) may become very large, up to more than 2S.
> 
> 
> 
> Shows Perf sched test result:
> 
> Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
> 
> -----------------------------------------------------------------------------------------------------------------
> 
>   CPU 0/KVM:49609       |    260.261 ms |       50 | avg:   82.017 ms | max: 2510.990 ms | max at:  43335.555886 s
> 
>   .....
> 
> 
> 
> We add some trace points, found the sequence as follows will lead to the issue:
> 
> -          'a' is only task of tg_A, when 'a' go to sleep, tg_A is dequeued, and tg_A->se->load.weight = MIN_SHARES.
> 
> -          'b' continue running, then trigger throttle. tg_A->cfs_rq->throttle_count=1
> 
> -          some task wakeup process 'a', When enqueue tg_A, tg_A->se->load.weight can't be updated because tg_A->cfs_rq->throttle_count=1
> 
> -          after one cfs quota period, vm_tg is unthrottled
> 
> -          'a' is running
> 
> -          after one tick, when update tg_A->se's vruntime, tg_A->se->load.weight is still MIN_SHARES, lead tg_A->se's vruntime has grown a large value.
> 
> -          That will cause 'a' to have a large schedule latancy.
> 
> The fix patch as follows:
> 
> Signed-off-by: Xiangyou Xie <xiexiangyou@huawei.com<mailto:xiexiangyou@huawei.com>>

The above Changelog violates just about every formatting rule ever
invented. Also you got your email format wrong.

The patch might be OK, but at this point I really can't do anything with
it anyway.

> ---
> kernel/sched/fair.c | 3 ---
> 1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2f0a0be..348ccd6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3016,9 +3016,6 @@ static void update_cfs_group(struct sched_entity *se)
>         if (!gcfs_rq)
>                 return;
> 
> -       if (throttled_hierarchy(gcfs_rq))
> -               return;
> -
> #ifndef CONFIG_SMP
>         runnable = shares = READ_ONCE(gcfs_rq->tg->shares);
> 
> --
> 1.8.3.1
> 
