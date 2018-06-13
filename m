Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8A3FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D49B204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AXAdrAOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D49B204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935666AbeFMMzv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:55:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935602AbeFMMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j28T1sJnLCU7vwmu1h9+HUdk4rIZ6bMNjM4YBzPOYto=; b=AXAdrAOQ6R4fjeWThK+Ouyklf
        aAdLAaw3zfvN4qChMGNuLc5yW2GWDVyKfMIreLdLXUXgglyrTHCdxaoKMhh4r3hdfzCPkN7Up9bOo
        nmnOFi+SBr+iR4lDC3jNA8szAiLU4QIresK+G1BYIze5EwvUozJNaTo6/YO0oOBjB5yh8c6KP8uW0
        6Il98gfvk4cLQ4XsXBLqJKWVEaMGtdbZwutAPD6SRWzQN07eePuaURdBjWcLEX6bJkBrrSwEddspG
        8kW8s6Y67YUPJD0t/kabgb7pWh1nNZhyr+Kte0F6rENIOmXIyJI4D5OoR9h2q4cjCEaehWsKwt/v5
        kNuoi9SEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT5JS-00038o-MS; Wed, 13 Jun 2018 12:55:46 +0000
Date:   Wed, 13 Jun 2018 05:55:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
Message-ID: <20180613125546.GB32016@infradead.org>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
 <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:40:00PM +0200, Marek Szyprowski wrote:
> It is not only the matter of the spinlocks. GFP_ATOMIC is not supported 
> by the
> memory compaction code, which is used in alloc_contig_range(). Right, this
> should be also noted in the documentation.

Documentation is good, asserts are better.  The code should reject any
flag not explicitly supported, or even better have its own flags type
with the few actually supported flags.
