Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E9550C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF27208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjkFEIUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF27208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935480AbeFMMYH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:24:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935274AbeFMMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fJihSswcbsj16ee6bnFV5DWujsO+wz/juQ1eNFJA2h0=; b=TjkFEIUKawi17brJcEkYsPnoz
        FjbZ7hjuuebogRXvnr0c9+b2zLlFiyT3nuCmP73Ai5LhkzlD1FVC5nEtUc49YWz96ah8bLpI3C6LD
        XginU7vMvPBYXfnP+3T+Pc0Bx0XDVSWVesgGCIMwUegu+jM/ZDY9ylWdOXqUi3krsDbl/g3vWj1t3
        bpP3wDAFvTuKJ2GBwUjQ6zD4l9rdicIJuATFP7RQBZVvnb9UAgkBppNzzNIwlKWBaK20qU03UImyk
        g0ydKZgzFNMdS3bGtHu5J2beSrZclGL4qHwNVsJU+AZXhPlLLn7pbQ7UXg3ITNM6zaefjVCupmPwp
        3Lpm7M8gQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT4oj-0005Lv-64; Wed, 13 Jun 2018 12:24:01 +0000
Date:   Wed, 13 Jun 2018 05:24:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
Message-ID: <20180613122359.GA8695@bombadil.infradead.org>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:58:37AM +0200, Marek Szyprowski wrote:
> cma_alloc() function has gfp mask parameter, so users expect that it
> honors typical memory allocation related flags. The most imporant from
> the security point of view is handling of __GFP_ZERO flag, because memory
> allocated by this function usually can be directly remapped to userspace
> by device drivers as a part of multimedia processing and ignoring this
> flag might lead to leaking some kernel structures to userspace.
> Some callers of this function (for example arm64 dma-iommu glue code)
> already assumed that the allocated buffers are cleared when this flag
> is set. To avoid such issues, add simple code for clearing newly
> allocated buffer when __GFP_ZERO flag is set. Callers will be then
> updated to skip implicit clearing or adjust passed gfp flags.

I think the documentation for this function needs improving.  For example,
GFP_ATOMIC does not work (it takes a mutex lock, so it can sleep).
At the very least, the kernel-doc needs:

 * Context: Process context (may sleep even if GFP flags indicate otherwise).

Unless someone wants to rework this allocator to use spinlocks instead
of mutexes ...
