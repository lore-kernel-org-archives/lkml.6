Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDINGP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:06:15 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35167 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeDINGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:06:14 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, geert@linux-m68k.org,
        linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [RFC v2 2/2] base: dma-mapping: Postpone page_to_pfn() on mmap()
Date: Mon, 09 Apr 2018 16:06:15 +0300
Message-ID: <2555020.mSAUJ9kk90@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <7da3f31e-e4ad-7f1a-e66c-0d3e0fb8b27d@arm.com>
References: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org> <20180409072547.GU20945@w540> <7da3f31e-e4ad-7f1a-e66c-0d3e0fb8b27d@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Monday, 9 April 2018 14:11:22 EEST Robin Murphy wrote:
> On 09/04/18 08:25, jacopo mondi wrote:
> > Hi Robin, Laurent,
> > 
> >      a long time passed, sorry about this.
> > 
> > On Wed, Nov 15, 2017 at 01:38:23PM +0000, Robin Murphy wrote:
> >> On 14/11/17 17:08, Jacopo Mondi wrote:
> >>> On SH4 architecture, with SPARSEMEM memory model, translating page to
> >>> pfn hangs the CPU. Post-pone translation to pfn after
> >>> dma_mmap_from_dev_coherent() function call as it succeeds and make page
> >>> translation not necessary.
> >>> 
> >>> This patch was suggested by Laurent Pinchart and he's working to submit
> >>> a proper fix mainline. Not sending for inclusion at the moment.
> >> 
> >> Y'know, I think this patch does have some merit by itself - until we know
> >> that cpu_addr *doesn't* represent some device-private memory which is not
> >> guaranteed to be backed by a struct page, calling virt_to_page() on it is
> >> arguably semantically incorrect, even if it might happen to be benign in
> >> most cases.
> > 
> > I still need to carry this patch in my trees to have a working dma memory
> > mapping on SH4 platforms. My understanding from your comment is that
> > there may be a way forward for this patch, do you still think the same?
> > Have you got any suggestion on how to improve this eventually for
> > inclusion?
> 
> As before, the change itself does seem reasonable; it might be worth
> rewording the commit message in more general terms rather than making it
> sound like an SH-specific workaround (which I really don't think it is),
> but otherwise I'd say just repost it as a non-RFC patch.

I actually can't remember any better fix I would have in mind, so this looks 
good to me :-) I agree with Robin, the commit message should be reworded. 
Robin's explanation of why virt_to_page() should be postponed until we know 
that cpu_addr represents memory that is guaranteed to be backed by a struct 
page is a good starting point. You can mention SH4 as an example of an 
architecture that will crash when calling virt_to_page() in such a case, but 
the fix isn't specific to SH4.

> >>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>> ---
> >>> 
> >>>   drivers/base/dma-mapping.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> >>> index e584edd..73d64d3 100644
> >>> --- a/drivers/base/dma-mapping.c
> >>> +++ b/drivers/base/dma-mapping.c
> >>> @@ -227,8 +227,8 @@ int dma_common_mmap(struct device *dev, struct
> >>> vm_area_struct *vma,
> >>>   #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
> >>>   	unsigned long user_count = vma_pages(vma);
> >>>   	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> >>> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> >>>   	unsigned long off = vma->vm_pgoff;
> >>> +	unsigned long pfn;
> >>> 
> >>>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >>> 
> >>> @@ -236,6 +236,7 @@ int dma_common_mmap(struct device *dev, struct
> >>> vm_area_struct *vma,
> >>>   		return ret;
> >>>   	
> >>>   	if (off < count && user_count <= (count - off)) {
> >>> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
> >>>   		ret = remap_pfn_range(vma, vma->vm_start,
> >>>   				      pfn + off,
> >>>   				      user_count << PAGE_SHIFT,

-- 
Regards,

Laurent Pinchart
