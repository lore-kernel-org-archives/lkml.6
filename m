Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D96C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4DF223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gNjmATLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4DF223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbeKMXCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:02:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733149AbeKMXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xw0e9pUuPE4jyfmt82hmla1ifjaoOHX2HYiDGLajvQ8=; b=gNjmATLFb6RdRz1/NdxrLly7r
        UgbDZLY3Bz2+fC3QMcuKjzrKQXcTB3NQsGR79zK1C+VCvUrlXVZrroPpU/balgwUod/OjRXlBwrYv
        Q+kUm7TSWchIV14rM593yS+Km4sS/fYNjhpJUcLMXhXutFXSFHLs8ygWHEEz4vcQs9zlAwU81yQYr
        24JMVx+qJJREn4c9CjLeWZFS4iuuBcg77nmPnzY4ZcJ9zqAEKEUCCg3GtHj7tNeLU9a4iOehgtto9
        msG4hNRkmnGDTjkOqevgJVLODvnFJSKvtjc1ihknnenqI8GT14bZbsjHHm3yW3yt/ipgJjaPs4jWx
        kc55vq2eA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMYMe-00055j-Pt; Tue, 13 Nov 2018 13:04:20 +0000
Date:   Tue, 13 Nov 2018 05:04:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim()
 when CONFIG_NUMA is n
Message-ID: <20181113130420.GV21824@bombadil.infradead.org>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
 <20181113080436.22078-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113080436.22078-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 04:04:36PM +0800, Wei Yang wrote:
> Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
> fail zone_reclaim() as full") changed the return value of node_reclaim().
> The original return value 0 means NODE_RECLAIM_SOME after this commit.
> 
> While the return value of node_reclaim() when CONFIG_NUMA is n is not
> changed. This will leads to call zone_watermark_ok() again.
> 
> This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
> node_reclaim() is only called in page_alloc.c, move it to mm/internal.h.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
