Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112B9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90A020869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90A020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbeKGDq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:46:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38115 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388442AbeKGDq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:46:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6IJP97893930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 10:19:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6IJP2o893927;
        Tue, 6 Nov 2018 10:19:25 -0800
Date:   Tue, 6 Nov 2018 10:19:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vishal Verma <tipbot@zytor.com>
Message-ID: <tip-e8a308e5f47e545e0d41d0686c00f5f5217c5f61@git.kernel.org>
Cc:     yazen.ghannam@amd.com, bp@suse.de, dan.j.williams@intel.com,
        mingo@kernel.org, tony.luck@intel.com, mingo@redhat.com,
        x86@kernel.org, arnd@arndb.de, qiuxu.zhuo@intel.com,
        rjw@rjwysocki.net, elliott@hpe.com, linux-edac@vger.kernel.org,
        tglx@linutronix.de, lenb@kernel.org, stable@vger.kernel.org,
        vishal.l.verma@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, zwisler@kernel.org,
        dave.jiang@intel.com
Reply-To: dan.j.williams@intel.com, yazen.ghannam@amd.com, bp@suse.de,
          tony.luck@intel.com, mingo@kernel.org, mingo@redhat.com,
          x86@kernel.org, arnd@arndb.de, qiuxu.zhuo@intel.com,
          rjw@rjwysocki.net, elliott@hpe.com, lenb@kernel.org,
          stable@vger.kernel.org, vishal.l.verma@intel.com,
          linux-edac@vger.kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, zwisler@kernel.org,
          dave.jiang@intel.com, hpa@zytor.com
In-Reply-To: <20181026003729.8420-2-vishal.l.verma@intel.com>
References: <20181026003729.8420-2-vishal.l.verma@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] acpi/nfit, x86/mce: Validate a MCE's address
 before using it
Git-Commit-ID: e8a308e5f47e545e0d41d0686c00f5f5217c5f61
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

Commit-ID:  e8a308e5f47e545e0d41d0686c00f5f5217c5f61
Gitweb:     https://git.kernel.org/tip/e8a308e5f47e545e0d41d0686c00f5f5217c5f61
Author:     Vishal Verma <vishal.l.verma@intel.com>
AuthorDate: Thu, 25 Oct 2018 18:37:29 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 6 Nov 2018 19:13:26 +0100

acpi/nfit, x86/mce: Validate a MCE's address before using it

The NFIT machine check handler uses the physical address from the mce
structure, and compares it against information in the ACPI NFIT table
to determine whether that location lies on an NVDIMM. The mce->addr
field however may not always be valid, and this is indicated by the
MCI_STATUS_ADDRV bit in the status field.

Export mce_usable_address() which already performs validation for the
address, and use it in the NFIT handler.

Fixes: 6839a6d96f4e ("nfit: do an ARS scrub on hitting a latent media error")
Reported-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: elliott@hpe.com
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: linux-edac <linux-edac@vger.kernel.org>
CC: linux-nvdimm@lists.01.org
CC: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Ross Zwisler <zwisler@kernel.org>
CC: stable <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tony Luck <tony.luck@intel.com>
CC: x86-ml <x86@kernel.org>
CC: Yazen Ghannam <yazen.ghannam@amd.com>
Link: http://lkml.kernel.org/r/20181026003729.8420-2-vishal.l.verma@intel.com
---
 arch/x86/include/asm/mce.h       | 1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
 drivers/acpi/nfit/mce.c          | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dbd9fe2f6163..c1a812bd5a27 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -222,6 +222,7 @@ static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return mce_am
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
+int mce_usable_address(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 77527b8ea982..36d2696c9563 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -485,7 +485,7 @@ static void mce_report_event(struct pt_regs *regs)
  * be somewhat complicated (e.g. segment offset would require an instruction
  * parser). So only support physical addresses up to page granuality for now.
  */
-static int mce_usable_address(struct mce *m)
+int mce_usable_address(struct mce *m)
 {
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
@@ -505,6 +505,7 @@ static int mce_usable_address(struct mce *m)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(mce_usable_address);
 
 bool mce_is_memory_error(struct mce *m)
 {
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index 7a51707f87e9..d6c1b10f6c25 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -29,6 +29,10 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
 		return NOTIFY_DONE;
 
+	/* Verify the address reported in the MCE is valid. */
+	if (!mce_usable_address(mce))
+		return NOTIFY_DONE;
+
 	/*
 	 * mce->addr contains the physical addr accessed that caused the
 	 * machine check. We need to walk through the list of NFITs, and see
