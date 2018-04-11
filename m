Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48t/EHe8PWzevd/dG2I760w2NglY8vyzeQvP+exhbiRdBrgwYxyLlSWGGYyyLWN1xejE5fT
ARC-Seal: i=1; a=rsa-sha256; t=1523473000; cv=none;
        d=google.com; s=arc-20160816;
        b=l2T/92h7eIf9O9PoENqiAGIX2aDgGqsqSIWTTfn5fFJNheNi08XQnf9m/0b1lAHhLA
         023QyPrntEJ/5RlnS/wJ4Ol4VAXQ6uYwsb3PWdTocrJV6GY9j+daHSP3U1R2qmuUsSkQ
         i2y4uAjvBWkArG+vuyOl8r3ZJ7c0/MhIs6NYmLdvJHF/a6eCQtgiWefOGLMzAF8uxYMB
         UT5kpLYy7S7TdQBdWOxKpXJJpWpLiRMBvrmWpZUYWnpXsrxe+bG5OX+pb4GFtMlV8FNb
         MubdNvxHGZiYhP56cQtfTes21Vw0K1Ji0Uzzob+ywQs8p9vXiPG+sgnDXli/8pMqiIBt
         OL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WFUz/PtoA5DHCXgTn9C2pofphyjDKwCgXg/UOwX+diU=;
        b=EuWYci0ohNnZOXPUkaR5pcJDC89L8jETCXl6e0pz+t4li3ddcIRwj1G5jZxg/9oM0z
         GJD5WybYpJ6YnMbu9pztHkXBhoK16/rcdTEi2Ra7tPBhjtpeWLaK5ACYME8tMmFHsYn9
         Pq6U6k+Ftd2CBS2E6tOlwStvsuSwmwld6kqS92ZbSJPK4id7/awY3etV0HeiRz5sJntq
         TsvBwZM3FbdT33ffC+NqmI1luPh+03255V7G8wfzUn1pbmguoIy4Dj+H/b5o5bdNWw3r
         IWaMPCRZ8sKFZipAhd/1T6XrY3Gf8iL/5admtjGXJ18E0CR915tbG3E6iDkirv1/PoAk
         Ezmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 093/310] sched/numa: Use down_read_trylock() for the mmap_sem
Date: Wed, 11 Apr 2018 20:33:52 +0200
Message-Id: <20180411183626.241614322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476641164892578?=
X-GMAIL-MSGID: =?utf-8?q?1597477225403244578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>


[ Upstream commit 8655d5497735b288f8a9b458bd22e7d1bf95bb61 ]

A customer has reported a soft-lockup when running an intensive
memory stress test, where the trace on multiple CPU's looks like this:

 RIP: 0010:[<ffffffff810c53fe>]
  [<ffffffff810c53fe>] native_queued_spin_lock_slowpath+0x10e/0x190
...
 Call Trace:
  [<ffffffff81182d07>] queued_spin_lock_slowpath+0x7/0xa
  [<ffffffff811bc331>] change_protection_range+0x3b1/0x930
  [<ffffffff811d4be8>] change_prot_numa+0x18/0x30
  [<ffffffff810adefe>] task_numa_work+0x1fe/0x310
  [<ffffffff81098322>] task_work_run+0x72/0x90

Further investigation showed that the lock contention here is pmd_lock().

The task_numa_work() function makes sure that only one thread is let to perform
the work in a single scan period (via cmpxchg), but if there's a thread with
mmap_sem locked for writing for several periods, multiple threads in
task_numa_work() can build up a convoy waiting for mmap_sem for read and then
all get unblocked at once.

This patch changes the down_read() to the trylock version, which prevents the
build up. For a workload experiencing mmap_sem contention, it's probably better
to postpone the NUMA balancing work anyway. This seems to have fixed the soft
lockups involving pmd_lock(), which is in line with the convoy theory.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@redhat.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170515131316.21909-1-vbabka@suse.cz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2429,7 +2429,8 @@ void task_numa_work(struct callback_head
 		return;
 
 
-	down_read(&mm->mmap_sem);
+	if (!down_read_trylock(&mm->mmap_sem))
+		return;
 	vma = find_vma(mm, start);
 	if (!vma) {
 		reset_ptenuma_scan(p);
