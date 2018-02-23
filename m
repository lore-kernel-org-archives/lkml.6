Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuEDOH+GUjMBdBS2F7JHzZSUfvm5qOKG57rA6/Lu2CXsspmCrtjoq1bhn8eWX5jkTPPtXCK
ARC-Seal: i=1; a=rsa-sha256; t=1519412308; cv=none;
        d=google.com; s=arc-20160816;
        b=Y5iihlVWLdyPOpg0EYKMhzjScUokHnWL0F1rXLgdN6ecDDL/MDnQjh+il8DseYD3QP
         jbodgAXIGDUQuhlaJPvetWWx1xpFSrg+9SezzOa+dRmpAJQIir85bKrr9qMO5rnolTDu
         /l8C+Il9/sON6GQH0cIz0px6KelY6n5mCkX4FGp9lOb2iubrZHgZj0jMG9ACMcYD9m1g
         5vrgttCdCyI05LBxdDFYKn/wjmzwpI27cQPVdckRalenYuvuubf4xrqiRb6QmTvWg4oW
         pWD/OH4YbWVS07GNvhrwdl1bQCc15nm/K4rURrL6dOt+J87RITZl0Y66K2Fh3KLfkb3d
         f1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D5jqqtaTbYyN57tVg1XyiiELB7zBDAVSgMNTN0UK4CI=;
        b=iIX3bGnJWJScECJrdmpsmPYUvjHsAKnZVbe1w77tnwhwJMOngTysQILs0FbF2PtmLb
         vPMBUsv8VBiZfu2TmKbobd1DY2yQsFWCwX62Q0eRDF3OIM4zW62GaGFB/aGFGjVgzj/b
         6xIxBLJojLSL9utn4FCVoo/h03BJwXQGihQWH1zPhJquwtpMtv45tPqR8jDGIkOf58Ab
         zVaTPhWE63oOhc/ddV5qlnQDxHc6xoGM2PWGxYGDIGCB7yFMBxBbUeMKStWU+ZHR+3h+
         BZFV/uTuK1dkJyuybhFDH6xMq2dC82K7TlkqFkuek5c+QVoJr1E7DjLaofgS7m+1F3ZK
         tm6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 35/45] staging: iio: adc: ad7192: fix external frequency setting
Date: Fri, 23 Feb 2018 19:29:14 +0100
Message-Id: <20180223170720.902262954@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217732777267779?=
X-GMAIL-MSGID: =?utf-8?q?1593219281071051473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit e31b617d0a63c6558485aaa730fd162faa95a766 upstream.

The external clock frequency was set only when selecting
the internal clock, which is fixed at 4.9152 Mhz.

This is incorrect, since it should be set when any of
the external clock or crystal settings is selected.

Added range validation for the external (crystal/clock)
frequency setting.
Valid values are between 2.4576 and 5.12 Mhz.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/adc/ad7192.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -141,6 +141,8 @@
 #define AD7192_GPOCON_P1DAT	BIT(1) /* P1 state */
 #define AD7192_GPOCON_P0DAT	BIT(0) /* P0 state */
 
+#define AD7192_EXT_FREQ_MHZ_MIN	2457600
+#define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
 /* NOTE:
@@ -218,6 +220,12 @@ static int ad7192_calibrate_all(struct a
 				ARRAY_SIZE(ad7192_calib_arr));
 }
 
+static inline bool ad7192_valid_external_frequency(u32 freq)
+{
+	return (freq >= AD7192_EXT_FREQ_MHZ_MIN &&
+		freq <= AD7192_EXT_FREQ_MHZ_MAX);
+}
+
 static int ad7192_setup(struct ad7192_state *st,
 			const struct ad7192_platform_data *pdata)
 {
@@ -243,17 +251,20 @@ static int ad7192_setup(struct ad7192_st
 			 id);
 
 	switch (pdata->clock_source_sel) {
-	case AD7192_CLK_EXT_MCLK1_2:
-	case AD7192_CLK_EXT_MCLK2:
-		st->mclk = AD7192_INT_FREQ_MHZ;
-		break;
 	case AD7192_CLK_INT:
 	case AD7192_CLK_INT_CO:
-		if (pdata->ext_clk_hz)
-			st->mclk = pdata->ext_clk_hz;
-		else
-			st->mclk = AD7192_INT_FREQ_MHZ;
+		st->mclk = AD7192_INT_FREQ_MHZ;
 		break;
+	case AD7192_CLK_EXT_MCLK1_2:
+	case AD7192_CLK_EXT_MCLK2:
+		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
+			st->mclk = pdata->ext_clk_hz;
+			break;
+		}
+		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
+			pdata->ext_clk_hz);
+		ret = -EINVAL;
+		goto out;
 	default:
 		ret = -EINVAL;
 		goto out;
