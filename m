Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637CBECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B220858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeaUqTtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1B220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeGURPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeGURPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:15:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C56B20849;
        Sat, 21 Jul 2018 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532190146;
        bh=Jh1FL4RBwQPojQxKub41wZxOQw7/lh+lK9Gmvtjmq+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MeaUqTtAfOPsBhBcBozfVbrR3TAvWWPXbnoF3u/ZHa5+YzxfbVyXsPBwkL7ljrySF
         lWIuyFNocJeAe3jmcnabtDAh8+m4aBRBcFMtA2dO0WACh3idD0Lt6ejGq2bVG0K06i
         wvlvJkmR2oWPxfQQVIi0WdAYscpOVSA9ljprnKjk=
Date:   Sat, 21 Jul 2018 17:22:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <michal.simek@xilinx.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anirudh@xilinx.com>,
        <sgoud@xilinx.com>
Subject: Re: [PATCH 2/4] iio: adc: xilinx: Remove dead code from
 xadc_zynq_setup
Message-ID: <20180721172221.7851fb25@archlinux>
In-Reply-To: <1531912331-26431-3-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
        <1531912331-26431-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 16:42:09 +0530
Manish Narani <manish.narani@xilinx.com> wrote:

> This patch removes dead code from xadc_zynq_setup. The condition
> "if (tck_rate > XADC_ZYNQ_TCK_RATE_MAX)" cannot be true at any point of
> time. There is also an incompatible parameter used in the code.
> This patch fixes the same reported by coverity.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to try and break it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 27b45df..248cffa 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -341,8 +341,6 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>  
>  	pcap_rate = clk_get_rate(xadc->clk);
>  
> -	if (tck_rate > XADC_ZYNQ_TCK_RATE_MAX)
> -		tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
>  	if (tck_rate > pcap_rate / 2) {
>  		div = 2;
>  	} else {
> @@ -1045,7 +1043,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	unsigned int num_channels;
>  	const char *external_mux;
>  	u32 ext_mux_chan;
> -	int reg;
> +	u32 reg;
>  	int ret;
>  
>  	*conf = 0;

