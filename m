Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85249ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6C220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeGSXMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:12:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:12:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMQiJa2438908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:26:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMQhre2438905;
        Thu, 19 Jul 2018 15:26:43 -0700
Date:   Thu, 19 Jul 2018 15:26:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-9b3661cd7e5400689ed168a7275e75af333177e6@git.kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        bp@suse.de, pasha.tatashin@oracle.com, mingo@kernel.org,
        hpa@zytor.com
Reply-To: bp@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          bp@alien8.de, hpa@zytor.com, mingo@kernel.org,
          pasha.tatashin@oracle.com
In-Reply-To: <20180719205545.16512-11-pasha.tatashin@oracle.com>
References: <20180719205545.16512-11-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/CPU: Call detect_nopl() only on the BSP
Git-Commit-ID: 9b3661cd7e5400689ed168a7275e75af333177e6
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

Commit-ID:  9b3661cd7e5400689ed168a7275e75af333177e6
Gitweb:     https://git.kernel.org/tip/9b3661cd7e5400689ed168a7275e75af333177e6
Author:     Borislav Petkov <bp@alien8.de>
AuthorDate: Thu, 19 Jul 2018 16:55:29 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:39 +0200

x86/CPU: Call detect_nopl() only on the BSP

Make it use the setup_* variants and have it be called only on the BSP and
drop the call in generic_identify() - X86_FEATURE_NOPL will be replicated
to the APs through the forced caps. Helps to keep the mess at a manageable
level.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-11-pasha.tatashin@oracle.com

---
 arch/x86/kernel/cpu/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 71281ac43b15..46408a8cdf62 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1024,12 +1024,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
  * unless we can find a reliable way to detect all the broken cases.
  * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
  */
-static void detect_nopl(struct cpuinfo_x86 *c)
+static void detect_nopl(void)
 {
 #ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_clear_cpu_cap(X86_FEATURE_NOPL);
 #else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_force_cpu_cap(X86_FEATURE_NOPL);
 #endif
 }
 
@@ -1108,7 +1108,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
-	detect_nopl(c);
+	detect_nopl();
 }
 
 void __init early_cpu_init(void)
@@ -1206,8 +1206,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_model_name(c); /* Default name */
 
-	detect_nopl(c);
-
 	detect_null_seg_behavior(c);
 
 	/*
