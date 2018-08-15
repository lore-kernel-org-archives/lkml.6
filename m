Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF509C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63435216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63435216E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeHOKUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:20:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:55050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbeHOKUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:20:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01471AEB9;
        Wed, 15 Aug 2018 07:29:00 +0000 (UTC)
Date:   Wed, 15 Aug 2018 09:29:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 2/2] mm: drain memcg stocks on css offlining
Message-ID: <20180815072900.GM32645@dhcp22.suse.cz>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815003620.15678-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815003620.15678-2-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-08-18 17:36:20, Roman Gushchin wrote:
> Memcg charge is batched using per-cpu stocks, so an offline memcg
> can be pinned by a cached charge up to a moment, when a process
> belonging to some other cgroup will charge some memory on the same
> cpu. In other words, cached charges can prevent a memory cgroup
> from being reclaimed for some time, without any clear need.
> 
> Let's optimize it by explicit draining of all stocks on css offlining.
> As draining is performed asynchronously, and is skipped if any
> parallel draining is happening, it's cheap.

Yes this makes sense.

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4e3c1315b1de..cfb64b5b9957 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4575,6 +4575,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	memcg_offline_kmem(memcg);
>  	wb_memcg_offline(memcg);
>  
> +	drain_all_stock(memcg);
> +
>  	mem_cgroup_id_put(memcg);
>  }
>  
> -- 
> 2.14.4

-- 
Michal Hocko
SUSE Labs
