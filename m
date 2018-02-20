Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeBTQQR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:16:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:40119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbeBTQQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:16:16 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/6] DISCONTIGMEM support for PPC32
Date: Tue, 20 Feb 2018 17:14:18 +0100
Message-Id: <20180220161424.5421-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:P3Zn9VFYRabmV2qaGHNDR/yE3vsO1btaPGbd3lic3FQ8OMgGLK0
 6pTRW/lZIXeQlrehMBJk7mIlJzfhhYFwWWsmzsjJ1sDnZMPPaj+dY1yMIlyudli/hrrgb7x
 q+CqTnGo3fU5L689dcViIzNNRYaiCioRj1mfFCyUHZCAK4plBsJ1grUKpv6YL/9p3g1doK4
 bNE61hQ0u9yQEudd/hWpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c6AuXNF4uqY=:5fORZAKvAa9Lh85VwGcNJ9
 9ZRe55W4+oeO1PV/cK79YUvi+CHaRf42Z3wP+w3+Of4+XoZu1181Emt5UKb9VdUBmnXYebcg5
 SEx+zwVVldIz2MnUioFxskevRHXXqb53Fkjh2ga9K99PIF4sRGSlcBsX7fBOfzB69Qa/UN9Qn
 V4RbbM6B3lOrVniKHND2HoWiSrQSGV0UzdwRAGKdZ5Bev863yvjZIEDOd31WOfhie4YQBxAkb
 d2voTt6KENrJPqI/8cpWhy7jyrwXSZ0AJ+WStRp91LS+oS1I14YClICeAw895AhQyFxWZ4poW
 LrLmnchafkEd6sY7zbynwaGX7FrOFdOHUPFStRoq3Xy5jt/VhaLjkQRQSZ3dkB1L2u6z0nm0B
 DeMluXWldeKJVD4ReQ3ZWeWr8V9pwzQuHxrrbg0eWJU02kSejyUmARfnmm0tPXYquZp3NAQoU
 1/2Jyevkaz/8BLZ4zzbnnKqN+i/vNHCBDFU/8ssWf1T57O771UD9T5gyNgAfRtX3YJG0m/HZq
 lpLdqV6i47Y4Qj80I26Xo8aU9MPiOQjP5nBKz5/ktkilVaaXzGy20WgYi146maU6bYzme3xvn
 QxhuLBV7v9S5nvumtEZkhs2/9i8bWbfu7fIBzUqILui3ErhsFdg2FE7KRIoUyNMgM+YZyA3Wh
 1KzWHFqNEySWip3lhXmoNS+nAF5+47DMyKJ8ouME9bqe+dJS1QnXYXE2+DcwrpB/V53ymfJ2l
 8yDIJYRWQeyI/3VKOoIhzD2NioY6oq0XwPfyIqIl7hI+Vxg4zopnuZ1J1U2YqyNvtbISjvIK1
 UJM3Or7LqjQ9U4A2UaQIoxJN+xRp5lziCK+yfExsZY+mtONKQY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for DISCONTIGMEM on 32-bit PowerPC. This is
required to properly support the Nintendo Wii's memory layout, in which
there are two blocks of RAM and MMIO in the middle.

Previously, this memory layout was handled by code that joins the two
RAM blocks into one, reserves the MMIO hole, and permits allocations of
reserved memory in ioremap. This hack didn't work with resource-based
allocation (as used for example in the GPIO driver for Wii[1]), however.

After this patchset, users of the Wii can either select CONFIG_FLATMEM
to get the old behaviour, or CONFIG_DISCONTIGMEM to get the new
behaviour.

Some parts of this patchset are probably not ideal (I'm thinking of my
implementation of pfn_to_nid here), and will require some discussion/
changes.

[1]: https://www.spinics.net/lists/devicetree/msg213956.html

Jonathan Neuschäfer (6):
  powerpc/mm/32: Use pfn_valid to check if pointer is in RAM
  powerpc: numa: Fix overshift on PPC32
  powerpc: numa: Use the right #ifdef guards around functions
  powerpc: numa: Restrict fake NUMA enulation to CONFIG_NUMA systems
  powerpc: Implement DISCONTIGMEM and allow selection on PPC32
  powerpc: wii: Don't rely on reserved memory hack if DISCONTIGMEM is
    set

 arch/powerpc/Kconfig                     |  5 ++++-
 arch/powerpc/include/asm/mmzone.h        | 21 +++++++++++++++++++++
 arch/powerpc/mm/numa.c                   | 18 +++++++++++++++---
 arch/powerpc/mm/pgtable_32.c             |  2 +-
 arch/powerpc/platforms/embedded6xx/wii.c | 10 +++++++---
 5 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.16.1
