Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeDJLKF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:10:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:60703 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752591AbeDJLKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:10:04 -0400
Date: Tue, 10 Apr 2018 13:10:01 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180410111001.GD21835@dhcp22.suse.cz>
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180410090917.GZ21835@dhcp22.suse.cz>
 <20180410094047.GB2041@uranus.lan>
 <20180410104215.GB21835@dhcp22.suse.cz>
 <20180410110242.GC2041@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410110242.GC2041@uranus.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 14:02:42, Cyrill Gorcunov wrote:
> On Tue, Apr 10, 2018 at 12:42:15PM +0200, Michal Hocko wrote:
> > On Tue 10-04-18 12:40:47, Cyrill Gorcunov wrote:
> > > On Tue, Apr 10, 2018 at 11:09:17AM +0200, Michal Hocko wrote:
> > > > On Tue 10-04-18 05:52:54, Yang Shi wrote:
> > > > [...]
> > > > > So, introduce a new spinlock in mm_struct to protect the concurrent
> > > > > access to arg_start|end, env_start|end and others except start_brk and
> > > > > brk, which are still protected by mmap_sem to avoid concurrent access
> > > > > from do_brk().
> > > > 
> > > > Is there any fundamental problem with brk using the same lock?
> > > 
> > > Seems so. Look into mm/mmap.c:brk syscall which reads and writes
> > > brk value under mmap_sem ('cause of do_brk called inside).
> > 
> > Why cannot we simply use the lock when the value is updated?
> 
> Because do_brk does vma manipulations, for this reason it's
> running under down_write_killable(&mm->mmap_sem). Or you
> mean something else?

Yes, all we need the new lock for is to get a consistent view on brk
values. I am simply asking whether there is something fundamentally
wrong by doing the update inside the new lock while keeping the original
mmap_sem locking in the brk path. That would allow us to drop the
mmap_sem lock in the proc path when looking at brk values.

-- 
Michal Hocko
SUSE Labs
