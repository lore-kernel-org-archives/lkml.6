Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030945AbeCST6G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969447AbeCST6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:58:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE9C2178C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 19 Mar 2018 14:57:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/IOV: Skip initializing the base addresses from the
 VF config space
Message-ID: <20180319195758.GK77194@bhelgaas-glaptop.roam.corp.google.com>
References: <1520051590-11750-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520051590-11750-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2018 at 05:33:10AM +0100, KarimAllah Ahmed wrote:
> Per PCIe r4.0, sec 9.3.4.1.11, the BARs registers from the VF config space
> are all RO Zero for PCI VFs. So just skip reading them for VFs.
> 
> This is an optimization when enabling SR-IOV on a device with many VFs.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Applied to pci/virtualization for v4.17, thanks!

> ---
>  drivers/pci/probe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a96837e..7204d46 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -329,6 +329,10 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	if (dev->non_compliant_bars)
>  		return;
>  
> +	/* Per PCIe r4.0, sec 9.3.4.1.11, the VF BARs are all RO Zero */
> +	if (dev->is_virtfn)
> +		return;
> +
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> -- 
> 2.7.4
> 
