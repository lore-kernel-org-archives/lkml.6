Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A547C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A87217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="FcceSwUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfBFHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:07:50 -0500
Received: from tomli.me ([153.92.126.73]:49936 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfBFHHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:07:50 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 3060678a;
        Wed, 6 Feb 2019 07:07:47 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b75:4650)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Wed, 06 Feb 2019 07:07:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=TXmS04p0/Vjvf2HiVvC4vH1nuwaTteSpJPhSTTK+8OY=; b=FcceSwUbGiM6vg+yxFZkVBAKHRbf3y8nPiXFmt8mLOoBTAatoC3ihfaHsShhzkSv/NwFAAoX0jLLcZdQHd+w8jcNAMh5uy2BB37b7KvqL5lqT2VaWE0+1YhjPQkaojf/eodtergLFWlEOAd+LWmjRaX0W2mxSfP2NN1DHm21mP3zmf59RAlUFV3iCkOBMeLcg9fxIJh1NxPptfqwQ15jNj4neCBNtwc3WQnXIpaJfdEn2DDjdSP/EdUBacekCpYCuajjAi97T7qi7s6d3ujD8fK0xKDdh+erOSDqnx0RMeYY4icl9ySRAFmZUKjDF5nWRLR4ksPD2L+MgqXeQihb1Q==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-mips@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Yifeng Li <tomli@tomli.me>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] mips: loongson64: remove unreachable(), fix loongson_poweroff().
Date:   Wed,  6 Feb 2019 15:07:21 +0800
Message-Id: <20190206070721.19185-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Yeeloong 8089, I noticed the machine fails to shutdown
properly, and often, the function mach_prepare_reboot() is
unexpectedly executed, thus the machine reboots instead. A
wait loop is needed to ensure the system is in a well-defined
state before going down.

In commit 997e93d4df16 ("MIPS: Hang more efficiently on
halt/powerdown/restart"), a general superset of the wait loop for all
platforms is already provided, so we don't need to implement our own.

This commit simply removes the unreachable() compiler marco after
mach_prepare_reboot(), thus allowing the execution of machine_hang().
My test shows that the machine is now able to shutdown successfully.

Please note that there are two different bugs preventing the machine
from shutting down, another work-in-progress commit is needed to
fix a lockup in cpufreq / i8259 driver, please read Reference, this
commit does not fix that bug.

Reference: https://lkml.org/lkml/2019/2/5/908
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 arch/mips/loongson64/common/reset.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/common/reset.c
index a60715e11306..b26892ce871c 100644
--- a/arch/mips/loongson64/common/reset.c
+++ b/arch/mips/loongson64/common/reset.c
@@ -59,7 +59,12 @@ static void loongson_poweroff(void)
 {
 #ifndef CONFIG_LEFI_FIRMWARE_INTERFACE
 	mach_prepare_shutdown();
-	unreachable();
+
+	/*
+	 * It needs a wait loop here, but mips/kernel/reset.c already calls
+	 * a generic delay loop, machine_hang(), so simply return.
+	 */
+	return;
 #else
 	void (*fw_poweroff)(void) = (void *)loongson_sysconf.poweroff_addr;
 
-- 
2.20.1

