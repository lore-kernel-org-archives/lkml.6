Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDRS6D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:58:03 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34034 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeDRS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:58:02 -0400
X-Google-Smtp-Source: AIpwx49C74446izmYLJo0nb9qaUsTKMEj5qd09kfSECkvHDrsaxW8F58p1xMDHnOJzZvSaluPUQdRQ==
Date: Wed, 18 Apr 2018 11:58:00 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
In-Reply-To: <20180418132715.GD17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1804181152240.227784@chino.kir.corp.google.com>
References: <20180418022912.248417-1-minchan@kernel.org> <20180418072002.GN17484@dhcp22.suse.cz> <20180418074117.GA210164@rodete-desktop-imager.corp.google.com> <20180418075437.GP17484@dhcp22.suse.cz> <20180418132328.GB210164@rodete-desktop-imager.corp.google.com>
 <20180418132715.GD17484@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Michal Hocko wrote:

> > Okay, no problem. However, I don't feel we need ratelimit at this moment.
> > We can do when we got real report. Let's add just one line warning.
> > However, I have no talent to write a poem to express with one line.
> > Could you help me?
> 
> What about
> 	pr_info("Failed to create memcg slab cache. Report if you see floods of these\n");
>  

Um, there's nothing actionable here for the user.  Even if the message 
directed them to a specific email address, what would you ask the user for 
in response if they show a kernel log with 100 of these?  Probably ask 
them to use sysrq at the time it happens to get meminfo.  But any user 
initiated sysrq is going to reveal very different state of memory compared 
to when the kmalloc() actually failed.

If this really needs a warning, I think it only needs to be done once and 
reveal the state of memory similar to how slub emits oom warnings.  But as 
the changelog indicates, the system is oom and we couldn't reclaim.  We 
can expect this happens a lot on systems with memory pressure.  What is 
the warning revealing that would be actionable?
