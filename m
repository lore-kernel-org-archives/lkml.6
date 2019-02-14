Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F299B21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439950AbfBNUaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:30:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfBNUaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:30:09 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C690AD1;
        Thu, 14 Feb 2019 20:30:07 +0000 (UTC)
Date:   Thu, 14 Feb 2019 12:30:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some
 swap operations
Message-Id: <20190214123002.b921b680fea07bf5f798df79@linux-foundation.org>
In-Reply-To: <20190214143318.GJ4525@dhcp22.suse.cz>
References: <20190211083846.18888-1-ying.huang@intel.com>
        <20190214143318.GJ4525@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 15:33:18 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> > Because swapoff() is very rare code path, to make the normal path runs as
> > fast as possible, disabling preemption + stop_machine() instead of
> > reference count is used to implement get/put_swap_device().  From
> > get_swap_device() to put_swap_device(), the preemption is disabled, so
> > stop_machine() in swapoff() will wait until put_swap_device() is called.
> > 
> > In addition to swap_map, cluster_info, etc.  data structure in the struct
> > swap_info_struct, the swap cache radix tree will be freed after swapoff,
> > so this patch fixes the race between swap cache looking up and swapoff
> > too.
> > 
> > Races between some other swap cache usages protected via disabling
> > preemption and swapoff are fixed too via calling stop_machine() between
> > clearing PageSwapCache() and freeing swap cache data structure.
> > 
> > Alternative implementation could be replacing disable preemption with
> > rcu_read_lock_sched and stop_machine() with synchronize_sched().
> 
> using stop_machine is generally discouraged. It is a gross
> synchronization.

This was discussed to death and I think the changelog explains the
conclusions adequately.  swapoff is super-rare so a stop_machine() in
that path is appropriate if its use permits more efficiency in the
regular swap code paths.  

> Besides that, since when do we have this problem?

What problem??
