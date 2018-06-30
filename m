Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE3C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6877C27FA5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3z7CNYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6877C27FA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934994AbeF3CEz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934060AbeF3CEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:04:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4B527FA5;
        Sat, 30 Jun 2018 02:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530324294;
        bh=wSxiUSI0XTVxVJlTtbgl194eetcx+mLc4LWes8Nf4yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3z7CNYYGTYoutZHUVlkpmBx7PyDZ15lJ6HKWv44e1/l8BIZwcYqEH+kiaJ3O4qr2
         tTAvhFHyDaJjVw5neWhnmRKGItW+AABgnS6OXiiPCsSIrbGqyaQLC+n1inOAfZetS7
         g45PN33uOnGMTqI9r/D/yrlGN6N6EG2/XRX/p4Ew=
Date:   Fri, 29 Jun 2018 21:04:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH v3] PCI: Expand documentation for pci_add_dma_alias()
Message-ID: <20180630020452.GO40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180530201311.11274-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530201311.11274-1-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 02:13:11PM -0600, Logan Gunthorpe wrote:
> Seeing there's been some confusion about the use of pci_add_dma_alias(),
> expand the comment to describe why it must be called early and how
> early it must be called.
> 
> Also, expand on the purpose of this function and common reasons it would
> be used.
> 
> [The comment was reworded to some extent by Alex Williamson]
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to pci/switchtec for v4.19, thanks!

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Doug Meyer <dmeyer@gigaio.com>
> ---
> 
> v3: Fixed some typos pointed out by Randy
> v2: Reworked the patch with Alex's suggested wording
> 
> drivers/pci/pci.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dbfe7c4f3776..2d8650253cc9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * @dev: the PCI device for which alias is added
>   * @devfn: alias slot and function
>   *
> - * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> - * It should be called early, preferably as PCI fixup header quirk.
> + * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
> + * which is used to program permissible bus-devfn source addresses for DMA
> + * requests in an IOMMU. These aliases factor into IOMMU group creation
> + * and are useful for devices generating DMA requests beyond or different
> + * from their logical bus-devfn. Examples include device quirks where the
> + * device simply uses the wrong devfn, as well as non-transparent bridges
> + * where the alias may be a proxy for devices in another domain.
> + *
> + * IOMMU group creation is performed during device discovery or addition,
> + * prior to any potential DMA mapping and therefore prior to driver probing
> + * (especially for userspace assigned devices where IOMMU group definition
> + * cannot be left as a userspace activity). DMA aliases should therefore
> + * be configured via quirks, such as the PCI fixup header quirk.
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
> --
> 2.11.0
