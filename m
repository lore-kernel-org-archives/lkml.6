Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B625ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F0220862
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F0220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeGPX0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:26:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeGPX0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:26:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1532BE1;
        Mon, 16 Jul 2018 22:57:17 +0000 (UTC)
Date:   Mon, 16 Jul 2018 15:57:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/6] bdi: Use refcount_t for reference counting instead
 atomic_t
Message-Id: <20180716155716.1f7ac43d211133a8cb476637@linux-foundation.org>
In-Reply-To: <20180703200141.28415-4-bigeasy@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
        <20180703200141.28415-4-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jul 2018 22:01:38 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> refcount_t type and corresponding API should be used instead of atomic_t when
> the variable is used as a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free situations.
> 
> ...
>
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -438,10 +438,10 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
>  	if (new_congested) {
>  		/* !found and storage for new one already allocated, insert */
>  		congested = new_congested;
> -		new_congested = NULL;
>  		rb_link_node(&congested->rb_node, parent, node);
>  		rb_insert_color(&congested->rb_node, &bdi->cgwb_congested_tree);
> -		goto found;
> +		spin_unlock_irqrestore(&cgwb_lock, flags);
> +		return congested;
>  	}
>  
>  	spin_unlock_irqrestore(&cgwb_lock, flags);
> @@ -451,13 +451,13 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
>  	if (!new_congested)
>  		return NULL;
>  
> -	atomic_set(&new_congested->refcnt, 0);
> +	refcount_set(&new_congested->refcnt, 1);
>  	new_congested->__bdi = bdi;
>  	new_congested->blkcg_id = blkcg_id;
>  	goto retry;
>  
>  found:
> -	atomic_inc(&congested->refcnt);
> +	refcount_inc(&congested->refcnt);
>  	spin_unlock_irqrestore(&cgwb_lock, flags);
>  	kfree(new_congested);
>  	return congested;
>
> ...
>

I'm not sure that the restructuring of wb_congested_get_create() was
desirable and it does make the patch harder to review.  But it looks
OK to me.
