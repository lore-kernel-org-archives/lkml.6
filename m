Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F89BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC14E22448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HBfopJMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC14E22448
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeHJU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:28:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=05ASOexPmcXUtTYPGaAvZDBJzDZ7HxYJ+kOmV/JrOjI=; b=HBfopJMzzP7JqwiQukuvhYehX
        aCBwDaeZV8knmdKdMD/ZQaFqwb7K573gaw1pHnNKa2sFBLlXYlY0/f0ozjNkYsp8ttfX9fpPJPtuf
        Mrvu7LrJjWaYfappRXipPsbaqdJ+M2OzJI5h+9t3IdnKKgxDa3S3HCfs/h0OE6MzLXbBtReKxd0N+
        OfiDTaGv5/IdThnWUy2/9uUTrAGR5QcO9ol5H87lY4q+h7BzMImh7c3fZk/guw90JYUNCwSZHLaX4
        p6Ys67NjKt//3KjyNbisw0E1RIsvQqrY1sY3jlwCso4XD1SkhZ4M6cdHNsoT7EEVAf++SuBntrdXp
        o2LXf9DEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1foBfj-00056u-8E; Fri, 10 Aug 2018 17:57:59 +0000
Date:   Fri, 10 Aug 2018 10:57:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v7 PATCH 2/4] mm: mmap: zap pages with read mmap_sem in
 munmap
Message-ID: <20180810175759.GB6487@bombadil.infradead.org>
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
 <1533857763-43527-3-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533857763-43527-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 07:36:01AM +0800, Yang Shi wrote:
> +/*
> + * Zap pages with read mmap_sem held
> + *
> + * uf is the list for userfaultfd
> + */
> +static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
> +			       size_t len, struct list_head *uf)

I don't like the name here.  We aren't zapping rlocks, we're zapping
pages.  Not sure what to call it though ...

