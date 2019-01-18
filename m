Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D90C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA4820873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aEOICe9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfARAG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:06:59 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42785 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfARAG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:06:58 -0500
Received: by mail-yb1-f194.google.com with SMTP id q145so3707992ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 16:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nxEmOP9weOAbqYM2Txz/VscMt2v3+Ec00LAU86aEkLM=;
        b=aEOICe9g83XClGlvDv8kLCCm6h9r533mZUwG8HCbHTlZrqhfOkNAlgiplf86d33XCw
         U9hzVq/zfQEN6YCYqTgRCLbA2tBLFxwWQR1/fAz4le7g5Mg9LjnGvF9zGhk9W3zqF38X
         YPdpfNA5BNCyfKZjWUX0aUoOZqoMiLVJrYQvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nxEmOP9weOAbqYM2Txz/VscMt2v3+Ec00LAU86aEkLM=;
        b=aY/ovd15EOe0FgkLwTUav/SXX1v7lUBQBM9RQfjD6gynkGES1zDZxRi58vgTnEu/Li
         4P6vQOkqgtrpI0kZloAx0aN7oZwrV/9+sCtH5mi8qroiwdP49j2fABSl9Q+J0qBAK93U
         njYRFd1KJTg0m/dVaGKpCYBCqEJhbN5214NWakT4+76JKzy41/Cr4BNEuEtxqnojl0Lf
         vKHjSiy6aHwyORXRhBCVhzKREDtihJyai8COrJmhfnF3EAzAcz5HLKkVKIZycvqX+z2B
         TZ1Z+AsLRyenLZOn+YUwjImfzEtrtkpTDdTFeNQCYgcI2eLFH5N7KRd+dhd2SgkHn/OK
         xinw==
X-Gm-Message-State: AJcUukdFQIAvWN9zHuQ3e+Z+gUlVRPn+wfRC9D+4uJCR7k+/7v7pzb4x
        s/CqTPkgDr/Tf0IDYBRYuQzTIA==
X-Google-Smtp-Source: ALg8bN7dbtxx/7YBbDGnfnhystCyXtOJtN4w+Ncix8L49cvJJXCCmvMlXltLGE+db1qQ3c9BLrRpPw==
X-Received: by 2002:a5b:9c4:: with SMTP id y4mr12368906ybq.380.1547770016721;
        Thu, 17 Jan 2019 16:06:56 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j65sm1209077ywf.21.2019.01.17.16.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 16:06:55 -0800 (PST)
Subject: Re: [PATCH v2 1/8] i2c: iproc: I2C read up to 255 bytes support
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        rjui@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        shreesha.rajashekar@broadcom.com, sbranden@broadcom.com,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ccheng@broadcom.com,
        heikki.krogerus@linux.intel.com, geert@linux-m68k.org,
        arnd@arndb.de, manivannan.sadhasivam@linaro.org, ajayg@nvidia.com,
        ard.biesheuvel@linaro.org, eajames@linux.vnet.ibm.com,
        kramasub@codeaurora.org, vigneshr@ti.com,
        mika.westerberg@linux.intel.com, pierre-yves.mordret@st.com,
        f.fainelli@gmail.com, aaron.wu@analog.com, jdelvare@suse.de,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rayagonoda.kokatanur@braodcom.com,
        Shreesha Rajashekar <shreesha@broadcom.com>
References: <1547631870-4896-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <1547631870-4896-2-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <7bf5e06b-9185-0069-c5c4-74c36aa677d3@broadcom.com>
Date:   Thu, 17 Jan 2019 16:06:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547631870-4896-2-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rayagonda,

On 1/16/2019 1:44 AM, Rayagonda Kokatanur wrote:
> From: Shreesha Rajashekar <shreesha@broadcom.com>
> 
> Add support to allow I2C RX transfer up to 255 bytes.
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 99 +++++++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 4c8c3bc4669c..f32a5e038314 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -80,6 +80,10 @@
>  
>  #define I2C_TIMEOUT_MSEC             50000
>  #define M_TX_RX_FIFO_SIZE            64
> +#define M_RX_FIFO_MAX_THLD_VALUE     63

probably make more sense to use:

