Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970943AbeEXPob (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:44:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967988AbeEXPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:44:22 -0400
From: Scott Wood <swood@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Pei Zhang <pezhang@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH] x86/microcode: Make update_lock raw
Date: Thu, 24 May 2018 10:44:20 -0500
Message-Id: <20180524154420.24455-1-swood@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__reload_late() is called from stop_machine context and thus
cannot acquire a non-raw spinlock on PREEMPT_RT.

Signed-off-by: Scott Wood <swood@redhat.com>
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
-- 
2.17.0
