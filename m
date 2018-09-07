Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B949C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C53206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C53206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbeIHC3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:29:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbeIHC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:18 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A2D4F36;
        Fri,  7 Sep 2018 21:45:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3.18 08/29] iio: ad9523: Fix displayed phase
Date:   Fri,  7 Sep 2018 23:10:29 +0200
Message-Id: <20180907210910.179946993@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

commit 5a4e33c1c53ae7d4425f7d94e60e4458a37b349e upstream.

Fix the displayed phase for the ad9523 driver. Currently the most
significant decimal place is dropped and all other digits are shifted one
to the left. This is due to a multiplication by 10, which is not necessary,
so remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: cd1678f9632 ("iio: frequency: New driver for AD9523 SPI Low Jitter Clock Generator")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/frequency/ad9523.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -641,7 +641,7 @@ static int ad9523_read_raw(struct iio_de
 		code = (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
 			AD9523_CLK_DIST_DIV_REV(ret);
 		*val = code / 1000000;
-		*val2 = (code % 1000000) * 10;
+		*val2 = code % 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;


