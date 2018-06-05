Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeFEUqC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:46:02 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34528 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeFEUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:46:00 -0400
X-Google-Smtp-Source: ADUXVKLV/5YFFdUtulYhpI63dA0yDH0DoMQ6G+sQo3wvluzM03z+E7H3HesT0H9o0H0keIJ+OLUhsw==
Date: Tue, 5 Jun 2018 13:45:56 -0700
From: Tejun Heo <tj@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 06/13] blkcg: add generic throttling mechanism
Message-ID: <20180605204556.GJ1351649@devbig577.frc2.facebook.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
 <20180605132948.1664-7-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605132948.1664-7-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:29:41AM -0400, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> Since IO can be issued from literally anywhere it's almost impossible to
> do throttling without having some sort of adverse effect somewhere else
> in the system because of locking or other dependencies.  The best way to
> solve this is to do the throttling when we know we aren't holding any
> other kernel resources.  Do this by tracking throttling in a per-blkg
> basis, and if we require throttling flag the task that it needs to check
> before it returns to user space and possibly sleep there.
> 
> This is to address the case where a process is doing work that is
> generating IO that can't be throttled, whether that is directly with a
> lot of REQ_META IO, or indirectly by allocating so much memory that it
> is swamping the disk with REQ_SWAP.  We can't use task_add_work as we
> don't want to induce a memory allocation in the IO path, so simply
> saving the request queue in the task and flagging it to do the
> notify_resume thing achieves the same result without the overhead of a
> memory allocation.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
