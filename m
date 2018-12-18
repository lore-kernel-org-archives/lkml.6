Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9125FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F72F2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DNE2olsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLRKpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:45:39 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40040 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lHWQL5ZkkZOHZm9RFneFu3rdbyqynYoSp+SPVhSSX/c=; b=DNE2olszgXnx60fA2Bvm2RYpY
        QJqTcKlCT3V6v6EugC5mEfj8zAfVfmnHLp+TaKsQqxW/sJHG7m4gabMVbXZ2jLMcLY5mMHU8XMK79
        9//45ZtPtLHbnLFpMoyYgLN/jdIddpExzHPIQRiTAK6Urk4TteJf7EGc5C5QI1JIYm4xk=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38318)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZCsP-0005eW-7v; Tue, 18 Dec 2018 10:45:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZCsH-0006Bp-Ry; Tue, 18 Dec 2018 10:45:18 +0000
Date:   Tue, 18 Dec 2018 10:45:13 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux-mm@kvack.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181218104513.GM26090@n2100.armlinux.org.uk>
References: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217202246.GA10500@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 01:52:46AM +0530, Souptick Joarder wrote:
> Convert to use vm_insert_range to map range of kernel memory
> to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/firewire/core-iso.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784c..7bf28bb 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>  			  struct vm_area_struct *vma)
>  {
> -	unsigned long uaddr;
> -	int i, err;
> -
> -	uaddr = vma->vm_start;
> -	for (i = 0; i < buffer->page_count; i++) {
> -		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -		if (err)
> -			return err;
> -
> -		uaddr += PAGE_SIZE;
> -	}
> -
> -	return 0;
> +	return vm_insert_range(vma, vma->vm_start, buffer->pages,
> +				buffer->page_count);

This looks functionally equivalent.  Note that if we go with my
proposal to your patch 4, that would cause an issue for this
implementation.

Maybe we need two functions, but that then causes problems with
which function should be used (which makes it easy to get wrong.)

I'm beginning to wonder if the risks of causing regressions and
introducing bugs is actually worth the effort of trying to clean
this up.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
