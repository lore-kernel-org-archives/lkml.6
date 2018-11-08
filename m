Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03212C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6E320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuPu58oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6E320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbeKIIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:06:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbeKIHii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B5A21479;
        Thu,  8 Nov 2018 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714469;
        bh=JQeSYdHZs6lW9p/bVCWuYVS9Lz02X1PgU4UBC75vd+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuPu58oW3U96IydayyMS8AHHbdESrL6xF/+tle87A0sQXrRUEFDw1tQ6e3+awpKvn
         dY2G5vS05zAu6l0/xpqxQZKJUhS35Dcl7hZ4viTkSWEdAvvLbmlBougcPssnwPFbaN
         KsFZTNNMSBpWCwQ1u5JOLcpxaNR3iLFKpCm92eNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 075/114] spi/bcm63xx: fix error return code in bcm63xx_spi_probe()
Date:   Thu,  8 Nov 2018 13:51:30 -0800
Message-Id: <20181108215107.776162596@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ba8afe94723e9ba665aee9cca649fb2c80f7304c ]

platform_get_irq() returns an error code, but the spi-bcm63xx driver
ignores it and always returns -ENXIO. This is not correct and,
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index bf9a610e5b89..f14500910bc2 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -496,8 +496,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq\n");
-		return -ENXIO;
+		dev_err(dev, "no irq: %d\n", irq);
+		return irq;
 	}
 
 	clk = devm_clk_get(dev, "spi");
-- 
2.17.1



