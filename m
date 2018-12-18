Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B44C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8576217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CG+Yj1vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRMrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:47:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TfZjB9lI7EVRxAVYcf0zZ1xtWdi/rELwqI+mZwQek18=; b=CG+Yj1vT69STr93GCwEw42qJn
        G1bvOxxIKAKP5zQuZzEekENyvxA9OXp5Bz7ERt1xf+QRSuN9TD9aUjbGA9NyVT+NgsKwzKmSpXoEf
        Qu4DrNA1V5aoe6tVH9KjS/ZU+N7lQ6eqQW3UsvUvFLMNDMWyApskikzRQ9uiA8rZDPeoEYaJhhc0Z
        WxeQgW71kAy8XGk5u+3Aq2gexmkMcaRfGMZHjcWOyGl1NndL5VTqVab182+HY3MZYry7jemFzyHuG
        nQ1hbr0SY6PD4HanR/HUl0onPmczXYaKth4loj7exGbWyjYATb4oNZTD+YnEntsGosa9ucZk2GMXh
        rIVbWLxpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZEmE-0008CR-E2; Tue, 18 Dec 2018 12:47:10 +0000
Date:   Tue, 18 Dec 2018 04:47:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     gchen.guomin@gmail.com
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, guominchen@tencent.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Export mm_update_next_owner function for unuse_mm.
Message-ID: <20181218124710.GU10600@bombadil.infradead.org>
References: <1545104531-30658-1-git-send-email-gchen.guomin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545104531-30658-1-git-send-email-gchen.guomin@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 11:42:11AM +0800, gchen.guomin@gmail.com wrote:
> +EXPORT_SYMBOL(mm_update_next_owner);

Unless you've figured out how to build mmu_context.c as a module, you
don't need to EXPORT the symbol.  Just the below hunk is enough.

> diff --git a/mm/mmu_context.c b/mm/mmu_context.c
> index 3e612ae..9eb81aa 100644
> --- a/mm/mmu_context.c
> +++ b/mm/mmu_context.c
> @@ -60,5 +60,6 @@ void unuse_mm(struct mm_struct *mm)
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
>  	task_unlock(tsk);
> +	mm_update_next_owner(mm);
>  }
>  EXPORT_SYMBOL_GPL(unuse_mm);
> -- 
> 1.8.3.1
> 
