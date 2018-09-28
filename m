Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5961C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8362172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8362172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeI1P5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:57:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:14995 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbeI1P5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:57:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 02:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,314,1534834800"; 
   d="scan'208";a="74593779"
Received: from shbuild888.sh.intel.com ([10.239.146.239])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2018 02:34:47 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] x86/earlyprintk: Add a force option for pciserial device
Date:   Fri, 28 Sep 2018 17:40:08 +0800
Message-Id: <20180928094008.23138-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"pciserial" earlyprintk helps much on many modern x86 platforms,
but unfortunately there are still some platforms whose PCI UART
devices have wrong PCI class code, which will be blocked by current
class code check.

Add a option "force" so that developer could still use a UART device
even it has wrong class code, with format "",B:D.F,force,baud". And
the original format ",B:D.F,baud" is kept unchanged.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/early_printk.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 5e801c8..35d0f66 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -213,8 +213,10 @@ static unsigned int mem32_serial_in(unsigned long addr, int offset)
  * early_pci_serial_init()
  *
  * This function is invoked when the early_printk param starts with "pciserial"
- * The rest of the param should be ",B:D.F,baud" where B, D & F describe the
- * location of a PCI device that must be a UART device.
+ * The rest of the param should be ",B:D.F,baud" or ",B:D.F,force,baud", where
+ * B, D & F describe the location of a PCI device that must be a UART device,
+ * "force" is optional and means insisting using a UART device with a wrong
+ * pci class code.
  */
 static __init void early_pci_serial_init(char *s)
 {
@@ -224,6 +226,7 @@ static __init void early_pci_serial_init(char *s)
 	u32 classcode, bar0;
 	u16 cmdreg;
 	char *e;
+	int force = 0;
 
 
 	/*
@@ -252,6 +255,15 @@ static __init void early_pci_serial_init(char *s)
 	if (*s == ',')
 		s++;
 
+	/* User may insist to use a UART device with wrong class code */
+	if (!strncmp(s, "force", 5)) {
+		force = 1;
+		s += 5;
+
+		if (*s == ',')
+			s++;
+	}
+
 	/*
 	 * Second, find the device from the BDF
 	 */
@@ -262,10 +274,12 @@ static __init void early_pci_serial_init(char *s)
 	/*
 	 * Verify it is a UART type device
 	 */
-	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
-	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
-	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
-		return;
+	if (!force) {
+		if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
+		     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
+		   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
+			return;
+	}
 
 	/*
 	 * Determine if it is IO or memory mapped
-- 
2.7.4

