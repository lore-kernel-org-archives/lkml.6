Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6364C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C57A2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C57A2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeI0TFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:05:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:5056 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbeI0TFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:05:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 05:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="94275780"
Received: from shbuild888.sh.intel.com ([10.239.146.239])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2018 05:38:01 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH RFC] x86/earlyprintk: Don't fail the pciserial device with incorrect class code
Date:   Thu, 27 Sep 2018 20:43:20 +0800
Message-Id: <20180927124320.13419-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"pciserial" earlyprintk helps much on many modern x86 platforms,
but unfortunately there are some platforms whose PCI UART devices
have wrong PCI class code, which will be blocked by current check.

So loose the class code check by giving a warning message instead.
This should be fine, as a developer who can give the accurate
BDF should know whether it's a usable UART device.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/early_printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 5e801c8..abe1d08 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -265,7 +265,8 @@ static __init void early_pci_serial_init(char *s)
 	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
 	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
 	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */
-		return;
+		pr_warn("earlyprintk: classcode for pcidev %d:%d:%d shows it's not a UART like device, please check!\n",
+			bus, slot, func);
 
 	/*
 	 * Determine if it is IO or memory mapped
-- 
2.7.4

