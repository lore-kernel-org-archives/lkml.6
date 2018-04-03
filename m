Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeDCNDh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:03:37 -0400
Received: from smtp38.i.mail.ru ([94.100.177.98]:45514 "EHLO smtp38.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932153AbeDCNDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:03:35 -0400
Subject: Re: [PATCH 6/6] spi: sun4i: add DMA transfers support
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-7-ssuloev@orpaltech.com>
 <20180403081711.rqsp77mgnuvlnzt5@flea>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <19d5907c-f081-21ce-1b72-7c0a331eb073@orpaltech.com>
Date: Tue, 3 Apr 2018 16:03:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403081711.rqsp77mgnuvlnzt5@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A56E96B8F32EF386FA9E4130E898BA3A9A535400B9010DFEBA725E5C173C3A84C30584FF81F342DA07226B25F53A7E5D1CD2457FAF19517CF2C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D8491734E5BE2966C42ED35C980218CED0720F069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 11:17 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:07PM +0300, Sergey Suloev wrote:
>> +static int sun4i_spi_dma_setup(struct device *dev,
>> +			       struct resource *res)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	struct dma_slave_config dma_sconf;
>> +	int ret;
>> +
>> +	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
>> +	if (IS_ERR(master->dma_tx)) {
>> +		dev_err(dev, "Unable to acquire DMA TX channel\n");
>> +		ret = PTR_ERR(master->dma_tx);
>> +		goto out;
>> +	}
>> +
>> +	dma_sconf.direction = DMA_MEM_TO_DEV;
>> +	dma_sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +	dma_sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> I guess that would depend on the size of the transfer, right?
no
"this is the width in bytes of the source (RX)register where DMA data 
shall be read. If the sourceis memory this may be ignored depending on 
architecture."
AFAIK is should be 1 byte for SPI side and seems to be ignored for 
memory side, but as soon as I don't know what should be correct value 
for memory side I just put 1 there too.
>
>> +	dma_sconf.dst_addr = res->start + SUN4I_TXDATA_REG;
>> +	dma_sconf.dst_maxburst = 1;
>> +	dma_sconf.src_maxburst = 1;
> And a burst of 1 seems sub-optimal here.
I did some tests before with 3/4 FIFO size but it didn't work and I got 
stuck with 1 byte.
It seems like 1 byte is the correct value because in SPI protocol we can 
only send 1 byte in 1 burst.

>
>> +	ret = sun4i_spi_dma_setup(&pdev->dev, res);
>> +	if (ret) {
>> +		if (ret == -EPROBE_DEFER) {
>> +			/* wait for the dma driver to load */
>> +			goto err_free_master;
>> +		}
>> +		dev_warn(&pdev->dev, "DMA transfer not supported\n");
> Saying why it's not supported would be great.
I can put more info in this log
but there is already a message printed from sun4_spi_dma_setup() if any 
error occurs
>
> Maxime
>
