Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqbeDNi0dnyDOLeoc2wrRPxTfxGgRqnU6CRXJQSztIRySch/S9lq6qhzzlqLp4CSZ/boYSW
ARC-Seal: i=1; a=rsa-sha256; t=1526937251; cv=none;
        d=google.com; s=arc-20160816;
        b=mFHJ+Lg057coWSpXN81+M/jU1bhO7DPvntnXAH7PR92W4m9CZIU2IGJ0FvodRavddV
         fBqPtfwf5zRfL8n8ifFBnSU2RLo1oD6nJBS3tc0x1c5Zwv599fUfuM8AJUSmy80l4qnJ
         B3zgTBSeTdxM4eo3XrpQmfmfa03RyL0zXSFYOgE134Oww64SKXLjOK2rqRLmBxFMptDV
         s7hOT4omL+7TQiHt1FPcx4jj0xOQRFLrprBh/IgZQKO6JJnMxK8AFnLWJwOaAF9RdivY
         ZcQ/xfnz+4OQYKdMWmcYZlj6tLjgp0Zw5nkSP3wCewx6ZWMLVB4CSwVL++2oomXnT3V7
         IScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Fbuj46DzoGlf84fn0/TX0lpvw7cLHvdGx5HUr/a37dg=;
        b=oOTzhOzOEcvGxOU3FaSQbZpy1EyeXO+wArFh66p4a/+BiARlcO9dMulxt28/KNAejF
         OY5JKXmWTX7MUIxg9GqLgV1jE0tQuutp1pZLzPhbpWmoNSuogQ2DkiV+qFOnCaUyGT/u
         l/RNNonEBkUJ+dm8hdWMamOZP/afmlucmuF/voglVEaOwLaoewHfIB1pwwbhk0h/5MZP
         GnXCxomjqo+GL2glaREs1eTyVPynEIwvXk7+9RWcqwoYrluwoz5rkHmkDNF3u3J47CY4
         fJZ3vTxaQ6MNrcUVqMAslQ2HFtkM/IsF1U6G+qGh8hE/KCrxUvgY4nJ9jcKVJx/BzMvf
         d9PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=REHj9IvG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=REHj9IvG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Waiman Long <Waiman.Long@hpe.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stas Sergeev <stsp@list.ru>,
	Scott J Norton <scott.norton@hpe.com>,
	Douglas Hatch <doug.hatch@hpe.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Subject: [PATCH 4.9 14/87] signals: avoid unnecessary taking of sighand->siglock
Date: Mon, 21 May 2018 23:10:50 +0200
Message-Id: <20180521210421.524274294@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109754935892721?=
X-GMAIL-MSGID: =?utf-8?q?1601109754935892721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <Waiman.Long@hpe.com>

commit c7be96af89d4b53211862d8599b2430e8900ed92 upstream.

When running certain database workload on a high-end system with many
CPUs, it was found that spinlock contention in the sigprocmask syscalls
became a significant portion of the overall CPU cycles as shown below.

  9.30%  9.30%  905387  dataserver  /proc/kcore 0x7fff8163f4d2
  [k] _raw_spin_lock_irq
            |
            ---_raw_spin_lock_irq
               |
               |--99.34%-- __set_current_blocked
               |          sigprocmask
               |          sys_rt_sigprocmask
               |          system_call_fastpath
               |          |
               |          |--50.63%-- __swapcontext
               |          |          |
               |          |          |--99.91%-- upsleepgeneric
               |          |
               |          |--49.36%-- __setcontext
               |          |          ktskRun

Looking further into the swapcontext function in glibc, it was found that
the function always call sigprocmask() without checking if there are
changes in the signal mask.

A check was added to the __set_current_blocked() function to avoid taking
the sighand->siglock spinlock if there is no change in the signal mask.
This will prevent unneeded spinlock contention when many threads are
trying to call sigprocmask().

With this patch applied, the spinlock contention in sigprocmask() was
gone.

Link: http://lkml.kernel.org/r/1474979209-11867-1-git-send-email-Waiman.Long@hpe.com
Signed-off-by: Waiman Long <Waiman.Long@hpe.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Scott J Norton <scott.norton@hpe.com>
Cc: Douglas Hatch <doug.hatch@hpe.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/signal.h |   17 +++++++++++++++++
 kernel/signal.c        |    7 +++++++
 2 files changed, 24 insertions(+)

--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -97,6 +97,23 @@ static inline int sigisemptyset(sigset_t
 	}
 }
 
+static inline int sigequalsets(const sigset_t *set1, const sigset_t *set2)
+{
+	switch (_NSIG_WORDS) {
+	case 4:
+		return	(set1->sig[3] == set2->sig[3]) &&
+			(set1->sig[2] == set2->sig[2]) &&
+			(set1->sig[1] == set2->sig[1]) &&
+			(set1->sig[0] == set2->sig[0]);
+	case 2:
+		return	(set1->sig[1] == set2->sig[1]) &&
+			(set1->sig[0] == set2->sig[0]);
+	case 1:
+		return	set1->sig[0] == set2->sig[0];
+	}
+	return 0;
+}
+
 #define sigmask(sig)	(1UL << ((sig) - 1))
 
 #ifndef __HAVE_ARCH_SIG_SETOPS
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2495,6 +2495,13 @@ void __set_current_blocked(const sigset_
 {
 	struct task_struct *tsk = current;
 
+	/*
+	 * In case the signal mask hasn't changed, there is nothing we need
+	 * to do. The current->blocked shouldn't be modified by other task.
+	 */
+	if (sigequalsets(&tsk->blocked, newset))
+		return;
+
 	spin_lock_irq(&tsk->sighand->siglock);
 	__set_task_blocked(tsk, newset);
 	spin_unlock_irq(&tsk->sighand->siglock);
