Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEPWo1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:44:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEPWo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:44:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F30360558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: DPC: Clear AER status bits before disabling port
 containment
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180516213306.27027-1-mr.nuke.me@gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <605540c0-b6c5-89a2-9d50-12a3005d9f88@codeaurora.org>
Date: Wed, 16 May 2018 18:44:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516213306.27027-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2018 5:33 PM, Alexandru Gagniuc wrote:
> AER status bits are sticky, and they survive system resets. Downstream
> devices are usually taken care of after re-enumerating the downstream
> busses, as the AER bits are cleared during probe().
> 
> However, nothing clears the bits of the port which contained the
> error. These sticky bits may leave some BIOSes to think that something
> bad happened, and print ominous messages on next boot. To prevent this,
> tidy up the AER status bits before releasing containment.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/pcie/dpc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 8c57d607e603..bf82d6936556 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -112,6 +112,10 @@ static void dpc_work(struct work_struct *work)
>  		dpc->rp_pio_status = 0;
>  	}
>  
> +	/* DPC event made a mess of our AER status bits. Clean them up. */
> +	pci_cleanup_aer_error_status_regs(pdev);
> +	/* TODO: Should we also use aer_print_error to log the event? */
> +
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>  
> 

I think Keith has a patch to fix this. It was under review at some point.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
