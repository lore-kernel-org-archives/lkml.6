Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3021C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE82A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NzN4oTZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbeLQPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:55:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeLQPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=574+4ZD7Du9DDrY3jcdjsYd7VDFDIpxaJakuUWbr19s=; b=NzN4oTZi6gyJm2aSWquP3ym0d
        9omamrHx6pqwcZKsaR2e90jn3JJGPgWxUbNtXeKUrfjI47HpoiolK5gTOXYmROfIcTsA4j38T2tS6
        QwtlKihqL0AwxJKPVt2KhAMOEkNu+c9hCRXVjbXZIp9geLuF9OkitZG5hfKTCJ3BtBmTXjGlrSYI1
        4TgSqH4hgpz+eFez7W8mmEGlwcbjR5NRugb3gofnJfLixyB/rnj0dIWTg3Trhfze1lT42vr5lqQVB
        Z5uHM1LAngIidwmkDDiiTrrPgFICAjkZgEEmZ5miFSveGJjArtzaUovOv2s9v6TQNP94sjT0v0yGT
        oftNPPBHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYvEu-0000Ca-Vq; Mon, 17 Dec 2018 15:55:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7717F20276AC4; Mon, 17 Dec 2018 16:55:25 +0100 (CET)
Date:   Mon, 17 Dec 2018 16:55:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 4/6] psi: introduce state_mask to represent stalled psi
 states
Message-ID: <20181217155525.GC2218@hirez.programming.kicks-ass.net>
References: <20181214171508.7791-1-surenb@google.com>
 <20181214171508.7791-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214171508.7791-5-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:15:06AM -0800, Suren Baghdasaryan wrote:
> The psi monitoring patches will need to determine the same states as
> record_times(). To avoid calculating them twice, maintain a state mask
> that can be consulted cheaply. Do this in a separate patch to keep the
> churn in the main feature patch at a minimum.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/psi_types.h |  3 +++
>  kernel/sched/psi.c        | 29 +++++++++++++++++++----------
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 2cf422db5d18..2c6e9b67b7eb 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -53,6 +53,9 @@ struct psi_group_cpu {
>  	/* States of the tasks belonging to this group */
>  	unsigned int tasks[NR_PSI_TASK_COUNTS];
>  
> +	/* Aggregate pressure state derived from the tasks */
> +	u32 state_mask;
> +
>  	/* Period time sampling buckets for each state of interest (ns) */
>  	u32 times[NR_PSI_STATES];
>  

Since we spend so much time counting space in that line, maybe add a
note to the Changlog about how this fits.

Also, since I just had to re-count, you might want to add explicit
numbers to the psi_res and psi_states enums.

> +		if (state_mask & (1 << s))

We have the BIT() macro, but I'm honestly not sure that will improve
things.
