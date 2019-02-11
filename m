Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2550BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBDF20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896067;
	bh=NuQwz1WxA4bt7yeBdFHgId5msaVale2RPXRQtJCXM6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0wZg5ehLyBS2thYQInHuaRfha8fTrIHj0PaMYb2Up3BElGNBxAODtZ2eg6hWpOTg
	 RyTDYw1m1hGOqgXmSAdLuBo/4TUsa6/BMhOLqDCCs+tiYkRJ1ABUvqBWy/kz005px1
	 Z+XhCNmvZ1PREzVMLZkyVarr/IftZR8YZ2QOdOlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbfBKOlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732162AbfBKOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:41:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F23120700;
        Mon, 11 Feb 2019 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896062;
        bh=NuQwz1WxA4bt7yeBdFHgId5msaVale2RPXRQtJCXM6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ejAhId52KbqrxkF1VeThSLpB+3hskK/P67IvxQsWK9BVOBdoBUbvHq5Ycha/nFZk
         VEQ8j4d/HfRUE2Gn28NcIbcpxeUjVuWcIFb3QvhwoRlVs4yG2aelQpOtdJ84Hg6Jug
         UDkFQ75zWnNGrNwwWVcV4SvejYVVBt2U6b6YY5pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/313] staging:iio:ad2s90: Make probe handle spi_setup failure
Date:   Mon, 11 Feb 2019 15:15:11 +0100
Message-Id: <20190211141855.500734674@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index 59586947a936..51cda9151412 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -85,7 +85,12 @@ static int ad2s90_probe(struct spi_device *spi)
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



