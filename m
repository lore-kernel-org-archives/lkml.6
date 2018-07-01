Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A774A252A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A774A252A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030752AbeGAQdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:33:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbeGAQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ECC8E49B;
        Sun,  1 Jul 2018 16:33:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 091/157] iio: adc: ad7791: remove sample freq sysfs attributes
Date:   Sun,  1 Jul 2018 18:22:43 +0200
Message-Id: <20180701160857.109002318@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 7eb6b35d93c356f1afebbfb808bc296d6351e708 upstream.

In the current state, these attributes are broken, because they are
registered already, and the kernel throws a warning.
The first registration happens via the `IIO_CHAN_INFO_SAMP_FREQ` flag from
the `ad_sigma_delta` driver.

In this commit these attrs are removed, and in the following the
IIO_CHAN_INFO_SAMP_FREQ behavior will be implemented, which replaces these
hooks.

This is done to make things a bit easier to review as there is a bit of
overlap in the patch if it's done all at once.

Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ad7791.c |   49 -----------------------------------------------
 1 file changed, 49 deletions(-)

--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -244,58 +244,9 @@ static int ad7791_read_raw(struct iio_de
 	return -EINVAL;
 }
 
-static const char * const ad7791_sample_freq_avail[] = {
-	[AD7791_FILTER_RATE_120] = "120",
-	[AD7791_FILTER_RATE_100] = "100",
-	[AD7791_FILTER_RATE_33_3] = "33.3",
-	[AD7791_FILTER_RATE_20] = "20",
-	[AD7791_FILTER_RATE_16_6] = "16.6",
-	[AD7791_FILTER_RATE_16_7] = "16.7",
-	[AD7791_FILTER_RATE_13_3] = "13.3",
-	[AD7791_FILTER_RATE_9_5] = "9.5",
-};
-
-static ssize_t ad7791_read_frequency(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7791_state *st = iio_priv(indio_dev);
-	unsigned int rate = st->filter & AD7791_FILTER_RATE_MASK;
-
-	return sprintf(buf, "%s\n", ad7791_sample_freq_avail[rate]);
-}
-
-static ssize_t ad7791_write_frequency(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7791_state *st = iio_priv(indio_dev);
-	int i, ret;
-
-	i = sysfs_match_string(ad7791_sample_freq_avail, buf);
-	if (i < 0)
-		return i;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	st->filter &= ~AD7791_FILTER_RATE_MASK;
-	st->filter |= i;
-	ad_sd_write_reg(&st->sd, AD7791_REG_FILTER, sizeof(st->filter),
-			st->filter);
-	iio_device_release_direct_mode(indio_dev);
-
-	return len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ad7791_read_frequency,
-		ad7791_write_frequency);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("120 100 33.3 20 16.7 16.6 13.3 9.5");
 
 static struct attribute *ad7791_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };


