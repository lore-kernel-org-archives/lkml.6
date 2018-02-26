Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvoCGPF1IBEX5q7WVPMP2h6vRLOs90cGMttNt0Qp/G46pkH+au5zNtAFb2QRp9VwwF414D+
ARC-Seal: i=1; a=rsa-sha256; t=1519676636; cv=none;
        d=google.com; s=arc-20160816;
        b=KpoljBVgEIa0C4V93Mo6RYIxdFGKzpvotlFx9yiZVoo2vKV2n6I3bLurXoUWihKZ5R
         tDhQx+q857SabwSKpyhxwFhPu5aeZCCecdTVTT6jx/SK+p+pEYbIsIp0OrQ2jGgi68tm
         O99K+uwkuifTUdBrbSQ6PSEmFKWlL1462MmiaeuqiTGvZKotKH6MOv28enPABarFbxMY
         GKE/kpIQFd6Acvhb6XX5A9b4YNSdyYUQ8jJkId82nNXhzIOSzIhMirOPc55X19mt39kj
         tbsoPWdK7VgjNgpSs23Kmtie7PiIfn++hYeagD7+50UdzTcVAryiDvCNSoZPGQopMnSy
         tPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nj9t3hySp4V9grbFqVBZ+iMgpP/aWdwMlyWLQNKiFB8=;
        b=VtnW1L7RAnPUkQFpxdsUjEGSQPUp2+6JzWhg4Eosrurcqp7ABBYGW2IaTJzyVtaCDx
         xmxOuterAaPveKaMSmbgdrklSQRG7Zsifc+CsHDen7T7k+w1X9oQJ5Kq4veJJnkt0enY
         pXVK12bmDsqrRABy2DvViz056pkhI/Mo1Co0sGOdOm1ZCUoYkiHoYYm0yArlj7neb8mz
         dJSn60w0PfBn6n/KXoyakHmugP/ZudNrOd8QsIXEvFjAYFm8xC19h8h9QlZt+ZLDYL7R
         tdsIKatps5HujfwHx6d2B05hkWz1sJvyokPXQBjTQuaLtkC5h7VhONHusSudsmcVCkKD
         Qfvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 21/54] iio: adc: stm32: fix stm32h7_adc_enable error handling
Date: Mon, 26 Feb 2018 21:21:58 +0100
Message-Id: <20180226202145.463670002@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496448510056884?=
X-GMAIL-MSGID: =?utf-8?q?1593496448510056884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit a3b5655ebdb501a98a45c0d3265dca9f2fe0218a upstream.

Error handling in stm32h7_adc_enable routine doesn't unwind enable
sequence correctly. ADEN can only be cleared by hardware (e.g. by
writing one to ADDIS).
It's also better to clear ADRDY just after it's been set by hardware.

Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/stm32-adc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -764,8 +764,6 @@ static int stm32h7_adc_enable(struct stm
 	int ret;
 	u32 val;
 
-	/* Clear ADRDY by writing one, then enable ADC */
-	stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
 
 	/* Poll for ADRDY to be set (after adc startup time) */
@@ -773,8 +771,11 @@ static int stm32h7_adc_enable(struct stm
 					   val & STM32H7_ADRDY,
 					   100, STM32_ADC_TIMEOUT_US);
 	if (ret) {
-		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADDIS);
 		dev_err(&indio_dev->dev, "Failed to enable ADC\n");
+	} else {
+		/* Clear ADRDY by writing one */
+		stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
 	}
 
 	return ret;
