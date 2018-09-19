Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60DBECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77713206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77713206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbeISSbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5829 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbeISSbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D0E73084038;
        Wed, 19 Sep 2018 12:53:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B30F75D96E;
        Wed, 19 Sep 2018 12:53:33 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com
Subject: [PATCH 3/3 v2] x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table
Date:   Wed, 19 Sep 2018 20:52:51 +0800
Message-Id: <20180919125251.8181-4-lijiang@redhat.com>
In-Reply-To: <20180919125251.8181-1-lijiang@redhat.com>
References: <20180919125251.8181-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 19 Sep 2018 12:53:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E820 reserved ranges is useful in kdump kernel, we have added this in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region
otherwise it falls back to legacy mode.

When AMD SME kdump support, it needs to map dmi table area as unencrypted.
For normal boot these ranges sit in e820 reserved ranges thus the early
ioremap code naturally map them as unencrypted. So if we have same e820
reserve setup in kdump kernel then it will just work like normal kernel.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/crash.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index ae724a6e0a5f..3460be990e0c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -384,6 +384,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	/* Add all reserved ranges */
+	cmd.type = E820_TYPE_RESERVED;
+	walk_iomem_res_desc(IORES_DESC_NONE, 0, 0, -1, &cmd,
+			memmap_entry_callback);
+
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
-- 
2.17.1

