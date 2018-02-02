Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225DzjCIaYq1STh/YZWLucwvCflFbt51iILc30KGd9SmUN1EjY1pw1hKC/QW3vsyMGISiurm
ARC-Seal: i=1; a=rsa-sha256; t=1517591654; cv=none;
        d=google.com; s=arc-20160816;
        b=TLEKEh1MsP8gpznVS5q11cV2jlZ/TaD51xCGHtRhMuQx4nhtHTCZN50spxnmN21lq4
         b9R3NANndMw7lb9ENQzwCemdpbyWiq7MwBNxOUU1yutE4hWQzrRK5psQGE7AQiRvUFwG
         N7d7PdZ/3CrKt9QU/09poJSv1Nw6sQ5BeK/l4DIMnrYW8IjOVUwNNfRLc4WwodGsTim2
         wLAV+c2rijMvud8Dz8U2+J0GUB4AopJWm8dL4PvlNMugMaJj529payatnIr5gpssC/3F
         IE1fW6kyn8fGd9KG1cFkP2gUJkP5faL+DEjPp7xFMBQvoAeleY0XzDnewaQLWbCE71dJ
         Rugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P6pRjxwNdx5i2w354yJB6SNcBvjFAveYa3OwtSKp6vI=;
        b=TsLSNwRAl948IkqS3gaQ35Z2K3PjwHvN8shtcdHj2kCnOSxs/RzKMJ+jUn1ekp5/Jg
         SaIY6eB5QhMKCeNlN+PXFWBNDczfnkojtAerLSLNjl1qxKpkFXsCRu3nqN8NsY2hE0ni
         v94UXWO8C+SMUPwTQE41z7ES+O1p1o+1zOqdnzjcOFGXSLcenh62tWHliWxmPIOZAcI9
         ELLWvtsy5WRQF2CGq5W2YjFCP77lfI/usX/xAkiteljoRKaOBH3m2G8t+VlGymQ6PXaV
         Z+SLf7W2NR76R2jlBpi2YiUr19YImbOrrz7uIaghjBNMP+rZO5u8U8YHPH0PeX6zihj2
         BQDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 152/156] iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels
Date: Fri,  2 Feb 2018 17:58:53 +0100
Message-Id: <20180202140847.279051738@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310186948803408?=
X-GMAIL-MSGID: =?utf-8?q?1591310186948803408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>

commit 8f114acd4e1a9cfa05b70bcc4219bc88197b5c9b upstream.

in_concentration_raw should report, according to sysfs-bus-iio documentation,
a "Raw (unscaled no offset etc.) percentage reading of a substance."

Modify scale to convert from ppm/ppb to percentage:
1 ppm = 0.0001%
1 ppb = 0.0000001%

There is no offset needed to convert the ppm/ppb to percentage,
so remove offset from IIO_CONCENTRATION (IIO_MOD_CO2) channel.

Cc'd stable to reduce chance of userspace breakage in the long
run as we fix this wrong bit of ABI usage.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/ccs811.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -91,7 +91,6 @@ static const struct iio_chan_spec ccs811
 		.channel2 = IIO_MOD_CO2,
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_OFFSET) |
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = 0,
 		.scan_type = {
@@ -245,24 +244,18 @@ static int ccs811_read_raw(struct iio_de
 			switch (chan->channel2) {
 			case IIO_MOD_CO2:
 				*val = 0;
-				*val2 = 12834;
+				*val2 = 100;
 				return IIO_VAL_INT_PLUS_MICRO;
 			case IIO_MOD_VOC:
 				*val = 0;
-				*val2 = 84246;
-				return IIO_VAL_INT_PLUS_MICRO;
+				*val2 = 100;
+				return IIO_VAL_INT_PLUS_NANO;
 			default:
 				return -EINVAL;
 			}
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_OFFSET:
-		if (!(chan->type == IIO_CONCENTRATION &&
-		      chan->channel2 == IIO_MOD_CO2))
-			return -EINVAL;
-		*val = -400;
-		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
