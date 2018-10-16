Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E32921479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="okObfftN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E32921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeJQBOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbeJQBOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E43A20658;
        Tue, 16 Oct 2018 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710555;
        bh=xmqqmEsPA+Vs3GwsfXUvyaXEltPEQeWQkeGuaDmuQ3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okObfftNKp0BbEN7vZ0Zx+O0Adb/q5PsVQVq2cAC1WKfGC3EoNHAhv/2yN3XOaP4T
         WDNM/gWXCaK0z8dINBbHPvn0orONKStUIkgA5XUoWLbKBuqiSXiV6JPP9qX/cAUtYF
         eveCfdgaHJ3n/ne+cUhhqvdXeQMZZY5EYKzDqcKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 077/109] mm: Preserve _PAGE_DEVMAP across mprotect() calls
Date:   Tue, 16 Oct 2018 19:05:45 +0200
Message-Id: <20181016170529.077156063@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 4628a64591e6cee181237060961e98c615c33966 upstream.

Currently _PAGE_DEVMAP bit is not preserved in mprotect(2) calls. As a
result we will see warnings such as:

BUG: Bad page map in process JobWrk0013  pte:800001803875ea25 pmd:7624381067
addr:00007f0930720000 vm_flags:280000f9 anon_vma:          (null) mapping:ffff97f2384056f0 index:0
file:457-000000fe00000030-00000009-000000ca-00000001_2001.fileblock fault:xfs_filemap_fault [xfs] mmap:xfs_file_mmap [xfs] readpage:          (null)
CPU: 3 PID: 15848 Comm: JobWrk0013 Tainted: G        W          4.12.14-2.g7573215-default #1 SLE12-SP4 (unreleased)
Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0833.051120182255 05/11/2018
Call Trace:
 dump_stack+0x5a/0x75
 print_bad_pte+0x217/0x2c0
 ? enqueue_task_fair+0x76/0x9f0
 _vm_normal_page+0xe5/0x100
 zap_pte_range+0x148/0x740
 unmap_page_range+0x39a/0x4b0
 unmap_vmas+0x42/0x90
 unmap_region+0x99/0xf0
 ? vma_gap_callbacks_rotate+0x1a/0x20
 do_munmap+0x255/0x3a0
 vm_munmap+0x54/0x80
 SyS_munmap+0x1d/0x30
 do_syscall_64+0x74/0x150
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
...

when mprotect(2) gets used on DAX mappings. Also there is a wide variety
of other failures that can result from the missing _PAGE_DEVMAP flag
when the area gets used by get_user_pages() later.

Fix the problem by including _PAGE_DEVMAP in a set of flags that get
preserved by mprotect(2).

Fixes: 69660fd797c3 ("x86, mm: introduce _PAGE_DEVMAP")
Fixes: ebd31197931d ("powerpc/mm: Add devmap support for ppc64")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/book3s/64/pgtable.h |    4 ++--
 arch/x86/include/asm/pgtable_types.h         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -102,7 +102,7 @@
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | H_PAGE_THP_HUGE | _PAGE_PTE | \
-			 _PAGE_SOFT_DIRTY)
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 /*
  * user access blocked by key
  */
@@ -120,7 +120,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
-			 _PAGE_SOFT_DIRTY)
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 /*
  * Mask of bits returned by pte_pgprot()
  */
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -124,7 +124,7 @@
  */
 #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
 			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY)
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
 /*


