Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCPQWZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:22:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39748 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934660AbeCPQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:17:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B9DA60D81
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Ariel Elior <ariel.elior@cavium.com>, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/18] bnx2x: Eliminate duplicate barriers on weakly-ordered archs
Date: Fri, 16 Mar 2018 12:16:25 -0400
Message-Id: <1521216991-28706-13-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
index 76a4668..3b2f1bd 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c
@@ -170,7 +170,7 @@ static int bnx2x_send_msg2pf(struct bnx2x *bp, u8 *done, dma_addr_t msg_mapping)
 	wmb();
 
 	/* Trigger the PF FW */
-	writeb(1, &zone_data->trigger.vf_pf_channel.addr_valid);
+	writeb_relaxed(1, &zone_data->trigger.vf_pf_channel.addr_valid);
 
 	/* Wait for PF to complete */
 	while ((tout >= 0) && (!*done)) {
-- 
2.7.4
