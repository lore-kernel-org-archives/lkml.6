Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeC2MX5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:23:57 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:36470 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeC2MXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:55 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] MIPS: memset.S: Fix 2 issues with __clear_user
Date: Thu, 29 Mar 2018 10:28:22 +0100
Message-ID: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522326228-452059-22111-54593-5
X-BESS-VER: 2018.4.1-r1803282120
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191512
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses 2 issues that have been present in memset.S since
the initial git import(!).
The first patch addresses an issue when memset is called with a size
less than the size of a long (4 bytes on 32bit, 8 bytes on 64bit). There
is no fixup handler provided for the byte store loop, meaning that if
the access triggers a page fault, rather than being fixup up, the kernel
OOPS'. A secondary issue is also addressed here, that when EVA support
was added by commit fd9720e96e85 ("MIPS: lib: memset: Add EVA support
for the __bzero function."), this small memset was not changed. Hence
kernel mode addressing is always used and if the userspace address being
stored to overlaps kernel, then some potentially critical kernel data is
overwritten.

The second patch addresses an issue found while debugging the first.
clear_user() is specified to return the number of bytes that could not be
cleared. After the first patch, this is now done for sizes 0-3, but
sizes 4-63 would return garbage. This was tracked down to an error in
reusing the t1 register meaning it no longer contained the expected
value in the fault handler, and the fault handler erroneously masking
off the lower bits of the result.

The following test code was used to verify the behavior.

  int j, k;
  for (j = 0; j < 512; j++) {
    if ((k = clear_user(NULL, j)) != j) {
       pr_err("clear_user (NULL %d) returned %d\n", j, k);
    }
  }

Without patch 1, an OOPS is triggered by the first iteration. Without
the second patch, j = 4..63 returns garbage.

Applies on v4.16-rc7
Tested on MIPS creator ci40 (MIPS32) and Cavium Octeon II (MIPS64).



Matt Redfearn (2):
  MIPS: memset.S: EVA & fault support for small_memset
  MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup

 arch/mips/lib/memset.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.7.4
