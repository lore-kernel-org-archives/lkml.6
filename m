Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6674BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375B82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQXzUi5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbeLQQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:37:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeLQQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tvRn8uif1FnxMDVH2moPVASXN2XAW1fiY/rFaMZFEyI=; b=dQXzUi5NrkierFSHvM7QCXs/O
        ZWFNmaeehaYNLpnR9GzryAAPBBuVRKGb5l5VBNg47EzvcT89POWv2REMMhC0649KvhmagRsJd1tAe
        CWc/ezl7zDP9exWBlWQqVDFjwSShk2d317FMyVCXlrY+5VwqB0lgpwGiPAS2S7juxUN90QpPCo335
        w1nOWDyeWHwjeWfpfeglVR7q5ulW8OAr7kzgQwyk72FblOry58HlIPfwfLw+tOfINWShO3EXTyu9c
        801sQ9YVHkOnYX7T5Py6gD59cwK0XaIHPSww5RXI6TDjy8JZFY5geZl+5MLUlQDc6vioOAhAuiKu1
        po2hgPN8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYvtX-00011h-MH; Mon, 17 Dec 2018 16:37:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D56420276ABC; Mon, 17 Dec 2018 17:27:13 +0100 (CET)
Date:   Mon, 17 Dec 2018 17:27:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 6/6] psi: introduce psi monitor
Message-ID: <20181217162713.GE2218@hirez.programming.kicks-ass.net>
References: <20181214171508.7791-1-surenb@google.com>
 <20181214171508.7791-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214171508.7791-7-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:15:08AM -0800, Suren Baghdasaryan wrote:
> @@ -358,28 +526,23 @@ static void psi_update_work(struct work_struct *work)
>  {
>  	struct delayed_work *dwork;
>  	struct psi_group *group;
> +	u64 next_update;
>  
>  	dwork = to_delayed_work(work);
>  	group = container_of(dwork, struct psi_group, clock_work);
>  
>  	/*
> +	 * Periodically fold the per-cpu times and feed samples
> +	 * into the running averages.
>  	 */
>  
> +	psi_update(group);
>  
> +	/* Calculate closest update time */
> +	next_update = min(group->polling_next_update,
> +				group->avg_next_update);
> +	schedule_delayed_work(dwork, min(PSI_FREQ,
> +		nsecs_to_jiffies(next_update - sched_clock()) + 1));

See, so I don't at _all_ like how there is no idle option..

>  }


