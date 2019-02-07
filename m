Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A2921872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGOo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:44:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:43168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfBGOo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:44:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84374AD38;
        Thu,  7 Feb 2019 14:44:27 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com, palmer@sifive.com, aou@eecs.berkeley.edu
Subject: [PATCH] arch: riscv: fix logic error in parse_dtb
References: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com>
X-Yow:  Why was I BORN?
Date:   Thu, 07 Feb 2019 15:44:26 +0100
In-Reply-To: <alpine.DEB.2.21.9999.1812171913510.29609@viisi.sifive.com> (Paul
        Walmsley's message of "Mon, 17 Dec 2018 19:15:12 -0800 (PST)")
Message-ID: <mvmr2cjy7xx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function early_init_dt_scan returns true if a DTB was detected.

Fixes: 8fd6e05c7463 ("arch: riscv: support kernel command line forcing when no DTB passed")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 45e9a2f053dc..84f19ca6d88b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -140,7 +140,7 @@ asmlinkage void __init setup_vm(void)
 
 void __init parse_dtb(unsigned int hartid, void *dtb)
 {
-	if (!early_init_dt_scan(__va(dtb)))
+	if (early_init_dt_scan(__va(dtb)))
 		return;
 
 	pr_err("No DTB passed to the kernel\n");
-- 
2.20.1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
