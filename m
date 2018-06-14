Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8CF04C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DFF208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1ZFgIAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DFF208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936154AbeFNOFr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936131AbeFNOFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:05:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51401208DE;
        Thu, 14 Jun 2018 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985142;
        bh=iBYtOU1lmQDrfp5hFCvlJ+HggJsY10aj3uf5D559kns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1ZFgIAiR66difko2IoxlZY585cYZKjAR8iCN3iGVYGeB52roWRq+5edj6tTM/hDC
         KYQ40h9F66p2GHTLM4RTHHwGU88n+EJFgaknDo7HkryTV4xKOYCtKyqAeq0w2RDJlm
         r50gTPbndrrBK1bXF1AxeCxKdOGMfEs2DRzn0v7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.17 15/45] phy: qcom-qusb2: Fix crash if nvmem cell not specified
Date:   Thu, 14 Jun 2018 16:04:06 +0200
Message-Id: <20180614132127.564772062@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manu Gautam <mgautam@codeaurora.org>

commit 0b4555e776ba0712c6fafb98b226b21fd05d2427 upstream.

Driver currently crashes due to NULL pointer deference
while updating PHY tune register if nvmem cell is NULL.
Since, fused value for Tune1/2 register is optional,
we'd rather bail out.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/qualcomm/phy-qcom-qusb2.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -315,6 +315,10 @@ static void qusb2_phy_set_tune2_param(st
 	const struct qusb2_phy_cfg *cfg = qphy->cfg;
 	u8 *val;
 
+	/* efuse register is optional */
+	if (!qphy->cell)
+		return;
+
 	/*
 	 * Read efuse register having TUNE2/1 parameter's high nibble.
 	 * If efuse register shows value as 0x0, or if we fail to find


