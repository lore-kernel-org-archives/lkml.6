Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeDDVkk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:40:40 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:11515 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752303AbeDDVki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:40:38 -0400
Date: Thu, 5 Apr 2018 07:40:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: Waiman Long <longman@redhat.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: REGRESSION/TEST FAILURE caused by DEBUG_RWSEMS
Message-ID: <20180404214033.GB23861@dastard>
References: <20180404132354.GA13897@thunk.org>
 <5670badd-0268-8a06-6612-b58eb6a304b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5670badd-0268-8a06-6612-b58eb6a304b6@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:55:18AM -0400, Waiman Long wrote:
> On 04/04/2018 09:23 AM, Theodore Y. Ts'o wrote:
> > The commit 5149cbac4235: "locking/rwsem: Add DEBUG_RWSEMS to look for
> > lock/unlock emismatches" (newly added in this merge window) will cause
> > xfstests tests failures in generic/068 for all file systems.
> >
> > This is because the freeze and thaw ioctls, by design, are run in
> > different processes.  It looks like the concern for why
> > CONFIG_DEBUG_RWSEMS was added is because read/write semaphores can
> > spin --- which if the case, we need to make sure that (a) the spinlock
> > code path is not used for the freeze/thaw ioctls, and (b) we don't
> > trigger the debug WARN_ON.
> >
> > Cheers,
> >
> The rwsem code has an up_read_non_owner() function for this kind of
> cross task lock/unlock.  I think we should add the corresponding
> up_write_non_owner() for that.

Keep in mind this is a percpu_rwsem, not a rwsem. It's the
sb_freeze_unlock() call in thaw_super() that is triggering it, and
it would appear that percpu_rwsems have no concept on "non_owner"
operation ATM.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
