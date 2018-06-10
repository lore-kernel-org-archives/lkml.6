Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fd3DGyc8HVtzcQAAmS7hNA
	; Sun, 10 Jun 2018 14:56:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5BB6460791; Sun, 10 Jun 2018 14:56:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BF953604D4;
	Sun, 10 Jun 2018 14:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF953604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeFJO4Y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:56:24 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44222 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753462AbeFJO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:56:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,498,1520895600";
   d="scan'208";a="331181271"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 10 Jun 2018 16:56:19 +0200
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-janitors@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clocksource/drivers/stm32: fix error return code
Date: Sun, 10 Jun 2018 16:24:15 +0200
Message-Id: <1528640655-18948-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error code on failure.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/clocksource/timer-stm32.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index e5cdc3a..2717f88 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -304,8 +304,10 @@ static int __init stm32_timer_init(struct device_node *node)
 
 	to->private_data = kzalloc(sizeof(struct stm32_timer_private),
 				   GFP_KERNEL);
-	if (!to->private_data)
+	if (!to->private_data) {
+		ret = -ENOMEM;
 		goto deinit;
+	}
 
 	rstc = of_reset_control_get(node, NULL);
 	if (!IS_ERR(rstc)) {
