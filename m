Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E124EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D7D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="omyyzYFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D7D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGKVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:21:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeLGKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jlt6oPDlNUrSd4b7eI0gl4S4IYfP9Z3f9TP0ruoj2Wc=; b=omyyzYFA/WJQ76bsXvBMuTeQp
        dkukelt7iyBkhTM/Wq+0puib8zHMjfA73rz5NHPDxAQ3iqaC6G7CxdJD3b9MVHmez8rGwWgOqALb9
        35+c63NrjVlklfYrLITFfS33f7xCc4hxVRE4N3Ol5tU666LKUrYnF4R3DdNV44u+JNzN10nfdVAC3
        kNMd4hcs6iAcAicU/FIxdYSNAqJ+LZndZuDwbTdM9iS6zKs/Y+UL3dao8G5SMVlhI43tv1jq9DWy6
        r9g+YrMr1ocQ/f/dyx53GabbXlTjK+9szHZa233OYFGluzXRQA1KbBCsQRjKtioQQ/oGFPqFddpyi
        mffLjEoBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVDGT-00019J-6O; Fri, 07 Dec 2018 10:21:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 755A6207261F0; Fri,  7 Dec 2018 11:21:43 +0100 (CET)
Date:   Fri, 7 Dec 2018 11:21:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 16/24] locking/lockdep: Retain the class key and name
 while freeing a lock class
Message-ID: <20181207102143.GH2237@hirez.programming.kicks-ass.net>
References: <20181207011148.251812-1-bvanassche@acm.org>
 <20181207011148.251812-17-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207011148.251812-17-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:11:40PM -0800, Bart Van Assche wrote:
> The next patch in this series uses the class name in code that
> detects calls to lock_acquire() while a class key is being freed. Hence
> retain the class name for lock classes that are being freed.

From readin the discussion with v2; you meant to say: 'uses the class
name pointer', right? You're not actually ever going to dereference it,
since that would be a UaF.

> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  kernel/locking/lockdep.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index ecd92969674c..92bdb187987f 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4147,10 +4147,8 @@ static void zap_class(struct lock_class *class)
>  	 * Unhash the class and remove it from the all_lock_classes list:
>  	 */
>  	hlist_del_rcu(&class->hash_entry);
> +	class->hash_entry.pprev = NULL;
>  	list_del(&class->lock_entry);
> -
> -	RCU_INIT_POINTER(class->key, NULL);
> -	RCU_INIT_POINTER(class->name, NULL);
>  }
>  
>  static inline int within(const void *addr, void *start, unsigned long size)
> -- 
> 2.20.0.rc2.403.gdbc3b29805-goog
> 
