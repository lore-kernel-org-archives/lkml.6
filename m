Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514B20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="gf2ygXnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B514B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIMTgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:36:37 -0400
Received: from vern.gendns.com ([206.190.152.46]:46517 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMTgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IZZgvUx9RJZ8uvSOM70gTpEseE17YXDOS1vzz42g9CM=; b=gf2ygXnOlv8/yenUmgXA4zOvbc
        E9zdQFFXvs0tSTeGHaKd6y/CGqfyozLC6bZmXZO8tbr6/Vlc9CAmdZ6BXVoZdtD4lksVV2dtON+JZ
        A2aR8FXrMexIF//fCeWF5Bepv5JESbGCFXsWzvt3GHkchtR6PomUo4DpkK4NEe01/zcLhQMqyRKA+
        sdImI08SfZCe1Y94DXzdgfl2DHndkZ3WJ3AKm3c0Z0z3g95DqvUreBl0r0a6W28iwXj0+BtinZIVp
        /muSLehWvUgf4s9f90vdZRlDxs/fxOlZdaGNhqGgIYTliWo1OLJbCYRvahsvAHGnij2VEVSjkgGgY
        Qo8/6T/A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42168 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g0Sa0-00BuOP-Jo; Thu, 13 Sep 2018 10:26:48 -0400
Subject: Re: [PATCH v2 4/4] spi: spi-davinci: Add support for SPI_CS_WORD
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180913003920.30600-1-david@lechnology.com>
 <20180913003920.30600-5-david@lechnology.com>
 <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <fb43f4d7-5b19-72be-9216-efdca9b59eba@lechnology.com>
Date:   Thu, 13 Sep 2018 09:26:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 08:44 AM, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Thu, Sep 13, 2018 at 2:40 AM David Lechner <david@lechnology.com> wrote:
>> This adds support for the SPI_CS_WORD flag to the TI DaVinci SPI
>> driver. This mode can be used as long as we are using the hardware
>> chip select and not a GPIO chip select.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   drivers/spi/spi-davinci.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>> index d502cf504deb..8f7dcbc53c57 100644
>> --- a/drivers/spi/spi-davinci.c
>> +++ b/drivers/spi/spi-davinci.c
>> @@ -230,7 +230,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
>>                                  !(spi->mode & SPI_CS_HIGH));
>>          } else {
>>                  if (value == BITBANG_CS_ACTIVE) {
>> -                       spidat1 |= SPIDAT1_CSHOLD_MASK;
>> +                       if (!(spi->mode & SPI_CS_WORD))
>> +                               spidat1 |= SPIDAT1_CSHOLD_MASK;
>>                          spidat1 &= ~(0x1 << chip_sel);
>>                  }
>>          }
>> @@ -440,8 +441,12 @@ static int davinci_spi_setup(struct spi_device *spi)
>>                          return retval;
>>                  }
>>
>> -               if (internal_cs)
>> +               if (internal_cs) {
>>                          set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
>> +               } else if (spi->mode & SPI_CS_WORD) {
>> +                       dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
>> +                       return -EINVAL;
> 
> Does the SPI core fall back to splitting the transfer in this case?

Hmm... it doesn't look like it.

I suppose it might be best to modify the SPI core to say:

	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
					  gpio_is_valid(spi->cs_gpio)) {

instead of:

	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {

Then we could drop the error above.

> 
>> +               }
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 

