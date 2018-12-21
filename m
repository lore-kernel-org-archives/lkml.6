Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B377C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4342D2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OM5GHSgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbeLUNY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:24:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388588AbeLUNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c2UAElxy6bFokRO0JfnODxJ67MS9uqYE6zTrBkA7o88=; b=OM5GHSgQljCnq0bqQBYpoMk71
        Gu6S/GCvQlKg6JqHAa6kGgtJNsJv2ExZ3vOR+HYFC4RDsYoKsvNcv7z0aSHMwKfkPKbM7r0BGdkTy
        O53Wtd37R8a7bb+2LNbRHlgRemSWSWzdJIkpJmEj2RYmfe2gmAvSVQD2/GLdRrXhSZUq6HJn5Zbbd
        d0blzw5iZerKGmc5L14Vs39ZtlKToEIeqAesIuCH903TyldjNHZWR3sHijfEPI88eXza/bFXyoifC
        CTop9JgYjrwa7bXlVIoqXA59XqLImjxB/rtHa2eF1fjMcwypilk8CZjR/vxCx2gOBFD+xEJ+Cp8SJ
        CMgGyy9qQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaKmu-00036H-08; Fri, 21 Dec 2018 13:24:24 +0000
Date:   Fri, 21 Dec 2018 05:24:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: Define VM_(MAX|MIN)_READAHEAD via sizes.h constants
Message-ID: <20181221132423.GA10600@bombadil.infradead.org>
References: <20181221125314.5177-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221125314.5177-1-nborisov@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:53:14PM +0200, Nikolay Borisov wrote:
> All users of the aformentioned macros convert them to kbytes by
> multplying. Instead, directly define the macros via the aptly named
> SZ_16K/SZ_128K ones. Also remove the now redundant comments explaining
> that VM_* are defined in kbytes it's obvious. No functional changes.

Actually, all users of these constants convert them to pages!

> +	q->backing_dev_info->ra_pages = VM_MAX_READAHEAD / PAGE_SIZE;
> +		sb->s_bdi->ra_pages = VM_MAX_READAHEAD / PAGE_SIZE;
> +	sb->s_bdi->ra_pages	= VM_MAX_READAHEAD / PAGE_SIZE;
> +	sb->s_bdi->ra_pages = VM_MAX_READAHEAD / PAGE_SIZE;
> +	sb->s_bdi->ra_pages = VM_MAX_READAHEAD / PAGE_SIZE;

> -#define VM_MAX_READAHEAD	128	/* kbytes */
> -#define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
> +#define VM_MAX_READAHEAD	SZ_128K
> +#define VM_MIN_READAHEAD	SZ_16K	/* includes current page */

So perhaps:

#define VM_MAX_READAHEAD	(SZ_128K / PAGE_SIZE)

VM_MIN_READAHEAD isn't used, so just delete it?
