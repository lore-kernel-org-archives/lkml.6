Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A55C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C8B222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896986;
	bh=4tDVT+EyQzS8QX60BG0z1CecYjs/ut2J5FFnD8aBKx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxXykYeaySV6kOUqiAEkYnjTwurBJ7rdruE7CRyVfJ4DGxgUsViOdagmCRUoqbDps
	 jOU5z1V+vT7bru+YGLb22tJTmPxxUfygZ3JVwUGCq6bM/CERruJOQq0vwK0RWYVun6
	 kmx1pzSaKSxeI8ipcsBlVikYg3A4Yzgq7ZoeHRkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbfBKO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:56:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389155AbfBKO4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82E12229E;
        Mon, 11 Feb 2019 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896980;
        bh=4tDVT+EyQzS8QX60BG0z1CecYjs/ut2J5FFnD8aBKx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vnTTaeAvA15UZ3KE7e8lYidF0EDS520ErZwoMj+bqYm9kajR1L46VPF60Fl1z0dEu
         EcniyDPea7JWtFkQk5amRloeaNP5IsBDhBmTfuKu6F84fdx86ITGIRUDMFTtWVQqcV
         YZNYa5VQnIpDfESkTSsJ1sd6wbbj1Iyol+z1E1Ns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 021/205] staging:iio:ad2s90: Make probe handle spi_setup failure
Date:   Mon, 11 Feb 2019 15:16:59 +0100
Message-Id: <20190211141828.520585065@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index b2270908f26f..cbee9ad00f0d 100644
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



