Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61525206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbeL0I5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:57:16 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:22258 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728748AbeL0I5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:57:16 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2018 03:57:14 EST
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 27 Dec
 2018 16:42:05 +0800
Received: from timguo-System-Product-Name.zhaoxin.com (10.29.8.54) by
 zxbjmbx2.zhaoxin.com (10.29.252.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1261.35; Thu, 27 Dec 2018 16:42:04 +0800
From:   David Wang <davidwang@zhaoxin.com>
To:     <rjw@rjwysocki.net>, <mingo@redhat.com>, <len.brown@intel.com>,
        <pavel@ucw.cz>, <tglx@linutronix.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-pm@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH v3] Optimize C3 entry on Centaur CPUs
Date:   Thu, 27 Dec 2018 16:41:50 +0800
Message-ID: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For new Centaur CPUs the ucode will take care of the preservation of cache coherence
between CPU cores in C-states regardless of how deep the C-states are. So, it is not
necessary to flush the caches in software befor entering C3. And this useless operation
will cause performance drop for the cores which share some caches with the idling core.  

Signed-off-by: David Wang <davidwang@zhaoxin.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Changes from v2 to v3:
*1, Replace "c->x86_mask" with "c->x86_stepping".

Changes from v1 to v2:
* 1, Add some Family/Model/Stepping contrains to let this patch only apply
* to new centaur CPUs.
* 2, The arbiter disable/enable operations maybe needed for old VIA/Centaur
* platform. So, delete "flags->bm_control=0" in patch v1.

---
 arch/x86/kernel/acpi/cstate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 158ad14..ed17640 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -51,6 +51,18 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
+	/*
+	* For all recent Centaur CPUs, the ucode will make sure that each
+	* core can keep cache coherence with each other while entering C3
+	* type state. So, set bm_check to 1 to indicate that the kernel
+	* need not execute a cache flush operation (WBINVD) when entering
+	* C3 type state.
+	*/
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
+		    c->x86_stepping >= 0x0e))
+			flags->bm_check = 1;
+	}
 }
 EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
 
-- 
1.9.1

