Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E45320651
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfAJMUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:20:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfAJMUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:20:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3B47155AC;
        Thu, 10 Jan 2019 12:20:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C91235C72C;
        Thu, 10 Jan 2019 12:20:03 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, akpm@linux-foundation.org,
        bhe@redhat.com, dyoung@redhat.com, k-hagio@ab.jp.nec.com,
        anderson@redhat.com, linux-doc@vger.kernel.org
Subject: [PATCH 2/2 v6] kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date:   Thu, 10 Jan 2019 20:19:44 +0800
Message-Id: <20190110121944.6050-3-lijiang@redhat.com>
In-Reply-To: <20190110121944.6050-1-lijiang@redhat.com>
References: <20190110121944.6050-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 10 Jan 2019 12:20:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD machine with SME feature, makedumpfile tools need to know
whether the crashed kernel was encrypted or not. If SME is enabled
in the first kernel, the crashed kernel's page table(pgd/pud/pmd/pte)
contains the memory encryption mask, so makedumpfile needs to remove
the sme mask to obtain the true physical address.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..bc4108096b18 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -352,10 +352,13 @@ void machine_kexec(struct kimage *image)
 
 void arch_crash_save_vmcoreinfo(void)
 {
+	u64 sme_mask = sme_me_mask;
+
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
+	VMCOREINFO_NUMBER(sme_mask);
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.17.1

