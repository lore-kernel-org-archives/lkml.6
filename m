Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B03AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551108222;
	bh=pHjU9NcOB3MsX8dwk6v9qa9t5yRr63F1EpZWfjQCFgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yb5erMyzsejIqWthCnBYU6qmPrEGZF5b7qG+zCOQ5nL8eGMqVGPaw5Fx6XcNM+yYl
	 rHLKqnmb+W8aKCynglqcbwyuwbLToV0Xyj9Qsa6GfSoTG0ehRhnWtKeD3HqUdw32e0
	 hVrmoVZbJ6zz6O2jyYGxcv5ALqL4tsi/b8E/wZPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfBYPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:23:40 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33780 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfBYPXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:23:40 -0500
Received: by mail-yw1-f65.google.com with SMTP id i204so1285110ywb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aceOQhsR7Q7buD/56Nry5wu+S4gTAyrPWonUPvKLu3s=;
        b=BVogvhu8lLZ5N1ax+1XvrhGLrSCessyNRyuZcsG9L9/XPfeE5Gh+CHHP4SspTIXjZL
         09iF7o9dnHMygygO5jeEgdWY28r4Oti2qwuraRJHnm+MUCyS9ZrvzaiF3EOY4VQT3Ow4
         6pb4ztTaXMsHG0WUZ3U/l8u/SuyxlPSQBYrT4AESBH+ZwgF7gG7Y6uaAQp4jeC7s+HQ9
         3UKdsMzT2nm9Za0r4PJAuhsCEMvUKG+lojcPRwby3PAwR+v3baINk6njrQPEEqH+raUn
         WxPlCqZ/Y6boLADYweAcBN3h21VWWnmfW9m24gic59Ic1vm5F/bVaY7V1p8Ug7gfwL2I
         JtdA==
X-Gm-Message-State: AHQUAuYodK5MQ14L2EPzOywHWkaDRU1SNFBsWtDp4oRDhlZ4nJZWQZLg
        ftNOyFgEbw/zqxrBloBF9Hk=
X-Google-Smtp-Source: AHgI3Ib6GTB+XQ49xYR/2VSEmHU0P9cRyTShmN0tAnKdZHjxiFb314bAixYFQzQ1pQStm7Gpg+Z6LA==
X-Received: by 2002:a81:2fc1:: with SMTP id v184mr14231584ywv.129.1551108219233;
        Mon, 25 Feb 2019 07:23:39 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::1:8bb9])
        by smtp.gmail.com with ESMTPSA id v6sm3665012ywc.107.2019.02.25.07.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:23:38 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:23:36 -0500
From:   "dennis@kernel.org" <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [RFC] percpu: decrease pcpu_nr_slots by 1
Message-ID: <20190225152336.GC49611@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224092838.3417-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224092838.3417-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:17:08AM +0000, Peng Fan wrote:
> Entry pcpu_slot[pcpu_nr_slots - 2] is wasted with current code logic.
> pcpu_nr_slots is calculated with `__pcpu_size_to_slot(size) + 2`.
> Take pcpu_unit_size as 1024 for example, __pcpu_size_to_slot will
> return max(11 - PCPU_SLOT_BASE_SHIFT + 2, 1), it is 8, so the
> pcpu_nr_slots will be 10.
> 
> The chunk with free_bytes 1024 will be linked into pcpu_slot[9].
> However free_bytes in range [512,1024) will be linked into
> pcpu_slot[7], because `fls(512) - PCPU_SLOT_BASE_SHIFT + 2` is 7.
> So pcpu_slot[8] is has no chance to be used.
> 
> According comments of PCPU_SLOT_BASE_SHIFT, 1~31 bytes share the same slot
> and PCPU_SLOT_BASE_SHIFT is defined as 5. But actually 1~15 share the
> same slot 1 if we not take PCPU_MIN_ALLOC_SIZE into consideration, 16~31
> share slot 2. Calculation as below:
> highbit = fls(16) -> highbit = 5
> max(5 - PCPU_SLOT_BASE_SHIFT + 2, 1) equals 2, not 1.
> 
> This patch by decreasing pcpu_nr_slots to avoid waste one slot and
> let [PCPU_MIN_ALLOC_SIZE, 31) really share the same slot.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  Not very sure about whether it is intended to leave the slot there.
> 
>  mm/percpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 8d9933db6162..12a9ba38f0b5 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -219,7 +219,7 @@ static bool pcpu_addr_in_chunk(struct pcpu_chunk *chunk, void *addr)
>  static int __pcpu_size_to_slot(int size)
>  {
>  	int highbit = fls(size);	/* size is in bytes */
> -	return max(highbit - PCPU_SLOT_BASE_SHIFT + 2, 1);
> +	return max(highbit - PCPU_SLOT_BASE_SHIFT + 1, 1);
>  }

Honestly, it may be better to just have [1-16) [16-31) be separate. I'm
working on a change to this area, so I may change what's going on here.

>  
>  static int pcpu_size_to_slot(int size)
> @@ -2145,7 +2145,7 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  	 * Allocate chunk slots.  The additional last slot is for
>  	 * empty chunks.
>  	 */
> -	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 2;
> +	pcpu_nr_slots = __pcpu_size_to_slot(pcpu_unit_size) + 1;
>  	pcpu_slot = memblock_alloc(pcpu_nr_slots * sizeof(pcpu_slot[0]),
>  				   SMP_CACHE_BYTES);
>  	for (i = 0; i < pcpu_nr_slots; i++)
> -- 
> 2.16.4
> 

This is a tricky change. The nice thing about keeping the additional
slot around is that it ensures a distinction between a completely empty
chunk and a nearly empty chunk. It happens to be that the logic creates
power of 2 chunks which ends up being an additional slot anyway. So,
given that this logic is tricky and architecture dependent, I don't feel
comfortable making this change as the risk greatly outweighs the
benefit.

Thanks,
Dennis
