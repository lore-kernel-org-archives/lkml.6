Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9FCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E1A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aDtIEYWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E1A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeIYVlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:41:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbeIYVlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tvu2VJP2WyEjHnc8hzb8eViFE4xovbp59vcO8nNjWhg=; b=aDtIEYWwtv11sOvk7gzWQkVUO
        13UWxvKKH60Sfz+fl4xsgqxMmXnrPbh7WJSdgq3fdhGK3/Lbo82zg6rYiJTzS+EGr+OinsddmBbj2
        glv078NItHBmj0ah9vBEz2O8e3HAtqvt0YIqUldC7ARRCr/n9SHYx6UUMy5QvEwMnYPMSP3q4duc7
        msbn9TxJVNvtdsc87Iz+ASR/KljwVG1XbLPdRYhPFdTH6UbsKrCCF/iHiBqqNv+kTKsVt7pQDqQBa
        9axee0M/g2yD3T9aJuwbXTHJ51s8u6yJ0F0ITRdq7ojY4Tc8+5Gsz80UgelLmbOF0yAvV7VbeVHuU
        Cp1xc0BxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4pKN-0002Lz-1Q; Tue, 25 Sep 2018 15:33:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26A8720289D10; Tue, 25 Sep 2018 17:32:41 +0200 (CEST)
Date:   Tue, 25 Sep 2018 17:32:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com
Subject: Re: [PATCH v2 2/2] debugobjects: Disable lockdep tracking of
 debugobjects internal locks
Message-ID: <20180925153241.GD29985@hirez.programming.kicks-ass.net>
References: <1537886469-18227-1-git-send-email-longman@redhat.com>
 <1537886469-18227-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537886469-18227-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:41:09AM -0400, Waiman Long wrote:
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 70935ed91125..68d72ed9ca22 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -1106,8 +1106,15 @@ void __init debug_objects_early_init(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
> +	/*
> +	 * We don't need lockdep to verify correctness of debugobjects
> +	 * internal locks.
> +	 */
> +	lockdep_set_novalidate_class(&pool_lock);
> +	for (i = 0; i < ODEBUG_HASH_SIZE; i++) {
>  		raw_spin_lock_init(&obj_hash[i].lock);
> +		lockdep_set_novalidate_class(&obj_hash[i].lock);
> +	}
>  
>  	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
>  		hlist_add_head(&obj_static_pool[i].node, &obj_pool);

NAK, we do not _EVER_ set novalidate if it can at all be avoided.

If there is a severe performance problem with lockdep, try and cure
that. But really, who runs lockdep kernels on 8 sockets?
