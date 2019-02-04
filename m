Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DDC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5FF2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="o0347q27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfBDJ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:58:56 -0500
Received: from onstation.org ([52.200.56.107]:51364 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfBDJ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:58:56 -0500
Received: from xilitla.corp.homestore.net (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 889BE16B;
        Mon,  4 Feb 2019 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549274335;
        bh=b7lxn7IPmC16lhSHLt4y4k56qUSfLfZNL9DqQEZGjiI=;
        h=From:To:Cc:Subject:Date:From;
        b=o0347q27xIJpPKgG7j5Ry+qJ9Xvn+JX4r6iKW0C5tyss8717JmTx6b3PDlv8ukTyQ
         Vj5q8TTyCU2F0DNIbrGX3X3ng6FhujUQ9R/cs/ljmSM0vyme1jwCykrq4SL+qg47Mu
         FvLMLlsakQmmnkgLDENMy1wwDp/FZIDF7F+3pY6g=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com
Cc:     andy.gross@linaro.org, sboyd@kernel.org,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: [PATCH v2 -next 1/2] genirq: export irq_chip_set_wake_parent symbol
Date:   Mon,  4 Feb 2019 04:58:52 -0500
Message-Id: <20190204095853.12212-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the irq_chip_set_wake_parent symbol so that drivers with
hierarchical IRQ chips can be built as a module.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reported-by: Mark Brown <broonie@kernel.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
This fixes a build failure in linux-next's spmi-gpio when using
allmodconfig. See https://www.spinics.net/lists/linux-next/msg46362.html
for Mark's message.

Changes since v1:
- Moved message about build failure out of the commit message and into
  the notes field.

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

