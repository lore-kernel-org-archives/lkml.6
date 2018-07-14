Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B81ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2434420834
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2434420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeGNHpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 03:45:51 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:53518 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeGNHpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 03:45:51 -0400
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2018 03:45:50 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id BE2D81FB49ECDDA463A5;
        Sat, 14 Jul 2018 15:11:32 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6E7BRNv076341;
        Sat, 14 Jul 2018 15:11:27 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071415113754-370504 ;
          Sat, 14 Jul 2018 15:11:37 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH v2] kvmclock: fix nested guest always in tsc_early clocksource
Date:   Sat, 14 Jul 2018 23:28:29 +0800
Message-Id: <1531582109-73498-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-14 15:11:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-14 15:11:08,
        Serialize complete at 2018-07-14 15:11:08
X-MAIL: mse01.zte.com.cn w6E7BRNv076341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nested guest tsc_read_refs always return ULLONG_MAX, and that will
call tsc_refine_calibration_work periodly. So nested guest will read
acpi timer port 0x608 periodly.

The patch set X86_FEATURE_TSC_KNOWN_FREQ for kvmclock to avoid
'refine' operation.

Thanks for PeterZijlstra's advice.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kernel/kvmclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8b26c9e..fc1562e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -138,6 +138,7 @@ static unsigned long kvm_get_tsc_khz(void)
 	src = &hv_clock[cpu].pvti;
 	tsc_khz = pvclock_tsc_khz(src);
 	put_cpu();
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return tsc_khz;
 }
 
-- 
1.8.3.1

