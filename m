Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeC1AZx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:25:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:42183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbeC1AZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:25:52 -0400
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/5] PPC32/ioremap: Use memblock API to check for RAM
Date: Wed, 28 Mar 2018 02:25:39 +0200
Message-Id: <20180328002544.18526-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4IMAUl0QCW2qRnyrOKjfBi9I/qFY4DY8M2OA/u6DsrwyA/fIpe/
 nlJXobGdOqK6QIL3w42KzeOATJcQAHGEvRRJmcMbHii0vSGE+ubiasza/9JS54/JOZ0xugV
 3ttx2X6y5YgRXrFKIqMJ1mAFdo32PIxm6g9+nw7kn/FVl3kNcMbMCBLKr/tFDetbCyu/pna
 8RvF0bjV9QlvOe/Bv2Hvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ugmyfSjhUps=:+yUEqh9ZFQKql8nBYwoplt
 CS/3E4EYODO4nukO/Rm++fMFqmhHrvAH5o/pbjdpm6WZSNQ8Cyz49kXRWVIAtDy8mcQ3zSq8k
 ptjCHRSlskrkqfNsk8EhBJS3HRjJ9+HYqCOFJlIQboestaS/4H/4AdQhwQvTOEAS7oJE7B1o3
 psuchw4BvxaHFvKr6qMyWf/CduudqbtFTnhiq8mCOe2zNWUyNa8+HVTYrG21Gpn2ssvNlzmtI
 hj+SDmVHvyRwtQGqDWp/DtD7dj68mSn6LHziYsbl0w9lRCGsqSVWndaDhfNzHQLeyddE+tyJr
 tZocRMnFt24wRMCaA3uwV27aOK+4pFS3rbKgJ1o9qyioSEp/Cm73PNFd0rB3NiF8+JpahE4XQ
 FLk0T6NpKXmWurvkGNlY5fXYgnPDXV7iD5jXD2ONSrdushRebz1vQJcbHt3HnY7bsyolVtDbk
 T3CkUPoXdZ+/ccl9+KhrZshnBqlsvpmhuoyVdh7mytykFP9DYy/tLHXp/vZmpmE+lhpMHUxIh
 zNuK9XSrl5MD90UviWJAbn/xATYy/bKn9iBs/Nput0iLOCsvgwEQrb6RoAmMe6PRK4NLniPtn
 kS+W1Ya5VivQxccLi8ptqswcVPAdWfUONpdamDm3sADnqHoe8B5oGOta57JOKMZaLexyJgLSI
 ee8AdBJ9rXeOsHsTDRSjtJ7g+qKKc0ED9/Ir8DE/BOFAIQVZexvlRB/hMFOEFa5Xm49hcQMOH
 gqm6OqPzOzTL3HS8/PGQQrwxKdMgUjAuVW+bM6zzpJb4RY9fN2qQrtEAa1aiWMvyLJQty3PIm
 ZMrbDUHbmG5rdAvJAjYHr7oHQL5YHpll5GzJb1dpr6uhJzFAhg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://www.spinics.net/lists/linux-mm/msg145939.html

This patchset makes it possible to allocate MMIO ranges that are between
the two RAM chunks on the Wii, MEM1 and MEM2, not only with ioremap
(which previously worked through a hack) but also with kernel/resource.c.

Changes in v2:
- I added back the p < virt_to_phys(high_memory) check in
  __ioremap_caller because high memory should be allocatable through
  ioremap
- I expanded the commit messages a bit

Jonathan Neuschäfer (5):
  powerpc: mm: Simplify page_is_ram by using memblock_is_memory
  powerpc: mm: Use memblock API for PPC32 page_is_ram
  powerpc/mm/32: Use page_is_ram to check for RAM
  powerpc: wii: Don't rely on the reserved memory hack
  powerpc/mm/32: Remove the reserved memory hack

 arch/powerpc/mm/init_32.c                |  5 -----
 arch/powerpc/mm/mem.c                    | 12 +-----------
 arch/powerpc/mm/mmu_decl.h               |  1 -
 arch/powerpc/mm/pgtable_32.c             |  2 +-
 arch/powerpc/platforms/embedded6xx/wii.c | 14 +-------------
 5 files changed, 3 insertions(+), 31 deletions(-)

-- 
2.16.2
