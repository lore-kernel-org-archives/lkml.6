Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87409C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5474620834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5474620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeK2TOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 14:14:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeK2TOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 14:14:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60BEB3001DAB;
        Thu, 29 Nov 2018 08:10:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8197B60CCF;
        Thu, 29 Nov 2018 08:10:02 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, ard.biesheuvel@linaro.org,
        tony.luck@intel.com, fenghua.yu@intel.com, dyoung@redhat.com,
        bhe@redhat.com
Subject: [PATCH 0/2 v8] add reserved e820 ranges to the kdump kernel e820 table
Date:   Thu, 29 Nov 2018 16:09:54 +0800
Message-Id: <20181129080956.20776-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 29 Nov 2018 08:10:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did two things:
a). add a new I/O resource descriptor 'IORES_DESC_RESERVED'

When doing kexec_file_load, the first kernel needs to pass the e820
reserved ranges to the second kernel. But kernel can not exactly
match the e820 reserved ranges when walking through the iomem resources
with the descriptor 'IORES_DESC_NONE', because several e820 types(
e.g. E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
_TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'. It
may pass these four types to the kdump kernel, that is not desired result.

So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
for the iomem resources search interfaces. It is helpful to exactly
match the reserved resource ranges when walking through iomem resources.

In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
these code originally related to the descriptor 'IORES_DESC_NONE' need to
be updated. Otherwise, it will be easily confused and also cause some
errors. Because the 'E820_TYPE_RESERVED' type is converted to the new
descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
changed.

b). add the e820 reserved ranges to kdump kernel e820 table

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

Changes since v1:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.

Changes since v2:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.
2. Modified the invalid SOB chain issue.

Changes since v3:
1. Dropped [PATCH 1/3 v3] resource: fix an error which walks through iomem
   resources. Please refer to this commit <010a93bf97c7> "resource: Fix
   find_next_iomem_res() iteration issue"

Changes since v4:
1. Improve the patch log, and add kernel log.

Changes since v5:
1. Rewrite these patches log.

Changes since v6:
1. Modify the [PATCH 1/2], and add the new I/O resource descriptor
   'IORES_DESC_RESERVED' for the iomem resources search interfaces,
   and also updates these codes relates to 'IORES_DESC_NONE'.
2. Modify the [PATCH 2/2], and walk through io resource based on the
   new descriptor 'IORES_DESC_RESERVED'.
3. Update patch log.

Changes since v7:
1. Improve patch log.
2. Improve this function __ioremap_check_desc_other().
3. Modify code comment in the __ioremap_check_desc_other()


Lianbo Jiang (2):
  resource: add the new I/O resource descriptor 'IORES_DESC_RESERVED'
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/ia64/kernel/efi.c  |  4 ++++
 arch/x86/kernel/crash.c |  6 ++++++
 arch/x86/kernel/e820.c  |  2 +-
 arch/x86/mm/ioremap.c   | 13 ++++++++++++-
 include/linux/ioport.h  |  1 +
 kernel/resource.c       |  6 +++---
 6 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.17.1

