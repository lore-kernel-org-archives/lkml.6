Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFC8C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8E4258BE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8E4258BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934137AbeGAST0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:19:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964982AbeGAQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:25:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 172ACACD;
        Sun,  1 Jul 2018 16:25:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.9 003/101] x86/mce: Check for alternate indication of machine check recovery on Skylake
Date:   Sun,  1 Jul 2018 18:20:49 +0200
Message-Id: <20180701160757.272123280@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit 4c5717da1d021cf368eabb3cb1adcaead56c0d1e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/quirks.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -643,12 +643,19 @@ static void quirk_intel_brickland_xeon_r
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


