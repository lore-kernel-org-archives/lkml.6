Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDSK7i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:59:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbeDSK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:59:14 -0400
Date: Thu, 19 Apr 2018 03:58:56 -0700
From: tip-bot for Laura Abbott <tipbot@zytor.com>
Message-ID: <tip-c3bca5d450b620dd3d36e14b5e1f43639fd47d6b@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, labbott@redhat.com,
        m@max.pm, tglx@linutronix.de, mingo@kernel.org, john.stultz@linaro.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, labbott@redhat.com,
        m@max.pm, tglx@linutronix.de, mingo@kernel.org, john.stultz@linaro.org
In-Reply-To: <20180417215742.2521-1-labbott@redhat.com>
References: <20180417215742.2521-1-labbott@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] posix-cpu-timers: Ensure set_process_cpu_timer
 is always evaluated
Git-Commit-ID: c3bca5d450b620dd3d36e14b5e1f43639fd47d6b
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

Commit-ID:  c3bca5d450b620dd3d36e14b5e1f43639fd47d6b
Gitweb:     https://git.kernel.org/tip/c3bca5d450b620dd3d36e14b5e1f43639fd47d6b
Author:     Laura Abbott <labbott@redhat.com>
AuthorDate: Tue, 17 Apr 2018 14:57:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 19 Apr 2018 12:54:57 +0200

posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated

Commit a9445e47d897 ("posix-cpu-timers: Make set_process_cpu_timer()
more robust") moved the check into the 'if' statement. Unfortunately,
it did so on the right side of an && which means that it may get short
circuited and never evaluated. This is easily reproduced with:

$ cat loop.c
void main() {
  struct rlimit res;
  /* set the CPU time limit */
  getrlimit(RLIMIT_CPU,&res);
  res.rlim_cur = 2;
  res.rlim_max = 2;
  setrlimit(RLIMIT_CPU,&res);

  while (1);
}

Which will hang forever instead of being killed. Fix this by pulling the
evaluation out of the if statement but checking the return value instead.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1568337
Fixes: a9445e47d897 ("posix-cpu-timers: Make set_process_cpu_timer() more robust")
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: "Max R . P . Grossmann" <m@max.pm>
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180417215742.2521-1-labbott@redhat.com

---
 kernel/time/posix-cpu-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2541bd89f20e..5a6251ac6f7a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1205,10 +1205,12 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 			   u64 *newval, u64 *oldval)
 {
 	u64 now;
+	int ret;
 
 	WARN_ON_ONCE(clock_idx == CPUCLOCK_SCHED);
+	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
 
-	if (oldval && cpu_timer_sample_group(clock_idx, tsk, &now) != -EINVAL) {
+	if (oldval && ret != -EINVAL) {
 		/*
 		 * We are setting itimer. The *oldval is absolute and we update
 		 * it to be relative, *newval argument is relative and we update
