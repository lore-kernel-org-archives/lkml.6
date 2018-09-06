Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C389C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D491620652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D491620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeIFRAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:00:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIFRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:00:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86CP1PD292050
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 05:25:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86CP1wM292047;
        Thu, 6 Sep 2018 05:25:01 -0700
Date:   Thu, 6 Sep 2018 05:25:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chuanhua Lei <tipbot@zytor.com>
Message-ID: <tip-17f6bac2249356c795339e03a0742cd79be3cab8@git.kernel.org>
Cc:     rajvi.jingar@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
        chuanhua.lei@linux.intel.com, mingo@kernel.org,
        len.brown@intel.com, pasha.tatashin@microsoft.com
Reply-To: tglx@linutronix.de, douly.fnst@cn.fujitsu.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, rajvi.jingar@intel.com,
          pasha.tatashin@microsoft.com, len.brown@intel.com,
          mingo@kernel.org, chuanhua.lei@linux.intel.com
In-Reply-To: <1536228203-18701-1-git-send-email-chuanhua.lei@linux.intel.com>
References: <1536228203-18701-1-git-send-email-chuanhua.lei@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/tsc: Prevent result truncation on 32bit
Git-Commit-ID: 17f6bac2249356c795339e03a0742cd79be3cab8
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

Commit-ID:  17f6bac2249356c795339e03a0742cd79be3cab8
Gitweb:     https://git.kernel.org/tip/17f6bac2249356c795339e03a0742cd79be3cab8
Author:     Chuanhua Lei <chuanhua.lei@linux.intel.com>
AuthorDate: Thu, 6 Sep 2018 18:03:23 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 14:22:01 +0200

x86/tsc: Prevent result truncation on 32bit

Loops per jiffy is calculated by multiplying tsc_khz with 1e3 and then
dividing it by HZ.

Both tsc_khz and the temporary variable holding the multiplication result
are of type unsigned long, so on 32bit the result is truncated to the lower
32bit.

Use u64 as type for the temporary variable and cast tsc_khz to it before
multiplying.

[ tglx: Massaged changelog and removed pointless braces ]

Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")
Signed-off-by: Chuanhua Lei <chuanhua.lei@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: yixin.zhu@linux.intel.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@microsoft.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Link: https://lkml.kernel.org/r/1536228203-18701-1-git-send-email-chuanhua.lei@linux.intel.com

---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1463468ba9a0..6490f618e096 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1415,7 +1415,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 static unsigned long __init get_loops_per_jiffy(void)
 {
-	unsigned long lpj = tsc_khz * KHZ;
+	u64 lpj = (u64)tsc_khz * KHZ;
 
 	do_div(lpj, HZ);
 	return lpj;
