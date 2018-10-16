Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BCAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F1A2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wueBVVQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F1A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeJPMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbeJPMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACBF21479;
        Tue, 16 Oct 2018 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663224;
        bh=MtCxTdEf+TFrcIqy9d+k26BQiz8p5fE98/SBG7eeSvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wueBVVQVJlfdOiQNtUaV/Rli+GBNZ+w/8Ygfl+UYtnhjxq/eVRKXzTGZ+tS9xK8Nl
         ZBV4Pp3mmk4OwsWQfGzO85ABOjz4jauMAjlRAFmxBd0vzg3r2ZP/he11vyi8bHW5TO
         O6l6YdH1L5dt88xKvq91yDNRNDtGlL1TfqDiKgaw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 087/100] bnxt_en: get the reduced max_irqs by the ones used by RDMA
Date:   Tue, 16 Oct 2018 00:12:08 -0400
Message-Id: <20181016041221.135528-87-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit c78fe058879bdea919d44f23e21da26f603e9166 ]

When getting the max rings supported, get the reduced max_irqs
by the ones used by RDMA.

If the number MSIX is the limiting factor, this bug may cause the
max ring count to be higher than it should be when RDMA driver is
loaded and may result in ring allocation failures.

Fixes: 30f529473ec9 ("bnxt_en: Do not modify max IRQ count after RDMA driver requests/frees IRQs.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 84a96c277994..6d22762ca1c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8500,7 +8500,7 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	*max_tx = hw_resc->max_tx_rings;
 	*max_rx = hw_resc->max_rx_rings;
 	*max_cp = min_t(int, bnxt_get_max_func_cp_rings_for_en(bp),
-			hw_resc->max_irqs);
+			hw_resc->max_irqs - bnxt_get_ulp_msix_num(bp));
 	*max_cp = min_t(int, *max_cp, hw_resc->max_stat_ctxs);
 	max_ring_grps = hw_resc->max_hw_ring_grps;
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && BNXT_PF(bp)) {
-- 
2.17.1

