Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCLSWA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:22:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45559 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeCLSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:21:58 -0400
X-Google-Smtp-Source: AG47ELsGurStcvBLnwt1J/zd3pvR72+W7VcvJTvG2RKFbBRSwwvZELyg11qrYqM84+A0am+lwCd7Og==
Date: Mon, 12 Mar 2018 15:21:52 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging:iio:ad2s1210: Add write_raw to handle frequency
Message-ID: <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write interface of AD2S1210 utilizes IIO_DEVICE_ATTR, which violate
the official IIO ABI. This patch, add the write_raw function responsible
for handling the fclkin and fexcit channel; also it removes the use of
IIO_DEVICE_ATTR for fclkin and fexcit.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 117 +++++++++++++++-----------------
 1 file changed, 55 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 27a42ed10fcd..ea6ade4e563c 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -60,6 +60,8 @@
 
 #define AD2S1210_DEF_EXCIT	10000
 
+#define ERROR_MESSAGE "ad2s1210: %s out of range\n"
+
 enum ad2s1210_mode {
 	MOD_POS = 0,
 	MOD_VEL,
@@ -210,64 +212,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-static ssize_t ad2s1210_store_fclkin(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fclkin;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fclkin);
-	if (ret)
-		return ret;
-	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
-		dev_err(dev, "ad2s1210: fclkin out of range\n");
-		return -EINVAL;
-	}
-
-	mutex_lock(&st->lock);
-	st->fclkin = fclkin;
-
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
-static ssize_t ad2s1210_store_fexcit(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fexcit;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fexcit);
-	if (ret < 0)
-		return ret;
-	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
-		dev_err(dev,
-			"ad2s1210: excitation frequency out of range\n");
-		return -EINVAL;
-	}
-	mutex_lock(&st->lock);
-	st->fexcit = fexcit;
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
 static ssize_t ad2s1210_show_control(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -545,8 +489,58 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644, NULL, ad2s1210_store_fclkin, 0);
-static IIO_DEVICE_ATTR(fexcit, 0644, NULL, ad2s1210_store_fexcit, 0);
+static int ad2s1210_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	unsigned int clk = val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		switch (chan->channel) {
+		case FCLKIN:
+			if (clk < AD2S1210_MIN_CLKIN ||
+			    clk > AD2S1210_MAX_CLKIN) {
+				dev_err(&indio_dev->dev, ERROR_MESSAGE,
+					"fclkin");
+				ret = -EINVAL;
+				goto error_ret;
+			}
+			mutex_lock(&st->lock);
+			st->fclkin = clk;
+			break;
+		case FEXCIT:
+			if (clk < AD2S1210_MIN_EXCIT ||
+			    clk > AD2S1210_MAX_EXCIT) {
+				dev_err(&indio_dev->dev, ERROR_MESSAGE,
+					"excitation frequency");
+				ret = -EINVAL;
+				goto error_ret;
+			}
+			mutex_lock(&st->lock);
+			st->fexcit = clk;
+			break;
+		default:
+			ret = -EINVAL;
+			goto error_ret;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	}
+	ret = ad2s1210_update_frequency_control_word(st);
+	if (ret < 0)
+		goto error_unlock_mutex;
+	ret = ad2s1210_soft_reset(st);
+error_unlock_mutex:
+	mutex_unlock(&st->lock);
+error_ret:
+	return ret;
+}
+
 static IIO_DEVICE_ATTR(control, 0644,
 		       ad2s1210_show_control, ad2s1210_store_control, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
@@ -577,8 +571,6 @@ static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
 		       AD2S1210_REG_LOT_LOW_THRD);
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fclkin.dev_attr.attr,
-	&iio_dev_attr_fexcit.dev_attr.attr,
 	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
@@ -635,6 +627,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
+	.write_raw = ad2s1210_write_raw,
 	.attrs = &ad2s1210_attribute_group,
 };
 
-- 
2.16.2
