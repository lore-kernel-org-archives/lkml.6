Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BR2qD0+UGVvCXQAAmS7hNA
	; Thu, 07 Jun 2018 20:25:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 005A36074D; Thu,  7 Jun 2018 20:25:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 65BC060290;
	Thu,  7 Jun 2018 20:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65BC060290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbeFGUZe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:25:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeFGUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:25:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w57KPJXq2322818
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 13:25:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w57KPJPM2322815;
        Thu, 7 Jun 2018 13:25:19 -0700
Date: Thu, 7 Jun 2018 13:25:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-4c5717da1d021cf368eabb3cb1adcaead56c0d1e@git.kernel.org>
Cc: tglx@linutronix.de, dan.j.williams@intel.com, bp@suse.de,
        mingo@kernel.org, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, qiuxu.zhuo@intel.com,
        tony.luck@intel.com, hpa@zytor.com
Reply-To: tony.luck@intel.com, hpa@zytor.com, qiuxu.zhuo@intel.com,
          linux-kernel@vger.kernel.org, ashok.raj@intel.com,
          mingo@kernel.org, bp@suse.de, dan.j.williams@intel.com,
          tglx@linutronix.de
In-Reply-To: <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
References: <03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/urgent] x86/mce: Check for alternate indication of machine
 check recovery on Skylake
Git-Commit-ID: 4c5717da1d021cf368eabb3cb1adcaead56c0d1e
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

Commit-ID:  4c5717da1d021cf368eabb3cb1adcaead56c0d1e
Gitweb:     https://git.kernel.org/tip/4c5717da1d021cf368eabb3cb1adcaead56c0d1e
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Fri, 25 May 2018 14:42:09 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 7 Jun 2018 22:22:12 +0200

x86/mce: Check for alternate indication of machine check recovery on Skylake

Currently we just check the "CAPID0" register to see whether the CPU
can recover from machine checks.

But there are also some special SKUs which do not have all advanced
RAS features, but do enable machine check recovery for use with NVDIMMs.

Add a check for any of bits {8:5} in the "CAPID5" register (each
reports some NVDIMM mode available, if any of them are set, then
the system supports memory machine check recovery).

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org # 4.9
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/03cbed6e99ddafb51c2eadf9a3b7c8d7a0cc204e.1527283897.git.tony.luck@intel.com

---
 arch/x86/kernel/quirks.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 697a4ce04308..736348ead421 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -645,12 +645,19 @@ static void quirk_intel_brickland_xeon_ras_cap(struct pci_dev *pdev)
 /* Skylake */
 static void quirk_intel_purley_xeon_ras_cap(struct pci_dev *pdev)
 {
-	u32 capid0;
+	u32 capid0, capid5;
 
 	pci_read_config_dword(pdev, 0x84, &capid0);
+	pci_read_config_dword(pdev, 0x98, &capid5);
 
-	if ((capid0 & 0xc0) == 0xc0)
+	/*
+	 * CAPID0{7:6} indicate whether this is an advanced RAS SKU
+	 * CAPID5{8:5} indicate that various NVDIMM usage modes are
+	 * enabled, so memory machine check recovery is also enabled.
+	 */
+	if ((capid0 & 0xc0) == 0xc0 || (capid5 & 0x1e0))
 		static_branch_inc(&mcsafe_key);
+
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0ec3, quirk_intel_brickland_xeon_ras_cap);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, quirk_intel_brickland_xeon_ras_cap);
