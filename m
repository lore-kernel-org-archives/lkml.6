Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B950ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C73B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C73B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeGXQJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGXQJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6OF2Vf0032218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Jul 2018 08:02:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6OF2UPS032215;
        Tue, 24 Jul 2018 08:02:30 -0700
Date:   Tue, 24 Jul 2018 08:02:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-d9e6dbcf28f383bf08e6a3180972f5722e514a54@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        len.brown@intel.com
Reply-To: peterz@infradead.org, len.brown@intel.com, tglx@linutronix.de,
          hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <d0c7129e509660be9ec6b233284b8d42d90659e8.1532207856.git.len.brown@intel.com>
References: <d0c7129e509660be9ec6b233284b8d42d90659e8.1532207856.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic: Future-proof the TSC_DEADLINE quirk for
 SKX
Git-Commit-ID: d9e6dbcf28f383bf08e6a3180972f5722e514a54
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

Commit-ID:  d9e6dbcf28f383bf08e6a3180972f5722e514a54
Gitweb:     https://git.kernel.org/tip/d9e6dbcf28f383bf08e6a3180972f5722e514a54
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Sat, 21 Jul 2018 17:19:19 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 24 Jul 2018 10:05:13 +0200

x86/apic: Future-proof the TSC_DEADLINE quirk for SKX

All SKX with stepping higher than 4 support the TSC_DEADLINE,
no matter the microcode version.

Without this patch, upcoming SKX steppings will not be able to use
their TSC_DEADLINE timer.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: <stable@kernel.org> # v4.14+
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 616dd5872e ("x86/apic: Update TSC_DEADLINE quirk with additional SKX stepping")
Link: http://lkml.kernel.org/r/d0c7129e509660be9ec6b233284b8d42d90659e8.1532207856.git.len.brown@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 2aabd4cb0e3f..adbda5847b14 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -573,6 +573,9 @@ static u32 skx_deadline_rev(void)
 	case 0x04: return 0x02000014;
 	}
 
+	if (boot_cpu_data.x86_stepping > 4)
+		return 0;
+
 	return ~0U;
 }
 
