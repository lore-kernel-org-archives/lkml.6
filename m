Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431672064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431672064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeH3C6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:58:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:60409 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeH3C6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:58:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 15:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,305,1531810800"; 
   d="scan'208";a="85609392"
Received: from rpedgeco-desk5.jf.intel.com ([10.54.75.168])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2018 15:59:41 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, daniel@iogearbox.net,
        jannh@google.com, keescook@chromium.org
Cc:     kristen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v4 0/3] KASLR feature to randomize each loadable module
Date:   Wed, 29 Aug 2018 15:59:36 -0700
Message-Id: <1535583579-6138-1-git-send-email-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of the "KASLR feature to randomize each loadable module" patchset.
The purpose is to increase the randomization and also to make the modules
randomized in relation to each other instead of just the base, so that if one
module leaks the location of the others can't be inferred. It is enabled for
x86_64 for now.

V4 is a few small fixes. I humbly think this is in pretty good shape at this
point, unless anyone has any comments. The only other big change I was
considering was moving the new randomization algorithm into vmalloc so it could
be re-used for other architectures or possibly other vmalloc usages.

A few words on how this was tested - As previously mentioned, the entropy
estimates were done using extracted module text sizes from the in-tree modules.
These were also used to run 100,000's of simulated module allocations by calling
module_alloc from a test module, including testing until allocation failure. The
simulations kept track of every allocation address to make sure there were no
collisions, and verified memory was actually mapped.

In addition the __vmalloc_node_try_addr function has a suite of unit tests that
verify for a bunch of edge cases that it:
 - Allows for allocations when it should
 - Reports the right error code if it collides with a lazy-free area or real
   allocation
 - Verifies it frees a lazy free area when it should

These synthetic tests were also how the performance metrics were gathered.

Changes for V4:
 - Fix issue caused by KASAN, kmemleak being provided different allocation
   lengths (padding).
 - Avoid kmalloc until sure its needed in __vmalloc_node_try_addr.
 - Fix for debug file hang when the last VA is a lazy purge area
 - Fixed issues reported by 0-day build system.

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
 arch/x86/kernel/module.c                | 165 ++++++++++++++++---
 include/linux/vmalloc.h                 |   3 +
 mm/vmalloc.c                            | 279 +++++++++++++++++++++++++++++++-
 4 files changed, 429 insertions(+), 25 deletions(-)

-- 
2.7.4

