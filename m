Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9D3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8308B2173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok2VASkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8308B2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbeHNRGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbeHNRGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:06:50 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97C92172D;
        Tue, 14 Aug 2018 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534256367;
        bh=jdeCMloardC/nsAmA9+hPUm1/a0btD3ibf9LQ5RJ4Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ok2VASkOWv9KJi+bsW2TSQ6ZRDFBqt1M3K9rCDzcv9gcEdrqblsyNun9JlMTHZl5H
         surQUGFaTxsBTxqloxQ127n+B8FPLlO6L2+6sJA+q61qg7BHISy1xu4DscskOBAJlG
         9+DyTW3HOtgQSg1WqAix+Vwpu9SG2t+l52AMZrcA=
Date:   Tue, 14 Aug 2018 09:19:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     f.bluethner@mailbox.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
Message-ID: <20180814141926.GP113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180813194123.GM113140@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813194123.GM113140@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 02:41:23PM -0500, Bjorn Helgaas wrote:
> Hi,
> 
> Thanks a lot for your new report
> (https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134).
> 
> Can you confirm that the patch below is equivalent to what you tested and
> it resolves the problem?  If so, I'll try to include it for v4.19.

I applied this to pci/virtualization for v4.19.  Please let me know if you
see any issues.

> commit dd4e0ad485e12c9c04eb7a21ba69c24f12cb1918
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Aug 13 14:30:41 2018 -0500
> 
>     PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
>     
>     Add function 1 DMA alias quirk for Marvell 88SS9183 PCIe SSD Controller.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134
>     Reported-by: <f.bluethner@mailbox.org>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index deb051583eda..6994544125ff 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3845,6 +3845,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x917a,
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
>  			 quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
> +			 quirk_dma_func1_alias);
>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
>  			 quirk_dma_func1_alias);
