Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ADCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61F12081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61F12081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbeKGO3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbeKGO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0EAB3082E10;
        Wed,  7 Nov 2018 05:00:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 358E31711B;
        Wed,  7 Nov 2018 05:00:24 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org,
        dyoung@redhat.com, bhe@redhat.com
Subject: [PATCH 0/2 v5] add reserved e820 ranges to the kdump kernel e820 table
Date:   Wed,  7 Nov 2018 13:00:17 +0800
Message-Id: <20181107050019.6663-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 07 Nov 2018 05:00:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E820 reserved ranges is useful in kdump kernel, it has been added in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region otherwise
it falls back to legacy mode, and also outputs the following kernel log.

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

Furthermore, when AMD SME kdump support, it needs to map dmi table area
as decrypted. For normal boot, these ranges sit in e820 reserved ranges,
thus the early ioremap code naturally map them as decrypted. If it also
has same e820 reserve setup in kdump kernel then it will just work like
normal kernel.

Kdump uses walk_iomem_res_desc to iterate resources, then adds matched
desc to e820 table for the kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types,
we need add exact e820 type to the kdump kernel e820 table, thus it also
needs an extra checking in memmap_entry_callback() to match the e820 type
and resource name.

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

