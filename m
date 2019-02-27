Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37130C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16A321850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfB0RVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:21:18 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfB0RVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:21:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1D31688;
        Wed, 27 Feb 2019 09:21:17 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0543F703;
        Wed, 27 Feb 2019 09:21:16 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:21:13 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_ext: fix an imbalance with kmemleak
Message-ID: <20190227172113.GE125513@arrakis.emea.arm.com>
References: <20190227171556.75444-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227171556.75444-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:15:56PM -0500, Qian Cai wrote:
> After offlined a memory block, kmemleak scan will trigger a crash, as it
> encounters a page ext address that has already been freed during memory
> offlining. At the beginning in alloc_page_ext(), it calls
> kmemleak_alloc(), but it does not call kmemleak_free() in
> __free_page_ext().
[...]
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 8c78b8d45117..b68f2a58ea3b 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -288,6 +288,7 @@ static void __free_page_ext(unsigned long pfn)
>  	base = get_entry(ms->page_ext, pfn);
>  	free_page_ext(base);
>  	ms->page_ext = NULL;
> +	kmemleak_free(base);
>  }

The kmemleak_free() call should be placed before free_page_ext() to
avoid a small window where the address has been freed but kmemleak not
informed.

-- 
Catalin
