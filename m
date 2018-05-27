Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeE0T4S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 15:56:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeE0T4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 15:56:16 -0400
Date: Sun, 27 May 2018 12:55:00 -0700
From: tip-bot for Scott Wood <tipbot@zytor.com>
Message-ID: <tip-ff987fcf011d20c53b3a613edf6e2055ea48e26e@git.kernel.org>
Cc: williams@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@suse.de, ashok.raj@intel.com, mingo@kernel.org, x86@kernel.org,
        pezhang@redhat.com, swood@redhat.com, hpa@zytor.com
Reply-To: ashok.raj@intel.com, pezhang@redhat.com, mingo@kernel.org,
        x86@kernel.org, swood@redhat.com, hpa@zytor.com, williams@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de
In-Reply-To: <20180524154420.24455-1-swood@redhat.com>
References: <20180524154420.24455-1-swood@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode: Make the late update update_lock
 a raw lock for RT
Git-Commit-ID: ff987fcf011d20c53b3a613edf6e2055ea48e26e
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

Commit-ID:  ff987fcf011d20c53b3a613edf6e2055ea48e26e
Gitweb:     https://git.kernel.org/tip/ff987fcf011d20c53b3a613edf6e2055ea48e26e
Author:     Scott Wood <swood@redhat.com>
AuthorDate: Thu, 24 May 2018 10:44:20 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 27 May 2018 21:50:09 +0200

x86/microcode: Make the late update update_lock a raw lock for RT

__reload_late() is called from stop_machine context and thus cannot
acquire a non-raw spinlock on PREEMPT_RT.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Pei Zhang <pezhang@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20180524154420.24455-1-swood@redhat.com
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 77e201301528..08286269fd24 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -70,7 +70,7 @@ static DEFINE_MUTEX(microcode_mutex);
 /*
  * Serialize late loading so that CPUs get updated one-by-one.
  */
-static DEFINE_SPINLOCK(update_lock);
+static DEFINE_RAW_SPINLOCK(update_lock);
 
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
@@ -560,9 +560,9 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
-	spin_lock(&update_lock);
+	raw_spin_lock(&update_lock);
 	apply_microcode_local(&err);
-	spin_unlock(&update_lock);
+	raw_spin_unlock(&update_lock);
 
 	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
