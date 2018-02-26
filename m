Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225NEHtaDH0Af3c4QyctoAs2bUMpBM/HsJbbTLoEq+qC74AySHmzYAu4yRmNzuGfZPuPIige
ARC-Seal: i=1; a=rsa-sha256; t=1519676810; cv=none;
        d=google.com; s=arc-20160816;
        b=grkvjwSZpTQFzqdKfMtlqi/s2hCjntPMLyWIBleeFOx5eFCs62jYrwSnmjjzyKripx
         3LiNL2vDQ36BNNng+1uQWHo21AmmpU7jAavT0Ao/Kdg9gReajo0PxbFISZF7kJJN6bYd
         qllE1W6Le94c9re1a0b7N5bKYVPwqjG040BhbnXGuRaGl1PHVtvWlnA6jkHWwbOX2FsW
         NJReSqszhMQQs6OubuDTAjtOL3RsO9awtIXWVTpIQRZaiTZcT0FcKCFU1VTOzQIGe0hq
         oCbQ7zUaIuw3ERc6YjwpEefV1hSPki3TIpaxB+KmqQ2Acfyn/gNdeZQu0t8iAqCJvhZt
         BQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PU5TZvAhChUsLi3+hZM+BQQbVZiZ/sDo3YBTHqhV7Kg=;
        b=Tcgn5IHbDuqh3/kyBKACD//tcfVIvdwTU588xmXRTEdiPFDPu0EDOkjawsP/DI+Khh
         era2WPiwwJEyqEesC0jBpW1Ao9b7ukI9qado7EPtJmIWyCqNW9JqwN3mkIqwDDGHJwqo
         ChFuWUzBIZ1eVFkgP8jA4p63lEGOqS6n6lfueTHIuAYPOkEXzGZw4l1KGX+JAp5RGp/K
         hSjHxJ0TewVTvSJ2F65yuYxNTc6x8vgV+RsrIHS7eWrAKM/uDM9ieht0rUvWn6JRyEHd
         yxGORRvEICSROEb0oN+VtrRvNE+cODYowTHXJ1TUTKsCWZUF+M/2Al0Axj9zq8YRufrm
         txCw==
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
Subject: [PATCH 4.15 22/64] iio: adc: stm32: fix stm32h7_adc_enable error handling
Date: Mon, 26 Feb 2018 21:21:59 +0100
Message-Id: <20180226202154.411957860@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496448510056884?=
X-GMAIL-MSGID: =?utf-8?q?1593496631076370567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -765,8 +765,6 @@ static int stm32h7_adc_enable(struct stm
 	int ret;
 	u32 val;
 
-	/* Clear ADRDY by writing one, then enable ADC */
-	stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
 
 	/* Poll for ADRDY to be set (after adc startup time) */
@@ -774,8 +772,11 @@ static int stm32h7_adc_enable(struct stm
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
