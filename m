Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeCOUBj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:01:39 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36013 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeCOUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:01:37 -0400
X-Google-Smtp-Source: AG47ELuIGF++GcoTDNA6LpIEGPOBw2viqpfiDGKAlSEcIsRkZWoybol6UZz3uf7WHfC3JD54zpJayQ==
Date: Thu, 15 Mar 2018 13:01:35 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Roman Gushchin <guro@fb.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch -mm] mm, memcg: evaluate root and leaf memcgs fairly on
 oom
In-Reply-To: <20180315164646.GA1853@castle.DHCP.thefacebook.com>
Message-ID: <alpine.DEB.2.20.1803151259450.44030@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803131720470.247949@chino.kir.corp.google.com> <20180314121700.GA20850@castle.DHCP.thefacebook.com> <alpine.DEB.2.20.1803141337110.163553@chino.kir.corp.google.com>
 <20180315164646.GA1853@castle.DHCP.thefacebook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Roman Gushchin wrote:

> > Seems like it was dropped from the patch somehow.  It is intended to do 
> > atomic_long_add(nr_pages) in mem_cgroup_charge_skmem() and 
> > atomic_long_add(-nr_pages) mem_cgroup_uncharge_skmem().
> > 
> > > I also doubt that global atomic variable can work here,
> > > we probably need something better scaling.
> > > 
> > 
> > Why do you think an atomic_long_add() is too expensive when we're already 
> > disabling irqs and dong try_charge()?
> 
> Hard to say without having full code :)
> try_charge() is batched, if you'll batch it too, it will probably work.
> 

The full code is what's specified above: it does the 
atomic_long_add(nr_pages) in mem_cgroup_charge_skmem() and 
atomic_long_add(-nr_pages) mem_cgroup_uncharge_skmem().

The patch is comparing the root mem cgroup and leaf mem cgroups fairly.  
For this, it requires that we have stats that can be directly compared or 
at least very close approximations.  We don't want to get in a situation 
where root and leaf mem cgroups are being compared based on different 
stats.
