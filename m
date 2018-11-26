Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBD2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9331B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9331B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeKZUiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:38:11 -0500
Received: from www.osadl.org ([62.245.132.105]:51445 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeKZUiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:38:11 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wAQ9g1B1010454;
        Mon, 26 Nov 2018 10:42:01 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: iio: adc: ad7280a: check for devm_kasprint() failure
Date:   Mon, 26 Nov 2018 10:39:04 +0100
Message-Id: <1543225144-27468-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignments to  attr.name  are not safe if not checked. On error
ad7280_attr_init() returns a negative return so -ENOMEM should be
OK here (passed on as return value of the probe function).

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
---

Problem located with an experimental coccinelle script

As using   if(!st->iio_attr[cnt].dev_attr.attr.name)  seamed quite
unreadable in this case the  (var  == NULL)  variant was used. Not
sure if there are objections against this (checkpatch.pl issues
a CHECK on this).

Patch was compile tested with: x86_64_defconfig + STAGING=y
SPI=y, IIO=y, AD7280=m

Patch is against 4.20-rc4 (localversion-next is next-20181126)

 drivers/staging/iio/adc/ad7280a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0bb9ab1..5b87530 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -584,6 +584,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_switch_en",
 					       index, index + 1);
+			if (st->iio_attr[cnt].dev_attr.attr.name  == NULL)
+				return -ENOMEM;
+
 			ad7280_attributes[cnt] =
 				&st->iio_attr[cnt].dev_attr.attr;
 			cnt++;
@@ -600,6 +603,9 @@ static int ad7280_attr_init(struct ad7280_state *st)
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_timer",
 					       index, index + 1);
+			if (st->iio_attr[cnt].dev_attr.attr.name == NULL)
+				return -ENOMEM;
+
 			ad7280_attributes[cnt] =
 				&st->iio_attr[cnt].dev_attr.attr;
 		}
-- 
2.1.4

