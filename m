Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeCORu3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:50:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43960 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCORu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:50:27 -0400
Date: Thu, 15 Mar 2018 13:47:48 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] x86/amd_gart: look at coherent_dma_mask instead of
 GFP_DMA
Message-ID: <20180315174747.GP13391@char.us.oracle.com>
References: <20180314175213.20256-1-hch@lst.de>
 <20180314175213.20256-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314175213.20256-6-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150169
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 06:52:04PM +0100, Christoph Hellwig wrote:
> We want to phase out looking at the magic GFP_DMA flag in the dma mapping
> routines, so switch the gart driver to use the coherent_dma_mask instead,
> which is used to select the GFP_DMA flag in the caller.
> 
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/kernel/amd_gart_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index 52e3abcf3e70..79ac6caaaabb 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -484,7 +484,7 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
>  	unsigned long align_mask;
>  	struct page *page;
>  
> -	if (force_iommu && !(flag & GFP_DMA)) {
> +	if (force_iommu && dev->coherent_dma_mask > DMA_BIT_MASK(24)) {
>  		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
>  		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
>  		if (!page)
> -- 
> 2.14.2
> 
