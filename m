Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA00C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981F20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfAPTbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:31:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfAPTbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:31:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GJVZhc397652
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 11:31:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GJVY6v397649;
        Wed, 16 Jan 2019 11:31:34 -0800
Date:   Wed, 16 Jan 2019 11:31:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shirish S <tipbot@zytor.com>
Message-ID: <tip-30aa3d26edb0f3d7992757287eec0ca588a5c259@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, Shirish.S@amd.com,
        yazen.ghannam@amd.com, keescook@chromium.org, shirish.s@amd.com,
        vishal.l.verma@intel.com, tony.luck@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        mingo@kernel.org
Reply-To: bp@suse.de, Shirish.S@amd.com, hpa@zytor.com,
          tony.luck@intel.com, tglx@linutronix.de, shirish.s@amd.com,
          vishal.l.verma@intel.com, keescook@chromium.org,
          yazen.ghannam@amd.com, mingo@kernel.org, mingo@redhat.com,
          x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1547651417-23583-3-git-send-email-shirish.s@amd.com>
References: <1547651417-23583-3-git-send-email-shirish.s@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD: Carve out the MC4_MISC thresholding
 quirk
Git-Commit-ID: 30aa3d26edb0f3d7992757287eec0ca588a5c259
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  30aa3d26edb0f3d7992757287eec0ca588a5c259
Gitweb:     https://git.kernel.org/tip/30aa3d26edb0f3d7992757287eec0ca588a5c259
Author:     Shirish S <Shirish.S@amd.com>
AuthorDate: Wed, 16 Jan 2019 15:10:40 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 19:42:00 +0100

x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk

The MC4_MISC thresholding quirk needs to be applied during S5 -> S0 and
S3 -> S0 state transitions, which follow different code paths. Carve it
out into a separate function and call it mce_amd_feature_init() where
the two code paths of the state transitions converge.

 [ bp: massage commit message and the carved out function. ]

Signed-off-by: Shirish S <shirish.s@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1547651417-23583-3-git-send-email-shirish.s@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c  | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c | 29 -----------------------------
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 89298c83de53..ed3327342b40 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -545,6 +545,40 @@ out:
 	return offset;
 }
 
+/*
+ * Turn off MC4_MISC thresholding banks on all family 0x15 models since
+ * they're not supported there.
+ */
+void disable_err_thresholding(struct cpuinfo_x86 *c)
+{
+	int i;
+	u64 hwcr;
+	bool need_toggle;
+	u32 msrs[] = {
+		0x00000413, /* MC4_MISC0 */
+		0xc0000408, /* MC4_MISC1 */
+	};
+
+	if (c->x86 != 0x15)
+		return;
+
+	rdmsrl(MSR_K7_HWCR, hwcr);
+
+	/* McStatusWrEn has to be set */
+	need_toggle = !(hwcr & BIT(18));
+
+	if (need_toggle)
+		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
+
+	/* Clear CntP bit safely */
+	for (i = 0; i < ARRAY_SIZE(msrs); i++)
+		msr_clear_bit(msrs[i], 62);
+
+	/* restore old settings */
+	if (need_toggle)
+		wrmsrl(MSR_K7_HWCR, hwcr);
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -552,6 +586,8 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu = smp_processor_id();
 	int offset = -1;
 
+	disable_err_thresholding(c);
+
 	for (bank = 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d0c54160b439..6063ae2376b2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1611,35 +1611,6 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 0x15 && c->x86_model <= 0xf)
 			mce_flags.overflow_recov = 1;
 
-		/*
-		 * Turn off MC4_MISC thresholding banks on all models since
-		 * they're not supported there.
-		 */
-		if (c->x86 == 0x15) {
-			int i;
-			u64 hwcr;
-			bool need_toggle;
-			u32 msrs[] = {
-				0x00000413, /* MC4_MISC0 */
-				0xc0000408, /* MC4_MISC1 */
-			};
-
-			rdmsrl(MSR_K7_HWCR, hwcr);
-
-			/* McStatusWrEn has to be set */
-			need_toggle = !(hwcr & BIT(18));
-
-			if (need_toggle)
-				wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
-
-			/* Clear CntP bit safely */
-			for (i = 0; i < ARRAY_SIZE(msrs); i++)
-				msr_clear_bit(msrs[i], 62);
-
-			/* restore old settings */
-			if (need_toggle)
-				wrmsrl(MSR_K7_HWCR, hwcr);
-		}
 	}
 
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
