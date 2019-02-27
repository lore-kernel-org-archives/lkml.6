Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E202186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfB0R0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:26:49 -0500
Received: from foss.arm.com ([217.140.101.70]:37484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfB0R0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:26:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A6981688;
        Wed, 27 Feb 2019 09:26:48 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC223F703;
        Wed, 27 Feb 2019 09:26:47 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:26:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_ext: fix an imbalance with kmemleak
Message-ID: <20190227172644.GF125513@arrakis.emea.arm.com>
References: <20190227172445.75553-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227172445.75553-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:24:45PM -0500, Qian Cai wrote:
> After offlined a memory block, kmemleak scan will trigger a crash, as it
> encounters a page ext address that has already been freed during memory
> offlining. At the beginning in alloc_page_ext(), it calls
> kmemleak_alloc(), but it does not call kmemleak_free() in
> free_page_ext().
[...]
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 8c78b8d45117..0b6637d7bae9 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -274,6 +274,7 @@ static void free_page_ext(void *addr)
>  
>  		BUG_ON(PageReserved(page));
>  		free_pages_exact(addr, table_size);
> +		kmemleak_free(addr);

Same comment as for v1, call kmemleak_free() before free_pages_exact().
With that:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
