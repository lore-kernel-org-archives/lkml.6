Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175DEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEECE20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEECE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeIBQcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:32:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:32:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w82CGQW32914464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Sep 2018 05:16:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w82CGQbx2914461;
        Sun, 2 Sep 2018 05:16:26 -0700
Date:   Sun, 2 Sep 2018 05:16:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Filippo Sironi <tipbot@zytor.com>
Message-ID: <tip-8da38ebaad23fe1b0c4a205438676f6356607cfc@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@suse.de,
        linux-kernel@vger.kernel.org, sironi@amazon.de, hpa@zytor.com
Reply-To: mingo@kernel.org, sironi@amazon.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de
In-Reply-To: <1533050970-14385-1-git-send-email-sironi@amazon.de>
References: <1533050970-14385-1-git-send-email-sironi@amazon.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode: Update the new microcode revision
 unconditionally
Git-Commit-ID: 8da38ebaad23fe1b0c4a205438676f6356607cfc
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

Commit-ID:  8da38ebaad23fe1b0c4a205438676f6356607cfc
Gitweb:     https://git.kernel.org/tip/8da38ebaad23fe1b0c4a205438676f6356607cfc
Author:     Filippo Sironi <sironi@amazon.de>
AuthorDate: Tue, 31 Jul 2018 17:29:30 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 2 Sep 2018 14:10:54 +0200

x86/microcode: Update the new microcode revision unconditionally

Handle the case where microcode gets loaded on the BSP's hyperthread
sibling first and the boot_cpu_data's microcode revision doesn't get
updated because of early exit due to the siblings sharing a microcode
engine.

For that, simply write the updated revision on all CPUs unconditionally.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: prarit@redhat.com
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1533050970-14385-1-git-send-email-sironi@amazon.de
---
 arch/x86/kernel/cpu/microcode/amd.c   | 22 +++++++++++++---------
 arch/x86/kernel/cpu/microcode/intel.c | 13 ++++++++-----
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 602f17134103..07b5fc00b188 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -504,6 +504,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct microcode_amd *mc_amd;
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
+	enum ucode_state ret;
 	u32 rev, dummy;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
@@ -521,9 +522,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
 
 	/* need to apply patch? */
 	if (rev >= mc_amd->hdr.patch_id) {
-		c->microcode = rev;
-		uci->cpu_sig.rev = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	if (__apply_microcode_amd(mc_amd)) {
@@ -531,17 +531,21 @@ static enum ucode_state apply_microcode_amd(int cpu)
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;
 	}
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu,
-		mc_amd->hdr.patch_id);
 
-	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
-	c->microcode = mc_amd->hdr.patch_id;
+	rev = mc_amd->hdr.patch_id;
+	ret = UCODE_UPDATED;
+
+	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
+
+out:
+	uci->cpu_sig.rev = rev;
+	c->microcode	 = rev;
 
 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
 	if (c->cpu_index == boot_cpu_data.cpu_index)
-		boot_cpu_data.microcode = mc_amd->hdr.patch_id;
+		boot_cpu_data.microcode = rev;
 
-	return UCODE_UPDATED;
+	return ret;
 }
 
 static int install_equiv_cpu_table(const u8 *buf)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 256d336cbc04..16936a24795c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -795,6 +795,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_intel *mc;
+	enum ucode_state ret;
 	static int prev_rev;
 	u32 rev;
 
@@ -817,9 +818,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	 */
 	rev = intel_get_microcode_revision();
 	if (rev >= mc->hdr.rev) {
-		uci->cpu_sig.rev = rev;
-		c->microcode = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	/*
@@ -848,14 +848,17 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
+	ret = UCODE_UPDATED;
+
+out:
 	uci->cpu_sig.rev = rev;
-	c->microcode = rev;
+	c->microcode	 = rev;
 
 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
 	if (c->cpu_index == boot_cpu_data.cpu_index)
 		boot_cpu_data.microcode = rev;
 
-	return UCODE_UPDATED;
+	return ret;
 }
 
 static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