#define M_RX_FIFO_MAX_THLD_VALUE (M_TX_RX_FIFO_SIZE - 1)
> +
> +#define M_RX_MAX_READ_LEN            255
> +#define M_RX_FIFO_THLD_VALUE         50
>  
>  enum bus_speed_index {
>  	I2C_SPD_100K = 0,
> @@ -102,17 +106,41 @@ struct bcm_iproc_i2c_dev {
>  
>  	/* bytes that have been transferred */
>  	unsigned int tx_bytes;
> +	/* bytes that have been read */
> +	unsigned int rx_bytes;
> +	unsigned int thld_bytes;
>  };
>  
>  /*
>   * Can be expanded in the future if more interrupt status bits are utilized
>   */
> -#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT))
> +#define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT)\
> +		| BIT(IS_M_RX_THLD_SHIFT))
> +
> +static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	struct i2c_msg *msg = iproc_i2c->msg;
> +
> +	/* Read valid data from RX FIFO */
> +	while (iproc_i2c->rx_bytes < msg->len) {
> +		if (!((readl(iproc_i2c->base +
> +		M_FIFO_CTRL_OFFSET) >>
> +		M_FIFO_RX_CNT_SHIFT) &
> +		M_FIFO_RX_CNT_MASK))
> +			break;
> +
> +		msg->buf[iproc_i2c->rx_bytes] =
> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> +		iproc_i2c->rx_bytes++;
> +	}
> +}
>  
>  static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  {
>  	struct bcm_iproc_i2c_dev *iproc_i2c = data;
>  	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> +	u32 tmp;
>  
>  	status &= ISR_MASK;
>  
> @@ -136,8 +164,6 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  
>  			/* mark the last byte */
>  			if (idx == msg->len - 1) {
> -				u32 tmp;
> -
>  				val |= BIT(M_TX_WR_STATUS_SHIFT);
>  
>  				/*
> @@ -156,6 +182,33 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>  		iproc_i2c->tx_bytes += tx_bytes;
>  	}
>  
> +	if (status & BIT(IS_M_RX_THLD_SHIFT)) {
> +		struct i2c_msg *msg = iproc_i2c->msg;
> +		u32 bytes_left;
> +
> +		bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
> +		bytes_left = msg->len - iproc_i2c->rx_bytes;
> +		if (bytes_left == 0) {
> +			/* finished reading all data, disable rx thld event */
> +			tmp = readl(iproc_i2c->base + IE_OFFSET);
> +			tmp &= ~BIT(IS_M_RX_THLD_SHIFT);
> +			writel(tmp, iproc_i2c->base + IE_OFFSET);
> +		} else if (bytes_left < iproc_i2c->thld_bytes) {
> +			/* set bytes left as threshold */
> +			tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +			tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
> +			tmp |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
> +			writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +			iproc_i2c->thld_bytes = bytes_left;
> +		} else {
> +			/*
> +			 * bytes_left >= iproc_i2c->thld_bytes,
> +			 * hence no need to change the THRESHOLD SET.
> +			 * It will remain as iproc_i2c->thld_bytes itself
> +			 */

You can remove the else {} here but just leave the comment

> +		}
> +	}
> +
>  	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
>  		iproc_i2c->xfer_is_done = 1;
>  		complete(&iproc_i2c->done);
> @@ -253,7 +306,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  {
>  	int ret, i;
>  	u8 addr;
> -	u32 val;
> +	u32 val, tmp, val_intr_en;
>  	unsigned int tx_bytes;
>  	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
>  
> @@ -298,7 +351,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 * transaction is done, i.e., the internal start_busy bit, transitions
>  	 * from 1 to 0.
>  	 */
> -	val = BIT(IE_M_START_BUSY_SHIFT);
> +	val_intr_en = BIT(IE_M_START_BUSY_SHIFT);
>  
>  	/*
>  	 * If TX data size is larger than the TX FIFO, need to enable TX
> @@ -307,9 +360,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 */
>  	if (!(msg->flags & I2C_M_RD) &&
>  	    msg->len > iproc_i2c->tx_bytes)
> -		val |= BIT(IE_M_TX_UNDERRUN_SHIFT);
> -
> -	writel(val, iproc_i2c->base + IE_OFFSET);
> +		val_intr_en |= BIT(IE_M_TX_UNDERRUN_SHIFT);
>  
>  	/*
>  	 * Now we can activate the transfer. For a read operation, specify the
> @@ -317,11 +368,27 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	 */
>  	val = BIT(M_CMD_START_BUSY_SHIFT);
>  	if (msg->flags & I2C_M_RD) {
> +		iproc_i2c->rx_bytes = 0;
> +		if (msg->len > M_RX_FIFO_MAX_THLD_VALUE)
> +			iproc_i2c->thld_bytes = M_RX_FIFO_THLD_VALUE;
> +		else
> +			iproc_i2c->thld_bytes = msg->len;
> +
> +		/* set threshold value */
> +		tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +		tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
> +		tmp |= iproc_i2c->thld_bytes << M_FIFO_RX_THLD_SHIFT;
> +		writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
> +
> +		/* enable the RX threshold interrupt */
> +		val_intr_en |= BIT(IE_M_RX_THLD_SHIFT);
> +
>  		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
>  		       (msg->len << M_CMD_RD_CNT_SHIFT);
>  	} else {
>  		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
>  	}
> +	writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
>  	writel(val, iproc_i2c->base + M_CMD_OFFSET);
>  
>  	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> @@ -353,17 +420,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  		return ret;
>  	}
>  
> -	/*
> -	 * For a read operation, we now need to load the data from FIFO
> -	 * into the memory buffer
> -	 */
> -	if (msg->flags & I2C_M_RD) {
> -		for (i = 0; i < msg->len; i++) {
> -			msg->buf[i] = (readl(iproc_i2c->base + M_RX_OFFSET) >>
> -				      M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -395,9 +451,8 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
>  	.functionality = bcm_iproc_i2c_functionality,
>  };
>  
> -static const struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> -	/* need to reserve one byte in the FIFO for the slave address */
> -	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
> +static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +	.max_read_len = M_RX_MAX_READ_LEN,
>  };
>  
>  static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
> 

Thanks,

Ray
