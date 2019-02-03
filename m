Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6882C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BFA217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="H/Bmk39f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfBCMbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:31:42 -0500
Received: from onstation.org ([52.200.56.107]:49372 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfBCMbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:31:42 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A3DD115F;
        Sun,  3 Feb 2019 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549197101;
        bh=/6BKBlVr3V9azW1jkDtytolZIdZrfIhaCxzVmkTDFZI=;
        h=From:To:Cc:Subject:Date:From;
        b=H/Bmk39fx4BimPN/YiNwbVx4bnuqKhYU75Zs53RczHaw3Ou32WdGZ0BeWDeGFFNIu
         /oTjSbgx2gMQ4QTxZbH5ej4oVwaUOtS9rSkYcJt1YIpxnFTtpDt3u5e8q3y3CyPrhU
         sdeS+R/YCPx9gSjgVwyOBoLGDjARuCGsmHEF9rJ8=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com
Cc:     andy.gross@linaro.org, sboyd@kernel.org,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 1/2] genirq: export irq_chip_set_wake_parent symbol
Date:   Sun,  3 Feb 2019 07:31:30 -0500
Message-Id: <20190203123131.28323-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the irq_chip_set_wake_parent symbol so that drivers with
hierarchical IRQ chips can be built as a module.

This fixes a build failure in linux-next's spmi-gpio when using
allmodconfig.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reported-by: Mark Brown <broonie@kernel.org>
---
See https://www.spinics.net/lists/linux-next/msg46362.html for Mark's
message.

 kernel/irq/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 34e969069488..086d5a34b5a0 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1381,6 +1381,7 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 
 	return -ENOSYS;
 }
+EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
 #endif
 
 /**
-- 
2.17.2

