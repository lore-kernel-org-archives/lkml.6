Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeA3Iy7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:54:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60543 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbeA3Iyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:54:49 -0500
Date: Tue, 30 Jan 2018 09:54:45 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>, Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch -mm v2 2/3] mm, memcg: replace cgroup aware oom killer
 mount option with tunable
Message-ID: <20180130085445.GQ21609@dhcp22.suse.cz>
References: <alpine.DEB.2.10.1801161812550.28198@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1801251552320.161808@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1801251553030.161808@chino.kir.corp.google.com>
 <20180125160016.30e019e546125bb13b5b6b4f@linux-foundation.org>
 <alpine.DEB.2.10.1801261415090.15318@chino.kir.corp.google.com>
 <20180126143950.719912507bd993d92188877f@linux-foundation.org>
 <alpine.DEB.2.10.1801261441340.20954@chino.kir.corp.google.com>
 <20180126161735.b999356fbe96c0acd33aaa66@linux-foundation.org>
 <20180129104657.GC21609@dhcp22.suse.cz>
 <20180129191139.GA1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129191139.GA1121507@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-01-18 11:11:39, Tejun Heo wrote:
> Hello, Michal.
> 
> On Mon, Jan 29, 2018 at 11:46:57AM +0100, Michal Hocko wrote:
> > @@ -1292,7 +1292,11 @@ the memory controller considers only cgroups belonging to the sub-tree
> >  of the OOM'ing cgroup.
> >  
> >  The root cgroup is treated as a leaf memory cgroup, so it's compared
> > -with other leaf memory cgroups and cgroups with oom_group option set.
> > +with other leaf memory cgroups and cgroups with oom_group option
> > +set. Due to internal implementation restrictions the size of the root
> > +cgroup is a cumulative sum of oom_badness of all its tasks (in other
> > +words oom_score_adj of each task is obeyed). This might change in the
> > +future.
> 
> Thanks, we can definitely use more documentation.  However, it's a bit
> difficult to follow.  Maybe expand it to a separate paragraph on the
> current behavior with a clear warning that the default OOM heuristics
> is subject to changes?

Does this sound any better?

>From ea4fa9c36d3ec2cf13d1949169924a1a54b9fcd6 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Tue, 30 Jan 2018 09:54:15 +0100
Subject: [PATCH] oom, memcg: clarify root memcg oom accounting

David Rientjes has pointed out that the current way how the root memcg
is accounted for the cgroup aware OOM killer is undocumented. Unlike
regular cgroups there is no accounting going on in the root memcg
(mostly for performance reasons). Therefore we are suming up oom_badness
of its tasks. This might result in an over accounting because of the
oom_score_adj setting. Document this for now.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/cgroup-v2.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
index 2eaed1e2243d..67bdf19f8e5b 100644
--- a/Documentation/cgroup-v2.txt
+++ b/Documentation/cgroup-v2.txt
@@ -1291,8 +1291,14 @@ This affects both system- and cgroup-wide OOMs. For a cgroup-wide OOM
 the memory controller considers only cgroups belonging to the sub-tree
 of the OOM'ing cgroup.
 
-The root cgroup is treated as a leaf memory cgroup, so it's compared
-with other leaf memory cgroups and cgroups with oom_group option set.
+Leaf cgroups are compared based on their cumulative memory usage. The
+root cgroup is treated as a leaf memory cgroup as well, so it's
+compared with other leaf memory cgroups. Due to internal implementation
+restrictions the size of the root cgroup is a cumulative sum of
+oom_badness of all its tasks (in other words oom_score_adj of each task
+is obeyed). Relying on oom_score_adj (appart from OOM_SCORE_ADJ_MIN)
+can lead to overestimating of the root cgroup consumption and it is
+therefore discouraged. This might change in the future, though.
 
 If there are no cgroups with the enabled memory controller,
 the OOM killer is using the "traditional" process-based approach.
-- 
2.15.1
-- 
Michal Hocko
SUSE Labs
