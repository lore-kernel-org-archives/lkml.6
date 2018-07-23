Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E36AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6241420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6241420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbeGWKVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:21:33 -0400
Received: from www.osadl.org ([62.245.132.105]:41552 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388040AbeGWKVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:21:32 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6N9JV11016475;
        Mon, 23 Jul 2018 11:19:31 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] iio: ad_sigma_delta: use unsigned long for timeout
Date:   Mon, 23 Jul 2018 11:18:38 +0200
Message-Id: <1532337518-30085-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout returns unsigned long not int so an appropriate
variable is declared and the assignment and check fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

found by experimental coccinelle script

As the timeout returned is always << INT_MAX there is no side-effect with the
type conversion here, never the less proper types should be used.

Patch was compile tested with: x86_64_defconfig + CONFIG_SPI=y, CONFIG_IIO=y,
CONFIG_AD7793=y (implies CONFIG_AD_SIGMA_DELTA=y)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/iio/adc/ad_sigma_delta.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index cf1b048..fc95107 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -209,6 +209,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
 	int ret;
+	unsigned long timeout;
 
 	ret = ad_sigma_delta_set_channel(sigma_delta, channel);
 	if (ret)
@@ -224,8 +225,8 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
-	ret = wait_for_completion_timeout(&sigma_delta->completion, 2*HZ);
-	if (ret == 0) {
+	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
+	if (timeout == 0) {
 		sigma_delta->irq_dis = true;
 		disable_irq_nosync(sigma_delta->spi->irq);
 		ret = -EIO;
-- 
2.1.4

