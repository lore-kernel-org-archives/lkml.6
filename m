Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B74C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A8D2070C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfAFTu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:50:56 -0500
Received: from ec2-18-194-220-216.eu-central-1.compute.amazonaws.com ([18.194.220.216]:53986
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfAFTu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:50:56 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2019 14:50:55 EST
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 2EF8521AB3;
        Sun,  6 Jan 2019 19:41:02 +0000 (UTC)
Received: from sysam.it ([127.0.0.1])
        by localhost (sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h9d8cN4EJ3SV; Sun,  6 Jan 2019 19:41:00 +0000 (UTC)
Received: from jerusalem (host15-234-dynamic.4-87-r.retail.telecomitalia.it [87.4.234.15])
        by sysam.it (Postfix) with ESMTPSA id 6CB6921AA3;
        Sun,  6 Jan 2019 19:41:00 +0000 (UTC)
Date:   Sun, 6 Jan 2019 20:40:59 +0100
From:   Angelo Dureghello <angelo@sysam.it>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: use struct_size() in kzalloc()
Message-ID: <20190106194059.GA2120@jerusalem>
References: <20190104212545.GA16927@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104212545.GA16927@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 03:25:45PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/dma/fsl-edma-common.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 8876c4c1bb2c..fe529100674f 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -339,9 +339,7 @@ static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
>  	struct fsl_edma_desc *fsl_desc;
>  	int i;
>  
> -	fsl_desc = kzalloc(sizeof(*fsl_desc) +
> -			   sizeof(struct fsl_edma_sw_tcd) *
> -			   sg_len, GFP_NOWAIT);
> +	fsl_desc = kzalloc(struct_size(fsl_desc, tcd, sg_len), GFP_NOWAIT);
>  	if (!fsl_desc)
>  		return NULL;
>

Tested-by: Angelo Dureghello <angelo@sysam.it>

  
> -- 
> 2.20.1
> 
