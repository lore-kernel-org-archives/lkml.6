Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935093AbeEWXRk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:17:40 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35375 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEWXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:17:39 -0400
X-Google-Smtp-Source: AB8JxZpBc+Tqegrkx3Nn73Dhf/1D5PNMsUa+JrMXZYAfUN8KvVSqpHFZZ814uPOJbAMbEMJ7GxXjQA==
Date: Wed, 23 May 2018 16:17:36 -0700
From: Tejun Heo <tj@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
Message-ID: <20180523231736.GT1718769@devbig577.frc2.facebook.com>
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
 <1527112995.7898.31.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527112995.7898.31.camel@surriel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Rik.

On Wed, May 23, 2018 at 06:03:15PM -0400, Rik van Riel wrote:
> Dumb question.  Does setting max_active to 1 mean
> that every cgwb_release_workfn() ends up forcing
> another RCU grace period on the whole system, while
> today you might have a bunch of them waiting on the
> same RCU grace period advance?
> 
> Would it be faster to have some number (up to 16?)
> push RCU once, at the same time, instead of having
> each of them push RCU into a next grace period one
> after another?

Oh yeah, you're absolutely right.  This would end up doing a lot of
back-to-back synchronize_rcu_expedited() calls which can't be good.
I'll send a patch to push it upto 16.

Thanks.

-- 
tejun
