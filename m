Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2767DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348A2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VE6X3CWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C348A2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeH2CHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:07:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeH2CHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NfE2HGDwBxn5XzFSH1jyYLheTtzP5I0+o0JhVjH64vQ=; b=VE6X3CWmUY8OaKtJ7/CM4WF8+
        neGiSExjwnpEMxQ8B2pWBU/43C8GcHrW7oqFH/FzGltVgzznjniwV1Ztb3RzFCkPaQbyukvpPP4+V
        qPCi5QqQt1JJLcfjZezt8zYNxFDpEhI7CQeBBjSkEUlNttWi/8yRku9GREJ6FKLG6ftiB6OJST5oq
        R92pmVOaPbhGdJCNZ4nzTNC4QF9UGFpCdD90UzjLhdwftzquErM39cJgchd8Qm/4rLLe/QRiMF/d0
        ca/UU3ybwZv85BhxHHoBwigdWZ4Xt/piyeiTPlw3LWchzzds10YfT+pIISVEkyaHkvS1IBZ0mwG+G
        U5bvEcQrQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fumFE-00018n-Qf; Tue, 28 Aug 2018 22:13:52 +0000
Date:   Tue, 28 Aug 2018 15:13:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
Message-ID: <20180828221352.GC11400@bombadil.infradead.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535476780-5773-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:19:40PM -0400, Waiman Long wrote:
> @@ -134,7 +135,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
>  	spin_lock(&nlru->lock);
>  	if (list_empty(item)) {
>  		l = list_lru_from_kmem(nlru, item, &memcg);
> -		list_add_tail(item, &l->list);
> +		(add_tail ? list_add_tail : list_add)(item, &l->list);
>  		/* Set shrinker bit if the first element was added */
>  		if (!l->nr_items++)
>  			memcg_set_shrinker_bit(memcg, nid,

That's not OK.  Write it out properly, ie:

		if (add_tail)
			list_add_tail(item, &l->list);
		else
			list_add(item, &l->list);

