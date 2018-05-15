Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEOI0N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:26:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeEOI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:26:11 -0400
Date: Tue, 15 May 2018 10:25:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 1/2] locking/rwsem: Add a new
 RWSEM_WRITER_OWNED_NOSPIN flag
Message-ID: <20180515082547.GU12217@hirez.programming.kicks-ass.net>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526326267-22501-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 03:31:06PM -0400, Waiman Long wrote:
> There are use cases where a rwsem can be acquired by one task, but
> released by another task. In thess cases, it may not be appropriate
> for the lock waiters to spin on the task that acquires the lock.
> One example will be the filesystem freeze/thaw code.
> 
> To handle such use cases, a new RWSEM_WRITER_OWNED_NOSPIN
> flag can now be set in the owner field of the rwsem by the new
> rwsem_set_writer_owned_nospin() function to indicate that the rwsem is
> writer owned, but optimistic spinning on the rwsem should be disabled.
> 
> Later on, the new rwsem_set_writer_owned() function can be called to
> set the new owner, if it is known. This function should not be called
> without a prior rwsem_set_writer_owned_nospin() call.

Urgh.. no please don't do this. Aside from the horrible naming, do not
expose 'set-owner' semantics. Can't we just stick to the existing
_non_owner() interface without further polluting the API?
