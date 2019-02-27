Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA85C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60049218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfB0BzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:55:12 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:38622 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfB0BzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:55:12 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gyoR9-0007G9-AJ from Jiada_Wang@mentor.com ; Tue, 26 Feb 2019 17:55:07 -0800
Received: from [172.30.112.229] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 26 Feb 2019 17:55:04 -0800
Subject: Re: Bug in spi: imx: Add support for SPI Slave mode
To:     Trent Piepho <tpiepho@impinj.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>
References: <20170905051232.21203-1-jiada_wang@mentor.com>
 <1551217306.3075.188.camel@impinj.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <2ea41684-69b2-e7e8-0d2b-325c799104e1@mentor.com>
Date:   Wed, 27 Feb 2019 10:55:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551217306.3075.188.camel@impinj.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trent

Thanks for reporting

On 2019/02/27 6:41, Trent Piepho wrote:
> On Tue, 2017-09-05 at 14:12 +0900, Jiada Wang wrote:
>> Previously i.MX SPI controller only works in Master mode.
>> This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
>> controller to work also in Slave mode.
> 
> Recently DMA has been enabled for imx6/7 with SPI.  This results in
> memory corruption in some instances I've traced the problem to this
> patch.
> 
> 
>>   static int spi_imx_transfer(struct spi_device *spi,
>>   				struct spi_transfer *transfer)
>>   {
>>   	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>>   
>> +	/* flush rxfifo before transfer */
>> +	while (spi_imx->devtype_data->rx_available(spi_imx))
>> +		spi_imx->rx(spi_imx);
>> +
>> +	if (spi_imx->slave_mode)
>> +		return spi_imx_pio_transfer_slave(spi, transfer);
>> +
>>   	if (spi_imx->usedma)
>>   		return spi_imx_dma_transfer(spi_imx, transfer);
>>   	else
> 
> This is in the main xfer function that is used for both master mode and
> slave mode.  Normally RX data is received after the xfer is started, as
> part of the spi_imx_pio/dma_transfer() process.  But this patch has
> added a "flush rxfifo" command before this.  Why?
>
in the commit message of commit ("spi: imx: Add support for SPI Slave 
mode"), it mentions

"The stale data in RXFIFO will be dropped when the Slave does any new 
transfer"

> If it's necessary to empty the fifo before an xfer, then how did this
> driver ever work before this change?  I see no change anywhere else
> that would make this a new requirement.
> 
only slave mode needs to flush stale data in RXFIFO,

> If the rx fifo is not empty, and this code actually does rx something
> from the fifo, then how can it possibly work to place it into the
> xfer's RX buffer? How do you know the buffer is large enough (it's not!
> that's my DMA bug!)?  Won't it offset the actual rx data that comes
> after it in the xfer's buffer?
> 
Currently I am not able to test and this patch was created several years 
before, but as I can recall, the purpose is to flush stale data in RXFIFO
before spi->rx_buf is set, but seems there is bug, after the first xfer,
rx_buf will always point to somewhere, which can lead to memory corruption.

> In my test, switching from DMA to PIO, which happens if the 1st xfer is
>   large enough to pass a >fifo/2 size test, and uses DMA, and the 2nd
> xfer is smaller, and will use PIO, results in the PIO xfer trying to
> empty the rx buffer in this code above.  If there is not enough space
> in the xfer's rx buffer, and there is no reason for there to be any
> space at all, it clobbers memory.
> 
> I suspect the author of this wasn't aware that spi_imx->rx() will write
> the data received into the current xfer's rx buffer rather than throw
> it away, and never tested this actually getting used for a transfer
> where the rx data mattered.
> 
yes, you are right,
as I don't have access to HW, can you please submit a fix
(for example reset rx_buf after each xfer?)
> Still, I'd like to know why the flush rx thing is even here.  Nothing
> in the commit message or any discussion I could find addressed this.
> 
master side may xfer data longer than slave side is expecting,
the extra data received in RXFIFO, need to be dropped before new xfer

Thanks,
Jiada
