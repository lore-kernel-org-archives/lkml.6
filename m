Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eyCgADJMGVuEYAAAmS7hNA
	; Thu, 07 Jun 2018 15:16:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F31266089E; Thu,  7 Jun 2018 15:16:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6B73160290;
	Thu,  7 Jun 2018 15:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B73160290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935907AbeFGPQv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:16:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41358 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935010AbeFGPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:48 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005dI-HW; Thu, 07 Jun 2018 15:09:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Cj-6C; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "Borislav Petkov" <bp@suse.de>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.275888259@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 335/410] x86/MCE: Save microcode revision in machine
 check records
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit fa94d0c6e0f3431523f5701084d799c77c7d4a4f upstream.

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

[ Borislav: Simplify a bit. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180301233449.24311-1-tony.luck@intel.com
[bwh: Backported to 3.2:
 - Add other new fields to struct mce, to match upstream UAPI
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -25,6 +25,10 @@ struct mce {
 	__u32 socketid;	/* CPU socket ID */
 	__u32 apicid;	/* CPU initial apic ID */
 	__u64 mcgcap;	/* MCGCAP MSR: machine check capabilities of CPU */
+	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
+	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
+	__u64 ppin;	/* Protected Processor Inventory Number */
+	__u32 microcode;/* Microcode revision */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -135,6 +135,8 @@ void mce_setup(struct mce *m)
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
 	rdmsrl(MSR_IA32_MCG_CAP, m->mcgcap);
+
+	m->microcode = boot_cpu_data.microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
@@ -282,7 +284,7 @@ static void print_mce(struct mce *m)
 	 */
 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode %x\n",
 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
-		cpu_data(m->extcpu).microcode);
+		m->microcode);
 
 	/*
 	 * Print out human-readable details about the MCE error,
