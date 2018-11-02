Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002572082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002572082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeKBSCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:02:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeKBSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:02:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0267DAE8A;
        Fri,  2 Nov 2018 08:56:06 +0000 (UTC)
Date:   Fri, 2 Nov 2018 09:55:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm: do not start node_reclaim for page order >
 MAX_ORDER
Message-ID: <20181102081949.GQ23921@dhcp22.suse.cz>
References: <154109387197.925352.10499549042420271600.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154109387197.925352.10499549042420271600.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 20:37:52, Konstantin Khlebnikov wrote:
> Page allocator has check in __alloc_pages_slowpath() but nowdays
> there is earlier entry point into reclimer without such check:
> get_page_from_freelist() -> node_reclaim().

Is the order check so expensive that it would be visible in the fast
path? Spreading these MAX_ORDER checks sounds quite fragile to me.

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  mm/vmscan.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 62ac0c488624..52f672420f0b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4117,6 +4117,12 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  {
>  	int ret;
>  
> +	/*
> +	 * Do not scan if allocation will never succeed.
> +	 */
> +	if (order >= MAX_ORDER)
> +		return NODE_RECLAIM_NOSCAN;
> +
>  	/*
>  	 * Node reclaim reclaims unmapped file backed pages and
>  	 * slab pages if we are over the defined limits.
> 

-- 
Michal Hocko
SUSE Labs
