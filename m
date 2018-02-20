Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeBTQ2c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:28:32 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33201 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbeBTQZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:52 -0500
X-Google-Smtp-Source: AH8x226WmCmhHmsXfawYTUcdnsdqFn6UvMyxyE4F/Y+9vAkmBFb+GU1Gq3Tpzfos9qa5Ii8ZywMYiA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/15] memory: tegra: Do not handle spurious interrupts
Date: Tue, 20 Feb 2018 19:25:18 +0300
Message-Id: <48059f0e134d779e65fd92938e4162b191e400de.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
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
2.16.1
