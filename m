Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E563CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B836F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbeK1EJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:09:26 -0500
Received: from www.osadl.org ([62.245.132.105]:48621 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeK1EJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:09:26 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wARH81Zj008298;
        Tue, 27 Nov 2018 18:08:01 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] staging: iio: adc: ad7280a: check for devm_kasprint() failure
Date:   Tue, 27 Nov 2018 18:05:04 +0100
Message-Id: <1543338304-892-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignments to  attr.name  are not safe if not checked. On error
ad7280_attr_init() returns a negative return so -ENOMEM should be
OK here (passed on as return value of the probe function). To make the
error case more readable a temporary  iio_attr  is introduced and the code
refactored.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System2")
---

V2: use a tmp pointer to iio_attr to make the error check more readable
    as proposed by Dan Carpenter <dan.carpenter@oracle.com>

Problem located with an experimental coccinelle script

Patch was compile tested with: x86_64_defconfig + STAGING=y
SPI=y, IIO=y, AD7280=m

Patch is against 4.20-rc4 (localversion-next is next-20181127)

 drivers/staging/iio/adc/ad7280a.c | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0bb9ab1..7a0ba26 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -561,6 +561,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
 	unsigned int index;
+	struct iio_dev_attr *iio_attr;
 
 	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
 				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
@@ -571,37 +572,35 @@ static int ad7280_attr_init(struct ad7280_state *st)
 	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
 			ch++, cnt++) {
+			iio_attr = &st->iio_attr[cnt];
 			index = dev * AD7280A_CELLS_PER_DEV + ch;
-			st->iio_attr[cnt].address =
-				ad7280a_devaddr(dev) << 8 | ch;
-			st->iio_attr[cnt].dev_attr.attr.mode =
-				0644;
-			st->iio_attr[cnt].dev_attr.show =
-				ad7280_show_balance_sw;
-			st->iio_attr[cnt].dev_attr.store =
-				ad7280_store_balance_sw;
-			st->iio_attr[cnt].dev_attr.attr.name =
+			iio_attr->address = ad7280a_devaddr(dev) << 8 | ch;
+			iio_attr->dev_attr.attr.mode = 0644;
+			iio_attr->dev_attr.show = ad7280_show_balance_sw;
+			iio_attr->dev_attr.store = ad7280_store_balance_sw;
+			iio_attr->dev_attr.attr.name =
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_switch_en",
 					       index, index + 1);
-			ad7280_attributes[cnt] =
-				&st->iio_attr[cnt].dev_attr.attr;
+			if (!iio_attr->dev_attr.attr.name)
+				return -ENOMEM;
+
+			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
 			cnt++;
-			st->iio_attr[cnt].address =
-				ad7280a_devaddr(dev) << 8 |
+			iio_attr = &st->iio_attr[cnt];
+			iio_attr->address = ad7280a_devaddr(dev) << 8 |
 				(AD7280A_CB1_TIMER + ch);
-			st->iio_attr[cnt].dev_attr.attr.mode =
-				0644;
-			st->iio_attr[cnt].dev_attr.show =
-				ad7280_show_balance_timer;
-			st->iio_attr[cnt].dev_attr.store =
-				ad7280_store_balance_timer;
-			st->iio_attr[cnt].dev_attr.attr.name =
+			iio_attr->dev_attr.attr.mode = 0644;
+			iio_attr->dev_attr.show = ad7280_show_balance_timer;
+			iio_attr->dev_attr.store = ad7280_store_balance_timer;
+			iio_attr->dev_attr.attr.name =
 				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
 					       "in%d-in%d_balance_timer",
 					       index, index + 1);
-			ad7280_attributes[cnt] =
-				&st->iio_attr[cnt].dev_attr.attr;
+			if (!iio_attr->dev_attr.attr.name)
+				return -ENOMEM;
+
+			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
 		}
 
 	ad7280_attributes[cnt] = NULL;
-- 
2.1.4

