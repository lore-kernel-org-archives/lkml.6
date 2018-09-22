Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A30C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F7B21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="QzRxWonB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F7B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeIWBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 21:15:55 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:55568 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeIWBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 21:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ce02TxCekmqQ0uo5cVwaMreQXty+fONXT5m/+rLbQdE=; b=QzRxWonB7HLNtyyQn1tOnNKojS
        vqbfFMmHepUoS5KX+A/9sJ/5nFoD7GERFQ9WIbt06PzHG5Kx+9JADX7lB4YNhuEhs20VA5vwymdKq
        NrZuGbR1vZWcxPge5n9HniJIRBt7moNFva6FIZW6wgvGq89kHOym+rI7mtKIbKXHyuWU=;
Received: from p200300ccfbf756001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbf7:5600:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g3nSo-0006XN-RT; Sat, 22 Sep 2018 21:21:10 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g3nSo-0004DC-1U; Sat, 22 Sep 2018 21:21:10 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>, stable@vger.kernel.org
Subject: [PATCH] w1: omap-hdq: fix missing bus unregister at removal
Date:   Sat, 22 Sep 2018 21:20:54 +0200
Message-Id: <20180922192054.16107-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: <stable@vger.kernel.org>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/w1/masters/omap_hdq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 83fc9aab34e8..3099052e1243 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -763,6 +763,8 @@ static int omap_hdq_remove(struct platform_device *pdev)
 	/* remove module dependency */
 	pm_runtime_disable(&pdev->dev);
 
+	w1_remove_master_device(&omap_w1_master);
+
 	return 0;
 }
 
-- 
2.11.0

