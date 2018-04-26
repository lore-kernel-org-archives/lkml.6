Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbeDZOKE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:10:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeDZOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:10:00 -0400
Date: Thu, 26 Apr 2018 07:09:46 -0700
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051@git.kernel.org>
Cc: bp@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        yazen.ghannam@amd.com, mingo@kernel.org, Yazen.Ghannam@amd.com,
        hpa@zytor.com
Reply-To: Yazen.Ghannam@amd.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, yazen.ghannam@amd.com, bp@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180403140228.58540-1-Yazen.Ghannam@amd.com>
References: <20180403140228.58540-1-Yazen.Ghannam@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/smpboot: Don't use mwait_play_dead() on AMD
 systems
Git-Commit-ID: da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051
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

Commit-ID:  da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051
Gitweb:     https://git.kernel.org/tip/da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Tue, 3 Apr 2018 09:02:28 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 26 Apr 2018 16:06:19 +0200

x86/smpboot: Don't use mwait_play_dead() on AMD systems

Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
not allow deeper cstates than C1 on current systems.

play_dead() expects to use the deepest state available.  The deepest state
available on AMD systems is reached through SystemIO or HALT. If MWAIT is
available, it is preferred over the other methods, so the CPU never reaches
the deepest possible state.

Don't try to use MWAIT to play_dead() on AMD systems. Instead, use CPUIDLE
to enter the deepest state advertised by firmware. If CPUIDLE is not
available then fallback to HALT.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Link: https://lkml.kernel.org/r/20180403140228.58540-1-Yazen.Ghannam@amd.com

---
 arch/x86/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 45175b81dd5b..0f1cbb042f49 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1571,6 +1571,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
