Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4496C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D5F217CC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTgPq00n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D5F217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeHECFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:05:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbeHECFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iu3fjfOpsafVmdDczEyyoOHRTSSaMBmC8R2fS1jy5EA=; b=mTgPq00nU4mIw9F+1hrPznn0V
        thnP+UXxDb8i99+eNRdI20+8kk2QMqkjxoh57zlcYdFeSfWqtQQuxU/hT9VLTkzcheYLBPE/u7izt
        d4Urk0lvsYVpVguh83XHkQj1q7B+UF8FZFcykd8JrT0M4BJKKxsqVcL+e2TqbasMc1n7ubzZmL0/x
        sZNSFmggtlre82B9RWudq625kRVUnD8tXH2io+TY9pembIjOoDEpMzSirlKjdKZ54Z4s5s+9wZkGY
        LUf/pVUS1k8fYjV/hgJkYDcR7SEEOtq3GYvRqUVf7SaXEf7xkabLMIaIDztHJ/OzQB0UPK0ObeC+L
        DLoIrvZgA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fm6Vl-00051W-5f; Sun, 05 Aug 2018 00:03:05 +0000
Date:   Sat, 4 Aug 2018 17:03:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vdavydov.dev@gmail.com,
        mhocko@suse.com, aryabinin@virtuozzo.com, ying.huang@intel.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        jbacik@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
Message-ID: <20180805000305.GC3183@bombadil.infradead.org>
References: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
 <20180803155120.0d65511b46c100565b4f8a2c@linux-foundation.org>
 <843169c5-a47a-e6cd-7412-611e72eb20ba@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843169c5-a47a-e6cd-7412-611e72eb20ba@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 09:42:05PM +0300, Kirill Tkhai wrote:
> This is exactly the thing the patch makes. Instead of inserting a shrinker pointer
> to idr, it inserts a fake value SHRINKER_REGISTERING there. The patch makes impossible
> to dereference a shrinker unless it's completely registered. 

-       id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);

Instead:

+       id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);

... and the rest of your patch becomes even simpler.
