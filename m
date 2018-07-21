Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC740ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5E020854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nCNjbldw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5E020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeGUT7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:59:38 -0400
Received: from vern.gendns.com ([206.190.152.46]:51589 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbeGUT7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zRBBApzPTiZFdXFZSi3cUhjHkk3VpOYb1ojHmjbSxfk=; b=nCNjbldw2pA4PBQLe0tJVBw+21
        LN9KsHDyxY7O2CM3JbLISYlTt6TX86HrKEGgAHM5VX+AsAO/HzLuMF0/i84O8o3OT5a4GrKAdLGm5
        GwZbisiqg0A1JxYVN6sVPtbmMrzcUsXUGkkeAnQWNAZXAqhVTKxaqMDoI7hS7VeECKfoFE4LdxBCf
        vT69Xt0K8alZuHYEq++O8qTIhUFQ4OoXxnleXqKAmL16VR6WlOfwepltrP4TvDYrUW+6R8fFR/9BO
        nQcmzPkegMmafY4bstZHig2+B1oApR+TuoycgLTDIMdzPaeOPb90nY4dGwOCHkKhMLH91S6GWxy9B
        qQlkdA6w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:34568 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgxCQ-009XxO-Pb; Sat, 21 Jul 2018 15:05:50 -0400
Subject: Re: [PATCH 4/4] iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU
 usage
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-5-david@lechnology.com>
 <20180721185138.673bee00@archlinux>
From:   David Lechner <david@lechnology.com>
Message-ID: <e564e3c9-2fea-b203-ca39-ea94ba2b83b0@lechnology.com>
Date:   Sat, 21 Jul 2018 14:05:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180721185138.673bee00@archlinux>
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

On 07/21/2018 12:51 PM, Jonathan Cameron wrote:
> On Mon, 16 Jul 2018 22:20:52 -0500
> David Lechner <david@lechnology.com> wrote:
> 
>> This changes how the SPI message for the triggered buffer is setup in
>> the TI ADS7950 A/DC driver. By using the SPI_CS_WORD flag, we can read
>> multiple samples in a single SPI transfer. If the SPI controller
>> supports DMA transfers, we can see a significant reduction in CPU usage.
>>
>> For example, on an ARM9 system running at 456MHz reading just 4 channels
>> at 100Hz: before this change, top shows the CPU usage of the IRQ thread
>> of this driver to be ~7.7%. After this change, the CPU usage drops to
>> ~3.8%.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> Hmm. There is a userspace ABI change in here, though it shouldn't matter
> as long as people are using the full ABI rather than running some
> scripts that make assumptions.
> 
> It's quite nice if we have all the relevant emulation in the SPI core
> that this doesn't break things on any spi controllers.
> 
> Jonathan
> 
>> ---
>>
>> Dependency: this patch applies on top of "iio: adc: ti-ads7950: allow
>> simultaneous use of buffer and direct mode"[1]
>>
>> [1]: https://lore.kernel.org/lkml/20180716233550.6449-1-david@lechnology.com/
>>
>>
>>   drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
>>   1 file changed, 31 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>> index ba7e5a027490..60de4cbbd5fc 100644
>> --- a/drivers/iio/adc/ti-ads7950.c
>> +++ b/drivers/iio/adc/ti-ads7950.c
>> @@ -60,7 +60,7 @@
>>   struct ti_ads7950_state {
>>   	struct iio_dev		*indio_dev;
>>   	struct spi_device	*spi;
>> -	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
>> +	struct spi_transfer	ring_xfer;
>>   	struct spi_transfer	scan_single_xfer[3];
>>   	struct spi_message	ring_msg;
>>   	struct spi_message	scan_single_msg;
>> @@ -69,16 +69,16 @@ struct ti_ads7950_state {
>>   	unsigned int		vref_mv;
>>   
>>   	unsigned int		settings;
>> -	__be16			single_tx;
>> -	__be16			single_rx;
>> +	u16			single_tx;
>> +	u16			single_rx;
>>   
>>   	/*
>>   	 * DMA (thus cache coherency maintenance) requires the
>>   	 * transfer buffers to live in their own cache lines.
>>   	 */
>> -	__be16	rx_buf[TI_ADS7950_MAX_CHAN + TI_ADS7950_TIMESTAMP_SIZE]
>> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2 + TI_ADS7950_TIMESTAMP_SIZE]
>>   							____cacheline_aligned;
>> -	__be16	tx_buf[TI_ADS7950_MAX_CHAN];
>> +	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];
>>   };
>>   
>>   struct ti_ads7950_chip_info {
>> @@ -116,7 +116,7 @@ enum ti_ads7950_id {
>>   		.realbits = bits,				\
>>   		.storagebits = 16,				\
>>   		.shift = 12 - (bits),				\
>> -		.endianness = IIO_BE,				\
>> +		.endianness = IIO_CPU,				\
> 
> Hmm. I'm getting a little dubious.  This is a userspace ABI change - it 'might'
> break someone.  We'd have to cross our fingers it doesn't.

Dubious is a good word for this. ;-)

I was hoping that we could try to get away with this anyway. If someone
complains, we can always change it back, right? And if no one complains, then
did we really break anything?

I'll have to play around with the a default SPI_CS_WORD implementation first
to make sure it won't influence this either.


