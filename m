Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/0b0ja+bzeUUzovgoiMlnHxNbCylfmDyCOrPpVrA1f5TiEG9ZDla5H75Z/sOGRnTh10IyS
ARC-Seal: i=1; a=rsa-sha256; t=1522168701; cv=none;
        d=google.com; s=arc-20160816;
        b=bs/NYEp/kC4r6zaTc4/SFVqRS6frz6h8gk2wl2P/7svifTa7FEC9iClCAhZERzu6kW
         OsvaU8SHsxYJTwpxS+g+6liUU92lLnvcKRXH9poD2B/KaQbYklSmMx/NtJOzRdAEQMvk
         oRq+DJunlMlTLXGpYYgzPQIjMV4mYjrOLxA0UNDPMeTRlBhq4mifRn7I2/Ro8Niqns9/
         cC4pQc1qXEzRi3Qpc8YrQYLsYxZYvrLVVqXQK5Pe0XSmtUln+rMAKXZffnGOKpA/P87Z
         2evivTcW/2sulr3RuacuPRf7QIyBC3YgdXsfs35UrLc0CVYfKxd4y8EEaHcJG6Y+orRz
         3U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZYrlZSqDFZK2fGNbYYuzxYp1fB6i5TzmmWKb5MG2iHA=;
        b=Hxuy3bd1vB6WKkoj+8rFQEpL6tl8F0BJ57yjo7oguWr6WBt3yEtMqLSq3zzGRdyOsu
         azVyi4aSGripqXRqLhildqLO4XCM8HvrxH8kxIvQ/7ttTlfWPY/WGlNbWwDdVWWdTHQw
         5VE1SlzQZHRzzqHcGMRglAeEMdRZpY1vGkdMLVRcdPjHE3B1FXM/1uTJCWzTYt543Epq
         fjc4194OHz/C1R9+pxxO1BLqnvTibBj5gIV9wLaeph4uXFNlvlhGVcaqb7CU2E7SAjrI
         CnFWThIVXoT5xgsJMW9k9KT6wUEh/6QqpEvsrBAUUYd8adqSfKWo9G6ec9GDu4VuMvOL
         RfGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Shakeel Butt <shakeelb@google.com>,
	Michal Hocko <mhocko@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 058/101] mm/vmscan: wake up flushers for legacy cgroups too
Date: Tue, 27 Mar 2018 18:27:30 +0200
Message-Id: <20180327162753.545466903@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109568190515678?=
X-GMAIL-MSGID: =?utf-8?q?1596109568190515678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit 1c610d5f93c709df56787f50b3576704ac271826 upstream.

Commit 726d061fbd36 ("mm: vmscan: kick flushers when we encounter dirty
pages on the LRU") added flusher invocation to shrink_inactive_list()
when many dirty pages on the LRU are encountered.

However, shrink_inactive_list() doesn't wake up flushers for legacy
cgroup reclaim, so the next commit bbef938429f5 ("mm: vmscan: remove old
flusher wakeup from direct reclaim path") removed the only source of
flusher's wake up in legacy mem cgroup reclaim path.

This leads to premature OOM if there is too many dirty pages in cgroup:
    # mkdir /sys/fs/cgroup/memory/test
    # echo $$ > /sys/fs/cgroup/memory/test/tasks
    # echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    # dd if=/dev/zero of=tmp_file bs=1M count=100
    Killed

    dd invoked oom-killer: gfp_mask=0x14000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=0

    Call Trace:
     dump_stack+0x46/0x65
     dump_header+0x6b/0x2ac
     oom_kill_process+0x21c/0x4a0
     out_of_memory+0x2a5/0x4b0
     mem_cgroup_out_of_memory+0x3b/0x60
     mem_cgroup_oom_synchronize+0x2ed/0x330
     pagefault_out_of_memory+0x24/0x54
     __do_page_fault+0x521/0x540
     page_fault+0x45/0x50

    Task in /test killed as a result of limit of /test
    memory: usage 51200kB, limit 51200kB, failcnt 73
    memory+swap: usage 51200kB, limit 9007199254740988kB, failcnt 0
    kmem: usage 296kB, limit 9007199254740988kB, failcnt 0
    Memory cgroup stats for /test: cache:49632KB rss:1056KB rss_huge:0KB shmem:0KB
            mapped_file:0KB dirty:49500KB writeback:0KB swap:0KB inactive_anon:0KB
	    active_anon:1168KB inactive_file:24760KB active_file:24960KB unevictable:0KB
    Memory cgroup out of memory: Kill process 3861 (bash) score 88 or sacrifice child
    Killed process 3876 (dd) total-vm:8484kB, anon-rss:1052kB, file-rss:1720kB, shmem-rss:0kB
    oom_reaper: reaped process 3876 (dd), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB

Wake up flushers in legacy cgroup reclaim too.

Link: http://lkml.kernel.org/r/20180315164553.17856-1-aryabinin@virtuozzo.com
Fixes: bbef938429f5 ("mm: vmscan: remove old flusher wakeup from direct reclaim path")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmscan.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1847,6 +1847,20 @@ shrink_inactive_list(unsigned long nr_to
 		set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 	/*
+	 * If dirty pages are scanned that are not queued for IO, it
+	 * implies that flushers are not doing their job. This can
+	 * happen when memory pressure pushes dirty pages to the end of
+	 * the LRU before the dirty limits are breached and the dirty
+	 * data has expired. It can also happen when the proportion of
+	 * dirty pages grows not through writes but through memory
+	 * pressure reclaiming all the clean cache. And in some cases,
+	 * the flushers simply cannot keep up with the allocation
+	 * rate. Nudge the flusher threads in case they are asleep.
+	 */
+	if (stat.nr_unqueued_dirty == nr_taken)
+		wakeup_flusher_threads(0, WB_REASON_VMSCAN);
+
+	/*
 	 * Legacy memcg will stall in page writeback so avoid forcibly
 	 * stalling here.
 	 */
@@ -1858,22 +1872,9 @@ shrink_inactive_list(unsigned long nr_to
 		if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
 			set_bit(PGDAT_CONGESTED, &pgdat->flags);
 
-		/*
-		 * If dirty pages are scanned that are not queued for IO, it
-		 * implies that flushers are not doing their job. This can
-		 * happen when memory pressure pushes dirty pages to the end of
-		 * the LRU before the dirty limits are breached and the dirty
-		 * data has expired. It can also happen when the proportion of
-		 * dirty pages grows not through writes but through memory
-		 * pressure reclaiming all the clean cache. And in some cases,
-		 * the flushers simply cannot keep up with the allocation
-		 * rate. Nudge the flusher threads in case they are asleep, but
-		 * also allow kswapd to start writing pages during reclaim.
-		 */
-		if (stat.nr_unqueued_dirty == nr_taken) {
-			wakeup_flusher_threads(0, WB_REASON_VMSCAN);
+		/* Allow kswapd to start writing pages during reclaim. */
+		if (stat.nr_unqueued_dirty == nr_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
-		}
 
 		/*
 		 * If kswapd scans pages marked marked for immediate
