Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCPUBt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:01:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49085 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeCPUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:01:46 -0400
Date: Fri, 16 Mar 2018 13:01:29 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-bb8c13d61a629276a162c1d2b1a20a815cbcfbb7@git.kernel.org>
Cc: ashok.raj@intel.com, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, xftroxgpx@protonmail.com, bp@suse.de
Reply-To: xftroxgpx@protonmail.com, mingo@kernel.org, bp@suse.de,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        thomas.lendacky@amd.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180314183615.17629-2-bp@alien8.de>
References: <20180314183615.17629-2-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode: Fix CPU synchronization routine
Git-Commit-ID: bb8c13d61a629276a162c1d2b1a20a815cbcfbb7
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

Commit-ID:  bb8c13d61a629276a162c1d2b1a20a815cbcfbb7
Gitweb:     https://git.kernel.org/tip/bb8c13d61a629276a162c1d2b1a20a815cbcfbb7
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 14 Mar 2018 19:36:15 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Mar 2018 20:55:51 +0100

x86/microcode: Fix CPU synchronization routine

Emanuel reported an issue with a hang during microcode update because my
dumb idea to use one atomic synchronization variable for both rendezvous
- before and after update - was simply bollocks:

  microcode: microcode_reload_late: late_cpus: 4
  microcode: __reload_late: cpu 2 entered
  microcode: __reload_late: cpu 1 entered
  microcode: __reload_late: cpu 3 entered
  microcode: __reload_late: cpu 0 entered
  microcode: __reload_late: cpu 1 left
  microcode: Timeout while waiting for CPUs rendezvous, remaining: 1

CPU1 above would finish, leave and the others will still spin waiting for
it to join.

So do two synchronization atomics instead, which makes the code a lot more
straightforward.

Also, since the update is serialized and it also takes quite some time per
microcode engine, increase the exit timeout by the number of CPUs on the
system.

That's ok because the moment all CPUs are done, that timeout will be cut
short.

Furthermore, panic when some of the CPUs timeout when returning from a
microcode update: we can't allow a system with not all cores updated.

Also, as an optimization, do not do the exit sync if microcode wasn't
updated.

Reported-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20180314183615.17629-2-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/core.c | 68 ++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 9f0fe5bb450d..10c4fc2c91f8 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -517,7 +517,29 @@ static int check_online_cpus(void)
 	return -EINVAL;
 }
 
-static atomic_t late_cpus;
+static atomic_t late_cpus_in;
+static atomic_t late_cpus_out;
+
+static int __wait_for_cpus(atomic_t *t, long long timeout)
+{
+	int all_cpus = num_online_cpus();
+
+	atomic_inc(t);
+
+	while (atomic_read(t) < all_cpus) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				all_cpus - atomic_read(t));
+			return 1;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+	return 0;
+}
 
 /*
  * Returns:
@@ -527,30 +549,16 @@ static atomic_t late_cpus;
  */
 static int __reload_late(void *info)
 {
-	unsigned int timeout = NSEC_PER_SEC;
-	int all_cpus = num_online_cpus();
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
 
-	atomic_dec(&late_cpus);
-
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	while (atomic_read(&late_cpus)) {
-		if (timeout < SPINUNIT) {
-			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
-				atomic_read(&late_cpus));
-			return -1;
-		}
-
-		ndelay(SPINUNIT);
-		timeout -= SPINUNIT;
-
-		touch_nmi_watchdog();
-	}
+	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
+		return -1;
 
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
@@ -558,15 +566,22 @@ static int __reload_late(void *info)
 
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		ret = -1;
-	} else if (err == UCODE_UPDATED) {
+		return -1;
+	/* siblings return UCODE_OK because their engine got updated already */
+	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
+	} else {
+		return ret;
 	}
 
-	atomic_inc(&late_cpus);
-
-	while (atomic_read(&late_cpus) != all_cpus)
-		cpu_relax();
+	/*
+	 * Increase the wait timeout to a safe value here since we're
+	 * serializing the microcode update and that could take a while on a
+	 * large number of CPUs. And that is fine as the *actual* timeout will
+	 * be determined by the last CPU finished updating and thus cut short.
+	 */
+	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC * num_online_cpus()))
+		panic("Timeout during microcode update!\n");
 
 	return ret;
 }
@@ -579,12 +594,11 @@ static int microcode_reload_late(void)
 {
 	int ret;
 
-	atomic_set(&late_cpus, num_online_cpus());
+	atomic_set(&late_cpus_in,  0);
+	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret < 0)
-		return ret;
-	else if (ret > 0)
+	if (ret > 0)
 		microcode_check();
 
 	return ret;
