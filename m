Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27991C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE652146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543691;
	bh=QrwVrGQDkNr+crhmsDzrRflRFByCb3XiIV1IZ/Yy7bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kJ3f4bDuy+K90hmcanXi+z3BMMET2dTR5VvtvApnDJZnX1YyoytkreGIJTP9veJYd
	 bSBlFa8y5ofmHXlYy4a6gXn0yMagXH7tYzoKx682VpeHPaAHXDpD90hHBsC22Z4YhN
	 3ycEUC8Mp4WwwnvmjvabfJ+s2s62JKesd+R7UWcw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE652146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbeLKPyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbeLKPyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5442146E;
        Tue, 11 Dec 2018 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543686;
        bh=QrwVrGQDkNr+crhmsDzrRflRFByCb3XiIV1IZ/Yy7bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuUmxgVnoliwqpOJ4Iq5DJ6bUs6+Maf4X0aXVoxeEoV/4lyQnowN8ezYQ04yXUDcZ
         fW7A9aqMCKWg0FlWXS4KGuvVUrIAU+uPm7eNBA91hjFvhL+mDt52n/ZE3V7M/gFtDE
         xFOmhfYid3bvOmqZHNyaq+PJUOu6d0w4/itgGRCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/118] s390/ism: clear dmbe_mask bit before SMC IRQ handling
Date:   Tue, 11 Dec 2018 16:40:43 +0100
Message-Id: <20181211151645.219854857@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 007b656851ed7f94ba0fa358ac3e5d7705da6846 ]

SMC-D stress workload showed connection stalls. Since the firmware
decides to skip raising an interrupt if the SBA DMBE mask bit is
still set, this SBA DMBE mask bit should be cleared before the
IRQ handling in the SMC code runs. Otherwise there are small windows
possible with missing interrupts for incoming data.
SMC-D currently does not care about the old value of the SBA DMBE
mask.

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c0631895154e..8684bcec8ff4 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -415,9 +415,9 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 			break;
 
 		clear_bit_inv(bit, bv);
+		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 		barrier();
 		smcd_handle_irq(ism->smcd, bit + ISM_DMB_BIT_OFFSET);
-		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 	}
 
 	if (ism->sba->e) {
-- 
2.19.1



