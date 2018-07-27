Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36993C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E26205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I8e2GYxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E26205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbeG0UYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:24:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389049AbeG0UYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/DpfbAEoQ5HpyQJkehZnxdlt2e/Pp6Otk9fD0u7Q1s0=; b=I8e2GYxAY62BUCed7Ayf/Eu7t
        DLgXZErem8nLVsU1XWpzUWT2S+FvDvRgCVRCNlRCBde+sGtJ1ndcnE9X7QZm8Y4yJ6wtp3J9ZMmWa
        CGsIwLpqQN8ICyKNXq4VnnWHgP5Z+f7LIw5jrQf8z1xCdI5G31p5bkGNo9bUEYWIXB87Vxrp7Ez6Q
        BUHVgEtFmrx+SvYPO6ikg5wrRLJLoHpv0ie0DsWuybyV6Ps7Cp61wtGEXEsgPrDxMsovDQ1jcqm6+
        z8aocML541emx0rdky1R6yZhEnMZpclKNsEsvbpztgiN+MQz63WnQx1LlOgiChpHM4QGo8IjN6Ser
        T6bNpfnXw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj7zO-0004hW-PG; Fri, 27 Jul 2018 19:01:22 +0000
Date:   Fri, 27 Jul 2018 12:01:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux@endlessm.com, linux-kernel@vger.kernel.org
Subject: Re: Making direct reclaim fail when thrashing
Message-ID: <20180727190122.GA3825@bombadil.infradead.org>
References: <20180727162143.26466-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727162143.26466-1-drake@endlessm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:21:43AM -0500, Daniel Drake wrote:
> Here I'm experimenting by adding another tag to the page cache radix tree,
> tagging pages that were activated in the refault path.

NAK.  No more tags or you blow up the memory consumption of the radix
tree by 15%.

> And then in get_scan_count I'm checking how many active pages have that
> tag, and also looking at the size of the active and inactive lists.

You'd be better off using a bit in struct page somewhere ...

