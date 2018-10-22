Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFF7C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633E20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8633E20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJVQEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeJVQEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:04:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5586D3082E4C;
        Mon, 22 Oct 2018 07:47:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8D256EE20;
        Mon, 22 Oct 2018 07:47:11 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, thomas.lendacky@amd.com,
        dyoung@redhat.com, bhe@redhat.com
Subject: [PATCH 0/2 v4] add reserved e820 ranges to the kdump kernel e820 table
Date:   Mon, 22 Oct 2018 15:47:05 +0800
Message-Id: <20181022074707.13901-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 22 Oct 2018 07:47:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

E820 reserved ranges is useful in kdump kernel, it has been added in
kexec-tools code.

One reason is PCI mmconf (extended mode) requires reserved region otherwise
it falls back to legacy mode.

Furthermore, when AMD SME kdump support, it needs to map dmi table area as
decrypted. For normal boot, these ranges sit in e820 reserved ranges, thus
the early ioremap code naturally map them as decrypted. If it also has same
e820 reserve setup in kdump kernel then it will just work like normal
kernel.

Kdump uses walk_iomem_res_desc to iterate resources, then adds matched desc
to e820 table for the kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types, we
need add exact e820 type to the kdump kernel e820 table, thus it also needs
an extra checking in memmap_entry_callback() to match the e820 type and
resource name.

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

Note:
1. The patches are made based on this branch:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

2. And you need to apply the follow patch before test kdump file_load,
   otherwise these patches won't work.
   commit <010a93bf97c7> "resource: Fix find_next_iomem_res() iteration
   issue"

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

