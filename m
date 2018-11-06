Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D0CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8CF20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8CF20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbeKGDpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:45:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKGDpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:45:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6IIphN893857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 10:18:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6IIpWL893853;
        Tue, 6 Nov 2018 10:18:51 -0800
Date:   Tue, 6 Nov 2018 10:18:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vishal Verma <tipbot@zytor.com>
Message-ID: <tip-5d96c9342c23ee1d084802dcf064caa67ecaa45b@git.kernel.org>
Cc:     linux-edac@vger.kernel.org, dave.jiang@intel.com,
        rjw@rjwysocki.net, stable@vger.kernel.org, tony.luck@intel.com,
        arnd@arndb.de, mingo@redhat.com, yazen.ghannam@amd.com,
        x86@kernel.org, dan.j.williams@intel.com, qiuxu.zhuo@intel.com,
        lenb@kernel.org, vishal.l.verma@intel.com, bp@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        omar.avelar@intel.com, zwisler@kernel.org, mingo@kernel.org,
        hpa@zytor.com
Reply-To: arnd@arndb.de, mingo@redhat.com, tony.luck@intel.com,
          yazen.ghannam@amd.com, dave.jiang@intel.com,
          linux-edac@vger.kernel.org, stable@vger.kernel.org,
          rjw@rjwysocki.net, zwisler@kernel.org, tglx@linutronix.de,
          omar.avelar@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, dan.j.williams@intel.com,
          x86@kernel.org, lenb@kernel.org, bp@suse.de,
          vishal.l.verma@intel.com, qiuxu.zhuo@intel.com
In-Reply-To: <20181026003729.8420-1-vishal.l.verma@intel.com>
References: <20181026003729.8420-1-vishal.l.verma@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] acpi/nfit, x86/mce: Handle only uncorrectable
 machine checks
Git-Commit-ID: 5d96c9342c23ee1d084802dcf064caa67ecaa45b
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

Commit-ID:  5d96c9342c23ee1d084802dcf064caa67ecaa45b
Gitweb:     https://git.kernel.org/tip/5d96c9342c23ee1d084802dcf064caa67ecaa45b
Author:     Vishal Verma <vishal.l.verma@intel.com>
AuthorDate: Thu, 25 Oct 2018 18:37:28 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 6 Nov 2018 19:13:10 +0100

acpi/nfit, x86/mce: Handle only uncorrectable machine checks

The MCE handler for nfit devices is called for memory errors on a
Non-Volatile DIMM and adds the error location to a 'badblocks' list.
This list is used by the various NVDIMM drivers to avoid consuming known
poison locations during IO.

The MCE handler gets called for both corrected and uncorrectable errors.
Until now, both kinds of errors have been added to the badblocks list.
However, corrected memory errors indicate that the problem has already
been fixed by hardware, and the resulting interrupt is merely a
notification to Linux.

As far as future accesses to that location are concerned, it is
perfectly fine to use, and thus doesn't need to be included in the above
badblocks list.

Add a check in the nfit MCE handler to filter out corrected mce events,
and only process uncorrectable errors.

Fixes: 6839a6d96f4e ("nfit: do an ARS scrub on hitting a latent media error")
Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dan Williams <dan.j.williams@intel.com>
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
Link: http://lkml.kernel.org/r/20181026003729.8420-1-vishal.l.verma@intel.com
---
 arch/x86/include/asm/mce.h       | 1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
 drivers/acpi/nfit/mce.c          | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4da9b1c58d28..dbd9fe2f6163 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -221,6 +221,7 @@ static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c) { return mce_am
 
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
+bool mce_is_correctable(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 8c66d2fc8f81..77527b8ea982 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -534,7 +534,7 @@ bool mce_is_memory_error(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
-static bool mce_is_correctable(struct mce *m)
+bool mce_is_correctable(struct mce *m)
 {
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
 		return false;
@@ -547,6 +547,7 @@ static bool mce_is_correctable(struct mce *m)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(mce_is_correctable);
 
 static bool cec_add_mce(struct mce *m)
 {
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index e9626bf6ca29..7a51707f87e9 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -25,8 +25,8 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_spa *nfit_spa;
 
-	/* We only care about memory errors */
-	if (!mce_is_memory_error(mce))
+	/* We only care about uncorrectable memory errors */
+	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
 		return NOTIFY_DONE;
 
 	/*
