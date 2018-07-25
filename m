Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA81C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A0620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A0620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeGYN01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:26:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35792 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbeGYN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:26:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so5817446wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 05:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z6S70Lx522ZvfK9hqnX/5d6uCBHzOPCHpz4zqCGOyAQ=;
        b=lZnHATxV87QxIb6N7s0p9Oj+s2DqgFSJIsIG2TI5yZ8uotLlv8ouDHXfafq8DA50r1
         rG9jaKw2BxeF3mrGnxyR98duWIcYq+b8XA2+2KSI5bPQJKLMqr5pXfgHYw0A8BG3l4sZ
         EcIq9hdDvAffdWlAn5XjpVB5/Ut/HvPY28zMCDnP/U9qJUaxHX1CDPSqYy8ZKKM6Nzu6
         22OFrOQFl7S/LGaFcgVtzgR65XK2mxj+DazMiJyexh/VuLQ7V/afoKheHhpPFuiGVTS3
         jDSf8teqH6ax9SbZ5xlWxmvlCdIkJ2aIMS4rXXbd0aEMqmHfyK5G8OhB5/HifUjXudPm
         Ybiw==
X-Gm-Message-State: AOUpUlGNvvsT+yQOdQtQNRQeaaddMQuPtf3KH3PZ0diqRa9efyy6iyDC
        5P1HzFTZR32RErifrIxQJPY=
X-Google-Smtp-Source: AAOMgpcODspZxlVaHD8h9BQgNfEVuQ0F1sAcGlm3iW0d/qv27AN6pTONIYYaHWsl8q9sWHz/fycenA==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr4380782wmy.81.1532520901376;
        Wed, 25 Jul 2018 05:15:01 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 35-v6sm14139304wri.78.2018.07.25.05.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 05:15:00 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 0270712432E; Wed, 25 Jul 2018 14:14:59 +0200 (CEST)
Date:   Wed, 25 Jul 2018 14:14:59 +0200
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
Subject: Re: [PATCH 2/3] mm: calculate deferred pages after skipping mirrored
 memory
Message-ID: <20180725121459.GA16987@techadventures.net>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
 <20180724235520.10200-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724235520.10200-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:55:19PM -0400, Pavel Tatashin wrote:
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
>  mm/page_alloc.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cea749b26394..86c678cec6bd 100644
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
> +
> +	if (prev_end_pfn != end_pfn) {
> +		prev_end_pfn = end_pfn;
> +		nr_initialised = 0;
> +	}
Hi Pavel,

What about a comment explaining that "if".
I am not the brightest one, so it took me a bit to figure out that we got that "if" there
because now that the variables are static, we need to somehow track whenever we change to
another zone.

Thanks
-- 
Oscar Salvador
SUSE L3
