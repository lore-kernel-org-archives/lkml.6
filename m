Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0330EC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CB9217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBDHRL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:17:11 -0500
Received: from mail1.abatec.at ([81.10.186.19]:35322 "EHLO mail1.abatec.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBDHRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:17:10 -0500
Received: from exchange02.regau.abatec.at (192.168.100.22) by
 exchange02.regau.abatec.at (192.168.100.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 4 Feb 2019 08:17:07 +0100
Received: from exchange02.regau.abatec.at ([::1]) by
 exchange02.regau.abatec.at ([::1]) with mapi id 15.01.1415.002; Mon, 4 Feb
 2019 08:17:07 +0100
From:   Georg Ottinger <g.ottinger@abatec.at>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "Stefan Etzlstorfer" <s.etzlstorfer@abatec.at>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: AW: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Thread-Topic: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Thread-Index: AQHUuKGafWrpkxg4ckeOny6mkh/hBaXMP+cAgAMB7lA=
Date:   Mon, 4 Feb 2019 07:17:07 +0000
Message-ID: <0974ce54b3da4d82b6bd3026a3de5ff3@abatec.at>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
 <20190202102021.12bb0a72@archlinux>
In-Reply-To: <20190202102021.12bb0a72@archlinux>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.115.56]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually this issue occurred to us with an concrete product, where we experienced a system hang at -20 °C.
It was triggered by a race condition between the Touch Trigger and the Channel Trigger of the ADC. Once triggered we got in to the situation where an ongoing Channel Conversion was lost (Timeout case).When we queried a second channel than we got a system hang. Investigating this issue we developed an error demonstrator - reading alternating two channels as fast as possible (when Touch is enabled). This also provokes this issue at room temperature.

For the error demonstrator use following commandline to compile:

$ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o adc_demo_error2

-------------
// adc_demo_error.c
#include <unistd.h>
#include <fcntl.h>

#define VLEN 10

int main()
{
  int fd_adc,fd_adc2;
  int ret;
  char dummy[VLEN];
  
  fd_adc = open ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltage4_raw",O_RDONLY);  
#ifdef 2ND_CHANNEL
  fd_adc2 = open ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltage5_raw",O_RDONLY);
#endif

  while(1) {

    lseek(fd_adc, 0, SEEK_SET);
    ret = read(fd_adc, dummy, VLEN);
#ifdef 2ND_CHANNEL
    lseek(fd_adc2, 0, SEEK_SET);
    ret = read(fd_adc2, dummy, VLEN);
#endif

  }
}

------------


Greeting, Georg

-----Ursprüngliche Nachricht-----
Von: Jonathan Cameron [mailto:jic23@kernel.org] 
Gesendet: Samstag, 02. Februar 2019 11:21
An: Georg Ottinger <g.ottinger@abatec.at>
Cc: eugen.hristev@microchip.com; Stefan Etzlstorfer <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Nicolas Ferre <nicolas.ferre@microchip.com>; Alexandre Belloni <alexandre.belloni@bootlin.com>; Ludovic Desroches <ludovic.desroches@microchip.com>; David S. Miller <davem@davemloft.net>; Ard Biesheuvel <ard.biesheuvel@linaro.org>; Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Maxime Ripard <maxime.ripard@bootlin.com>
Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout case

On Wed, 30 Jan 2019 14:42:02 +0100
<g.ottinger@abatec.at> wrote:

> From: Georg Ottinger <g.ottinger@abatec.at>
> 
> Having a brief look at at91_adc_read_raw() it is obvious that in the 
> case of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR 
> registers is omitted. If 2 different channels are queried we can end 
> up with a situation where two interrupts are enabled, but only one 
> interrupt is cleared in the interrupt handler. Resulting in a 
> interrupt loop and a system hang.
> 
> Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>

Whilst I agree this looks like a correct change, I would like Maxime to take a look as he is obviously much more familiar with the driver than I am.

I suspect you can only actually get there in the event of a hardware failure as that isn't actually a timeout you should ever see.
Could be wrong though!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c 
> index 75d2f7358..596841a3c 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
>  						       st->done,
>  						       msecs_to_jiffies(1000));
> -		if (ret == 0)
> -			ret = -ETIMEDOUT;
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> -		}
> -
> -		*val = st->last_value;
>  
> +		/* Disable interrupts, regardless if adc conversion was
> +		 * successful or not
> +		 */
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
>  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>  
> -		st->last_value = 0;
> -		st->done = false;
> +		if (ret > 0) {
> +			/* a valid conversion took place */
> +			*val = st->last_value;
> +			st->last_value = 0;
> +			st->done = false;
> +			ret = IIO_VAL_INT;
> +		} else if (ret == 0) {
> +			/* conversion timeout */
> +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> +				chan->channel);
> +			ret = -ETIMEDOUT;
> +		}
> +
>  		mutex_unlock(&st->lock);
> -		return IIO_VAL_INT;
> +		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_mv;

