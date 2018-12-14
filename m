Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8079C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C9206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rkSFm7cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbeLNS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:29:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=grE+6gLG3gNLHucsgTRLlETMHrzAhGFRJZUeMfuKWKM=; b=rkSFm7cbA+2zpPrI8MS4+MTLE
        7jBPRGGETYKJ5riAOed3yavPXb8xyzcme8XjOTcpjveOPZ8pU8KU6zI14c8JU2dnr2aLFrOC63Orw
        dADovfiMTttG7iR3L5pQlEEQN3iHZyoZnlGTtPmaxW+Z+aKRED4ZnXWBtp3/dcqJ6piBJWoOdHHJp
        JmAzjDFU6SrrV7tIPU8Dhxagc5G9E6I8uYmePc+K1a1gZRkuLrfLIlcWV+/VbDFsj6Kzw6XsaTKPW
        AAJbaFN3FwkAogSbDCZMt6a5akD2v6uA+WSVgiYEenj37JdYIfR8eGZtm8WWd6RLrw7GBvuP4jWf3
        9WqCJh0YA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXsCu-0005Qx-O0; Fri, 14 Dec 2018 18:29:04 +0000
Date:   Fri, 14 Dec 2018 10:29:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC 4/4] mm: show number of vmalloc pages in /proc/meminfo
Message-ID: <20181214182904.GE10600@bombadil.infradead.org>
References: <20181214180720.32040-1-guro@fb.com>
 <20181214180720.32040-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214180720.32040-5-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:07:20AM -0800, Roman Gushchin wrote:
> Vmalloc() is getting more and more used these days (kernel stacks,
> bpf and percpu allocator are new top users), and the total %
> of memory consumed by vmalloc() can be pretty significant
> and changes dynamically.
> 
> /proc/meminfo is the best place to display this information:
> its top goal is to show top consumers of the memory.
> 
> Since the VmallocUsed field in /proc/meminfo is not in use
> for quite a long time (it has been defined to 0 by the
> commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
> /proc/meminfo")), let's reuse it for showing the actual
> physical memory consumption of vmalloc().

Do you see significant contention on nr_vmalloc_pages?  Also, if it's
just an atomic_long_t, is it worth having an accessor for it?  And if
it is worth having an accessor for it, then it can be static.

Also, I seem to be missing 3/4.

