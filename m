Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB47C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1600B21871
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="T+xOpF1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfAWPm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:42:58 -0500
Received: from node.akkea.ca ([192.155.83.177]:53406 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfAWPm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:42:57 -0500
Received: by node.akkea.ca (Postfix, from userid 33)
        id C26884E204B; Wed, 23 Jan 2019 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548258176; bh=hpydxlUbPNVTFjaIeaR+9n70cc5NfFN03bvjQEo1UbU=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=T+xOpF1cXj7CVamez22PIzRepOMR9AHCkbPhlxwb7DeHfTYFjDH6nCIrfMbQLaTmc
         6G5vEFFUOJuhnl8hyLebeHO5Xp3hlPXeqiipnX0qXaJTH/POHSuY3GUGoX9NATuDUj
         7IS8xQFtsCqYEKpvUEKuMS7zt3ki9NWIvxXVy5Ug=
To:     Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v3 4/5] dma: imx-sdma: add an index for imx8mq multi sdma  devices
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 23 Jan 2019 08:42:56 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
In-Reply-To: <1548257514.28802.3.camel@pengutronix.de>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190123152310.11680-1-angus@akkea.ca>
 <20190123152310.11680-5-angus@akkea.ca>
 <1548257514.28802.3.camel@pengutronix.de>
Message-ID: <d5f73096cf62ef379e27c11e024c52ff@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 08:31, Lucas Stach wrote:
> Hi Angus,
> 
> Am Mittwoch, den 23.01.2019, 08:23 -0700 schrieb Angus Ainslie 
> (Purism):
>> On i.mx8mq, there are two sdma instances, and the common dma framework
>> will get a channel dynamically from any available sdma instance 
>> whether
>> it's the first sdma device or the second sdma device. Some IPs like
>> SAI only work with sdma2 not sdma1. To make sure the sdma channel is 
>> from
>> the correct sdma device, use an index to match.
>> 
>> Based on MLK-16104-2 by Robin Gong <yibin.gong@nxp.com>
> 
> This relies on the probe order of the devices (which should be treated
> as random) for the match to find the right device. This is not
> acceptable upstream.
> 
> The DT "dmas" property already specifies the correct SDMA device to use
>  for a consumer, so the filter function should really match the OF node
> of the SDMA device with the node specified in the dmas phandle in order
> to pick the right SDMA engine.
> 

Thanks Lucas, I'll fix it for rev 4

> Regards,
> Lucas
> 
>> 
>> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  drivers/dma/imx-sdma.c                | 12 ++++++++++++
>>  include/linux/platform_data/dma-imx.h |  1 +
>>  2 files changed, 13 insertions(+)
>> 
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index 2e691b1cd0eb..bf3752a6a64f 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -442,6 +442,7 @@ struct sdma_engine {
>> > >  	struct sdma_buffer_descriptor	*bd0;
>> >  	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
>> > >  	bool				clk_ratio;
>> > > +	int				idx;
>>  };
>>  
>>  static int sdma_config_write(struct dma_chan *chan,
>> @@ -606,6 +607,8 @@ static const struct of_device_id sdma_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, sdma_dt_ids);
>>  
>> +static int sdma_dev_idx;
>> +
>> >  #define SDMA_H_CONFIG_DSPDMA	BIT(12) /* indicates if the DSPDMA is used */
>> >  #define SDMA_H_CONFIG_RTD_PINS	BIT(11) /* indicates if Real-Time Debug pins are enabled */
>> >  #define SDMA_H_CONFIG_ACR	BIT(4)  /* indicates if AHB freq /core freq = 2 or 1 */
>> @@ -1934,6 +1937,11 @@ static bool sdma_filter_fn(struct dma_chan 
>> *chan, void *fn_param)
>> >  	if (!imx_dma_is_general_purpose(chan))
>> >  		return false;
>>  
>> > +	/* return false if it's not the right device */
>> > +	if ((sdmac->sdma->drvdata == &sdma_imx8mq)
>> > +		&& (sdmac->sdma->idx != data->idx))
>> > +		return false;
>> +
>> >  	sdmac->data = *data;
>> >  	chan->private = &sdmac->data;
>>  
>> @@ -1961,6 +1969,7 @@ static struct dma_chan *sdma_xlate(struct 
>> of_phandle_args *dma_spec,
>> >  	 * be set to sdmac->event_id1.
>> >  	 */
>> >  	data.dma_request2 = 0;
>> > +	data.idx = sdma->idx;
>>  
>> >  	return dma_request_channel(mask, sdma_filter_fn, &data);
>>  }
>> @@ -2149,6 +2158,9 @@ static int sdma_probe(struct platform_device 
>> *pdev)
>> >  		of_node_put(spba_bus);
>> >  	}
>>  
>> > +	/* There maybe multi sdma devices such as i.mx8mq */
>> > +	sdma->idx = sdma_dev_idx++;
>> +
>> >  	return 0;
>>  
>>  err_register:
>> diff --git a/include/linux/platform_data/dma-imx.h 
>> b/include/linux/platform_data/dma-imx.h
>> index 7d964e787299..843faf081282 100644
>> --- a/include/linux/platform_data/dma-imx.h
>> +++ b/include/linux/platform_data/dma-imx.h
>> @@ -55,6 +55,7 @@ struct imx_dma_data {
>> >  	int dma_request2; /* secondary DMA request line */
>> >  	enum sdma_peripheral_type peripheral_type;
>> >  	int priority;
>> > +	int idx;
>>  };
>>  
>>  static inline int imx_dma_is_ipu(struct dma_chan *chan)

