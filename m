Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B309ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FD12146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FD12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbeIRE3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:29:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIRE3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:29:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8204FC77;
        Mon, 17 Sep 2018 23:00:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filippo Sironi <sironi@amazon.de>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, prarit@redhat.com
Subject: [PATCH 4.14 017/126] x86/microcode: Update the new microcode revision unconditionally
Date:   Tue, 18 Sep 2018 00:41:05 +0200
Message-Id: <20180917211705.818051135@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filippo Sironi <sironi@amazon.de>

commit 8da38ebaad23fe1b0c4a205438676f6356607cfc upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/amd.c   |   22 +++++++++++++---------
 arch/x86/kernel/cpu/microcode/intel.c |   13 ++++++++-----
 2 files changed, 21 insertions(+), 14 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -504,6 +504,7 @@ static enum ucode_state apply_microcode_
 	struct microcode_amd *mc_amd;
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
+	enum ucode_state ret;
 	u32 rev, dummy;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
@@ -521,9 +522,8 @@ static enum ucode_state apply_microcode_
 
 	/* need to apply patch? */
 	if (rev >= mc_amd->hdr.patch_id) {
-		c->microcode = rev;
-		uci->cpu_sig.rev = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	if (__apply_microcode_amd(mc_amd)) {
@@ -531,17 +531,21 @@ static enum ucode_state apply_microcode_
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
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -795,6 +795,7 @@ static enum ucode_state apply_microcode_
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_intel *mc;
+	enum ucode_state ret;
 	static int prev_rev;
 	u32 rev;
 
@@ -817,9 +818,8 @@ static enum ucode_state apply_microcode_
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
@@ -848,14 +848,17 @@ static enum ucode_state apply_microcode_
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


