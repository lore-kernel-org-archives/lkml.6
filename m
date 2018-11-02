Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE66C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBF12082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBF12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeKCEie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:38:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:61248 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbeKCEie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:38:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 12:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,457,1534834800"; 
   d="scan'208";a="276669246"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2018 12:30:07 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     jeyu@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v8 0/4] KASLR feature to randomize each loadable module
Date:   Fri,  2 Nov 2018 12:25:16 -0700
Message-Id: <20181102192520.4522-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is V8 of the "KASLR feature to randomize each loadable module" patchset.
The purpose is to increase the randomization and also to make the modules
randomized in relation to each other instead of just the base, so that if one
module leaks the location of the others can't be inferred.

This version gets rid of the more complex, more LOC, new logic in vmalloc that
helped optimization around lazy the free area case, and hopefully makes this
patchset more straightforward. Earlier versions were concerned with efficiently
handling this case, but I have learned they are actually not common in real
world module loader usage. So instead there are some smaller tweaks to existing
vmalloc logic to allow an allocation to be tried without triggering a
purge_vmap_area_lazy() and retry, when it encounters a real (non lazy free)
area. The kselftest simulations have been updated with the logic of init
sections getting cleaned up as well.

There is a small allocation performance degradation versus v7 as a trade off, but
it is still faster on average than the existing algorithm until >7000 modules.

Changes for V8:
 - Simplify code by removing logic for optimum handling of lazy free areas

Changes for V7:
 - More 0-day build fixes, readability improvements (Kees Cook)

Changes for V6:
 - 0-day build fixes by removing un-needed functional testing, more error
   handling

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

 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kaslr_modules.h          |  38 ++
 arch/x86/include/asm/pgtable_64_types.h       |   7 +
 arch/x86/kernel/module.c                      | 111 ++++--
 include/linux/vmalloc.h                       |   3 +
 lib/Kconfig.debug                             |   9 +
 lib/Makefile                                  |   1 +
 lib/test_mod_alloc.c                          | 343 ++++++++++++++++++
 mm/vmalloc.c                                  | 228 ++++++++++--
 tools/testing/selftests/bpf/test_mod_alloc.sh |  29 ++
 10 files changed, 711 insertions(+), 61 deletions(-)
 create mode 100644 arch/x86/include/asm/kaslr_modules.h
 create mode 100644 lib/test_mod_alloc.c
 create mode 100755 tools/testing/selftests/bpf/test_mod_alloc.sh

-- 
2.17.1

