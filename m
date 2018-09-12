Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88FC07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9050E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9050E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeIMECa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:02:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:63289 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725751AbeIMECS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:02:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 15:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="69545853"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2018 15:55:21 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org,
        alexei.starovoitov@gmail.com
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v5 0/4] KASLR feature to randomize each loadable module
Date:   Wed, 12 Sep 2018 15:55:36 -0700
Message-Id: <1536792940-8294-1-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is V5 of the "KASLR feature to randomize each loadable module" patchset.
The purpose is to increase the randomization and also to make the modules
randomized in relation to each other instead of just the base, so that if one
module leaks the location of the others can't be inferred.

V5 is the addition of a module_alloc micro benchmarking module. It can be used
to see the performance and module area capacity differences between module_alloc
algorithms. Because of the dataset of the module text section sizes is very
large, I replaced it with a heuristic that generates module sizes that roughly
approximate the real X86_64 modules. As a result the benchmarks are slightly
different. If there is any interest in the real dataset I am happy to send it
out.

Changes for V5:
 - Add module_alloc test module

Changes for V4:
 - Fix issue caused by KASAN, kmemleak being provided different allocation
   lengths (padding).
 - Avoid kmalloc until sure its needed in __vmalloc_node_try_addr.
 - Fixed issues reported by 0-day.

Changes for V3:
 - Code cleanup based on internal feedback. (thanks to Dave Hansen and Andriy
   Shevchenko)
 - Slight refactor of existing algorithm to more cleanly live along side new
   one.
 - BPF synthetic benchmark

Changes for V2:
 - New implementation of __vmalloc_node_try_addr based on the
   __vmalloc_node_range implementation, that only flushes TLB when needed.
 - Modified module loading algorithm to try to reduce the TLB flushes further.
 - Increase "random area" tries in order to increase the number of modules that
   can get high randomness.
 - Increase "random area" size to 2/3 of module area in order to increase the
  number of modules that can get high randomness.
 - Fix for 0day failures on other architectures.
 - Fix for wrong debugfs permissions. (thanks to Jann Horn)
 - Spelling fix. (thanks to Jann Horn)
 - Data on module_alloc performance and TLB flushes. (brought up by Kees Cook
   and Jann Horn)
 - Data on memory usage. (suggested by Jann)


Rick Edgecombe (4):
  vmalloc: Add __vmalloc_node_try_addr function
  x86/modules: Increase randomization for modules
  vmalloc: Add debugfs modfraginfo
  Kselftest for module text allocation benchmarking

 arch/x86/include/asm/pgtable_64_types.h       |   7 +
 arch/x86/kernel/module.c                      | 165 ++++++++--
 include/linux/vmalloc.h                       |   3 +
 lib/Kconfig.debug                             |  10 +
 lib/Makefile                                  |   1 +
 lib/test_mod_alloc.c                          | 446 ++++++++++++++++++++++++++
 mm/vmalloc.c                                  | 279 +++++++++++++++-
 tools/testing/selftests/bpf/test_mod_alloc.sh |  29 ++
 8 files changed, 915 insertions(+), 25 deletions(-)
 create mode 100644 lib/test_mod_alloc.c
 create mode 100755 tools/testing/selftests/bpf/test_mod_alloc.sh

-- 
2.7.4

