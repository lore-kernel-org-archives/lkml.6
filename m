Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeDITbF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:31:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45002 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753108AbeDIT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:29:55 -0400
X-Google-Smtp-Source: AIpwx4+tb1ysa8Chxx24KqaORxtBrrHLkLRvRZEwS2lSBgsbmiqAkESxgdCU2mR6HyuFXhDL4enRHg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/15] memory: tegra: Do not handle spurious interrupts
Date: Mon,  9 Apr 2018 22:28:27 +0300
Message-Id: <30ec0fb1941e2ea2e10808d59f478f022b06266b.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISR reads interrupts-enable mask, but doesn't utilize it. Apply the
mask to the interrupt status and don't handle interrupts that MC driver
haven't asked for. Kernel would disable spurious MC IRQ and report the
error. This would happen only in a case of a very severe bug.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index a4803ac192bb..d2005b995821 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -252,8 +252,11 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 	unsigned int bit;
 
 	/* mask all interrupts to avoid flooding */
-	status = mc_readl(mc, MC_INTSTATUS);
 	mask = mc_readl(mc, MC_INTMASK);
+	status = mc_readl(mc, MC_INTSTATUS) & mask;
+
+	if (!status)
+		return IRQ_NONE;
 
 	for_each_set_bit(bit, &status, 32) {
 		const char *error = status_names[bit] ?: "unknown";
-- 
2.16.3
