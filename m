Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE8C4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AF221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBHFtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:49:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBHFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:49:20 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E469FBF56;
        Fri,  8 Feb 2019 05:49:18 +0000 (UTC)
Date:   Thu, 7 Feb 2019 21:49:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     john.hubbard@gmail.com
Cc:     Nick Piggin <npiggin@suse.de>, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/1] mm: page_cache_add_speculative(): refactor out some
 code duplication
Message-Id: <20190207214917.9d07ca3fc52d3df0cde018bd@linux-foundation.org>
In-Reply-To: <20190206231016.22734-2-jhubbard@nvidia.com>
References: <20190206231016.22734-1-jhubbard@nvidia.com>
        <20190206231016.22734-2-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Feb 2019 15:10:16 -0800 john.hubbard@gmail.com wrote:

> From: John Hubbard <jhubbard@nvidia.com>
> 
> This combines the common elements of these routines:
> 
>     page_cache_get_speculative()
>     page_cache_add_speculative()
> 
> This was anticipated by the original author, as shown by the comment
> in commit ce0ad7f095258 ("powerpc/mm: Lockless get_user_pages_fast()
> for 64-bit (v3)"):
> 
>     "Same as above, but add instead of inc (could just be merged)"
> 
> There is no intention to introduce any behavioral change, but there is a
> small risk of that, due to slightly differing ways of expressing the
> TINY_RCU and related configurations.
> 
> This also removes the VM_BUG_ON(in_interrupt()) that was in
> page_cache_add_speculative(), but not in page_cache_get_speculative(). This
> provides slightly less detection of such bugs, but it given that it was
> only there on the "add" path anyway, we can likely do without it just fine.

It removes the 
VM_BUG_ON_PAGE(PageCompound(page) && page != compound_head(page), page);
also.

We'll live ;)


