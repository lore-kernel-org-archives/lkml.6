Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4BA20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760209;
	bh=TrsHP+mSKldZMkI8efKDISv8agUsrtjR+CItDFjhVqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KTPoqtyMwozeinFAx8E0hpvfYqVsoCifObzltLmbJBaCTihdQjgEl+tAeLBAZu1mD
	 bNltREKMaQoLDcM9Ly3HYlY1U0FTJuBBmXk5Fd9QEyfRMJtPcRuE3n8zQ7KFSJGzqP
	 At8GCSCoUimShlFuYswAa5FpXz5fn1FI9klTvkr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfBUOn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:43:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbfBUOnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889D02084D;
        Thu, 21 Feb 2019 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760202;
        bh=TrsHP+mSKldZMkI8efKDISv8agUsrtjR+CItDFjhVqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPWOE5WqdwVoi+yaBZpBHOQeS3QFmDRN88Q6y7Lc+qopRIFQdfWE77DHMjalKDhiI
         87D7LfcrAMB1ET/eYxMmzYCvscA5AxvLWw/DW/1KuNKKQq8de5hXmG5b/T5RtYHcsq
         NmJSK7nd5R6wxwjPfAUeu4oL5+f+JymmfNRfju8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 27/32] mmc: meson-gx: fix interrupt name
Date:   Thu, 21 Feb 2019 15:36:15 +0100
Message-Id: <20190221125252.522004549@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

[ Upstream commit 83e418a805d880a8b18add07f94d19b2a5a80307 ]

Commit bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
changed the _probe code to use request_threaded_irq() instead of
devm_request_threaded_irq().
Unfortunately this removes a fallback for the interrupt name:
devm_request_threaded_irq() uses the device name as fallback if the
given IRQ name is NULL. request_threaded_irq() has no such fallback,
thus /proc/interrupts shows "(null)" instead.

Explicitly pass the dev_name() so we get the IRQ name shown in
/proc/interrupts again.
While here, also fix the indentation of the request_threaded_irq()
parameter list.

Fixes: bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index ef9deaa361c73..ddd98cdd33bcd 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1286,7 +1286,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	       host->regs + SD_EMMC_IRQ_EN);
 
 	ret = request_threaded_irq(host->irq, meson_mmc_irq,
-			meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
+				   meson_mmc_irq_thread, IRQF_SHARED,
+				   dev_name(&pdev->dev), host);
 	if (ret)
 		goto err_init_clk;
 
-- 
2.19.1



