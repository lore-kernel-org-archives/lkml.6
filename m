Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38494C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0542920882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0542920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbeKFFj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:39:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeKFFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:39:57 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BAB46B5D;
        Mon,  5 Nov 2018 20:18:34 +0000 (UTC)
Date:   Mon, 5 Nov 2018 12:18:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH] mm/mmu_notifier: rename mmu_notifier_synchronize() to
 <...>_barrier()
Message-Id: <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
In-Reply-To: <20181105192955.26305-1-sean.j.christopherson@intel.com>
References: <20181105192955.26305-1-sean.j.christopherson@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 11:29:55 -0800 Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> ...and update its comment to explicitly reference its association with
> mmu_notifier_call_srcu().
> 
> Contrary to its name, mmu_notifier_synchronize() does not synchronize
> the notifier's SRCU instance, but rather waits for RCU callbacks to
> finished, i.e. it invokes rcu_barrier().  The RCU documentation is
> quite clear on this matter, explicitly calling out that rcu_barrier()
> does not imply synchronize_rcu().  The misnomer could lean an unwary
> developer to incorrectly assume that mmu_notifier_synchronize() can
> be used in conjunction with mmu_notifier_unregister_no_release() to
> implement a variation of mmu_notifier_unregister() that synchronizes
> SRCU without invoking ->release.  A Documentation-allergic and hasty
> developer could be further confused by the fact that rcu_barrier() is
> indeed a pass-through to synchronize_rcu()... in tiny SRCU.

Fair enough.

> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -35,12 +35,12 @@ void mmu_notifier_call_srcu(struct rcu_head *rcu,
>  }
>  EXPORT_SYMBOL_GPL(mmu_notifier_call_srcu);
>  
> -void mmu_notifier_synchronize(void)
> +void mmu_notifier_barrier(void)
>  {
> -	/* Wait for any running method to finish. */
> +	/* Wait for any running RCU callbacks (see above) to finish. */
>  	srcu_barrier(&srcu);
>  }
> -EXPORT_SYMBOL_GPL(mmu_notifier_synchronize);
> +EXPORT_SYMBOL_GPL(mmu_notifier_barrier);
>  
>  /*
>   * This function can't run concurrently against mmu_notifier_register

But as it has no callers, why retain it?
