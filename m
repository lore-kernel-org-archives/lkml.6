Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1932208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUWFre77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1932208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeK2RCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeK2RCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:14 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7042A208E7;
        Thu, 29 Nov 2018 05:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471084;
        bh=IDkL5D9m5XilB4ZC81EcFyEdbK8HV1XUHMMUSulgWII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUWFre778DI0i+9vFJVzqeMrkHjnbnI9j8/m5JxO5CwFz4KqT+OOPGEu6MkM3ESwH
         hYeYv7JiTwp3wkRsFLj496UyTrDpt60iOGmGqj+5Vyg4o+99ijmqIRAzpALnR60TWT
         AfV0dl4lozSJ52rkAxE192QajsOJeHHcYsbyGdP0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 24/68] s390/ism: clear dmbe_mask bit before SMC IRQ handling
Date:   Thu, 29 Nov 2018 00:55:15 -0500
Message-Id: <20181129055559.159228-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

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
2.17.1

