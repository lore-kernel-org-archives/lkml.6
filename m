Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030548AbeEYVll (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:41:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:27064 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030291AbeEYVlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="202546707"
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/mce: Improve error message when kernel cannot recover.
Date: Fri, 25 May 2018 14:41:39 -0700
Message-Id: <4cc7c465150a9a48b8b9f45d0b840278e77eb9b5.1527283897.git.tony.luck@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1527283897.git.tony.luck@intel.com>
References: <cover.1527283897.git.tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: stable@vger.kernel.org # 4.6+
Signed-off-by: Tony Luck <tony.luck@intel.com>
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
-- 
2.17.0
