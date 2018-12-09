Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED6BC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F226520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeLIWHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37192 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727576AbeLIWHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:14 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002iZ-HB; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Sf-33; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        prarit@redhat.com, "Filippo Sironi" <sironi@amazon.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.242229314@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 179/328] x86/microcode: Update the new microcode
 revision unconditionally
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Link: http://lkml.kernel.org/r/1533050970-14385-1-git-send-email-sironi@amazon.de
[bwh: Backported to 3.16:
 - Keep returning 0 on success
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -214,26 +214,26 @@ int apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
-		c->microcode = rev;
-		uci->cpu_sig.rev = rev;
-		return 0;
-	}
+	if (rev >= mc_amd->hdr.patch_id)
+		goto out;
 
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return -1;
 	}
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu,
-		mc_amd->hdr.patch_id);
 
-	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
-	c->microcode = mc_amd->hdr.patch_id;
+	rev = mc_amd->hdr.patch_id;
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
 
 	return 0;
 }
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -161,11 +161,8 @@ int apply_microcode(int cpu)
 	 * already.
 	 */
 	rev = intel_get_microcode_revision();
-	if (rev >= mc_intel->hdr.rev) {
-		uci->cpu_sig.rev = rev;
-		c->microcode = rev;
-		return 0;
-	}
+	if (rev >= mc_intel->hdr.rev)
+		goto out;
 
 	/* write microcode via MSR 0x79 */
 	wrmsr(MSR_IA32_UCODE_WRITE,
@@ -185,8 +182,9 @@ int apply_microcode(int cpu)
 		mc_intel->hdr.date >> 24,
 		(mc_intel->hdr.date >> 16) & 0xff);
 
+out:
 	uci->cpu_sig.rev = rev;
-	c->microcode = rev;
+	c->microcode	 = rev;
 
 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
 	if (c->cpu_index == boot_cpu_data.cpu_index)

