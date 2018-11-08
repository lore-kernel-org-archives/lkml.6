Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89160C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5720720827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5720720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeKHSHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:07:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:37856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbeKHSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:07:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FB7BAE12;
        Thu,  8 Nov 2018 08:32:58 +0000 (UTC)
Date:   Thu, 8 Nov 2018 09:32:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v3 2/4] mm: convert zone->managed_pages to atomic variable
Message-ID: <20181108083258.GP27423@dhcp22.suse.cz>
References: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
 <1541665398-29925-3-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541665398-29925-3-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-11-18 13:53:16, Arun KS wrote:
> totalram_pages, zone->managed_pages and totalhigh_pages updates
> are protected by managed_page_count_lock, but readers never care
> about it. Convert these variables to atomic to avoid readers
> potentially seeing a store tear.
> 
> This patch converts zone->managed_pages. Subsequent patches will
> convert totalram_panges, totalhigh_pages and eventually
> managed_page_count_lock will be removed.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> ---
> Main motivation was that managed_page_count_lock handling was
> complicating things. It was discussed in lenght here,
> https://lore.kernel.org/patchwork/patch/995739/#1181785
> So it seemes better to remove the lock and convert variables
> to atomic, with preventing poteintial store-to-read tearing as
> a bonus.

Do not be afraid to put this into the changelog. It is much better to
have it there in case anybody wonders in future and use git blame rather
than chase an email archive to find it in the foot note. The same
applies to the meta patch.

> Most of the changes are done by below coccinelle script,
> 
> @@
> struct zone *z;
> expression e1;
> @@
> (
> - z->managed_pages = e1
> + atomic_long_set(&z->managed_pages, e1)
> |
> - e1->managed_pages++
> + atomic_long_inc(&e1->managed_pages)
> |
> - z->managed_pages
> + zone_managed_pages(z)
> )
> 
> @@
> expression e,e1;
> @@
> - e->managed_pages += e1
> + atomic_long_add(e1, &e->managed_pages)
> 
> @@
> expression z;
> @@
> - z.managed_pages
> + zone_managed_pages(&z)
> 
> Then, manually apply following change,
> include/linux/mmzone.h
> 
> - unsigned long managed_pages;
> + atomic_long_t managed_pages;
> 
> +static inline unsigned long zone_managed_pages(struct zone *zone)
> +{
> +       return (unsigned long)atomic_long_read(&zone->managed_pages);
> +}
> 
-- 
Michal Hocko
SUSE Labs
