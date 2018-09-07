Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A618C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAD320645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAD320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeIHCHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:07:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeIHCHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:07:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A575DEF6;
        Fri,  7 Sep 2018 21:24:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.18 145/145] arm64: mm: always enable CONFIG_HOLES_IN_ZONE
Date:   Fri,  7 Sep 2018 23:10:11 +0200
Message-Id: <20180907210914.322793793@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit f52bb98f5aded4c43e52f5ce19fb83f7261e9e73 upstream.

Commit 6d526ee26ccd ("arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA")
only enabled HOLES_IN_ZONE for NUMA systems because the NUMA code was
choking on the missing zone for nomap pages. This problem doesn't just
apply to NUMA systems.

If the architecture doesn't set HAVE_ARCH_PFN_VALID, pfn_valid() will
return true if the pfn is part of a valid sparsemem section.

When working with multiple pages, the mm code uses pfn_valid_within()
to test each page it uses within the sparsemem section is valid. On
most systems memory comes in MAX_ORDER_NR_PAGES chunks which all
have valid/initialised struct pages. In this case pfn_valid_within()
is optimised out.

Systems where this isn't true (e.g. due to nomap) should set
HOLES_IN_ZONE and provide HAVE_ARCH_PFN_VALID so that mm tests each
page as it works with it.

Currently non-NUMA arm64 systems can't enable HOLES_IN_ZONE, leading to
a VM_BUG_ON():

| page:fffffdff802e1780 is uninitialized and poisoned
| raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
| raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
| page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
| ------------[ cut here ]------------
| kernel BUG at include/linux/mm.h:978!
| Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[...]
| CPU: 1 PID: 25236 Comm: dd Not tainted 4.18.0 #7
| Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
| pstate: 40000085 (nZcv daIf -PAN -UAO)
| pc : move_freepages_block+0x144/0x248
| lr : move_freepages_block+0x144/0x248
| sp : fffffe0071177680
[...]
| Process dd (pid: 25236, stack limit = 0x0000000094cc07fb)
| Call trace:
|  move_freepages_block+0x144/0x248
|  steal_suitable_fallback+0x100/0x16c
|  get_page_from_freelist+0x440/0xb20
|  __alloc_pages_nodemask+0xe8/0x838
|  new_slab+0xd4/0x418
|  ___slab_alloc.constprop.27+0x380/0x4a8
|  __slab_alloc.isra.21.constprop.26+0x24/0x34
|  kmem_cache_alloc+0xa8/0x180
|  alloc_buffer_head+0x1c/0x90
|  alloc_page_buffers+0x68/0xb0
|  create_empty_buffers+0x20/0x1ec
|  create_page_buffers+0xb0/0xf0
|  __block_write_begin_int+0xc4/0x564
|  __block_write_begin+0x10/0x18
|  block_write_begin+0x48/0xd0
|  blkdev_write_begin+0x28/0x30
|  generic_perform_write+0x98/0x16c
|  __generic_file_write_iter+0x138/0x168
|  blkdev_write_iter+0x80/0xf0
|  __vfs_write+0xe4/0x10c
|  vfs_write+0xb4/0x168
|  ksys_write+0x44/0x88
|  sys_write+0xc/0x14
|  el0_svc_naked+0x30/0x34
| Code: aa1303e0 90001a01 91296421 94008902 (d4210000)
| ---[ end trace 1601ba47f6e883fe ]---

Remove the NUMA dependency.

Link: https://www.spinics.net/lists/arm-kernel/msg671851.html
Cc: <stable@vger.kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -754,7 +754,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 
 config HOLES_IN_ZONE
 	def_bool y
-	depends on NUMA
 
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz


