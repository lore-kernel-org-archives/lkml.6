Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E82FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C878C20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fkme21kW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C878C20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeIKXaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:30:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47038 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIKXaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536690619; x=1568226619;
  h=from:to:cc:subject:date:message-id;
  bh=Lbt92zuZLscvpMeLYQK26pQ6esQna28Q4vKhJ3Hn2os=;
  b=fkme21kWUhmGYuqLb6OTpPqct0xPnx5bsXaqiXwVWqwJepCFHgV8O2H1
   eyXNi9L6w1WIJRsl8hRYl/KCHof34Kqbe5Mg0wjxpdMjIjUoAZ427cYbM
   yCyWn/xx9pQFwIb7Hs/vYsPwTdp9y884TgRLnghkDI4HiQWcVWOFL7xhx
   YAqFxZT9b7u1hm1QWVanVtvigUjLKF/d+9X0iVxXiCUN0tSScIsndGnjH
   L0gZfXX2vI7OeFENtbUdiTiitT4LEi7+86D+CCIO6KT9CCx/StzJVxKAD
   tlwHyz1YjiRfXkjA7BwK8MDneAJ/t4TP3yhJ1I6XAalLDmONWLOAZF9KQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193724045"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 02:30:18 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 11:16:52 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2018 11:30:19 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     hch@infradead.org, anup@brainfault.org, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        terpstra@sifive.com
Subject: [PATCH] RISCV: Fix end PFN for low memory
Date:   Tue, 11 Sep 2018 11:30:18 -0700
Message-Id: <1536690618-9157-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memblock_end_of_DRAM which provides correct last low memory
PFN. Without that, DMA32 region becomes empty resulting in zero
pages being allocated for DMA32.

This patch is based on earlier patch from palmer which never
merged into 4.19. I just edited the commit text to make more
sense.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index db20dc63..a192bf8a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -193,7 +193,7 @@ static void __init setup_bootmem(void)
 	BUG_ON(mem_size == 0);
 
 	set_max_mapnr(PFN_DOWN(mem_size));
-	max_low_pfn = pfn_base + PFN_DOWN(mem_size);
+	max_low_pfn = memblock_end_of_DRAM();
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
-- 
2.7.4

