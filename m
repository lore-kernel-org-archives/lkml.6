Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeCVRKS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:10:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCVRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:10:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14EE3603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Dept-GELinuxNICDev@cavium.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] net: qla3xxx: Eliminate duplicate barriers on weakly-ordered archs
Date: Thu, 22 Mar 2018 13:09:58 -0400
Message-Id: <1521738603-23596-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521738603-23596-1-git-send-email-okaya@codeaurora.org>
References: <1521738603-23596-1-git-send-email-okaya@codeaurora.org>
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
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 9e5264d..0e71b74 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -1858,8 +1858,8 @@ static void ql_update_small_bufq_prod_index(struct ql3_adapter *qdev)
 			qdev->small_buf_release_cnt -= 8;
 		}
 		wmb();
-		writel(qdev->small_buf_q_producer_index,
-			&port_regs->CommonRegs.rxSmallQProducerIndex);
+		writel_relaxed(qdev->small_buf_q_producer_index,
+			       &port_regs->CommonRegs.rxSmallQProducerIndex);
 	}
 }
 
-- 
2.7.4
