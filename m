Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B5DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3224568
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC3224568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeFVP6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57715 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933853AbeFVP6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:58:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F752AD5C;
        Fri, 22 Jun 2018 15:58:41 +0000 (UTC)
Date:   Fri, 22 Jun 2018 17:58:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: depend on CONFIG_SLUB_DEBUG
Message-ID: <20180622155839.GF10465@dhcp22.suse.cz>
References: <CALvZod7Rf0FZHqYBPd1OTkVuvA5QRrkYQku40QJtS2--g6PrQQ@mail.gmail.com>
 <20180622154623.25388-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622154623.25388-1-Jason@zx2c4.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 17:46:23, Jason A. Donenfeld wrote:
> KASAN depends on having access to some of the accounting that SLUB_DEBUG
> does; without it, there are immediate crashes [1]. So, the natural thing
> to do is to make KASAN select SLUB_DEBUG.
> 
> [1] http://lkml.kernel.org/r/CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com
> 
> Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: <stable@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This is the simplest way to do but I strongly suspect that the whole
SLUB_DEBUG is not really necessary

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  lib/Kconfig.kasan | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 3d35d062970d..c253c1b46c6b 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -6,6 +6,7 @@ if HAVE_ARCH_KASAN
>  config KASAN
>  	bool "KASan: runtime memory debugger"
>  	depends on SLUB || (SLAB && !DEBUG_SLAB)
> +	select SLUB_DEBUG if SLUB
>  	select CONSTRUCTORS
>  	select STACKDEPOT
>  	help
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
