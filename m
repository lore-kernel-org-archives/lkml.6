Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC327C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864472073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfBCOdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:33:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55140 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727918AbfBCOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIca-000626-RI; Sun, 03 Feb 2019 14:19:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006ra-I0; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Andreas Kemnade" <andreas@kemnade.info>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.515054935@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 055/305] w1: omap-hdq: fix missing bus unregister at
 removal
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Kemnade <andreas@kemnade.info>

commit a007734618fee1bf35556c04fa498d41d42c7301 upstream.

The bus master was not removed after unloading the module
or unbinding the driver. That lead to oopses like this

[  127.842987] Unable to handle kernel paging request at virtual address bf01d04c
[  127.850646] pgd = 70e3cd9a
[  127.853698] [bf01d04c] *pgd=8f908811, *pte=00000000, *ppte=00000000
[  127.860412] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
[  127.866668] Modules linked in: bq27xxx_battery overlay [last unloaded: omap_hdq]
[  127.874542] CPU: 0 PID: 1022 Comm: w1_bus_master1 Not tainted 4.19.0-rc4-00001-g2d51da718324 #12
[  127.883819] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[  127.890441] PC is at 0xbf01d04c
[  127.893798] LR is at w1_search_process_cb+0x4c/0xfc
[  127.898956] pc : [<bf01d04c>]    lr : [<c05f9580>]    psr: a0070013
[  127.905609] sp : cf885f48  ip : bf01d04c  fp : ddf1e11c
[  127.911132] r10: cf8fe040  r9 : c05f8d00  r8 : cf8fe040
[  127.916656] r7 : 000000f0  r6 : cf8fe02c  r5 : cf8fe000  r4 : cf8fe01c
[  127.923553] r3 : c05f8d00  r2 : 000000f0  r1 : cf8fe000  r0 : dde1ef10
[  127.930450] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  127.938018] Control: 10c5387d  Table: 8f8f0019  DAC: 00000051
[  127.944091] Process w1_bus_master1 (pid: 1022, stack limit = 0x9135699f)
[  127.951171] Stack: (0xcf885f48 to 0xcf886000)
[  127.955810] 5f40:                   cf8fe000 00000000 cf884000 cf8fe090 000003e8 c05f8d00
[  127.964477] 5f60: dde5fc34 c05f9700 ddf1e100 ddf1e540 cf884000 cf8fe000 c05f9694 00000000
[  127.973114] 5f80: dde5fc34 c01499a4 00000000 ddf1e540 c0149874 00000000 00000000 00000000
[  127.981781] 5fa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 00000000
[  127.990447] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  127.999114] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[  128.007781] [<c05f9580>] (w1_search_process_cb) from [<c05f9700>] (w1_process+0x6c/0x118)
[  128.016479] [<c05f9700>] (w1_process) from [<c01499a4>] (kthread+0x130/0x148)
[  128.024047] [<c01499a4>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[  128.031677] Exception stack(0xcf885fb0 to 0xcf885ff8)
[  128.037017] 5fa0:                                     00000000 00000000 00000000 00000000
[  128.045684] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  128.054351] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  128.061340] Code: bad PC value
[  128.064697] ---[ end trace af066e33c0e14119 ]---

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/w1/masters/omap_hdq.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -622,6 +622,8 @@ static int omap_hdq_remove(struct platfo
 	/* remove module dependency */
 	pm_runtime_disable(&pdev->dev);
 
+	w1_remove_master_device(&omap_w1_master);
+
 	return 0;
 }
 

