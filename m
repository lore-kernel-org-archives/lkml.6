Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBB8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B907520875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NklE6PJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B907520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbeFUDf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:35:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeFUDf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9rN4WPOaDAdQrHZKtVSKwfnGHageL7nl3Z8DGtCigv0=; b=NklE6PJ5ubwSxjlLz4NSlG4/L
        myzDFV0Zy2YerYDp+8gnjubPKYPbuzkSH8SsDAdgWDFT3dDQeW0/D8DGCcrpHUVCXo4GmDmd8rI4P
        HPMbvJFJFMrF0n6BNbdS0w38UD4II6e5dQC6XGe2UOSntdBgPsrHmXvdYEncxZ8XiEZnx1tkZ5QGQ
        9awbJGAEhixHzwzzIDppvohMsEpmm/xBF2NKPhc7hVVDdy7++mAQ3ea26ZTT50+YfnR3JniawcJxZ
        YeyryO3+nYrYxrmmQ8GNODCz9Svzl3jFP2kGrhrsWWtz2YVvodW4MeC8bG9kejZ7XTgJD8NhTrvY5
        hdCnAZjfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVqNP-00088l-BD; Thu, 21 Jun 2018 03:35:15 +0000
Date:   Wed, 20 Jun 2018 20:35:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     axboe@kernel.dk, akpm@linux-foundation.or, jack@suse.cz,
        zhangweiping@didichuxing.com, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] mm: backing-dev: a possible sleep-in-atomic-context bug in
 cgwb_create()
Message-ID: <20180621033515.GA12608@bombadil.infradead.org>
References: <626acba3-c565-7e05-6c8b-0d100ff645c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626acba3-c565-7e05-6c8b-0d100ff645c5@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:02:58AM +0800, Jia-Ju Bai wrote:
> The kernel may sleep with holding a spinlock.
> The function call path (from bottom to top) in Linux-4.16.7 is:
> 
> [FUNC] schedule
> lib/percpu-refcount.c, 222:
>         schedule in __percpu_ref_switch_mode
> lib/percpu-refcount.c, 339:
>         __percpu_ref_switch_mode in percpu_ref_kill_and_confirm
> ./include/linux/percpu-refcount.h, 127:
>         percpu_ref_kill_and_confirm in percpu_ref_kill
> mm/backing-dev.c, 545:
>         percpu_ref_kill in cgwb_kill
> mm/backing-dev.c, 576:
>         cgwb_kill in cgwb_create
> mm/backing-dev.c, 573:
>         _raw_spin_lock_irqsave in cgwb_create
> 
> This bug is found by my static analysis tool (DSAC-2) and checked by my
> code review.

I disagree with your code review.

         * If the previous ATOMIC switching hasn't finished yet, wait for
         * its completion.  If the caller ensures that ATOMIC switching
         * isn't in progress, this function can be called from any context.

I believe cgwb_kill is always called under the spinlock, so we will never
sleep because the percpu ref will never be switching to atomic mode.

This is complex and subtle, so I could be wrong.
