Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8910320834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8910320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeK2TPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:15:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeK2TPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:15:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51B9231256A7;
        Thu, 29 Nov 2018 08:11:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EE3161084;
        Thu, 29 Nov 2018 08:10:33 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, ard.biesheuvel@linaro.org,
        tony.luck@intel.com, fenghua.yu@intel.com, dyoung@redhat.com,
        bhe@redhat.com
Subject: [PATCH 2/2 v8] x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table
Date:   Thu, 29 Nov 2018 16:09:56 +0800
Message-Id: <20181129080956.20776-3-lijiang@redhat.com>
In-Reply-To: <20181129080956.20776-1-lijiang@redhat.com>
References: <20181129080956.20776-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 29 Nov 2018 08:11:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, when use the kexec_file_load syscall to load the kernel image
and initramfs(for example: kexec -s -p xxx), kernel does not pass the e820
reserved ranges to the second kernel, which might cause two problems:

The first one is the MMCONFIG issue. The basic problem is that this device
is in PCI segment 1 and the kernel PCI probing can not find it without all
the e820 I/O reservations being present in the e820 table. And the kdump
kernel does not have those reservations because the kexec command does not
pass the I/O reservation via the "memmap=xxx" command line option. (This
problem does not show up for other vendors, as SGI is apparently the
actually fails for everyone, but devices in segment 0 are then found by
some legacy lookup method.) The workaround for this is to pass the I/O
reserved regions to the kdump kernel.

MMCONFIG(aka ECAM) space is described in the ACPI MCFG table. If you don't
have ECAM: (a) PCI devices won't work at all on non-x86 systems that use
only ECAM for config access, (b) you won't be albe to access devices on
non-0 segments, (c) you won't be able to access extended config space(
address 0x100-0xffff), which means none of the Extended Capabilities will
be available(AER, ACS, ATS, etc). [Bjorn's comment]

The second issue is that the SME kdump kernel doesn't work without the
e820 reserved ranges. When SME is active in kdump kernel, actually, those
reserved regions are still decrypted, but because those reserved ranges are
not present at all in kdump kernel e820 table, those reserved regions are
considered as encrypted, it goes wrong.

The e820 reserved range is useful in kdump kernel, so it is necessary to
pass the e820 reserved ranges to kdump kernel.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/crash.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f631a3f15587..5354a84f1684 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -380,6 +380,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1, &cmd,
 			memmap_entry_callback);
 
+	/* Add e820 reserved ranges */
+	cmd.type = E820_TYPE_RESERVED;
+	flags = IORESOURCE_MEM;
+	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
+			   memmap_entry_callback);
+
 	/* Add crashk_low_res region */
 	if (crashk_low_res.end) {
 		ei.addr = crashk_low_res.start;
-- 
2.17.1

