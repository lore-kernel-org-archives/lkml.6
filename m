Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeENHxn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:53:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeENHxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:53:38 -0400
Date: Mon, 14 May 2018 00:53:02 -0700
From: tip-bot for Claudio Scordino <tipbot@zytor.com>
Message-ID: <tip-bb4e30a48045c9cc16c4efe447489542750397cc@git.kernel.org>
Cc: hpa@zytor.com, juri.lelli@redhat.com, corbet@lwn.net, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, efault@gmx.de, claudio@evidence.eu.com,
        luca.abeni@santannapisa.it, tglx@linutronix.de
Reply-To: efault@gmx.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, mingo@kernel.org, corbet@lwn.net,
        juri.lelli@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <1522741362-4542-1-git-send-email-claudio@evidence.eu.com>
References: <1522741362-4542-1-git-send-email-claudio@evidence.eu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/deadline/Documentation: Add overrun signal
 and GRUB-PA documentation
Git-Commit-ID: bb4e30a48045c9cc16c4efe447489542750397cc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bb4e30a48045c9cc16c4efe447489542750397cc
Gitweb:     https://git.kernel.org/tip/bb4e30a48045c9cc16c4efe447489542750397cc
Author:     Claudio Scordino <claudio@evidence.eu.com>
AuthorDate: Tue, 3 Apr 2018 09:42:42 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 09:12:27 +0200

sched/deadline/Documentation: Add overrun signal and GRUB-PA documentation

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1522741362-4542-1-git-send-email-claudio@evidence.eu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/scheduler/sched-deadline.txt | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-deadline.txt b/Documentation/scheduler/sched-deadline.txt
index 8ce78f82ae23..b14e03ff3528 100644
--- a/Documentation/scheduler/sched-deadline.txt
+++ b/Documentation/scheduler/sched-deadline.txt
@@ -49,7 +49,7 @@ CONTENTS
 2.1 Main algorithm
 ------------------
 
- SCHED_DEADLINE uses three parameters, named "runtime", "period", and
+ SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
  "runtime" microseconds of execution time every "period" microseconds, and
  these "runtime" microseconds are available within "deadline" microseconds
@@ -117,6 +117,10 @@ CONTENTS
          scheduling deadline = scheduling deadline + period
          remaining runtime = remaining runtime + runtime
 
+ The SCHED_FLAG_DL_OVERRUN flag in sched_attr's sched_flags field allows a task
+ to get informed about runtime overruns through the delivery of SIGXCPU
+ signals.
+
 
 2.2 Bandwidth reclaiming
 ------------------------
@@ -279,6 +283,19 @@ CONTENTS
     running_bw is incremented.
 
 
+2.3 Energy-aware scheduling
+------------------------
+
+ When cpufreq's schedutil governor is selected, SCHED_DEADLINE implements the
+ GRUB-PA [19] algorithm, reducing the CPU operating frequency to the minimum
+ value that still allows to meet the deadlines. This behavior is currently
+ implemented only for ARM architectures.
+
+ A particular care must be taken in case the time needed for changing frequency
+ is of the same order of magnitude of the reservation period. In such cases,
+ setting a fixed CPU frequency results in a lower amount of deadline misses.
+
+
 3. Scheduling Real-Time Tasks
 =============================
 
@@ -505,6 +522,12 @@ CONTENTS
   17 - L. Abeni, G. Lipari, A. Parri, Y. Sun, Multicore CPU reclaiming: parallel
        or sequential?. In Proceedings of the 31st Annual ACM Symposium on Applied
        Computing, 2016.
+  18 - J. Lelli, C. Scordino, L. Abeni, D. Faggioli, Deadline scheduling in the
+       Linux kernel, Software: Practice and Experience, 46(6): 821-839, June
+       2016.
+  19 - C. Scordino, L. Abeni, J. Lelli, Energy-Aware Real-Time Scheduling in
+       the Linux Kernel, 33rd ACM/SIGAPP Symposium On Applied Computing (SAC
+       2018), Pau, France, April 2018.
 
 
 4. Bandwidth management
