Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeFDHFA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753875AbeFDHE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Nosthoff <committed@heine.so>,
        Stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.16 25/47] iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ
Date: Mon,  4 Jun 2018 08:58:37 +0200
Message-Id: <20180604065550.543342991@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Nosthoff <committed@heine.so>

commit 490fba90a90eb7b741f57fefd2bcf2c1e11eb471 upstream.

This commit is a follow-up to changes made to ad_sigma_delta.h
in staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ
which broke ad7793 as it was not altered to match those changes.

This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ
attribute wherein usage has some advantages like it can be accessed by
in-kernel consumers as well as reduces the code size.

Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the
sampling_frequency attribute instead of using IIO_DEV_ATTR_SAMP_FREQ()
macro.

Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ()
into respective read and write hooks with the mask set to
IIO_CHAN_INFO_SAMP_FREQ.

Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ")

Signed-off-by: Michael Nosthoff <committed@heine.so>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ad7793.c |   75 +++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 51 deletions(-)

--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -348,55 +348,6 @@ static const u16 ad7793_sample_freq_avai
 static const u16 ad7797_sample_freq_avail[16] = {0, 0, 0, 123, 62, 50, 0,
 					33, 0, 17, 16, 12, 10, 8, 6, 4};
 
-static ssize_t ad7793_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n",
-	       st->chip_info->sample_freq_avail[AD7793_MODE_RATE(st->mode)]);
-}
-
-static ssize_t ad7793_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
-	long lval;
-	int i, ret;
-
-	ret = kstrtol(buf, 10, &lval);
-	if (ret)
-		return ret;
-
-	if (lval == 0)
-		return -EINVAL;
-
-	for (i = 0; i < 16; i++)
-		if (lval == st->chip_info->sample_freq_avail[i])
-			break;
-	if (i == 16)
-		return -EINVAL;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	st->mode &= ~AD7793_MODE_RATE(-1);
-	st->mode |= AD7793_MODE_RATE(i);
-	ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), st->mode);
-	iio_device_release_direct_mode(indio_dev);
-
-	return len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ad7793_read_frequency,
-		ad7793_write_frequency);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 	"470 242 123 62 50 39 33 19 17 16 12 10 8 6 4");
 
@@ -424,7 +375,6 @@ static IIO_DEVICE_ATTR_NAMED(in_m_in_sca
 		ad7793_show_scale_available, NULL, 0);
 
 static struct attribute *ad7793_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
 	NULL
@@ -435,7 +385,6 @@ static const struct attribute_group ad77
 };
 
 static struct attribute *ad7797_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
 	NULL
 };
@@ -505,6 +454,10 @@ static int ad7793_read_raw(struct iio_de
 			*val -= offset;
 		}
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->chip_info
+			       ->sample_freq_avail[AD7793_MODE_RATE(st->mode)];
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -542,6 +495,26 @@ static int ad7793_write_raw(struct iio_d
 				break;
 			}
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val) {
+			ret = -EINVAL;
+			break;
+		}
+
+		for (i = 0; i < 16; i++)
+			if (val == st->chip_info->sample_freq_avail[i])
+				break;
+
+		if (i == 16) {
+			ret = -EINVAL;
+			break;
+		}
+
+		st->mode &= ~AD7793_MODE_RATE(-1);
+		st->mode |= AD7793_MODE_RATE(i);
+		ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode),
+				st->mode);
+		break;
 	default:
 		ret = -EINVAL;
 	}
