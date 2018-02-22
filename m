Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeBVMRb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:17:31 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:63181 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeBVMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:17:30 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w1MCFdUD020774
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        linux-m68k@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 0/5] linux/const.h: cleanups of macros such as UL(), _BITUL(), BIT() etc.
Date: Thu, 22 Feb 2018 21:15:10 +0900
Message-Id: <1519301715-31798-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ARM, ARM64, UniCore32 define UL() as a shorthand of _AC(..., UL).
More architectures may introduce it in the future.

UL() is arch-agnostic, and useful. So let's move it to
include/linux/const.h

Currently, <asm/memory.h> must be included to use UL().
It pulls in more bloats just for defining some bit macros.

I posted V2 one year ago.

The previous posts are:
https://patchwork.kernel.org/patch/9498273/
https://patchwork.kernel.org/patch/9498275/
https://patchwork.kernel.org/patch/9498269/
https://patchwork.kernel.org/patch/9498271/

At that time, what blocked this series was a comment from
David Howells:
  You need to be very careful doing this.  Some userspace stuff
  depends on the guard macro names on the kernel header files.

(https://patchwork.kernel.org/patch/9498275/)

Looking at the code closer, I noticed this is not a problem.

See the following line.
https://github.com/torvalds/linux/blob/v4.16-rc2/scripts/headers_install.sh#L40

scripts/headers_install.sh rips off _UAPI prefix from guard macro names.

I ran "make headers_install" and confirmed the result is what I expect.

So, we can prefix the include guard of include/uapi/linux/const.h,
and add a new include/linux/const.h.



Masahiro Yamada (5):
  linux/const.h: prefix include guard of uapi/linux/const.h with _UAPI
  m68k: rename UL() to TO_UL()
  linux/const.h: move UL() macro to include/linux/const.h
  linux/const.h: refactor _BITUL and _BITULL a bit
  linux/const.h: move BIT(_ULL) to linux/const.h for use in assembly

 arch/arm/include/asm/memory.h       |  6 ------
 arch/arm64/include/asm/memory.h     |  6 ------
 arch/m68k/mm/init.c                 |  6 +++---
 arch/unicore32/include/asm/memory.h |  6 ------
 include/linux/bitops.h              |  3 +--
 include/linux/const.h               | 12 ++++++++++++
 include/uapi/linux/const.h          | 13 ++++++++-----
 7 files changed, 24 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/const.h

-- 
2.7.4
