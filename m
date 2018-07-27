Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F80C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AD4208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AD4208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeG0NSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:18:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39426 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbeG0NSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:18:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so4785047wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 04:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C346TXP08hQ83aqIVdDlTwEDeQFVwrj1FhJIUolPwHQ=;
        b=FsbYcD463rXOccYNQd0vljHkmgmu2L5HxaQcESMP3Hpi7+KjhfG7OVCnoD+jnM2Ryt
         UvE0QIJ5zowjaNw1u9ZLc/7KAqOzyc8qNZJUClQZI5vXmcc3CTOfa46QXC2uUXzaRRbc
         fUuTnMMcURNRRAT4xhnND6DzTSCvxNno4f24/HGb/10P4wbXwHCYWCx1PbZC1eYY3n5K
         /RM9/CMBNwp5rG+CGzU6lffsQmf/J0FUoVhB1Yxk1D5IUK04/zKiBLzgBcuF3sHDT0pR
         qCL87MF1u0H5cB6FPbXVIaxCW4Rph2owcoUDp8QMRrAq2k/YB5HLGQdck6Ii4GePA44m
         lIRA==
X-Gm-Message-State: AOUpUlGZq615zjBt2pg+xPtjUf5HKPNblzuoSqT60M46+iVN04geHwPB
        6WOLmmN0HI5XqEidYg20CZM=
X-Google-Smtp-Source: AAOMgpcUVdt+5TKboBRzWJf9o8UrEE0EVeXfWLUXWx8qUy3bQT7+mPzAlf73l+QiKnMJQeMrp6Zx9w==
X-Received: by 2002:adf:fb92:: with SMTP id a18-v6mr4336614wrr.278.1532692606771;
        Fri, 27 Jul 2018 04:56:46 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a2-v6sm2944833wmb.6.2018.07.27.04.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 04:56:46 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 100D8124400; Fri, 27 Jul 2018 13:56:45 +0200 (CEST)
Date:   Fri, 27 Jul 2018 13:56:45 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/3] mm: calculate deferred pages after skipping
 mirrored memory
Message-ID: <20180727115645.GA13637@techadventures.net>
References: <20180726193509.3326-1-pasha.tatashin@oracle.com>
 <20180726193509.3326-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726193509.3326-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:35:08PM -0400, Pavel Tatashin wrote:
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
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  mm/page_alloc.c | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6796dacd46ac..4946c73e549b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -306,24 +306,33 @@ static inline bool __meminit early_page_uninitialised(unsigned long pfn)
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
> +static bool __meminit
> +defer_init(int nid, unsigned long pfn, unsigned long end_pfn)

Hi Pavel,

maybe I do not understand properly the __init/__meminit macros, but should not
"defer_init" be __init instead of __meminit?
I think that functions marked as __meminit are not freed up, right?

Besides that, this looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>
-- 
Oscar Salvador
SUSE L3
