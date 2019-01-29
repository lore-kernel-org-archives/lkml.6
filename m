Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A56C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfA2VZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:25:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35659 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfA2VZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:25:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TLOwO32105831
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 13:24:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TLOvXa2105827;
        Tue, 29 Jan 2019 13:24:58 -0800
Date:   Tue, 29 Jan 2019 13:24:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-34d66caf251df91ff27b24a3a786810d29989eca@git.kernel.org>
Cc:     peterz@infradead.org, srinivas.eeda@oracle.com, tglx@linutronix.de,
        dwmw@amazon.co.uk, zhenzhong.duan@oracle.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        konrad.wilk@oracle.com, hpa@zytor.com, bp@suse.de
Reply-To: bp@suse.de, hpa@zytor.com, konrad.wilk@oracle.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, zhenzhong.duan@oracle.com, dwmw@amazon.co.uk,
          peterz@infradead.org, srinivas.eeda@oracle.com
In-Reply-To: <e2e064f2-e8ef-42ca-bf4f-76b612964752@default>
References: <e2e064f2-e8ef-42ca-bf4f-76b612964752@default>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] x86/speculation: Remove redundant
 arch_smt_update() invocation
Git-Commit-ID: 34d66caf251df91ff27b24a3a786810d29989eca
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

Commit-ID:  34d66caf251df91ff27b24a3a786810d29989eca
Gitweb:     https://git.kernel.org/tip/34d66caf251df91ff27b24a3a786810d29989eca
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Thu, 17 Jan 2019 02:10:59 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 22:20:24 +0100

x86/speculation: Remove redundant arch_smt_update() invocation

With commit a74cfffb03b7 ("x86/speculation: Rework SMT state change"),
arch_smt_update() is invoked from each individual CPU hotplug function.

Therefore the extra arch_smt_update() call in the sysfs SMT control is
redundant.

Fixes: a74cfffb03b7 ("x86/speculation: Rework SMT state change")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <konrad.wilk@oracle.com>
Cc: <dwmw@amazon.co.uk>
Cc: <bp@suse.de>
Cc: <srinivas.eeda@oracle.com>
Cc: <peterz@infradead.org>
Cc: <hpa@zytor.com>
Link: https://lkml.kernel.org/r/e2e064f2-e8ef-42ca-bf4f-76b612964752@default

---
 kernel/cpu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..c0c7f64573ed 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2090,10 +2090,8 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		cpuhp_offline_cpu_device(cpu);
 	}
-	if (!ret) {
+	if (!ret)
 		cpu_smt_control = ctrlval;
-		arch_smt_update();
-	}
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2104,7 +2102,6 @@ static int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
-	arch_smt_update();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
