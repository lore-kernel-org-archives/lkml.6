Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933926AbeE2MMW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:12:22 -0400
Received: from foss.arm.com ([217.140.101.70]:38696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933793AbeE2MMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:12:15 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 17/17] arm64: ssbd: Implement arch_seccomp_spec_mitigate
Date: Tue, 29 May 2018 13:11:21 +0100
Message-Id: <20180529121121.24927-18-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a way to safely implement TIF_SSBD for tasks
that are not in the kernel at the point were the flag gets
set, let's implement arch_seccomp_spec_mitigate().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/ssbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
index 34eafdc7fb6b..a61da5e1b2ed 100644
--- a/arch/arm64/kernel/ssbd.c
+++ b/arch/arm64/kernel/ssbd.c
@@ -77,6 +77,13 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 	}
 }
 
+#ifdef CONFIG_SECCOMP
+void arch_seccomp_spec_mitigate(struct task_struct *task)
+{
+	ssbd_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+}
+#endif
+
 static int ssbd_prctl_get(struct task_struct *task)
 {
 	switch (arm64_get_ssbd_state()) {
-- 
2.14.2
