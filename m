Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeCLSVo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:21:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43390 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:21:42 -0400
X-Google-Smtp-Source: AG47ELsPWwaHrtYydqN8zNra2Mo3DaV7JhRwtPJixMmiPF9uN9LgBVCokuIpw7d5HFvIGAEZDyDevw==
Date: Mon, 12 Mar 2018 15:21:36 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Graff Yang <graff.yang@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging:iio:ad2s1210: Add frequency handler in read_raw
Message-ID: <9296eddbaaa4f815978ce9433c7970a3a498d85b.1520878492.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read data from fclkin and fexcit does not utilize the ad2s1210_read_raw
function. This patch, append the required handler in the
ad2s1210_read_raw to return the correct value. Also, this patch removes
the legacy code related to the read function

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 45 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 28c3fd439663..27a42ed10fcd 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -210,15 +210,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-static ssize_t ad2s1210_show_fclkin(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fclkin);
-}
-
 static ssize_t ad2s1210_store_fclkin(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf,
@@ -249,15 +240,6 @@ static ssize_t ad2s1210_store_fclkin(struct device *dev,
 	return ret < 0 ? ret : len;
 }
 
-static ssize_t ad2s1210_show_fexcit(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fexcit);
-}
-
 static ssize_t ad2s1210_store_fexcit(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
@@ -486,7 +468,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val,
 			     int *val2,
-			     long m)
+			     long mask)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
 	u16 negative;
@@ -535,23 +517,36 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		*val = vel;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_FREQUENCY:
+		ret = IIO_VAL_INT;
+		switch (chan->channel) {
+		case FCLKIN:
+			*val = st->fclkin;
+			goto unlock_mutex;
+		case FEXCIT:
+			*val = st->fexcit;
+			goto unlock_mutex;
+		default:
+			ret = -EINVAL;
+			goto unlock_mutex;
+		}
+		break;
 	default:
-		mutex_unlock(&st->lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto unlock_mutex;
 	}
 
 error_ret:
 	gpio_set_value(st->pdata->sample, 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
+unlock_mutex:
 	mutex_unlock(&st->lock);
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644,
-		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
-static IIO_DEVICE_ATTR(fexcit, 0644,
-		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
+static IIO_DEVICE_ATTR(fclkin, 0644, NULL, ad2s1210_store_fclkin, 0);
+static IIO_DEVICE_ATTR(fexcit, 0644, NULL, ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(control, 0644,
 		       ad2s1210_show_control, ad2s1210_store_control, 0);
 static IIO_DEVICE_ATTR(bits, 0644,
-- 
2.16.2
