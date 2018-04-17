Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeDQV5s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:57:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38586 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeDQV5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:57:46 -0400
X-Google-Smtp-Source: AIpwx4/Qf08hMAHcf1vAI33RN4zCHXKW6Rc/NPxeyu8aMYF7Ng8mlrefn1DCXGESrL/DFh+ToTMgVQ==
From: Laura Abbott <labbott@redhat.com>
To: "Max R . P . Grossmann" <m@max.pm>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Laura Abbott <labbott@redhat.com>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated
Date: Tue, 17 Apr 2018 14:57:42 -0700
Message-Id: <20180417215742.2521-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/time/posix-cpu-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ec9f5da6f163..9cfa7f907654 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1187,10 +1187,12 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
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
-- 
2.17.0
