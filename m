Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeC0OnX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:43:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:41301 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbeC0OnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:43:22 -0400
Date: Tue, 27 Mar 2018 16:43:20 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mateusz Guzik <mguzik@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, adobriyan@gmail.com,
        willy@infradead.org, gorcunov@openvz.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180327144320.GI5652@dhcp22.suse.cz>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180327062939.GV5652@dhcp22.suse.cz>
 <20180327143122.rjgxjoj2adzvfck2@mguzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327143122.rjgxjoj2adzvfck2@mguzik>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-03-18 16:31:23, Mateusz Guzik wrote:
> On Tue, Mar 27, 2018 at 08:29:39AM +0200, Michal Hocko wrote:
> > On Tue 27-03-18 02:20:39, Yang Shi wrote:
> > [...]
> > The patch looks reasonable to me. Maybe it would be better to be more
> > explicit about the purpose of the patch. As others noticed, this alone
> > wouldn't solve the mmap_sem contention issues. I _think_ that if you
> > were more explicit about the mmap_sem abuse it would trigger less
> > questions.
> > 
> 
> >From what I gather even with other fixes the kernel will still end up
> grabbing the semaphore. In this case I don't see what's the upside of
> adding the spinlock for args. The downside is growth of mm_struct.

Because accessing the specific address in the address space can be later
changed to use a more fine-grained locking. There are people
experimenting with range locking. These mmap_sem abusers, on the other
hand, will require the full range lock without a good reason. So it is
really worth it to remove them and replace by a more fine grained
locking.

If the mm_struct grow is a real concern (I haven't checked that) then we
can use a set of hashed locks or something else.
-- 
Michal Hocko
SUSE Labs
