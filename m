Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvrnh6hi4Unb5hjnrSkIe/IHUpS4RhpZQsQ/BF9vTjk3mAiW/ED0xtbJDP1g40ITv/DqGF
ARC-Seal: i=1; a=rsa-sha256; t=1519410832; cv=none;
        d=google.com; s=arc-20160816;
        b=VeCSwxpf8OChje/JFuNk26RRXploTcfwmk/XSjATPsGTsh0BculTKXp7/AQdAWhtfm
         YsAmfMIZ5xl7fVvhzMSLlc8gW7NA4r6hfb3iJ3odBgvdmq32Om+QCV373Z21bEA6muS8
         zlRbZZGddyV8u7vVX14lxUrXuGVFr8KP3N3HrUzkRzGoz8QhDRrFtOw8apjsGNC5ng5u
         PI7JvEP7BrOocXP1O+l8q4k6F5KTRfsAUEvuWhqLcw0ya5vGyWnFmwpUxSnFZ6OD7QIC
         82k6oa0J+30on+18qkk/GEOQTy31jvOvBpt9Vre2KiHolvt9G91MkeqaKLTLrGmVxkZT
         xd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JWG8BGv1gyKh3rlQg7TGrWsh19Oaj18E3+ex3Y+RJNM=;
        b=gOjmuzdSU4pCG/fG5+te5F+ucMK1IIXdIZLuZRmo/BMhD06CPr5/97OxISR511jt0i
         3+iVffsx7XkTuyeyKbW0hkJfB4rlSlZBJlXE/GgvFf/E4SdyhOR+vh+EHwt21MHAY0D5
         HYHnuaTBlEirgIJTGR7/GcRqu8sB3on2KBDRLOU46rNV0OJ4mWQfn6cvso6sl5F/fHBH
         0kWt+h5hxzaRdn8WIcn8So7ZYgtklICjAH3L/tkcejCVjthlpOaLtIlVo7mI6CeHc3vj
         HOpA4rzTQ0L7fjzrg/uHPn1l9RLgmCDeSmTJbYqHjV8JOMfx0tcxEU4p0DvhKaxpNVuA
         0kjw==
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
Subject: [PATCH 4.4 028/193] staging: iio: adc: ad7192: fix external frequency setting
Date: Fri, 23 Feb 2018 19:24:21 +0100
Message-Id: <20180223170330.452883580@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217732777267779?=
X-GMAIL-MSGID: =?utf-8?q?1593217732777267779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -124,6 +124,8 @@
 #define AD7192_GPOCON_P1DAT	BIT(1) /* P1 state */
 #define AD7192_GPOCON_P0DAT	BIT(0) /* P0 state */
 
+#define AD7192_EXT_FREQ_MHZ_MIN	2457600
+#define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
 /* NOTE:
@@ -199,6 +201,12 @@ static int ad7192_calibrate_all(struct a
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
@@ -224,17 +232,20 @@ static int ad7192_setup(struct ad7192_st
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
