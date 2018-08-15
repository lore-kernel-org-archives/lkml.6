Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17510C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5CA21569
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CA21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeHOX2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:28:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:7364 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeHOX2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:28:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 13:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,244,1531810800"; 
   d="scan'208";a="224930391"
Received: from rpedgeco-hp-z240-tower-workstation.jf.intel.com (HELO rpedgeco-DESK5.jf.intel.com) ([10.54.75.168])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2018 13:34:18 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 0/3] KASLR feature to randomize each loadable module
Date:   Wed, 15 Aug 2018 13:30:16 -0700
Message-Id: <1534365020-18943-1-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is V3 of the "KASLR feature to randomize each loadable module" patchset.
The purpose is to increase the randomization and also to make the modules
randomized in relation to each other instead of just the base, so that if one
module leaks the location of the others can't be inferred.

V3 is a code cleanup from the V2 I had sent out RFC. The performance and memory
usage is the same as V2, in summary:
 - Average allocation 2-4 times better than existing algorithm
 - Max allocation time usually faster than the existing algorithm
 - TLB flushes close to existing algorithm, within 1% for <1000 modules, 
 - Memory usage (for PTEs) usually ~1MB higher than existing algorithm
 - Average module capacity slightly reduced, in the range of 17000 for both

For runtime performance, a synthetic benchmark was run that does 5000000 BPF
JIT invocations each, from varying numbers of parallel processes, while the
kernel compiles sharing the same CPU to stand in for the cache impact of a real
workload. The seccomp filter invocations were just Jann Horn's seccomp filtering
test from this thread http://openwall.com/lists/kernel-hardening/2018/07/18/2,
except non-real time priority. The kernel was configured with KPTI and
retpoline, and pcid was disabled. There wasn't any significant difference
between the new and the old.


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


Rick Edgecombe (3):
  vmalloc: Add __vmalloc_node_try_addr function
  x86/modules: Increase randomization for modules
  vmalloc: Add debugfs modfraginfo

 arch/x86/include/asm/pgtable_64_types.h |   7 +
 arch/x86/kernel/module.c                | 163 ++++++++++++++++---
 include/linux/vmalloc.h                 |   3 +
 mm/vmalloc.c                            | 266 +++++++++++++++++++++++++++++++-
 4 files changed, 415 insertions(+), 24 deletions(-)

-- 
2.7.4

