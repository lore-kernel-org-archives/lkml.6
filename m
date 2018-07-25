Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE7CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF1F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF1F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbeGYCk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:40:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbeGYCk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:40:59 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 90427D3A;
        Wed, 25 Jul 2018 01:31:44 +0000 (UTC)
Date:   Tue, 24 Jul 2018 18:31:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] mm: calculate deferred pages after skipping
 mirrored memory
Message-Id: <20180724183142.d20798b43fd1215f6165649c@linux-foundation.org>
In-Reply-To: <20180724235520.10200-3-pasha.tatashin@oracle.com>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
        <20180724235520.10200-3-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 19:55:19 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> update_defer_init() should be called only when struct page is about to be
> initialized. Because it counts number of initialized struct pages, but
> there we may skip struct pages if there is some mirrored memory.
> 
> So move, update_defer_init() after checking for mirrored memory.
> 
> Also, rename update_defer_init() to defer_init() and reverse the return
> boolean to emphasize that this is a boolean function, that tells that the
> reset of memmap initialization should be deferred.
> 
> Make this function self-contained: do not pass number of already
> initialized pages in this zone by using static counters.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -306,24 +306,28 @@ static inline bool __meminit early_page_uninitialised(unsigned long pfn)
>  }
>  
>  /*
> - * Returns false when the remaining initialisation should be deferred until
> + * Returns true when the remaining initialisation should be deferred until
>   * later in the boot cycle when it can be parallelised.
>   */
> -static inline bool update_defer_init(pg_data_t *pgdat,
> -				unsigned long pfn, unsigned long zone_end,
> -				unsigned long *nr_initialised)
> +static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  {
> +	static unsigned long prev_end_pfn, nr_initialised;

So answer me quick, what happens with a static variable in an inlined
function?  Is there one copy kernel-wide?  One copy per invocation
site?  One copy per compilation unit?

Well I didn't know so I wrote a little test.  One copy per compilation
unit (.o file), it appears.

It's OK in this case because the function is in .c (and has only one
call site).  But if someone moves it into a header and uses it from a
different .c file, they have problems.

So it's dangerous, and poor practice.  I'll make this non-static
__meminit.

--- a/mm/page_alloc.c~mm-calculate-deferred-pages-after-skipping-mirrored-memory-fix
+++ a/mm/page_alloc.c
@@ -309,7 +309,8 @@ static inline bool __meminit early_page_
  * Returns true when the remaining initialisation should be deferred until
  * later in the boot cycle when it can be parallelised.
  */
-static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
+static bool __meminit
+defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 {
 	static unsigned long prev_end_pfn, nr_initialised;
 

Also, what locking protects these statics?  Our knowledge that this
code is single-threaded, presumably?
