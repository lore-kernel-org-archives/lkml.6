Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeEBNg4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:36:56 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48838 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbeEBNgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:36:48 -0400
Date: Wed, 2 May 2018 09:38:32 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180502133832.GA18204@cmpxchg.org>
References: <20180423123610.27988-1-guro@fb.com>
 <20180424123002.utwbm54mu46q6aqs@esperanza>
 <20180424135409.GA28080@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424135409.GA28080@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 02:54:15PM +0100, Roman Gushchin wrote:
> From: Roman Gushchin <guro@fb.com>
> Date: Tue, 24 Apr 2018 14:44:14 +0100
> Subject: [PATCH] mm: ignore memory.min of abandoned memory cgroups
> 
> If a cgroup has no associated tasks, invoking the OOM killer
> won't help release any memory, so respecting the memory.min
> can lead to an infinite OOM loop or system stall.
> 
> Let's ignore memory.min of unpopulated cgroups.

Good point, this makes sense.

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -2549,8 +2549,11 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  				/*
>  				 * Hard protection.
>  				 * If there is no reclaimable memory, OOM.
> +				 * Abandoned cgroups are loosing protection,

                                                         losing
