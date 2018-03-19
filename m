Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsCW17Oq5zdgtAKudDc75TcAjfKRMviB+aeNRaqDwcZg9zbzPO+77nIlMR4/VbOHEAAccUq
ARC-Seal: i=1; a=rsa-sha256; t=1521483936; cv=none;
        d=google.com; s=arc-20160816;
        b=hBdN+zlB7YUdmTowo1jfu1r4ucP/mXH2Jge5JB+j+Eu7j3CoU5+1EG+OXYrFCBVbAf
         kCFAJuzWFt8GmS8AYBJ0Q/PWf5C5RR63PN2pqU+qC+iuOQXsCSSFhTSJ2iaFxrG5bpzt
         Oq/8bhlVGLqqO2udyeDgSAQRKhgiVRBcgnE3yBByPJo53k5ilhLP4xZTvCAWqrHu3KHn
         0QXEt6e2filmWCnD5K5dE9n/fh1Og1wotWUv7t1q2Yva884MqZjYGrB2SFIZzZ646OmM
         9nMAfUMAKJuRRWmH5lcDwHMSMJmp5Q14DEzmCnvwC602TjXHn/o0IOIpuaRe3yxMjuV9
         bDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KanUTORzTvImLxCM+axveSXsTfREu8aGbmhpZPD74zg=;
        b=vw4YbdfGNhlECf+Sg6v163k1u9sWbmW6O6Sg7scKkbdwy8jw04JKkoHaAJzzNEpJCw
         /VcsidCGY35vjrrzcGS5LJb4snS7Fo8+t52LFPPPGQQvzVq7hwZcUw6EEhrXJ2RorLxk
         iGxDIcmfWsiGohMQjlMQ6QONJKiLt8QAvG1nZLGWDFD6lpAGqxvdL08fLoXlM40ZU20e
         gaOLPJliXqVgPwYRqtOJZFPhUqoOVy5yVNWFnofZ+9g/36Ud+ZRep27XRv2vhM3JfKxp
         hQWXy6UyoQlMt1VXSB//RMrzdhtwfguT+APIPmBVkc98kGk55JX/iguKc2zrUjYB6t9l
         E4GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 170/241] sched: Stop switched_to_rt() from sending IPIs to offline CPUs
Date: Mon, 19 Mar 2018 19:07:15 +0100
Message-Id: <20180319180758.198717661@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390899532847799?=
X-GMAIL-MSGID: =?utf-8?q?1595391539993404002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>


[ Upstream commit 2fe2582649aa2355f79acddb86bd4d6c5363eb63 ]

The rcutorture test suite occasionally provokes a splat due to invoking
rt_mutex_lock() which needs to boost the priority of a task currently
sitting on a runqueue that belongs to an offline CPU:

WARNING: CPU: 0 PID: 12 at /home/paulmck/public_git/linux-rcu/arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x37/0x40
Modules linked in:
CPU: 0 PID: 12 Comm: rcub/7 Not tainted 4.14.0-rc4+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
task: ffff9ed3de5f8cc0 task.stack: ffffbbf80012c000
RIP: 0010:native_smp_send_reschedule+0x37/0x40
RSP: 0018:ffffbbf80012fd10 EFLAGS: 00010082
RAX: 000000000000002f RBX: ffff9ed3dd9cb300 RCX: 0000000000000004
RDX: 0000000080000004 RSI: 0000000000000086 RDI: 00000000ffffffff
RBP: ffffbbf80012fd10 R08: 000000000009da7a R09: 0000000000007b9d
R10: 0000000000000001 R11: ffffffffbb57c2cd R12: 000000000000000d
R13: ffff9ed3de5f8cc0 R14: 0000000000000061 R15: ffff9ed3ded59200
FS:  0000000000000000(0000) GS:ffff9ed3dea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000080686f0 CR3: 000000001b9e0000 CR4: 00000000000006f0
Call Trace:
 resched_curr+0x61/0xd0
 switched_to_rt+0x8f/0xa0
 rt_mutex_setprio+0x25c/0x410
 task_blocks_on_rt_mutex+0x1b3/0x1f0
 rt_mutex_slowlock+0xa9/0x1e0
 rt_mutex_lock+0x29/0x30
 rcu_boost_kthread+0x127/0x3c0
 kthread+0x104/0x140
 ? rcu_report_unblock_qs_rnp+0x90/0x90
 ? kthread_create_on_node+0x40/0x40
 ret_from_fork+0x22/0x30
Code: f0 00 0f 92 c0 84 c0 74 14 48 8b 05 34 74 c5 00 be fd 00 00 00 ff 90 a0 00 00 00 5d c3 89 fe 48 c7 c7 a0 c6 fc b9 e8 d5 b5 06 00 <0f> ff 5d c3 0f 1f 44 00 00 8b 05 a2 d1 13 02 85 c0 75 38 55 48

But the target task's priority has already been adjusted, so the only
purpose of switched_to_rt() invoking resched_curr() is to wake up the
CPU running some task that needs to be preempted by the boosted task.
But the CPU is offline, which presumably means that the task must be
migrated to some other CPU, and that this other CPU will undertake any
needed preemption at the time of migration.  Because the runqueue lock
is held when resched_curr() is invoked, we know that the boosted task
cannot go anywhere, so it is not necessary to invoke resched_curr()
in this particular case.

This commit therefore makes switched_to_rt() refrain from invoking
resched_curr() when the target CPU is offline.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/rt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2206,7 +2206,7 @@ static void switched_to_rt(struct rq *rq
 		if (tsk_nr_cpus_allowed(p) > 1 && rq->rt.overloaded)
 			queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
