Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeC2MYP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:24:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752256AbeC2MYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:24:13 -0400
Subject: Re: [Cluster-devel] [PATCH v2 0/2] gfs2: Stop using
 rhashtable_walk_peek
To: Andreas Gruenbacher <agruenba@redhat.com>, cluster-devel@redhat.com
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
References: <20180329120612.6104-1-agruenba@redhat.com>
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <b15f44f6-d052-17f2-b099-ea2d601c9a6e@redhat.com>
Date: Thu, 29 Mar 2018 13:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180329120612.6104-1-agruenba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can we solve the problem another way, by not taking refs on the glocks 
when we are iterating over them for the debugfs files? I assume that is 
the main issue here.

We didn't used to take refs since the rcu locking was enough during the 
walk itself. We used to only keep track of the hash bucket and offset 
within the bucket when we dropped the rcu lock between calls to the 
iterator. I may have lost track of why that approach did not work?

Steve.


On 29/03/18 13:06, Andreas Gruenbacher wrote:
> Here's a second version of the patch (now a patch set) to eliminate
> rhashtable_walk_peek in gfs2.
>
> The first patch introduces lockref_put_not_zero, the inverse of
> lockref_get_not_zero.
>
> The second patch eliminates rhashtable_walk_peek in gfs2.  In
> gfs2_glock_iter_next, the new lockref function from patch one is used to
> drop a lockref count as long as the count doesn't drop to zero.  This is
> almost always the case; if there is a risk of dropping the last
> reference, we must defer that to a work queue because dropping the last
> reference may sleep.
>
> Thanks,
> Andreas
>
> Andreas Gruenbacher (2):
>    lockref: Add lockref_put_not_zero
>    gfs2: Stop using rhashtable_walk_peek
>
>   fs/gfs2/glock.c         | 47 ++++++++++++++++++++++++++++-------------------
>   include/linux/lockref.h |  1 +
>   lib/lockref.c           | 28 ++++++++++++++++++++++++++++
>   3 files changed, 57 insertions(+), 19 deletions(-)
>
