Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0213C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FCF20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FCF20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeLLK46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:56:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbeLLK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:56:57 -0500
X-UUID: e75b33134e604f8288fe585d2bd6fb8e-20181212
X-UUID: e75b33134e604f8288fe585d2bd6fb8e-20181212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 446859826; Wed, 12 Dec 2018 18:56:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 18:56:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 18:56:51 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
Date:   Wed, 12 Dec 2018 18:56:49 +0800
Message-ID: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5C17EFA49BFC5B10294428546CA39A4491BDC7A3175BB255EF1A6BC31283A15A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
perform linear virtual address to physical address translation.
Sometimes we're debugging with only few information such as a kernel log
and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.

Tested by:
echo c > /proc/sysrq-trigger
[   11.996161] SMP: stopping secondary CPUs
[   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
[   11.996881] PHYS_OFFSET: 0xffffffeb40000000

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..4b0e1231625c 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
 		pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
 			 offset, KIMAGE_VADDR);
+		pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
 	} else {
 		pr_emerg("Kernel Offset: disabled\n");
 	}
-- 
2.18.0

