Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113E1C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63672081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63672081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeLIWNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37970 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbeLIWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:49 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002ik-HL; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003SV-07; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.420597284@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 177/328] x86/microcode/intel: Check microcode
 revision before updating sibling threads
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

From: Ashok Raj <ashok.raj@intel.com>

commit c182d2b7d0ca48e0d6ff16f7d883161238c447ed upstream.

After updating microcode on one of the threads of a core, the other
thread sibling automatically gets the update since the microcode
resources on a hyperthreaded core are shared between the two threads.

Check the microcode revision on the CPU before performing a microcode
update and thus save us the WRMSR 0x79 because it is a particularly
expensive operation.

[ Borislav: Massage changelog and coding style. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-2-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-3-bp@alien8.de
[bwh: Backported to 3.16:
 - s/mc->/mc_intel->/
 - Return 0 in this case
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -155,6 +155,18 @@ int apply_microcode(int cpu)
 	if (get_matching_mc(mc_intel, cpu) == 0)
 		return 0;
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc_intel->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		c->microcode = rev;
+		return 0;
+	}
+
 	/* write microcode via MSR 0x79 */
 	wrmsr(MSR_IA32_UCODE_WRITE,
 	      (unsigned long) mc_intel->bits,
--- a/arch/x86/kernel/cpu/microcode/intel_early.c
+++ b/arch/x86/kernel/cpu/microcode/intel_early.c
@@ -653,6 +653,17 @@ static int apply_microcode_early(struct
 	if (mc_intel == NULL)
 		return 0;
 
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev = intel_get_microcode_revision();
+	if (rev >= mc_intel->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		return 0;
+	}
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsr(MSR_IA32_UCODE_WRITE,
 	      (unsigned long) mc_intel->bits,

