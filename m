Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F978C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418EB204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418EB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeK1Ldq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:33:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:49268 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeK1Ldq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:33:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 16:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="91641474"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.128])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2018 16:34:06 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, luto@kernel.org, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, netdev@vger.kernel.org, ard.biesheuvel@linaro.org,
        jannh@google.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: =?UTF-8?q?=5BPATCH=200/2=5D=20Don=E2=80=99t=20leave=20executable=20TLB=20entries=20to=20freed=20pages?=
Date:   Tue, 27 Nov 2018 16:07:52 -0800
Message-Id: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when memory is freed via the module subsystem, an executable
permissioned TLB entry can remain to a freed page. If the page is re-used to
back an address that will receive data from userspace, it can result in user
data being mapped as executable in the kernel. The root of this behavior is
vfree lazily flushing the TLB, but not lazily freeing the underlying pages. 

There are sort of three categories of this which show up across modules, bpf,
kprobes and ftrace:

1. When executable memory is touched and then immediatly freed

   This shows up in a couple error conditions in the module loader and BPF JIT
   compiler.

2. When executable memory is set to RW right before being freed

   In this case (on x86 and probably others) there will be a TLB flush when its
   set to RW and so since the pages are not touched between setting the
   flush and the free, it should not be in the TLB in most cases. So this
   category is not as big of a concern. However, techinically there is still a
   race where an attacker could try to keep it alive for a short window with a
   well timed out-of-bound read or speculative read, so ideally this could be
   blocked as well.

3. When executable memory is freed in an interrupt

   At least one example of this is the freeing of init sections in the module
   loader. Since vmalloc reuses the allocation for the work queue linked list
   node for the deferred frees, the memory actually gets touched as part of the
   vfree operation and so returns to the TLB even after the flush from resetting
   the permissions.

I have only actually tested category 1, and identified 2 and 3 just from reading
the code.

To catch all of these, module_alloc for x86 is changed to use a new flag that
instructs the unmap operation to flush the TLB before freeing the pages.

If this solution seems good I can plug the flag in for other architectures that
define PAGE_KERNEL_EXEC.


Rick Edgecombe (2):
  vmalloc: New flag for flush before releasing pages
  x86/modules: Make x86 allocs to flush when free

 arch/x86/kernel/module.c |  4 ++--
 include/linux/vmalloc.h  |  1 +
 mm/vmalloc.c             | 13 +++++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.17.1

