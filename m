Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6524C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C5525DC9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qEeTkKsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5525DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeGBNpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:45:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGBNpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5+v84uH1/9EQYkPxyxAGi3xKR4sn8pO9VNpAK3oSEMs=; b=qEeTkKsAwWLliybIrCPnOMObN
        /FbAwzDbZZM7EDtzG6lZc74FDy5bH8sAIcQoYIpFQA8thaLmsOJvSi74WIDvXRxM1FSh5jc1o0kdU
        u85mbjNXTVTZUFThQse1m6zBvP72RjSBJMJuCMiGYYsiyv6aGJa0fJOwZNZZWCc/PJcWySUuN82a8
        q6g87sIjXRBrk2PJi4sCTTCksyJoeyHIK1UG1iw0MCA56be3xFE5jKIxUf33dIV2jm54m8N+lB0+M
        tBLc6AsSEVq/ftu5leupcCJ7Kt0t4nc5KOKJiEPJgN6Adb/BNqbaki0vtLOhQ4BItEFVykpRaBgS0
        mhjcBGtOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZyuH-00058v-9m; Mon, 02 Jul 2018 13:30:17 +0000
Date:   Mon, 2 Jul 2018 06:30:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
Message-ID: <20180702133016.GA16909@infradead.org>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
 <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
 <20180613125546.GB32016@infradead.org>
 <20180613133913.GD20315@dhcp22.suse.cz>
 <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702132335eucas1p1323fbf51cd5e82a59939d72097acee04~9kAizDyji0466904669eucas1p1w@eucas1p1.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 03:23:34PM +0200, Marek Szyprowski wrote:
> What about clearing the allocated buffer? Should it be another bool 
> parameter,
> done unconditionally or moved to the callers?

Please keep it in the callers.  I plan to push it up even higher
from the current callers short to midterm.
