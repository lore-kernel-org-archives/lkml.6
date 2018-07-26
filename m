Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8820685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X3+63UBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF8820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeGZORy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:17:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbeGZORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zXASJV1B8w6TWTclebE+L67zvG3MwPJohKc8D5awSUQ=; b=X3+63UBaeaMvPK++p/cHQHAiW
        Anbemo/zFWVPZn/xxrybQacASkIxDf8Wjq1wmUZo0cMJaa0b7pFX0tEbY1rVb/z/rm2yg+LFcQ176
        tRJ+nR2tLSZOnYvnixUqYt3llgF1fFqvj6iE2Cqax8jeOhaZHz4avEWBZ3pBRc0tfKoqqHRKcWAzI
        8ioHwZZxl6h4NgLB4xA+7nZIENHd2QIiTQAQ1RGa342TNVZ/YM/5PWLstnLSzeBs1sl0x8MS1x4H1
        XIY8UfCsbdji/bETtNhOlLaKfvB1UQ5RA2ZsrsG/VvG2MCOXGRMwandfQjTOggm7F3rvbxJjCdjVB
        bwilizJFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiftD-00006o-4m; Thu, 26 Jul 2018 13:01:07 +0000
Date:   Thu, 26 Jul 2018 06:01:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] docs/core-api: mm-api: add section about GFP flags
Message-ID: <20180726130106.GC3504@bombadil.infradead.org>
References: <1532607722-17079-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532607722-17079-8-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532607722-17079-8-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:22:02PM +0300, Mike Rapoport wrote:
> +Memory Allocation Controls
> +==========================

Perhaps call this section "Memory Allocation Flags" instead?

> +Linux provides a variety of APIs for memory allocation from direct
> +calls to page allocator through slab caches and vmalloc to allocators
> +of compressed memory. Although these allocators have different
> +semantics and are used in different circumstances, they all share the
> +GFP (get free page) flags that control behavior of each allocation
> +request.

While this isn't /wrong/, I think it might not be the most useful way
of explaining what the GFP flags are to someone who's just come across
them in some remote part of the kernel.  How about this paragraph instead?

  Functions which need to allocate memory often use GFP flags to express
  how that memory should be allocated.  The GFP acronym stands for "get
  free pages", the underlying memory allocation function.  Not every GFP
  flag is allowed to every function which may allocate memory.  Most
  users will want to use a plain ``GFP_KERNEL`` or ``GFP_ATOMIC``.

> +.. kernel-doc:: include/linux/gfp.h
> +   :doc: Page mobility and placement hints
> +
> +.. kernel-doc:: include/linux/gfp.h
> +   :doc: Watermark modifiers
> +
> +.. kernel-doc:: include/linux/gfp.h
> +   :doc: Reclaim modifiers
> +
> +.. kernel-doc:: include/linux/gfp.h
> +   :doc: Common combinations

Would it make more sense to put 'common combinations' first?

