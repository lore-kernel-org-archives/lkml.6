Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB63C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D0820883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="reSClfsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D0820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeKIHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbeKIHm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:28 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F19208A3;
        Thu,  8 Nov 2018 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714698;
        bh=Rs0YGFtKPNwWtNwR+hIS8Py5GeZNCeixBKaaTPD3Psc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reSClfsGux8nc+DXx5X717pkA0I/uyyw3xISCS9qvFF4sxa0b7vW5h1hLtdaRDv8D
         Jk0uPxlwsA+Z3LqyzlROKYG0AH707YvTrKoR485xFY+dp2xr2VgTswU27NvaC0/4AB
         EPeFnBRbZ5B1L9PqXLjhc526z+27hTdC1+ymAmcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 068/171] gpu: ipu-v3: Fix CSI selection for VDIC
Date:   Thu,  8 Nov 2018 13:50:38 -0800
Message-Id: <20181108215132.507732026@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b7dfee2433576f1f030cb84cdb04b70f36554992 ]

The description of the CSI_SEL bit in the i.MX6 reference manual is
incorrect. It states "This bit defines which CSI is the input to the
IC. This bit is effective only if IC_INPUT is bit cleared".

>From experiment it was found this is in fact not correct. The CSI_SEL
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



