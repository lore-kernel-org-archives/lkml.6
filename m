Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425067AbeE1NRw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:17:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51860 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163251AbeE1KuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:01 -0400
Message-Id: <cover.1527503958.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 0/3] powerpc/lib: Optimisation of memcmp() and __clear_user() for PPC32 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 28 May 2018 10:49:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie intends to optimise memcmp() and __clear_user() for PPC32
in the same spirit as already done on PPC64.

The first patch moves PPC32 specific functions from string.S into
a dedicated file named string_32.S
The second patch rewrites __clear_user() by using dcbz intruction
The third patch rewrites memcmp() to compare 32 bits words instead
of comparing byte per byte.

As shown in each individual commit log, second and third patches
provide significant improvment.

Changes in v5:
- Removed the handling of Little Endian, as PPC32 kernel only support Big Endian
at the time being, and because unaligned accesses should be handled differently
in LE.

Changes in v4:
- In memcmp(), dropped the special handling for when length is 0. Handling it 
through the small length path.

Changes in v3:
- Fixed the sign of the result returned by memcmp() by using a logical
comparison of u32 words and returning -1, 0 or 1 instead of doing a substract.
- In first patch, replaced PPC_LCMPI by cmpwi
- Fixed licence in string_32.S
- Removed the two last patches from the serie. They will be handled later as
they require further tests and analysis to properly identify their real benefit
in all possible cases.

Changes in v2:
- Moved out the patch removing the hot loop alignment on PPC32
- Squashed the changes related to NUL size verification in a single patch
- Reordered the patches in a more logical order
- Modified the inlining patch to avoid warning about impossibility to version symbols.


Christophe Leroy (3):
  powerpc/lib: move PPC32 specific functions out of string.S
  powerpc/lib: optimise 32 bits __clear_user()
  powerpc/lib: optimise PPC32 memcmp

 arch/powerpc/lib/Makefile    |   5 +-
 arch/powerpc/lib/string.S    |  61 ---------------------
 arch/powerpc/lib/string_32.S | 124 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 63 deletions(-)
 create mode 100644 arch/powerpc/lib/string_32.S

-- 
2.13.3
