Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62255C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5032087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAGLVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:21:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3962 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725550AbfAGLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:21:31 -0500
X-UUID: 8b8dea8163384ecb8d76bfe5e81adc3a-20190107
X-UUID: 8b8dea8163384ecb8d76bfe5e81adc3a-20190107
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 471533334; Mon, 07 Jan 2019 19:21:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 19:21:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 19:21:22 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] arm64: trap illegal translations in __virt_to_phys()
Date:   Mon, 7 Jan 2019 19:21:20 +0800
Message-ID: <1546860080-13027-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 234332DA94720DE407A4821BBD08A888B8AD06626A5B9BD0790A841A1B7E05452000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current __virt_to_phys() only print warning messages for non-linear
addresses. It's hard to catch all warnings by those messages. So add a
VIRTUAL_BUG_ON() to trap all non-linear and non-symbol addresses
(e.g., stack addresses)

Tested by pass stack addresses and symbol addresses to __pa(). Result:
stack addresses: kernel BUG()
symbol addresses: kernel warning message

Maybe we should trap all non-linear address translations in the future.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/physaddr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
index 67a9ba9eaa96..f6b935dad19c 100644
--- a/arch/arm64/mm/physaddr.c
+++ b/arch/arm64/mm/physaddr.c
@@ -14,6 +14,11 @@ phys_addr_t __virt_to_phys(unsigned long x)
 	      (void *)x,
 	      (void *)x);
 
+	/* trap all non-linear and non-symbol addresses */
+	VIRTUAL_BUG_ON(!__is_lm_address(x) &&
+			(x < (unsigned long)KERNEL_START ||
+			 x > (unsigned long)KERNEL_END));
+
 	return __virt_to_phys_nodebug(x);
 }
 EXPORT_SYMBOL(__virt_to_phys);
-- 
2.18.0

