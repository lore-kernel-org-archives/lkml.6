Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/apoKWa1F2Py4j1dUiy7A+X4wedcXBCXazppbp/LMe9cA7QWaMPPwVW6YQs7Yklu/CADgS
ARC-Seal: i=1; a=rsa-sha256; t=1522168809; cv=none;
        d=google.com; s=arc-20160816;
        b=Bx9t5OcE0PkP+P8otWiHC4lq3HlUJv1xZ1tkEBrMngwk87MNk3Bfq/H3GbB3HzHjNt
         APer5I+0OAwRCb1w5Wdl9EH4LSrBFCbWXuDiiDe8isgYK5asnCG4u2T5qEpW55ufefrt
         KSU+F7O/bRPObcU9hoMuXWtDcm7u/XA8CyDh3DvCSwOCOibOonOSPKxplnDT44McjOwo
         wrj4HlbmpG9p35LIq3vkgtfcUnJp+U2kdrb3ePyQMYs9ZIbeQVoziL46/6etpYLDrNoP
         pHR7IzzOXYWNtEpsBogFkX+pt5EvQmjLFWLAvEm6F8vsAl9kfESIHhaJOJeY+Gj3IDgJ
         5fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FV1BxhllvJIywl4FYaWziSiOo3iF00QCOdjdjTI5U3A=;
        b=IRuPtooEjzZEQWO0nk4B0updjfkd6UmpJvB40fInYgN7poMIEFFSzRxlEDhj4KMyhq
         NLamVpUJWjIxc7aclChR3R2m1bvaPX3j49UM5Qs+qT7N2uRkoJpKGBloISn5qDA8ENY7
         tspoh12J0fYmLCrLOXXuoUqDHNRaXUjo0POOmvmBPgXgykJcuVSIwoo5htf6Nby02Yxs
         e6BAJgZAIDwPJbVfxTeS3ECFgnlPCQr7VLAvk4QJW3Q+54HVPzBMynecdP9WLel6ecbr
         BFnC6oOml71FzHt33zcr2mpuAfbDjWxDFCnb9bYY1pErCMT6+IwXT4eiB38SzOhXjpzF
         0zSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 008/105] iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()
Date: Tue, 27 Mar 2018 18:26:48 +0200
Message-Id: <20180327162758.196506665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109334162552316?=
X-GMAIL-MSGID: =?utf-8?q?1596109681147337202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 3c3e4b3a708a9d6451052e348981f37d2b3e92b0 upstream.

The meson_sar_adc_lock() function is not supposed to hold the
"indio_dev->mlock" on the error path.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/meson_saradc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -462,8 +462,10 @@ static int meson_sar_adc_lock(struct iio
 			regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
 		} while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
 
-		if (timeout < 0)
+		if (timeout < 0) {
+			mutex_unlock(&indio_dev->mlock);
 			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
