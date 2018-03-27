Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49q5NuTu/pkar/9px7UWepYB2/CIZqgOOO6MdC/z3vciM+37ZI5Zb2wulls3/zKCSup4F+h
ARC-Seal: i=1; a=rsa-sha256; t=1522168766; cv=none;
        d=google.com; s=arc-20160816;
        b=XIEkSeE0avzw8NwqT0HgA5wRUmm+u66rl6Uc7zyU1I2Yf7k65Uw4XXCKxiq210gzwV
         mL0xsxsdw1i1pAASSXGqnLaMso7vqp2+MVocwQDMM75yJWx4dYsRf9mtsv7Vz2v2ZL5W
         gO6Nllm4jHzBaIBoFAkl4WzFLcDZfbUetIVztrV61oA6kWUMfzkgPMFodCbdIrZUVlTx
         p3qvSr73+60Z2/O7J9GrU66BFCARCiS9Wa4zRiGfHFu9gRDxObRvkinIOaUgxamDRoek
         B/rcboEqEfRXzhG41ozdycdYveblVC1n3a2CuKgbt/X+ELLm3ihRktbQiCBhgMWU1X1H
         WAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rM7oGzG/5HM9VNO7W2V59bz+LLAmK0UmRy1kNypLVIw=;
        b=szIrL0CgMR84BgRWLfkYfX98u5BjUZig06YRs3PXUByXERtfeaYiBMF8aiSb0xw+9e
         WhDIBf4VZsp8BDyebbhqFNV8JcxYKEQG0eSWQV7+D77B4wqqAs28cnep4utprqHaiw0J
         cDGVeHVJZgLQ3ndmuLm0M0R+vMoVeNtecYJOevwZouU7+S5YonbONGbLIR+H6OJgHJx+
         Bx/ZjY/ksw9noGnDZv49Xf7IOP3FBvLaVyAbstCGph7aO2ax0IrwEhpezd5KjJRQwXjR
         g0gfG6wOFVcg2GLOMmNPxUY8FMyKrgqmXKZ02BgoKfQS4Dawud3+I5jLv3O2d52vGdIF
         YIOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Dave Jones <davej@codemonkey.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Piggin <npiggin@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nikolay Borisov <nborisov@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 024/105] lockdep: fix fs_reclaim warning
Date: Tue, 27 Mar 2018 18:27:04 +0200
Message-Id: <20180327162758.890519461@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109440855505175?=
X-GMAIL-MSGID: =?utf-8?q?1596109636988068897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 2e517d681632326ed98399cb4dd99519efe3e32c upstream.

