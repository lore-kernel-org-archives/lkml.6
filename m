Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E2F2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693620;
	bh=SMCabk13T9+0o1E2xt/iWrrLggH23f1PRMvFQLe2z9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fd9VpXpLRRX/ddhRCObg1nLGx29tPXLD6Cov1tmWwOkt7zINWcDWdfrJSV3uBpCkR
	 LoUKzlsCWfeCOZC7vMLPP3ic0oHp+u5CtrnUj5SeSRQnTWTV3usla8NcdZaXWf/WLt
	 5qQzvuPTgMyTEQ24LVhAll+ojTY07+7DrqchXpVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbfA1QkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389694AbfA1QYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81C662084A;
        Mon, 28 Jan 2019 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692662;
        bh=SMCabk13T9+0o1E2xt/iWrrLggH23f1PRMvFQLe2z9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTv2rojT4brhyDMk9HvZuwSYE0bmVf0argqho3LhJUmswzT0YIqJ4vPJHgAwEp9QT
         wkWYSmolDgxWf0PJJJRVxs+43ELV7/AHXabQhs7BtzdfKw92rpHGliFsUVc4IAb4Cj
         70iM97Hw6pzaZpRMSM0PqWxkAuQbjEMx0intEQqs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.4 14/80] staging:iio:ad2s90: Make probe handle spi_setup failure
Date:   Mon, 28 Jan 2019 11:22:55 -0500
Message-Id: <20190128162401.58841-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

[ Upstream commit b3a3eafeef769c6982e15f83631dcbf8d1794efb ]

Previously, ad2s90_probe ignored the return code from spi_setup, not
handling its possible failure. This patch makes ad2s90_probe check if
the code is an error code and, if so, do the following:

- Call dev_err with an appropriate error message.
- Return the spi_setup's error code.

Note: The 'return ret' statement could be out of the 'if' block, but
this whole block will be moved up in the function in the patch:
'staging:iio:ad2s90: Move device registration to the end of probe'.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 5b1c0db33e7f..b44253eb62ec 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -86,7 +86,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	/* need 600ns between CS and the first falling edge of SCLK */
 	spi->max_speed_hz = 830000;
 	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi_setup failed!\n");
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.19.1

