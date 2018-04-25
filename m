Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754125AbeDYKxT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:53:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34485 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDYKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 06:52:59 -0400
X-Google-Smtp-Source: AB8JxZoVPnO4F+8urJx+Om1WJdgntSTv0abZ9ZVA472bPHeGODqVZvzxO0vIo8lB+sZz5/i6WBlmnQ==
Date: Wed, 25 Apr 2018 13:52:55 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] mm: introduce memory.min
Message-ID: <20180425105255.ixfuoanb6t4kr6l5@esperanza>
References: <20180423123610.27988-1-guro@fb.com>
 <20180424123002.utwbm54mu46q6aqs@esperanza>
 <20180424135409.GA28080@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424135409.GA28080@castle.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 02:54:15PM +0100, Roman Gushchin wrote:
> > On Mon, Apr 23, 2018 at 01:36:10PM +0100, Roman Gushchin wrote:
> > > +  memory.min
> > > +	A read-write single value file which exists on non-root
> > > +	cgroups.  The default is "0".
> > > +
> > > +	Hard memory protection.  If the memory usage of a cgroup
> > > +	is within its effective min boundary, the cgroup's memory
> > > +	won't be reclaimed under any conditions. If there is no
> > > +	unprotected reclaimable memory available, OOM killer
> > > +	is invoked.
> > 
> > What will happen if all tasks attached to a cgroup are killed by OOM,
> > but its memory usage is still within memory.min? Will memory.min be
> > ignored then?
> 
> Not really.
> 
> I don't think it's a big problem as long as a user isn't doing
> something weird (e.g. moving processes with significant
> amount of charged memory to other cgroups).

The user doesn't have to do anything weird for this to happen - just
read a file. This will allocate and charge page cache pages that are
not mapped to any process and hence cannot be freed by OOM killer.

> 
> But what we can do here, is to ignore memory.min of empty cgroups
> (patch below), it will resolve some edge cases like this.

Makes sense to me.

Thanks,
Vladimir
