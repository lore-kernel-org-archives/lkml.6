Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeA3KS1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:18:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:41480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbeA3KS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:18:26 -0500
Date: Tue, 30 Jan 2018 11:18:23 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: "He, Roger" <Hongbo.He@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Message-ID: <20180130101823.GX21609@dhcp22.suse.cz>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <20180130075553.GM21609@dhcp22.suse.cz>
 <9060281e-62dd-8775-2903-339ff836b436@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9060281e-62dd-8775-2903-339ff836b436@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-01-18 10:00:07, Christian König wrote:
> Am 30.01.2018 um 08:55 schrieb Michal Hocko:
> > On Tue 30-01-18 02:56:51, He, Roger wrote:
> > > Hi Michal:
> > > 
> > > We need a API to tell TTM module the system totally has how many swap
> > > cache.  Then TTM module can use it to restrict how many the swap cache
> > > it can use to prevent triggering OOM.  For Now we set the threshold of
> > > swap size TTM used as 1/2 * total size and leave the rest for others
> > > use.
> > Why do you so much memory? Are you going to use TB of memory on large
> > systems? What about memory hotplug when the memory is added/released?
> 
> For graphics and compute applications on GPUs it isn't unusual to use large
> amounts of system memory.
> 
> Our standard policy in TTM is to allow 50% of system memory to be pinned for
> use with GPUs (the hardware can't do page faults).
> 
> When that limit is exceeded (or the shrinker callbacks tell us to make room)
> we wait for any GPU work to finish and copy buffer content into a shmem
> file.
> 
> This copy into a shmem file can easily trigger the OOM killer if there isn't
> any swap space left and that is something we want to avoid.
> 
> So what we want to do is to apply this 50% rule to swap space as well and
> deny allocation of buffer objects when it is exceeded.

How does that help when the rest of the system might eat swap?

> > > But get_nr_swap_pages is the only API we can accessed from other
> > > module now.  It can't cover the case of the dynamic swap size
> > > increment.  I mean: user can use "swapon" to enable new swap file or
> > > swap disk dynamically or "swapoff" to disable swap space.
> > Exactly. Your scaling configuration based on get_nr_swap_pages or the
> > available memory simply sounds wrong.
> 
> Why? That is pretty much exactly what we are doing with buffer objects and
> system memory for years.

Could you be more specific? What kind of buffer objects you have in
mind?

-- 
Michal Hocko
SUSE Labs
