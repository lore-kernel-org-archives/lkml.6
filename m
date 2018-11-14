Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A242BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758A32086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758A32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbeKNRbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:31:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKNRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:31:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D9EB308214B;
        Wed, 14 Nov 2018 07:29:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2FD103BAB7;
        Wed, 14 Nov 2018 07:29:27 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org,
        dyoung@redhat.com, bhe@redhat.com
Subject: [PATCH 0/2 v6] add reserved e820 ranges to the kdump kernel e820 table
Date:   Wed, 14 Nov 2018 15:29:24 +0800
Message-Id: <20181114072926.13312-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 14 Nov 2018 07:29:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, when use the kexec_file_load syscall to load the kernel image
and initramfs(for example: kexec -s -p xxx), the upstream kernel does not
pass the e820 reserved ranges to the second kernel, which might produce
two problems:

The first one is the MMCONFIG issue, although which does not make the
system crash or hang, this issue is still a potential risk, and also
might lead to the hot-plug device could not be recognized in kdump kernel.
Because the PCI MMCONFIG(extended mode) requires the reserved region
otherwise it falls back to legacy mode. For example, the kdump kernel
outputs the following log.

Example:
......
[   19.798354] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[   19.800653] [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
[   19.800995] PCI: not using MMCONFIG
......

The correct kernel log is like this:
......
[    0.082649] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.083610] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
......

The second issue is that the e820 reserved ranges do not setup in kdump
kernel, which will cause some functions that related to the e820 reserved
ranges to become invalid. For example:

early_memremap()->
early_memremap_pgprot_adjust()->
memremap_should_map_decrypted()->
e820__get_entry_type()

Please focus on these functions, early_memremap_pgprot_adjust() and
memremap_should_map_decrypted().

In the first kernel, these ranges sit in e820 reserved ranges, so the
memremap_should_map_decrypted() will return true, that is to say, the
reserved memory is decrypted, then the early_memremap_pgprot_adjust()
will call the pgprot_decrypted() to clear the memory encryption mask.

In the second kernel, because the e820 reserved ranges are not passed
to the second kernel, these ranges don't sit in the e820 reserved ranges,
so the memremap_should_map_decrypted() will return false, that is to say,
the reserved memory is encrypted, and then the early_memremap_pgprot_
adjust() will also call the pgprot_encrypted() to set the memory encryption
mask.

In fact, in the second kernel, the e820 reserved memory is still decrypted.
Obviously, it has gone wrong. So, this issue must be fixed, otherwise kdump
won't work in this case.

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

Lianbo Jiang (2):
  x86/kexec_file: add e820 entry in case e820 type string matches to io
    resource name
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/include/asm/e820/api.h |  2 ++
 arch/x86/kernel/crash.c         | 10 +++++++++-
 arch/x86/kernel/e820.c          |  2 +-
 kernel/resource.c               |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1

