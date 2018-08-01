Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D458BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8802320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8802320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389960AbeHARbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:31:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47328 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389587AbeHARbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:31:47 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PZ6q2UWrhZFf; Wed,  1 Aug 2018 17:45:27 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DFEC1EC0591;
        Wed,  1 Aug 2018 17:45:27 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:45:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de, tony.luck@intel.com
Subject: [PATCH 2/2] x86/microcode: Update the new microcode revision
 unconditionally
Message-ID: <20180801154531.GE13988@nazgul.tnic>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
 <20180801154255.GC13988@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801154255.GC13988@nazgul.tnic>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

Handle the case where microcode gets loaded on the BSP's hyperthread
sibling first and the boot_cpu_data's microcode revision doesn't get
updated because of early exit due to the siblings sharing a microcode
engine.

For that, simply write the updated revision on all CPUs unconditionally.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Cc: prarit@redhat.com
Cc: stable@vger.kernel.org
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1533050970-14385-1-git-send-email-sironi@amazon.de
[ Massage everything a bit. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c   | 22 +++++++++++++---------
 arch/x86/kernel/cpu/microcode/intel.c | 13 ++++++++-----
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 63b072377ba4..07b5fc00b188 100644
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
-		boot_cpu_data.microcode =  mc_amd->hdr.patch_id;
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
-- 
2.18.0.321.gffc6fa0e3962


-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
