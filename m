Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeEQKtv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:49:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61217 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeEQKtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:49:50 -0400
Message-Id: <cover.1526553552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/5] powerpc/lib: Optimisation of string functions (mainly for PPC32)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 17 May 2018 12:49:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie intend to optimise string functions for PPC32 in the
same spirit as already done on PPC64.

The first patch moves PPC32 specific functions from string.S into
a dedicated file named string_32.S
The second patch rewrites __clear_user() by using dcbz intruction
The third patch rewrites memcmp() to compare 32 bits words instead
of comparing byte per byte.
The fourth patch removes NUL size verification from the assembly
functions so that GCC can optimise them out when the size is constant
The last patch inlines memcmp() for constant sizes <= 16

As shown in each individual commit log, second, third and last patches
provides significant improvment.

Changes in v2:
- Moved out the patch removing the hot loop alignment on PPC32
- Squashed the changes related to NUL size verification in a single patch
- Reordered the patches in a more logical order
- Modified the inlining patch to avoid warning about impossibility to version symbols.

Christophe Leroy (5):
  powerpc/lib: move PPC32 specific functions out of string.S
  powerpc/lib: optimise 32 bits __clear_user()
  powerpc/lib: optimise PPC32 memcmp
  powerpc/lib: inline string functions NUL size verification
  powerpc/lib: inline memcmp() for small constant sizes

 arch/powerpc/include/asm/string.h      |  91 ++++++++++++++++++++-
 arch/powerpc/kernel/prom_init_check.sh |   2 +-
 arch/powerpc/lib/Makefile              |   5 +-
 arch/powerpc/lib/memcmp_64.S           |   8 ++
 arch/powerpc/lib/string.S              |  75 ++++-------------
 arch/powerpc/lib/string_32.S           | 145 +++++++++++++++++++++++++++++++++
 6 files changed, 259 insertions(+), 67 deletions(-)
 create mode 100644 arch/powerpc/lib/string_32.S

-- 
2.13.3
