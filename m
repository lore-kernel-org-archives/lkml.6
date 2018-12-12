Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475BC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D420672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021D420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLLAMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:12:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:56048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLAMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:12:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 16:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="282839396"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.141])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2018 16:12:07 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, luto@kernel.org, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        jeyu@kernel.org, namit@vmware.com, netdev@vger.kernel.org,
        ard.biesheuvel@linaro.org, jannh@google.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=200/4=5D=20Don=E2=80=99t=20leave=20executable=20TLB=20entries=20to=20freed=20pages?=
Date:   Tue, 11 Dec 2018 16:03:50 -0800
Message-Id: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
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

This v2 enables vfree to handle freeing memory with special permissions. So now
it can be done with no W^X window, centralizing the logic for this operation,
and also to do this with only one TLB flush on x86.

I'm not sure if the algorithm Andy Lutomirski suggested (to do the whole
teardown with one TLB flush) will work across other architectures or not, so it
is in an x86 arch breakout(arch_vunmap) in this version. The default arch_vunmap
implementation does what Nadav is proposing users of module_alloc do on tear
down so it should be unchanged in behavior, just centralized. The main
difference will be BPF teardown will now get an extra TLB flush on archs that
have set_memory_* defined from set_memory_nx in addition to set_memory_rw. On
x86, due to the more efficient arch version, it will be unchanged at one flush.

The logic enabling this behavior is plugged into kernel/module.c and bpf cross
arch pieces. So it should be enabled for all architectures for regular .ko
modules and bpf but the other module_alloc users will be unchanged for now.

I did find one small downside with this approach, and that is that there is
occasionally one extra directmap page split in modules tear down, since one of
the modules subsections is RW. The x86 arch_vunmap will set the RW directmap of
the pages not present, since it doesn't know the whole thing is not executable,
so sometimes this results in an splitting an extra large page because the paging
structure would have its first special permission. But on the plus side many TLB
flushes are reduced down to one (on x86 here, and likely others in the future).
The other usages of modules (bpf, etc) will not have RW subsections and so this
will not increase. So I am thinking its not a big downside for a few modules
compared to reducing TLB flushes, removing executable stale TLB entries and code
simplicity.

Todo:
 - Merge with Nadav Amit's patchset
 - Test on x86 32 bit with highmem
 - Plug into ftrace and kprobes implementations in Nadav's next version of his
   patchset

Changes since v1:
 - New efficient algorithm on x86 for tearing down executable RO memory and
   flag for this (Andy Lutomirski)
 - Have no W^X violating window on tear down (Nadav Amit)


Rick Edgecombe (4):
  vmalloc: New flags for safe vfree on special perms
  modules: Add new special vfree flags
  bpf: switch to new vmalloc vfree flags
  x86/vmalloc: Add TLB efficient x86 arch_vunmap

 arch/x86/include/asm/set_memory.h |  2 +
 arch/x86/mm/Makefile              |  3 +-
 arch/x86/mm/pageattr.c            | 11 +++--
 arch/x86/mm/vmalloc.c             | 71 ++++++++++++++++++++++++++++++
 include/linux/filter.h            | 26 +++++------
 include/linux/vmalloc.h           |  2 +
 kernel/bpf/core.c                 |  1 -
 kernel/module.c                   | 43 +++++-------------
 mm/vmalloc.c                      | 73 ++++++++++++++++++++++++++++---
 9 files changed, 173 insertions(+), 59 deletions(-)
 create mode 100644 arch/x86/mm/vmalloc.c

-- 
2.17.1

