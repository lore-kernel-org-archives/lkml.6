Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC42E21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900222;
	bh=etrS1Kz6BK30fnjPjvyFaEMr12ZI1VREWGPXVe8X5fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lkqHWiD6xkR8xwlOMNiW+z9zRvFonpNlUDLTOPND4q1EAkgKl9HlIU7WWLZ1jT4/T
	 r9vv9c0h7ZCQQ4G6SBbBGDniG5D0V1RJE0egE/WleXVTwQmPtebz4I3zvEUFxlvdhj
	 4pOv+tpgNNX5lFNH43lWOVIoO8FC81/mj5ChzbHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfBKPuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfBKOjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0764C204FD;
        Mon, 11 Feb 2019 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895946;
        bh=etrS1Kz6BK30fnjPjvyFaEMr12ZI1VREWGPXVe8X5fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ4CpGi8+jnfW2DdOgh6oksx45ByVxrxVyYr6gOpk4nOS1mNdD68ZMvppPWVWbsII
         W2pPHgY38uOxCuav6vWRQd1cBZidbAnN9D82eZsEsJD/tDAlEBVrH6B5iqT6Q8ryx1
         3OVtfSvYIVFFy/Ot8beDUTKreDC+D3jMehx4QEnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Slawomir Stepien <sst@poczta.fm>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/313] staging: iio: adc: ad7280a: handle error from __ad7280_read32()
Date:   Mon, 11 Feb 2019 15:14:43 +0100
Message-Id: <20190211141852.990426000@linuxfoundation.org>
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

[ Upstream commit 0559ef7fde67bc6c83c6eb6329dbd6649528263e ]

Inside __ad7280_read32(), the spi_sync_transfer() can fail with negative
error code. This change will ensure that this error is being passed up
in the call stack, so it can be handled.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/adc/ad7280a.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..6a48ad067a8b 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -256,7 +256,9 @@ static int ad7280_read(struct ad7280_state *st, unsigned int devaddr,
 	if (ret)
 		return ret;
 
-	__ad7280_read32(st, &tmp);
+	ret = __ad7280_read32(st, &tmp);
+	if (ret)
+		return ret;
 
 	if (ad7280_check_crc(st, tmp))
 		return -EIO;
@@ -294,7 +296,9 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
 
 	ad7280_delay(st);
 
-	__ad7280_read32(st, &tmp);
+	ret = __ad7280_read32(st, &tmp);
+	if (ret)
+		return ret;
 
 	if (ad7280_check_crc(st, tmp))
 		return -EIO;
@@ -327,7 +331,9 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
 	ad7280_delay(st);
 
 	for (i = 0; i < cnt; i++) {
-		__ad7280_read32(st, &tmp);
+		ret = __ad7280_read32(st, &tmp);
+		if (ret)
+			return ret;
 
 		if (ad7280_check_crc(st, tmp))
 			return -EIO;
@@ -370,7 +376,10 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 		return ret;
 
 	for (n = 0; n <= AD7280A_MAX_CHAIN; n++) {
-		__ad7280_read32(st, &val);
+		ret = __ad7280_read32(st, &val);
+		if (ret)
+			return ret;
+
 		if (val == 0)
 			return n - 1;
 
-- 
2.19.1



