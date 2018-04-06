Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeDFU57 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:57:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:19573 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeDFU56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:57:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31340123"
Subject: [PATCH 00/11] [v5] Use global pages with PTI
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        keescook@google.com, hughd@google.com, jgross@suse.com, x86@kernel.org,
        namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Apr 2018 13:55:01 -0700
Message-Id: <20180406205501.24A1A4E7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4
 * Fix compile error reported by Tom Lendacky
 * Avoid setting _PAGE_GLOBAL on non-present entries

Changes from v3:
 * Fix whitespace issue noticed by willy
 * Clarify comments about X86_FEATURE_PGE checks
 * Clarify commit message around the necessity of _PAGE_GLOBAL
   filtering when CR4.PGE=0 or PGE is unsupported.

Changes from v2:

 * Add performance numbers to changelogs
 * Fix compile error resulting from use of x86-specific
   __default_kernel_pte_mask in arch-generic mm/early_ioremap.c
 * Delay kernel text cloning until after we are done messing
   with it (patch 11).
 * Blacklist K8 explicitly from mapping all kernel text as
   global (this should never happen because K8 does not use
   pti when pti=auto, but we on the safe side). (patch 11)

--

The later versions of the KAISER patches (pre-PTI) allowed the
user/kernel shared areas to be GLOBAL.  The thought was that this would
reduce the TLB overhead of keeping two copies of these mappings.

During the switch over to PTI, we seem to have lost our ability to have
GLOBAL mappings.  This adds them back.

To measure the benefits of this, I took a modern Atom system without
PCIDs and ran a microbenchmark[1] (higher is better):

No Global Lines (baseline  ): 6077741 lseeks/sec
88 Global Lines (kern entry): 7528609 lseeks/sec (+23.9%)
94 Global Lines (all ktext ): 8433111 lseeks/sec (+38.8%)

On a modern Skylake desktop with PCIDs, the benefits are tangible, but not
huge:

No Global pages (baseline): 15783951 lseeks/sec
28 Global pages (this set): 16054688 lseeks/sec
                             +270737 lseeks/sec (+1.71%)

I also double-checked with a kernel compile on the Skylake system (lower
is better):

No Global pages (baseline): 186.951 seconds time elapsed  ( +-  0.35% )
28 Global pages (this set): 185.756 seconds time elapsed  ( +-  0.09% )
                             -1.195 seconds (-0.64%)

1. https://github.com/antonblanchard/will-it-scale/blob/master/tests/lseek1.c

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Nadav Amit <namit@vmware.com>
