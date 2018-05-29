Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755413AbeE2JAb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:00:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:20185 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeE2JA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:00:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,455,1520924400";
   d="scan'208";a="42986481"
Date: Tue, 29 May 2018 17:00:24 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Ye, Xiaolong" <xiaolong.ye@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@01.org" <lkp@01.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Subject: Re: [LKP] [lkp-robot] [mm, memcontrol] 309fe96bfc:
 vm-scalability.throughput +23.0% improvement
Message-ID: <20180529090024.GC14785@intel.com>
References: <20180528114019.GF9904@yexl-desktop>
 <20180528120318.GB27180@dhcp22.suse.cz>
 <dbd727326f53648ed114e03a85085b6b4655fda2.camel@intel.com>
 <20180529075800.GL27180@dhcp22.suse.cz>
 <20180529081127.GB14785@intel.com>
 <20180529082751.GQ27180@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529082751.GQ27180@dhcp22.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:27:51AM +0200, Michal Hocko wrote:
> On Tue 29-05-18 16:11:27, Aaron Lu wrote:
> > On Tue, May 29, 2018 at 09:58:00AM +0200, Michal Hocko wrote:
> > > On Tue 29-05-18 03:15:51, Lu, Aaron wrote:
> > > > On Mon, 2018-05-28 at 14:03 +0200, Michal Hocko wrote:
> > > > > On Mon 28-05-18 19:40:19, kernel test robot wrote:
> > > > > > 
> > > > > > Greeting,
> > > > > > 
> > > > > > FYI, we noticed a +23.0% improvement of vm-scalability.throughput due to commit:
> > > > > > 
> > > > > > 
> > > > > > commit: 309fe96bfc0ae387f53612927a8f0dc3eb056efd ("mm, memcontrol: implement memory.swap.events")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > 
> > > > > This doesn't make any sense to me. The patch merely adds an accounting.
> > > > > It doesn't optimize anything. So I strongly suspect the result is just
> > > > > misleading or the test (environment) misconfigured. Not the first time
> > > > > I am seeing something like that I am afraid.
> > > > > 
> > > > 
> > > > Most likely the same situation as:
> > > > "
> > > > FYI, we noticed a -27.2% regression of will-it-scale.per_process_ops
> > > > due to commit:
> > > > 
> > > > 
> > > > commit: e27be240df53f1a20c659168e722b5d9f16cc7f4 ("mm: memcg: make sure
> > > > memory.events is uptodate when waking pollers")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > "
> > > > 
> > > > Where the performance change is due to layout change of
> > > > 'struct mem_cgroup':
> > > > http://lkml.kernel.org/r/20180528085201.GA2918@intel.com
> > > 
> > > I do not follow. How can _this_ patch lead to an improvement when it
> > > actually _adds_ an accounting? The other report you are mentioning is a
> > 
> > This patch also changed the layout of 'struct mem_cgroup':
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index d99b71bc2c66..517096c3cc99 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -208,6 +210,9 @@ struct mem_cgroup {
> >  	atomic_long_t memory_events[MEMCG_NR_MEMORY_EVENTS];
> >  	struct cgroup_file events_file;
> >  
> > +	/* handle for "memory.swap.events" */
> > +	struct cgroup_file swap_events_file;
> > +
> >  	/* protect arrays of thresholds */
> >  	struct mutex thresholds_lock;
> > 
> > And I'm guessing that might be the cause.
> 
> Ohh, you are right! Sorry, I've missed that part.

Never mind, I want to thank you for taking a look at these reports :-)

I just tried to move this newly added field to the bottom of the
structure(just above 'struct mem_cgroup_per_node *nodeinfo[0];'), and
performance dropped to 82665166, still much better than base but already
worse than this patch.

As you said in another email, this is really fragile.
