Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id veoiIyExGVtjMgAAmS7hNA
	; Thu, 07 Jun 2018 13:21:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 90678607DC; Thu,  7 Jun 2018 13:21:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWGCRTkG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 10F8B601C3;
	Thu,  7 Jun 2018 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10F8B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbeFGNVo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbeFGNVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:21:42 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8502086E;
        Thu,  7 Jun 2018 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528377701;
        bh=h9cFA1P3D+vZC6T7fcxE7lr79c7rSWjPhPLxThXNv8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWGCRTkGQUKP4ZiL/rRZq3G33/CH83m6cOMsyji12Cxk00nMtWMumyvfX8fJWrY1r
         UlAhhMpzOxNtwKSU83y+3djTAMqDNolavbSXeLyogMpbe/muoPmsQbZm1TJ6BHOt77
         mdXA1bjfZFCb3s9byO9xKrOZxRwPbTpSOU16A/bc=
Date: Thu, 7 Jun 2018 08:21:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 1/6] PCI/AER: Take mask into account while clearing
 error bits
Message-ID: <20180607132140.GA15137@bhelgaas-glaptop.roam.corp.google.com>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:00:29AM -0400, Oza Pawandeep wrote:
> PCIe ERR_NONFATAL and ERR_FATAL are uncorrectable errors, and clearing
> uncorrectable error bits should take error mask into account.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

If/when you repost these, please include a [0/6] cover letter with an
overview of the purpose of the series.

I assume these are for v4.19, so I'll look at them after the merge
window.

If they fix issues introduced during the v4.18 merge window, we may be
able to merge them during the v4.18 -rc cycle.  In this case, I would
need specifics about what exactly the problems are.

> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 377e576..8cbc62b 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -341,8 +341,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   */
>  static void aer_error_resume(struct pci_dev *dev)
>  {
> -	int pos;
> -	u32 status, mask;
>  	u16 reg16;
>  
>  	/* Clean up Root device status */
> @@ -350,11 +348,7 @@ static void aer_error_resume(struct pci_dev *dev)
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
>  
>  	/* Clean AER Root Error Status */
> -	pos = dev->aer_cap;
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
> -	status &= ~mask; /* Clear corresponding nonfatal bits */
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +	pci_cleanup_aer_uncorrect_error_status(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 946f3f6..309f3f5 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -50,13 +50,17 @@ EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>  {
>  	int pos;
> -	u32 status;
> +	u32 status, mask;
>  
>  	pos = dev->aer_cap;
>  	if (!pos)
>  		return -EIO;
>  
> +	/* Clean AER Root Error Status */
> +	pos = dev->aer_cap;
>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
> +	status &= ~mask; /* Clear corresponding nonfatal bits */
>  	if (status)
>  		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>  
> -- 
> 2.7.4
> 
