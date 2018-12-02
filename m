Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B660C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0862064A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0862064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeLBDRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbeLBDRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:17:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 933FC3DDB5;
        Sun,  2 Dec 2018 03:09:16 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 099985D9C9;
        Sun,  2 Dec 2018 03:09:06 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, akpm@linux-foundation.org,
        bhe@redhat.com, dyoung@redhat.com
Subject: [PATCH 2/2 v2] kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date:   Sun,  2 Dec 2018 11:08:39 +0800
Message-Id: <20181202030839.29945-3-lijiang@redhat.com>
In-Reply-To: <20181202030839.29945-1-lijiang@redhat.com>
References: <20181202030839.29945-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 02 Dec 2018 03:09:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For AMD machine with SME feature, makedumpfile tools need to know
whether the crash kernel was encrypted or not. If SME is enabled
in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
contains the memory encryption mask, so need to remove the sme mask
to obtain the true physical address.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..1860fe24117d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -352,10 +352,24 @@ void machine_kexec(struct kimage *image)
 
 void arch_crash_save_vmcoreinfo(void)
 {
+	u64 sme_mask = sme_me_mask;
+
 	VMCOREINFO_NUMBER(phys_base);
 	VMCOREINFO_SYMBOL(init_top_pgt);
 	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
 			pgtable_l5_enabled());
+	/*
+	 * Currently, the local variable 'sme_mask' stores the value of
+	 * sme_me_mask(bit 47), and also write the value of sme_mask to
+	 * the vmcoreinfo.
+	 * If need, the bit(sme_mask) might be redefined in the future,
+	 * but the 'bit63' will be reserved.
+	 * For example:
+	 * [ misc	   ][ enc bit  ][ other misc SME info       ]
+	 * 0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
+	 * 63   59   55   51   47   43   39   35   31   27   ... 3
+	 */
+	VMCOREINFO_NUMBER(sme_mask);
 
 #ifdef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(node_data);
-- 
2.17.1

