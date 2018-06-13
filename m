Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84BE4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F12C20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EPn05gRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F12C20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754459AbeFMEgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:36:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35771 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeFMEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:36:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so766324plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 21:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ba+V27PlnEb1LlfOVSoxkR/s1khchw1ga/W8XOLZzHI=;
        b=EPn05gRThzhVdNxcxDC9+gYgPEqqmljibwVEy2EGfnKqGa6TgXf488IuBu9Uwxu0B7
         Z2tir8SRjbSoaNLiF2a57on1ETI099Qq9NU50VWOsU5RvfgB8JoXKawMEXVgPEVhWWAf
         RJjZXryh/5AT46JOW4Npf+A6A8Ofx4m1mAJlky2HkzZKV7I4447K1selbyoYkfstYSYM
         CplCwQ24rgCYdmSdQun8DiWBE2hcX/OwyJsOazPnACZjxV/b16XeSeZ8idMgxlAqlxOv
         tRypy1ofq+GoB4LfFWN8liy4Dosm5qud9gDiraw0ZstVmvUjl/GySSJVugIPf2C1RewT
         1rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ba+V27PlnEb1LlfOVSoxkR/s1khchw1ga/W8XOLZzHI=;
        b=JJ7gLUmsszdx/IYiNGjes1MoPp+H8NYllj5Xlo7hJYXkMNIMJxitYag/r320t/hyIA
         dly782cVksr9aRMxJK50iLtB3G0BQg3c+93lJdD+qOZEm5AC6UW4dIp+yGHLx2z/8MAt
         3SW9dHj3NKLaxxB4+ur9415MWhe4HqkOgAr699AyJaCtYJ/ME2gEC4bJT12fZYEuzYiT
         P5mQlbVeCUWb1oCjHyzBJyeQ9BnPBQnj/UMkMIyXVebavHsdfAO8+ngMkeo48y/7Y190
         x3RZn92hRyOI+wdsWYOpWS6rrOlsg5ilfsrP7OPlus9ZpLAB6+CIz2Top1pZBF7BFbBF
         pwAA==
X-Gm-Message-State: APt69E27msUAQb5X2/5GkqhRiQuiMpIrwoA7DjFyIgtNt+Ha/4rXMgDX
        7sbiBhxe5L3bKtdfapyBspvnDQ==
X-Google-Smtp-Source: ADUXVKIwaEaA5Sext6QHdwL8E/dQdC+RWVt7HQw/n9ktyzdACBn9OfQ/R+mbTAaAv8CIpFBF5ScHWw==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5-v6mr3507340pls.32.1528864581934;
        Tue, 12 Jun 2018 21:36:21 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q69-v6sm3262994pfl.16.2018.06.12.21.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 21:36:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fSxW8-0005vd-8V; Tue, 12 Jun 2018 22:36:20 -0600
Date:   Tue, 12 Jun 2018 22:36:20 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lidong Chen <jemmy858585@gmail.com>
Cc:     dledford@redhat.com, akpm@linux-foundation.org,
        qing.huang@oracle.com, leon@kernel.org, artemyko@mellanox.com,
        dan.j.williams@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, adido@mellanox.com,
        galsha@mellanox.com, aviadye@mellanox.com,
        Lidong Chen <lidongchen@tencent.com>
Subject: Re: [PATCH v2] IB/umem: ib_ucontext already have tgid, remove pid
 from ib_umem structure
Message-ID: <20180613043620.GA22578@ziepe.ca>
References: <1525769416-14596-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525769416-14596-1-git-send-email-lidongchen@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 04:50:16PM +0800, Lidong Chen wrote:
> The userspace may invoke ibv_reg_mr and ibv_dereg_mr by different threads.
> If when ibv_dereg_mr invoke and the thread which invoked ibv_reg_mr has
> exited, get_pid_task will return NULL, ib_umem_release does not decrease
> mm->pinned_vm. This patch fixes it by use tgid in ib_ucontext struct.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  [v2]
>  - use ib_ucontext tgid instread of tgid in ib_umem structure

I'm looking at this again, and it doesn't seem quite right..

> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 9a4e899..2b6c9b5 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -119,7 +119,6 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>  	umem->length     = size;
>  	umem->address    = addr;
>  	umem->page_shift = PAGE_SHIFT;
> -	umem->pid	 = get_task_pid(current, PIDTYPE_PID);
>  	/*
>  	 * We ask for writable memory if any of the following
>  	 * access flags are set.  "Local write" and "remote write"
> @@ -132,7 +131,6 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>  		 IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND));
>  
>  	if (access & IB_ACCESS_ON_DEMAND) {
> -		put_pid(umem->pid);
>  		ret = ib_umem_odp_get(context, umem, access);
>  		if (ret) {
>  			kfree(umem);
> @@ -148,7 +146,6 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>  
>  	page_list = (struct page **) __get_free_page(GFP_KERNEL);
>  	if (!page_list) {
> -		put_pid(umem->pid);
>  		kfree(umem);
>  		return ERR_PTR(-ENOMEM);
>  	}

in ib_umem_get we are doing this:

	down_write(&current->mm->mmap_sem);
	locked     = npages + current->mm->pinned_vm;

And then in release we now do:

	task = get_pid_task(umem->context->tgid, PIDTYPE_PID);
	if (!task)
		goto out;
	mm = get_task_mm(task);
	mm->pinned_vm -= diff;

But there is no guarantee that context->tgid and 'current' are the
same thing during ib_umem_get..

So in the dysfunctional case where someone forks and keeps the context
FD open on both sides of the fork they can cause the pinned_vm
counter to become wrong in the processes. Sounds bad..

Thus, I think we need to go back to storing the tgid in the ib_umem
and just fix it to store the group leader not the thread PID?

And then even more we need the ib_get_mr_mm() helper to make sense of
this, because all the drivers are doing the wrong thing by using the
context->tgid too.

Is that all right?

Jason
