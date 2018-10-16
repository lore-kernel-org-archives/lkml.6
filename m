Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E6620866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY7xmAu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E6620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeJPMB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbeJPMBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0794F2147C;
        Tue, 16 Oct 2018 04:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663213;
        bh=KcuRR2dsKxD5gf/vfAS9Av0IWr/j+jJWwgR6nvv1ICQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mY7xmAu8P90kRPnj7OxdaOMwzVlYbAXcQQPwJ+p5TAgX6g3CmtahmwiBIHApQ1k/b
         VqO1xbzVSqk7XTR8j6LhFgsEzcm5iHUMlSsUflBI/viU3xDM2/AFGxa9yBAjIzhwUM
         QL/hwglOFPStFf6UMOf/VqDdkv2ZTJ6TtUtGUbaI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 075/100] RISCV: Fix end PFN for low memory
Date:   Tue, 16 Oct 2018 00:11:56 -0400
Message-Id: <20181016041221.135528-75-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

[ Upstream commit ef1f2258748b675422ca0107e5bfb9ceeac675de ]

Use memblock_end_of_DRAM which provides correct last low memory
PFN. Without that, DMA32 region becomes empty resulting in zero
pages being allocated for DMA32.

This patch is based on earlier patch from palmer which never
merged into 4.19. I just edited the commit text to make more
sense.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 0efa5b29d0a3..dcff272aee06 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -165,7 +165,7 @@ static void __init setup_bootmem(void)
 	BUG_ON(mem_size == 0);
 
 	set_max_mapnr(PFN_DOWN(mem_size));
-	max_low_pfn = pfn_base + PFN_DOWN(mem_size);
+	max_low_pfn = memblock_end_of_DRAM();
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
-- 
2.17.1

