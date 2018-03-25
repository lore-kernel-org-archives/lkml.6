Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeCYOjn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:39:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeCYOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:39:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E98C16030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/7] qlcnic: Eliminate duplicate barriers on weakly-ordered archs
Date: Sun, 25 Mar 2018 10:39:16 -0400
Message-Id: <1521988761-30344-3-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Manish Chopra <manish.chopra@cavium.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index 46b0372..97c146e7 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -478,7 +478,7 @@ irqreturn_t qlcnic_83xx_clear_legacy_intr(struct qlcnic_adapter *adapter)
 	wmb();
 
 	/* clear the interrupt trigger control register */
-	writel(0, adapter->isr_int_vec);
+	writel_relaxed(0, adapter->isr_int_vec);
 	intr_val = readl(adapter->isr_int_vec);
 	do {
 		intr_val = readl(adapter->tgt_status_reg);
-- 
2.7.4
