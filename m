Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9EFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1D2150D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuIyDHSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1D2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeIRV63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbeIRV62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:58:28 -0400
Received: from localhost (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C492150B;
        Tue, 18 Sep 2018 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537287908;
        bh=ldVGPbkEKxblm+q+QtQ3YNCOQA3jPR0xL6sIZDi2w5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuIyDHSSyqsj5i6wuPcsScZ8UA//bvwbR5J0C2oLLLSd0HEBW0fWHuJ/TNEqvmz2d
         1Z/m3foq3YMMhRfGwkSNIccxDeIkIYv9DigiE23mMdkB2Mf3JtMjy+8bGhjc6o/I0m
         GnuaJbEcPLoz25jOWF11/7oZf4ZxiS0bRvAPA6xA=
Date:   Tue, 18 Sep 2018 09:25:08 -0700
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH v5 4/7] dmaengine: xilinx_dma: program hardware supported
 buffer length
Message-ID: <20180918162508.GD2613@vkoul-mobl>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-4-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907062502.8241-4-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-18, 08:24, Andrea Merello wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> AXI-DMA IP supports configurable (c_sg_length_width) buffer length
> register width, hence read buffer length (xlnx,sg-length-width) DT
> property and ensure that driver doesn't program buffer length
> exceeding the supported limit. For VDMA and CDMA there is no change.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com> [rebase, reword]
> ---
> Changes in v2:
>         - drop original patch and replace with the one in Xilinx tree
> Changes in v3:
> 	- cc DT maintainers/ML
> Changes in v4:
> 	- upper bound for the property should be 26, not 23
> 	- add warn for width > 23 as per xilinx original patch
> 	- rework due to changes introduced in 1/6
> Changes in v5:
> 	None
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 36 +++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index aaa6de8a70e4..b17f24e4ec35 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -158,7 +158,9 @@
>  #define XILINX_DMA_REG_BTT		0x28
>  
>  /* AXI DMA Specific Masks/Bit fields */
> -#define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
> +#define XILINX_DMA_MAX_TRANS_LEN_MIN	8
> +#define XILINX_DMA_MAX_TRANS_LEN_MAX	23
> +#define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
>  #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
>  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
>  #define XILINX_DMA_CR_COALESCE_SHIFT	16
> @@ -418,6 +420,7 @@ struct xilinx_dma_config {
>   * @rxs_clk: DMA s2mm stream clock
>   * @nr_channels: Number of channels DMA device supports
>   * @chan_id: DMA channel identifier
> + * @max_buffer_len: Max buffer length
>   */
>  struct xilinx_dma_device {
>  	void __iomem *regs;
> @@ -437,6 +440,7 @@ struct xilinx_dma_device {
>  	struct clk *rxs_clk;
>  	u32 nr_channels;
>  	u32 chan_id;
> +	u32 max_buffer_len;
>  };
>  
>  /* Macros */
> @@ -964,7 +968,7 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
>  				    int size, int done)
>  {
>  	size_t copy = min_t(size_t, size - done,
> -		     XILINX_DMA_MAX_TRANS_LEN);
> +			    chan->xdev->max_buffer_len);

hmm why not add max_buffer_len in patch 1 again, and then use default
len as XILINX_DMA_MAX_TRANS_LEN and add multiple lengths here :)

- 
~Vinod
