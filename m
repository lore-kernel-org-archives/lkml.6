Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZpxWTE2+op47PEcCP4VD7Pcjrjd9w3g1OTcQF1hmoeUfouklMslyKp5bDfBywkoaJBGmDAh
ARC-Seal: i=1; a=rsa-sha256; t=1525823613; cv=none;
        d=google.com; s=arc-20160816;
        b=a1tbvckpio4N0joi9x3yF/xDKHFtQoSyKCLraqzfYDpiGypu55TSY3qmK8LYblMHkJ
         p02qTVn6oNpow+UuaaGIqv8Nu6/q3hIXjZjDcBkYwrxPtnnZ2vsRp/18Fy9WS1qbPmVd
         zUcSTaXwHYwRFV/plT/mophwcuzLRfdaVPRoFz+LWD8t//007P779J1+FVzScp8kuuit
         ME0zistWMLJ69i83etWXgUldwqi5T6oXBuC0ni/wIQXe0IhnTmsKs0AMEUq+k9/FMKzT
         a2VEEED1TC7PndwKq7VYnpA5VkJezyeZaN8BKPIvPN4DkjD+AzmcJmZLARpAJezNy3CS
         c6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=hP466augVnNKVifU13yQZPKpOWvAfQS1ENgvb9XjDoA=;
        b=dyeLojM2jg8V8PZoXbblyPZZiTuhBxHX5/YY2Fd48b91gac+eqJp8F/U+POozYBTHT
         AKri9IYDom4+netV8SbNJe8TVewLmS5v55TkKSu3Kqlqul72RVq9uUAqRISk7e749DT9
         eaEQMoelcEG+bK7UvpDOQ9IO0i0wD7XV2MCM/zKf82QkMBk2BeEWieEkiZCIpS0B6t0m
         /HtsEnvzHkaYARcW7CgcBfoMYeJxPMRc/JBbVbLNP4MIaRKsmyag/9N3tItymiBdMv7i
         MYhz62huLMO3TzHG+EHbsBTQdHrtP83R5xrBV4TSvqAOGm7bt4nfyBeXTR8q2agxbobT
         qVFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1lDD7dI0;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1lDD7dI0;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 18:53:30 -0500
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
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
Message-ID: <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525323838-1735-4-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977501212020?=
X-GMAIL-MSGID: =?utf-8?q?1599942021215601622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
> This patch alters the behavior of handling of ERR_FATAL, where removal
> of devices is initiated, followed by reset link, followed by
> re-enumeration.
> 
> So the errors are handled in a different way as follows:
> ERR_NONFATAL => call driver recovery entry points
> ERR_FATAL    => remove and re-enumerate
> 
> please refer to Documentation/PCI/pci-error-recovery.txt for more details.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 779b387..206f590 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>  
> +	/*
> +	 * This function is called only on ERR_FATAL now, and since
> +	 * the pci_report_resume is called only in ERR_NONFATAL case,
> +	 * the clearing part has to be taken care here.
> +	 */
> +	aer_error_resume(dev);

I don't understand this part.  Previously the ERR_FATAL path looked like
this:

  do_recovery
    reset_link
      driver->reset_link
        aer_root_reset
          pci_reset_bridge_secondary_bus                # <-- reset
    broadcast_error_message(..., report_resume)
      pci_walk_bus(..., report_resume, ...)
        report_resume
      if (cb == report_resume)
        pci_cleanup_aer_uncorrect_error_status
          pci_write_config_dword(PCI_ERR_UNCOR_STATUS)  # <-- clear status

After this patch, it will look like this:

  do_recovery
    do_fatal_recovery
      pci_cleanup_aer_uncorrect_error_status
        pci_write_config_dword(PCI_ERR_UNCOR_STATUS)    # <-- clear status
      reset_link
        driver->reset_link
          aer_root_reset
            pci_reset_bridge_secondary_bus              # <-- reset
            aer_error_resume
              pcie_capability_write_word(PCI_EXP_DEVSTA)        # <-- clear more
              pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      # <-- clear status

So if I'm understanding correctly, the new path clears the status too
early, then clears it again (plus clearing DEVSTA, which we didn't do
before) later.

I would think we would want to leave aer_root_reset() alone, and just move
the pci_cleanup_aer_uncorrect_error_status() in do_fatal_recovery() down so
it happens after we call reset_link().  That way the reset/clear sequence
would be the same as it was before.

>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 0ea5acc..655d4e8 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/kfifo.h>
>  #include "aerdrv.h"
> +#include "../../pci.h"
>  
>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>  				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
> @@ -474,6 +475,44 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  	return status;
>  }
>  
> +static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
> +{
> +	struct pci_dev *udev;
> +	struct pci_bus *parent;
> +	struct pci_dev *pdev, *temp;
> +	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
> +
> +	if (severity == AER_FATAL)
> +		pci_cleanup_aer_uncorrect_error_status(dev);
> +
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +		udev = dev;
> +	else
> +		udev = dev->bus->self;
> +
> +	parent = udev->subordinate;
> +	pci_lock_rescan_remove();
> +	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> +				 bus_list) {
> +		pci_dev_get(pdev);
> +		pci_dev_set_disconnected(pdev, NULL);
> +		if (pci_has_subordinate(pdev))
> +			pci_walk_bus(pdev->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +		pci_stop_and_remove_bus_device(pdev);
> +		pci_dev_put(pdev);
> +	}
> +
> +	result = reset_link(udev);
> +	if (result == PCI_ERS_RESULT_RECOVERED)
> +		if (pcie_wait_for_link(udev, true))
> +			pci_rescan_bus(udev->bus);
> +
> +	pci_unlock_rescan_remove();
> +
> +	return result;
> +}
> +
>  /**
>   * do_recovery - handle nonfatal/fatal error recovery process
>   * @dev: pointer to a pci_dev data structure of agent detecting an error
> @@ -485,11 +524,15 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>   */
>  static void do_recovery(struct pci_dev *dev, int severity)
>  {
> -	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
> +	pci_ers_result_t status;
>  	enum pci_channel_state state;
>  
> -	if (severity == AER_FATAL)
> -		state = pci_channel_io_frozen;
> +	if (severity == AER_FATAL) {
> +		status = do_fatal_recovery(dev, severity);
> +		if (status != PCI_ERS_RESULT_RECOVERED)
> +			goto failed;
> +		return;
> +	}
>  	else
>  		state = pci_channel_io_normal;
>  
> @@ -498,12 +541,6 @@ static void do_recovery(struct pci_dev *dev, int severity)
>  			"error_detected",
>  			report_error_detected);
>  
> -	if (severity == AER_FATAL) {
> -		result = reset_link(dev);
> -		if (result != PCI_ERS_RESULT_RECOVERED)
> -			goto failed;
> -	}
> -
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER)
>  		status = broadcast_error_message(dev,
>  				state,
> -- 
> 2.7.4
> 
