Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeE3Lme (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:42:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60677 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "Linus Walleij" <linus.walleij@linaro.org>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.166036395@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 153/153] mtd: jedec_probe: Fix crash in jedec_read_mfr()
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 87a73eb5b56fd6e07c8e499fe8608ef2d8912b82 upstream.

It turns out that the loop where we read manufacturer
jedec_read_mfd() can under some circumstances get a
CFI_MFR_CONTINUATION repeatedly, making the loop go
over all banks and eventually hit the end of the
map and crash because of an access violation:

Unable to handle kernel paging request at virtual address c4980000
pgd = (ptrval)
[c4980000] *pgd=03808811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1] PREEMPT ARM
CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc1+ #150
Hardware name: Gemini (Device Tree)
PC is at jedec_probe_chip+0x6ec/0xcd0
LR is at 0x4
pc : [<c03a2bf4>]    lr : [<00000004>]    psr: 60000013
sp : c382dd18  ip : 0000ffff  fp : 00000000
r10: c0626388  r9 : 00020000  r8 : c0626340
r7 : 00000000  r6 : 00000001  r5 : c3a71afc  r4 : c382dd70
r3 : 00000001  r2 : c4900000  r1 : 00000002  r0 : 00080000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: 00004000  DAC: 00000053
Process swapper (pid: 1, stack limit = 0x(ptrval))

Fix this by breaking the loop with a return 0 if
the offset exceeds the map size.

Fixes: 5c9c11e1c47c ("[MTD] [NOR] Add support for flash chips with ID in bank other than 0")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/chips/jedec_probe.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1888,6 +1888,8 @@ static inline u32 jedec_read_mfr(struct
 	do {
 		uint32_t ofs = cfi_build_cmd_addr(0 + (bank << 8), map, cfi);
 		mask = (1 << (cfi->device_type * 8)) - 1;
+		if (ofs >= map->size)
+			return 0;
 		result = map_read(map, base + ofs);
 		bank++;
 	} while ((result.x[0] & mask) == CFI_MFR_CONTINUATION);
