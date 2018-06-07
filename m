Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rhH9D36UGVuzXQAAmS7hNA
	; Thu, 07 Jun 2018 20:25:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EB428608BA; Thu,  7 Jun 2018 20:25:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5433360290;
	Thu,  7 Jun 2018 20:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5433360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932529AbeFGUZB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:25:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeFGUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:24:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w57KOoiE2322738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 13:24:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w57KOobP2322735;
        Thu, 7 Jun 2018 13:24:50 -0700
Date: Thu, 7 Jun 2018 13:24:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-c7d606f560e4c698884697fef503e4abacdd8c25@git.kernel.org>
Cc: tony.luck@intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        dan.j.williams@intel.com, bp@suse.de, tglx@linutronix.de,
        qiuxu.zhuo@intel.com
Reply-To: qiuxu.zhuo@intel.com, bp@suse.de, tglx@linutronix.de,
          ashok.raj@intel.com, linux-kernel@vger.kernel.org,
          dan.j.williams@intel.com, tony.luck@intel.com, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <4cc7c465150a9a48b8b9f45d0b840278e77eb9b5.1527283897.git.tony.luck@intel.com>
References: <4cc7c465150a9a48b8b9f45d0b840278e77eb9b5.1527283897.git.tony.luck@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/urgent] x86/mce: Improve error message when kernel cannot
 recover
Git-Commit-ID: c7d606f560e4c698884697fef503e4abacdd8c25
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

Commit-ID:  c7d606f560e4c698884697fef503e4abacdd8c25
Gitweb:     https://git.kernel.org/tip/c7d606f560e4c698884697fef503e4abacdd8c25
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Fri, 25 May 2018 14:41:39 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 7 Jun 2018 22:22:12 +0200

x86/mce: Improve error message when kernel cannot recover

Since we added support to add recovery from some errors inside the kernel in:

commit b2f9d678e28c ("x86/mce: Check for faults tagged in EXTABLE_CLASS_FAULT exception table entries")

we have done a less than stellar job at reporting the cause of recoverable
machine checks that occur in other parts of the kernel. The user just gets
the unhelpful message:

	mce: [Hardware Error]: Machine check: Action required: unknown MCACOD

doubly unhelpful when they check the manual for the reported IA32_MSR_STATUS.MCACOD
and see that it is listed as one of the standard recoverable values.

Add an extra rule to the MCE severity table to catch this case and report it
as:

	mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel

Fixes: b2f9d678e28c ("x86/mce: Check for faults tagged in EXTABLE_CLASS_FAULT exception table entries")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org # 4.6+
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/4cc7c465150a9a48b8b9f45d0b840278e77eb9b5.1527283897.git.tony.luck@intel.com

---
 arch/x86/kernel/cpu/mcheck/mce-severity.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index 5bbd06f38ff6..f34d89c01edc 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -160,6 +160,11 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
 		USER
 		),
+	MCESEV(
+		PANIC, "Data load in unrecoverable area of kernel",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
+		KERNEL
+		),
 #endif
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",
