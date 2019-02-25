Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8424F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130156;
	bh=/F5vmbaxnXONhpAvo0MwJ/tjCx4ewdJLlTKSdE0R+bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQ8m+klWNhq+MmChI+zQ0Cr7AIqXpojSXbFeNLCnPlepuEtNEkjLP+5aztTrwPTOo
	 G5TJEzU+CuioiMxFTahb2wl7exefZ2jBK/grUHvI7bJmgwd5o/wFrZHPRej3Qana1d
	 Fo/t861xdqMWM6j5QHhJ/nDfCF7vcpLpuXAL3tjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfBYV3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731996AbfBYV3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2544C2084D;
        Mon, 25 Feb 2019 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130151;
        bh=/F5vmbaxnXONhpAvo0MwJ/tjCx4ewdJLlTKSdE0R+bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZIV2QP8xL5+2PJx5HprIfLH8Yb2fN+FG+qvy6GDaLVyJAptzOaxSS3t7iP4OR18p
         2CKm3Rx7p2Li8rKLhnKy5N2ZZ2k+wk7O/gJ6uAp671w3asfUGVu4gNoNLw/cgH0qvF
         Wk4bDCNYRNyIDLX6FdT2OseDXiv/HeGCiDAETakA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 031/183] mfd: qcom_rpm: write fw_version to CTRL_REG
Date:   Mon, 25 Feb 2019 22:10:04 +0100
Message-Id: <20190225195059.912180064@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 504e4175829c44328773b96ad9c538e4783a8d22 ]

This is required as part of the initialization sequence on certain SoCs.

If these registers are not initialized, the hardware can be unresponsive.
This fixes the driver on apq8060 (HP TouchPad device).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/qcom_rpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 52fafea06067e..8d420c37b2a61 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -638,6 +638,10 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	writel(fw_version[0], RPM_CTRL_REG(rpm, 0));
+	writel(fw_version[1], RPM_CTRL_REG(rpm, 1));
+	writel(fw_version[2], RPM_CTRL_REG(rpm, 2));
+
 	dev_info(&pdev->dev, "RPM firmware %u.%u.%u\n", fw_version[0],
 							fw_version[1],
 							fw_version[2]);
-- 
2.19.1



