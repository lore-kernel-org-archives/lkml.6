Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeCYOjg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:39:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbeCYOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:39:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9942660390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, Dept-GELinuxNICDev@cavium.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/7] net: qla3xxx: Eliminate duplicate barriers on weakly-ordered archs
Date: Sun, 25 Mar 2018 10:39:15 -0400
Message-Id: <1521988761-30344-2-git-send-email-okaya@codeaurora.org>
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

Since code already has an explicit barrier call, changing code to

wmb()
writel_relaxed()
mmiowb()

for multi-arch support.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 9e5264d..b48f761 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -1858,8 +1858,9 @@ static void ql_update_small_bufq_prod_index(struct ql3_adapter *qdev)
 			qdev->small_buf_release_cnt -= 8;
 		}
 		wmb();
-		writel(qdev->small_buf_q_producer_index,
-			&port_regs->CommonRegs.rxSmallQProducerIndex);
+		writel_relaxed(qdev->small_buf_q_producer_index,
+			       &port_regs->CommonRegs.rxSmallQProducerIndex);
+		mmiowb();
 	}
 }
 
-- 
2.7.4
