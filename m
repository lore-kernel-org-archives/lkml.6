Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E505FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEB720671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEB720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGSRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:24:31 -0400
Received: from www381.your-server.de ([78.46.137.84]:35555 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbeGSRYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:24:31 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1fgByd-0005ux-LP; Thu, 19 Jul 2018 18:40:27 +0200
Received: from [2003:8b:4817:700:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fgByd-0002P6-Gr; Thu, 19 Jul 2018 18:40:27 +0200
Subject: Re: [PATCH 3/4] iio: adc: xilinx: Check for return values in clk
 related functions
To:     Manish Narani <manish.narani@xilinx.com>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     anirudh@xilinx.com, sgoud@xilinx.com
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
 <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f4b8e687-217f-15b1-b0b1-b95dbc3dcc2a@metafoo.de>
Date:   Thu, 19 Jul 2018 18:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531912331-26431-4-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24763/Thu Jul 19 10:39:52 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 01:12 PM, Manish Narani wrote:
> This patch adds check for return values from clock related functions.
> This was reported by static code analysis tool.

This patch seems to do something else.

> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 248cffa..47eb364 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -322,6 +322,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>  
>  #define XADC_ZYNQ_TCK_RATE_MAX 50000000
>  #define XADC_ZYNQ_IGAP_DEFAULT 20
> +#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
>  
>  static int xadc_zynq_setup(struct platform_device *pdev,
>  	struct iio_dev *indio_dev, int irq)
> @@ -332,6 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  	unsigned int div;
>  	unsigned int igap;
>  	unsigned int tck_rate;
> +	int ret;
>  
>  	/* TODO: Figure out how to make igap and tck_rate configurable */
>  	igap = XADC_ZYNQ_IGAP_DEFAULT;
> @@ -341,6 +343,13 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  
>  	pcap_rate = clk_get_rate(xadc->clk);
>  
> +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> +		ret = clk_set_rate(xadc->clk,
> +				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (tck_rate > pcap_rate / 2) {
>  		div = 2;
>  	} else {
> @@ -366,6 +375,12 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
>  			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
>  
> +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> +		ret = clk_set_rate(xadc->clk, pcap_rate);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -887,6 +902,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
>  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
>  	unsigned int div;
>  
> +	if (!clk_rate)
> +		return -EINVAL;
> +
>  	if (info != IIO_CHAN_INFO_SAMP_FREQ)
>  		return -EINVAL;
>  
> @@ -1239,8 +1257,10 @@ static int xadc_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  
>  	/* Disable all alarms */
> -	xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> -		XADC_CONF1_ALARM_MASK);
> +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
> +				  XADC_CONF1_ALARM_MASK);
> +	if (ret)
> +		goto err_free_irq;
>  
>  	/* Set thresholds to min/max */
>  	for (i = 0; i < 16; i++) {
> 

