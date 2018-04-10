Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AIpwx49bOdFhOuwQQNCkp6N+Ly0HQLDne8SrMUF7TzlnTwiklHcMtblgIc6+onpZms2wJZ2sDMGS
ARC-Seal: i=1; a=rsa-sha256; t=1523394231; cv=none;
        d=google.com; s=arc-20160816;
        b=z3ZFCULjUyPx+zm76gE4QImIAFLMv1dYcxZc6zyzxS8XE78pIALWhfZkv23ksEP5OF
         c29mW4EJ+cVmKzyLOojjcAati033quN+6dAYJ9h2sPDlW8Gtm95Ca3fdc+fgQsjRRbqU
         P2PiqONMuHn5hD+US2XiHYftBU0KhseNQzYpbdi/UMov+szHBghEslEIW2HXHkFYB9w3
         CNb0QEENrAwfIYgjO91Abt+bMsILZa60M6a3lmIdIiZfWHJJT1cPGIaZQAvEHFvUpdt4
         NIJBtW43fL8lFj8WahCXYDPRvoKpp0qg3cc+ZoarEt6dC6ohB/sK4ZV6LATUPKweVLJJ
         G6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=K4Cjfnf9qKt5xm1XigkSJSzXBOJdJhOtp1Eudzo6ucc=;
        b=lJI2VYnmQTxzE/9WVRGLEVMmKA4ciJtOD8/Y0RXaUI6HKzYYP38YYB06qyPvGau1lR
         0eop7kZT66vJ3Duk3T4cf7CdD0Z2dodNfW0ztMh7MGgOMsrcUg2JgTx+2+zv7lfJvzbt
         YTYBbaTrpXDNnNzfDiaoj7aVI75WbiG6zkvny5rx4hIj1VPrjnJrDunPnvEldyFDlW80
         zqqpselMj9SlY9gwrHQ0gVKKYDNY4I+1kXJUDkXmSYmeYi2iS7+p3FcJvfYRXuaSrv3p
         kkA7T8BZjL45KBc0V6bVHU0Ese5yugHlG3vWM6HuVNBPj7NaAT3R+kRP7BUkYJFutgxL
         kAgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF2F21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 10 Apr 2018 16:03:49 -0500
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
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-7-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597394629692307714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:54AM -0400, Oza Pawandeep wrote:
> DPC and AER should attempt recovery in the same way, except the
> cases where system is with hotplug enabled.

What's the connection with hotplug?  I see from the patch that for
hotplug bridges you remove the tree below the bridge, and otherwise
you just reset the secondary link (I think).

The changelog should explain why we need the difference.

I'm a little skeptical to begin with, because I'm not sure why we
should handle a DPC event differently just because a bridge has the
*capability* of hotplug.  Even if a hotplug bridge reports a DPC
event, that doesn't necessarily mean a hotplug has occurred.

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 8e1553b..6d9a841 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -108,8 +108,6 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>   */
>  static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {
> -	struct pci_bus *parent = pdev->subordinate;
> -	struct pci_dev *dev, *temp;
>  	struct dpc_dev *dpc;
>  	struct pcie_device *pciedev;
>  	struct device *devdpc;
> @@ -120,19 +118,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	dpc = get_service_data(pciedev);
>  	cap = dpc->cap_pos;
>  
> -	pci_lock_rescan_remove();
> -	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> -					 bus_list) {
> -		pci_dev_get(dev);
> -		pci_dev_set_disconnected(dev, NULL);
> -		if (pci_has_subordinate(dev))
> -			pci_walk_bus(dev->subordinate,
> -				     pci_dev_set_disconnected, NULL);
> -		pci_stop_and_remove_bus_device(dev);
> -		pci_dev_put(dev);
> -	}
> -	pci_unlock_rescan_remove();
> -
>  	dpc_wait_link_inactive(dpc);
>  	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
>  		return PCI_ERS_RESULT_DISCONNECT;
> @@ -152,13 +137,37 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> +static void dpc_reset_link_remove_dev(struct pci_dev *pdev)
> +{
> +	struct pci_bus *parent = pdev->subordinate;
> +	struct pci_dev *dev, *temp;
> +
> +	pci_lock_rescan_remove();
> +	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> +					 bus_list) {
> +		pci_dev_get(dev);
> +		pci_dev_set_disconnected(dev, NULL);
> +		if (pci_has_subordinate(dev))
> +			pci_walk_bus(dev->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +		pci_stop_and_remove_bus_device(dev);
> +		pci_dev_put(dev);
> +	}
> +	pci_unlock_rescan_remove();
> +
> +	dpc_reset_link(pdev);
> +}
> +
>  static void dpc_work(struct work_struct *work)
>  {
>  	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>  	struct pci_dev *pdev = dpc->dev->port;
>  
>  	/* From DPC point of view error is always FATAL. */
> -	pcie_do_recovery(pdev, DPC_FATAL);
> +	if (!pdev->is_hotplug_bridge)
> +		pcie_do_recovery(pdev, DPC_FATAL);
> +	else
> +		dpc_reset_link_remove_dev(pdev);
>  }
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
> -- 
> 2.7.4
> 
