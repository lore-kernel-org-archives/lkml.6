Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbeBVMPa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:15:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:35501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbeBVMP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:15:27 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/5] PPC32/ioremap: Use memblock API to check for RAM
Date: Thu, 22 Feb 2018 13:15:11 +0100
Message-Id: <20180222121516.23415-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gQsiFhYfVzo08wQtRSeqGLFC5PnJ/rvxEVNC2h7xNHlDQtAFmkx
 EmJj/14wlE1RWzIpOv7a1qI4ZyDMyTmP5V3V1JZmdYHpZ/XOjC9H1qsSdnafpwH6moBvXsB
 UymaJcgDTcaPdcC5gEOsrm7DzwNHbG39g/UpFS4ljNiQacQWwu+os+AKZH29ZSfd0Qp+114
 1UaplI1Uw27bB9AhP7UNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mRRVAmOKh9g=:+6id9Ow8zog9sAaku0cX5h
 MXETL2ANPYE3G4O7tq5/wKsLs2s6vUIOeq6oTx2HMLMyPLT9kD3phFqIo9jc/B2XcGNnpXYL/
 UvRiReyGckf+E7GQaTZaOWtQ+pXsHUiI7dSBh86SnuNKl6LqgttAkZzRvl67QC+22EW+3HuM6
 EFty/U6PYgE1t/c5CdqU1DQlga49m2yHzom499DgIUp0PjCTINyu4r+WJ4c33r8iVLCIvHUw7
 ko+yenNG6+abc1ANmMTaBwxgTjXzsCq83RoX6K3QqBDhpWGjxSO70zN9zrYCI0UX+IRoFO7SP
 JY/IhP1uyntD3WWRwjy/UXwKUhoBH2Il9engQe6N2E4hC9hiOrmxybVzPgJCY3OAuoQCEWcsW
 IwjyYjDpI/FvWOq7OBfFP8bKx1MWu1HVHRjQS8UhGM9tngmMDyNxNn1n2MkcHPVI5t5xjYNWM
 5Fw2CnZGm91yYnvQvM5q2NKJZCQyuvHzZzIjpQvubXpZ2CMjN1aOm2wdjFpWP6JOdMF0MZ3qL
 sZerGjNr7ycP566MnpT2p2klzelEOG4bvXQbgYF80LrrkW6Of+dPmbjP3tC6FIgmqg41LeEz4
 IRT72MPPqIyL05t0PS323Zbl+nkQo3MHXYC7rRroSKclrE+xqbrc/K/CvYKtVTiocswTfeZet
 9Pdge3XakFxIgl5gJrU84Td0uzX85NfDWwq99Lqd/c/eIpMptwUbwgPOLVSiBEuwthSt/Ti9c
 bKdPDw4d5aeKq9+A9AdKGJamlKXf7igasUefMGi4YmGoAPmJKB1s8trLng3Wh8JOaPiNsgSnh
 r6amVnG9Gc7+CBn7cFWGSHCUE2oi9K0r5mHqbOCD4LOiSl0lJg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset solves the same problem as my previous one[1] but follows
a rather different approach. Instead of implementing DISCONTIGMEM for
PowerPC32, I simply switched the "is this RAM" check in __ioremap_caller
to the existing page_is_ram function, and unified page_is_ram to search
memblock.memory on PPC64 and PPC32.

The intended result is, as before, that my Wii can allocate the MMIO
range of its GPIO controller, which was previously not possible, because
the reserved memory hack (__allow_ioremap_reserved) didn't affect the
API in kernel/resource.c.

Thanks to Christophe Leroy for reviewing the previous patchset.

[1]: https://www.spinics.net/lists/kernel/msg2726786.html

Jonathan Neuschäfer (5):
  powerpc: mm: Simplify page_is_ram by using memblock_is_memory
  powerpc: mm: Use memblock API for PPC32 page_is_ram
  powerpc/mm/32: Use page_is_ram to check for RAM
  powerpc: wii: Don't rely on the reserved memory hack
  powerpc/mm/32: Remove the reserved memory hack

 arch/powerpc/mm/init_32.c                |  5 -----
 arch/powerpc/mm/mem.c                    | 12 +-----------
 arch/powerpc/mm/mmu_decl.h               |  1 -
 arch/powerpc/mm/pgtable_32.c             |  4 +---
 arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
 5 files changed, 3 insertions(+), 33 deletions(-)

-- 
2.16.1
