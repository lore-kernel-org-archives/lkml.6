Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeEOLdI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:33:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752747AbeEOLdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:33:06 -0400
Date: Tue, 15 May 2018 13:33:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
Message-ID: <20180515113303.GB14527@redhat.com>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
 <20180515083525.GV12217@hirez.programming.kicks-ass.net>
 <20180515090052.cvlt3e7ue6bm4c2c@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515090052.cvlt3e7ue6bm4c2c@quack2.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15, Jan Kara wrote:
>
> Now this behavior upsets lockdep and that's why we fool it by telling the
> semaphore got released before returning to userspace (through
> percpu_rwsem_release() helper) and similarly we tell lockdep we've got the
> semaphore when an unfreeze syscall is called by percpu_rwsem_acquire(). Now
> Amir has discovered that also rwsem debugging code gets confused by this
> behavior

Yes, plus someone else has already reported the problem a month ago,

> and previously also someone noticed that rwsem spinning does not
> make sense and can be broken by this behavior.

Well, this doesn't really matter but again, freeze_super() checks
frozen == SB_UNFROZEN under sb->s_umount and only then does sb_wait_write(),
when the previous writer has already realeased this lock. So the new writer
will never spin after lockdep_sb_freeze_release() clears ->owner.

Oleg.
