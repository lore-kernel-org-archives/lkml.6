Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797E821E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1mTlHsTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797E821E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeHIQk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbeHIQk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:40:58 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8879621E21;
        Thu,  9 Aug 2018 14:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533824152;
        bh=Uu5sRSv8oJbas8tLraIrf/kYMvX+HMnTBtSBa4A+Tk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mTlHsTl+Cs/C5d2VfuZlFLdbFGP4EsbkQTg+PHmcs6WAs+IpzlHyRxoEBrkmzpHn
         TqzTQDb9+EX+eXeWr6Kcq0p/emEtc1CZp2jn7N/r94NxEWoquHcQ3Kf30NTPawboIz
         8wHRYOqXGQGdEUQIJsrDecdE4sEXsbzfj+ETA0fU=
Date:   Thu, 9 Aug 2018 09:15:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Message-ID: <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717153135.25925-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:31:23AM -0500, Alexandru Gagniuc wrote:
> When we don't own AER, we shouldn't touch the AER error bits. This
> happens unconditionally on device probe(). Clearing AER bits
> willy-nilly might cause firmware to miss errors. Instead
> these bits should get cleared by FFS, or via ACPI _HPX method.
> 
> This race is mostly of theoretical significance, as it is not easy to
> reasonably demonstrate it in testing.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/pcie/aer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..18037a2a8231 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return -ENODEV;
>  
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;

I like this patch.

Do we need the same thing in the following places that also clear AER
status bits or write AER control bits?

  enable_ecrc_checking()
  disable_ecrc_checking()
  pci_cleanup_aer_uncorrect_error_status()
  pci_aer_clear_fatal_status()

>  	pos = dev->aer_cap;
>  	if (!pos)
>  		return -EIO;
> -- 
> 2.14.3
> 
