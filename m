Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E384ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDC220824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDC220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJZVGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:06:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:62629 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeJZVF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:05:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 05:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,427,1534834800"; 
   d="scan'208";a="103504873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 26 Oct 2018 05:28:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B82EF33A; Fri, 26 Oct 2018 15:28:57 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        willy@infradead.org, x86@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/3] Fix couple of issues with LDT remap for PTI
Date:   Fri, 26 Oct 2018 15:28:53 +0300
Message-Id: <20181026122856.66224-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset fixes issues with LDT remap for PTI:

 - Layout collision due to KASLR with 5-level paging;

 - Information leak via Meltdown-like attack;

Please review and consider applying.

v3:
 - Split out cleanup in map_ldt_struct() into a separate patch
v2:
 - Rebase to the Linus' tree
   + fix conflict with new documentation of kernel memory layout
   + fix few mistakes in layout documentation
 - Fix typo in commit message

Kirill A. Shutemov (3):
  x86/mm: Move LDT remap out of KASLR region on 5-level paging
  x86/ldt: Unmap PTEs for the slot before freeing LDT pages
  x86/ldt: Remove unused variable in map_ldt_struct()

 Documentation/x86/x86_64/mm.txt         | 34 +++++++-------
 arch/x86/include/asm/page_64_types.h    | 12 ++---
 arch/x86/include/asm/pgtable_64_types.h |  4 +-
 arch/x86/kernel/ldt.c                   | 59 ++++++++++++++++---------
 arch/x86/xen/mmu_pv.c                   |  6 +--
 5 files changed, 67 insertions(+), 48 deletions(-)

-- 
2.19.1

