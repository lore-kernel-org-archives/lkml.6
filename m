Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B92C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F192075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F192075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIFOtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:49:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:24700 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbeIFOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:49:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 03:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,337,1531810800"; 
   d="scan'208";a="68817721"
Received: from unknown (HELO localhost) ([10.226.45.167])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2018 03:14:03 -0700
From:   Chuanhua Lei <chuanhua.lei@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/tsc: Fix 32bit mode issue in get_loops_per_jiffy()
Date:   Thu,  6 Sep 2018 18:03:23 +0800
Message-Id: <1536228203-18701-1-git-send-email-chuanhua.lei@linux.intel.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpj returns as zero which is not expected in 32 bit mode
After disassembling the code,
0xc1239a9e <+199>:   imul   $0x3e8,0xc12296e4,%edx
0xc1239aa8 <+209>:   xor    %ecx,%ecx
0xc1239aaa <+211>:   test   %edx,%edx
0xc1239aac <+213>:   mov    %eax,%ebx
0xc1239aae <+215>:   je     0xc1239abd <tsc_init+230>
0xc1239ab0 <+217>:   mov    $0x64,%ecx
0xc1239ab5 <+222>:   mov    %edx,%eax
0xc1239ab7 <+224>:   xor    %edx,%edx
0xc1239ab9 <+226>:   div    %ecx
0xc1239abb <+228>:   mov    %eax,%ecx
0xc1239abd <+230>:   mov    %ebx,%eax
0xc1239abf <+232>:   mov    $0x64,%ebx
0xc1239ac4 <+237>:   div    %ebx
0xc1239ac6 <+239>:   mov    %ecx,%edx

imul will load the result into %edx, %edx supposed to be high 32 bit
which is not zero. It should be zero in this case. Both lpj and tsc_khz
should be u64 to work properly for both 32 bit and 64 bit mode.

Signed-off-by: Chuanhua Lei <chuanhua.lei@linux.intel.com>
---

 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1463468..b346e3f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1415,7 +1415,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 static unsigned long __init get_loops_per_jiffy(void)
 {
-	unsigned long lpj = tsc_khz * KHZ;
+	u64 lpj = ((u64)tsc_khz * KHZ);
 
 	do_div(lpj, HZ);
 	return lpj;
-- 
2.7.5