Dave Jones reported fs_reclaim lockdep warnings.

  ============================================
  WARNING: possible recursive locking detected
  4.15.0-rc9-backup-debug+ #1 Not tainted
  --------------------------------------------
  sshd/24800 is trying to acquire lock:
   (fs_reclaim){+.+.}, at: [<0000000084f438c2>] fs_reclaim_acquire.part.102+0x5/0x30

  but task is already holding lock:
   (fs_reclaim){+.+.}, at: [<0000000084f438c2>] fs_reclaim_acquire.part.102+0x5/0x30

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(fs_reclaim);
    lock(fs_reclaim);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  2 locks held by sshd/24800:
   #0:  (sk_lock-AF_INET6){+.+.}, at: [<000000001a069652>] tcp_sendmsg+0x19/0x40
   #1:  (fs_reclaim){+.+.}, at: [<0000000084f438c2>] fs_reclaim_acquire.part.102+0x5/0x30

  stack backtrace:
  CPU: 3 PID: 24800 Comm: sshd Not tainted 4.15.0-rc9-backup-debug+ #1
  Call Trace:
   dump_stack+0xbc/0x13f
   __lock_acquire+0xa09/0x2040
   lock_acquire+0x12e/0x350
   fs_reclaim_acquire.part.102+0x29/0x30
   kmem_cache_alloc+0x3d/0x2c0
   alloc_extent_state+0xa7/0x410
   __clear_extent_bit+0x3ea/0x570
   try_release_extent_mapping+0x21a/0x260
   __btrfs_releasepage+0xb0/0x1c0
   btrfs_releasepage+0x161/0x170
   try_to_release_page+0x162/0x1c0
   shrink_page_list+0x1d5a/0x2fb0
   shrink_inactive_list+0x451/0x940
   shrink_node_memcg.constprop.88+0x4c9/0x5e0
   shrink_node+0x12d/0x260
   try_to_free_pages+0x418/0xaf0
   __alloc_pages_slowpath+0x976/0x1790
   __alloc_pages_nodemask+0x52c/0x5c0
   new_slab+0x374/0x3f0
   ___slab_alloc.constprop.81+0x47e/0x5a0
   __slab_alloc.constprop.80+0x32/0x60
   __kmalloc_track_caller+0x267/0x310
   __kmalloc_reserve.isra.40+0x29/0x80
   __alloc_skb+0xee/0x390
   sk_stream_alloc_skb+0xb8/0x340
   tcp_sendmsg_locked+0x8e6/0x1d30
   tcp_sendmsg+0x27/0x40
   inet_sendmsg+0xd0/0x310
   sock_write_iter+0x17a/0x240
   __vfs_write+0x2ab/0x380
   vfs_write+0xfb/0x260
   SyS_write+0xb6/0x140
   do_syscall_64+0x1e5/0xc05
   entry_SYSCALL64_slow_path+0x25/0x25

This warning is caused by commit d92a8cfcb37e ("locking/lockdep:
Rework FS_RECLAIM annotation") which replaced the use of
lockdep_{set,clear}_current_reclaim_state() in __perform_reclaim()
and lockdep_trace_alloc() in slab_pre_alloc_hook() with
fs_reclaim_acquire()/ fs_reclaim_release().

Since __kmalloc_reserve() from __alloc_skb() adds __GFP_NOMEMALLOC |
__GFP_NOWARN to gfp_mask, and all reclaim path simply propagates
__GFP_NOMEMALLOC, fs_reclaim_acquire() in slab_pre_alloc_hook() is
trying to grab the 'fake' lock again when __perform_reclaim() already
grabbed the 'fake' lock.

The

  /* this guy won't enter reclaim */
  if ((current->flags & PF_MEMALLOC) && !(gfp_mask & __GFP_NOMEMALLOC))
          return false;

test which causes slab_pre_alloc_hook() to try to grab the 'fake' lock
was added by commit cf40bd16fdad ("lockdep: annotate reclaim context
(__GFP_NOFS)").  But that test is outdated because PF_MEMALLOC thread
won't enter reclaim regardless of __GFP_NOMEMALLOC after commit
341ce06f69ab ("page allocator: calculate the alloc_flags for allocation
only once") added the PF_MEMALLOC safeguard (

  /* Avoid recursion of direct reclaim */
  if (p->flags & PF_MEMALLOC)
          goto nopage;

in __alloc_pages_slowpath()).

Thus, let's fix outdated test by removing __GFP_NOMEMALLOC test and
allow __need_fs_reclaim() to return false.

Link: http://lkml.kernel.org/r/201802280650.FJC73911.FOSOMLJVFFQtHO@I-love.SAKURA.ne.jp
Fixes: d92a8cfcb37ecd13 ("locking/lockdep: Rework FS_RECLAIM annotation")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Tested-by: Dave Jones <davej@codemonkey.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: <stable@vger.kernel.org>	[4.14+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3588,7 +3588,7 @@ static bool __need_fs_reclaim(gfp_t gfp_
 		return false;
 
 	/* this guy won't enter reclaim */
-	if ((current->flags & PF_MEMALLOC) && !(gfp_mask & __GFP_NOMEMALLOC))
+	if (current->flags & PF_MEMALLOC)
 		return false;
 
 	/* We're only interested __GFP_FS allocations for now */
