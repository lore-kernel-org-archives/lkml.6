Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1752ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4EB20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4EB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbeGTUN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:13:26 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46371 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbeGTUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:13:25 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgb0C-0001fn-PF; Fri, 20 Jul 2018 20:23:44 +0100
Message-ID: <1532114624.21552.43.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 101/105] spi: Fix scatterlist elements size in
 spi_map_buf
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 20 Jul 2018 20:23:44 +0100
In-Reply-To: <20180701153156.693937436@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
         <20180701153156.693937436@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 18:02 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> commit ce99319a182fe766be67f96338386f3ec73e321c upstream.
> 
> When SPI transfers can be offloaded using DMA, the SPI core need to
> build a scatterlist to make sure that the buffer to be transferred is
> dma-able.
> 
> This patch fixes the scatterlist entry size computation in the case
> where the maximum acceptable scatterlist entry supported by the DMA
> controller is less than PAGE_SIZE, when the buffer is vmalloced.
> 
> For each entry, the actual size is given by the minimum between the
> desc_len (which is the max buffer size supported by the DMA controller)
> and the remaining buffer length until we cross a page boundary.
> 
> Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/spi/spi.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -707,8 +707,14 @@ static int spi_map_buf(struct spi_master
>  	for (i = 0; i < sgs; i++) {
>  
>  		if (vmalloced_buf) { 
> -			min = min_t(size_t,
> -				    len, desc_len - offset_in_page(buf));
> +			/*
> +			 * Next scatterlist entry size is the minimum between
> +			 * the desc_len and the remaining buffer length that
> +			 * fits in a page.
> +			 */
> +			min = min_t(size_t, desc_len,
> +				    min_t(size_t, len,
> +					  PAGE_SIZE - offset_in_page(buf)));
>  			vm_page = vmalloc_to_page(buf);
>  			if (!vm_page) {
>  				sg_free_table(sgt);

I think this makes sense upstream, but in 4.4 it seems to be a no-op
since desc_len is always set to PAGE_SIZE when vmalloced_buf is true.
This fix depends on (at least) commit df88e91bbfd1 "spi: respect the
maximum segment size of DMA device" which went into 4.6.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
