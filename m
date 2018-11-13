Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12874C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A956522419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I7E4lcma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A956522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbeKMPco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:32:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeKMPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N8uvS0b4HRhoP90Kw3F4LGE63nyTHAen9aZ/M3o74Ek=; b=I7E4lcmaGE+ZO/GHFF5TPwdtr
        jUx0eT9XCXRtXvwBzWlHWT+2isHpry0LfTv2YggxyNZ+UMxhISlBVz5kDnXv7xgC+8mX/OCOI9xhA
        OQ2Bv26odrTjn0pQECkaiHx97HBYvEBgTohqTK/PbDzvU7vc6cSrpGKarlRfHQDKGEvPrkNa7YrC7
        H5BkvfTX5HE8dPadXodVWLV5lRBWjI4plGd+kXvGUruhnpMYW+8o7fMo+yoz37ZnFtus8dIs1yDD7
        Jt+2gMRKpIc4xwSJKVhTNoorG85IBeAGo89gA9sOueNTdKuBKJryIDl5LrlvX78zdm2sYNBYLEwHq
        uv/O7mYqg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMRN1-0007zk-UZ; Tue, 13 Nov 2018 05:36:15 +0000
Date:   Mon, 12 Nov 2018 21:36:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim()
 when CONFIG_NUMA is n
Message-ID: <20181113053615.GJ21824@bombadil.infradead.org>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113041750.20784-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:17:50PM +0800, Wei Yang wrote:
> Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
> fail zone_reclaim() as full") changed the return value of node_reclaim().
> The original return value 0 means NODE_RECLAIM_SOME after this commit.
> 
> While the return value of node_reclaim() when CONFIG_NUMA is n is not
> changed. This will leads to call zone_watermark_ok() again.
> 
> This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
> it is not proper to include "mm/internal.h", just hard coded it.

Since the return value is defined in mm/internal.h that means no code
outside mm/ can call node_reclaim (nor should it).  So let's move both
of node_reclaim's declarations to mm/internal.h instead of keeping them
in linux/swap.h.
