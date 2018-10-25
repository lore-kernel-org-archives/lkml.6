Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFCFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E51B2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmhpEE1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E51B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeJYXOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbeJYWsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:17 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3023D20834;
        Thu, 25 Oct 2018 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476921;
        bh=De1kYG3U43zttpm4yxRbXwflxtux71hpDQwk6WJmLEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmhpEE1k3sY9vRljaiC1vrz80GMhHFog+9oCjHjZKXP9FmsrbqS+v+aHEoSc2W7ec
         J6wCPo/fPBNPGp+813QVpCBQKvHyn44WmVVYKfRr8Gu0a7algqvV3B1rogLmxC7k62
         rsI08VRqPsTtUBZBCukgJ36Xm+ocdRNg1cSN1jXo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 38/98] gpu: ipu-v3: Fix CSI selection for VDIC
Date:   Thu, 25 Oct 2018 10:13:23 -0400
Message-Id: <20181025141423.213774-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit b7dfee2433576f1f030cb84cdb04b70f36554992 ]

The description of the CSI_SEL bit in the i.MX6 reference manual is
incorrect. It states "This bit defines which CSI is the input to the
IC. This bit is effective only if IC_INPUT is bit cleared".

From experiment it was found this is in fact not correct. The CSI_SEL
bit selects which CSI is input to _both_ the VDIC _and_ the IC. If the
IC_INPUT bit is set so that the IC is receiving from the VDIC, the IC
ignores the CSI_SEL bit, but CSI_SEL still selects which CSI the VDIC
receives from in that case.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-common.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index b9539f7c5e9a..99c813a4ec1f 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -715,15 +715,16 @@ void ipu_set_ic_src_mux(struct ipu_soc *ipu, int csi_id, bool vdi)
 	spin_lock_irqsave(&ipu->lock, flags);
 
 	val = ipu_cm_read(ipu, IPU_CONF);
-	if (vdi) {
+	if (vdi)
 		val |= IPU_CONF_IC_INPUT;
-	} else {
+	else
 		val &= ~IPU_CONF_IC_INPUT;
-		if (csi_id == 1)
-			val |= IPU_CONF_CSI_SEL;
-		else
-			val &= ~IPU_CONF_CSI_SEL;
-	}
+
+	if (csi_id == 1)
+		val |= IPU_CONF_CSI_SEL;
+	else
+		val &= ~IPU_CONF_CSI_SEL;
+
 	ipu_cm_write(ipu, val, IPU_CONF);
 
 	spin_unlock_irqrestore(&ipu->lock, flags);
-- 
2.17.1

