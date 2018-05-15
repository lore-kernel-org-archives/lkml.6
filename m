Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZoHfuX2KdwHZs/wqCDANFFKv1KiJNc3FOQ28pAC1m+l/dUxb1RIOFMgcZKG0B7gaN4oVx2b
ARC-Seal: i=1; a=rsa-sha256; t=1526428794; cv=none;
        d=google.com; s=arc-20160816;
        b=HbTBig8HKP/SYhofv52X/AV7ZDelrr/amHZURKyQFOpCkueWrk9ebpwR1RnCDkyL5X
         fWAtEjAVGcvObOnMG4eXxg1ZrvE8fpu7uQd3aOAs06TA1ReDp+DYReYBBZdhObebEV+6
         UdtsJLzQ/jaUSJy+3ceOKUhuetcitjdm7WJa6H3R8bGjKWy1W94619lk5qp4P3mrDJqM
         XZPVifNhu2flkx97Pr+hDhav5AU/3wreyZCCQOTs5PkDjWYtIeDZMl1GwPK8v30LBlqP
         agQWl4ByfV20qU1wE+mpGByZhGQFcDM/7UtYV4Jvq3jOvKjqgwba+K71NiPyLXpDmKd9
         nN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nAkYN3LwwVYVDlaBfg+3X0Z/xGkE+X/G4q+h8bNyIag=;
        b=d/GaxnL4hQm6ZxI9bX7odVg+M9rRJoF7HSwPY4ki8RJ9T8ana4FyIgMhvlf3JQav51
         XC/P/TBCNGLxjU+7ayCJnKovNWpdYrlxwW4bcdOPMmY31MgPDLz/mJwR8iH9rgGvBS74
         3ERaXTe+mUpWBeTSFUPNUGqSvOBO8yfNgb5rsC0rDNiDjS+LAuw+axSQ6zqlYuUufah1
         R5H4AY7T7x6fJbCE1gETHS92RF9cY+ovmdYJNbkUd7E1wi0DxFzOTV+LNR0Cx6y2bTPb
         w/el+/oj5BzDaHQWnxJDAitX6EZeDxjOBMvCI05pv0F92Ea/lkmCBGU0tfHMSh3bAI1+
         j6sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ig9+Xdaq;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ig9+Xdaq;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 15 May 2018 18:59:52 -0500
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
Subject: Re: [PATCH v16 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
Message-ID: <20180515235952.GC11156@bhelgaas-glaptop.roam.corp.google.com>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-4-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526035408-31328-4-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111733516590?=
X-GMAIL-MSGID: =?utf-8?q?1600576600330917008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 06:43:22AM -0400, Oza Pawandeep wrote:
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
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 0ea5acc..649dd1f 100644
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
> @@ -475,35 +476,84 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  }
>  
>  /**
> - * do_recovery - handle nonfatal/fatal error recovery process
> + * do_fatal_recovery - handle fatal error recovery process
> + * @dev: pointer to a pci_dev data structure of agent detecting an error
> + *
> + * Invoked when an error is fatal. Once being invoked, removes the devices
> + * benetah this AER agent, followed by reset link e.g. secondary bus reset
> + * followed by re-enumeration of devices.
> + */
> +
> +static void do_fatal_recovery(struct pci_dev *dev)
> +{
> +	struct pci_dev *udev;
> +	struct pci_bus *parent;
> +	struct pci_dev *pdev, *temp;
> +	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
> +	struct aer_broadcast_data result_data;
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

I don't like the fact that for DPC, the link reset happens before we call
the driver .remove() methods, while for AER, the reset happens *after* the
.remove() methods.  That means the .remove() methods may work differently
for AER vs. DPC, e.g., they may be able to access the device if AER is
handling the error, but they would not be able to access it if DPC is
handling it.

I don't know how to fix this, and I think we can keep this patch as it is
for now, but I think we should fix it eventually.

> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		/*
> +		 * If the error is reported by a bridge, we think this error
> +		 * is related to the downstream link of the bridge, so we
> +		 * do error recovery on all subordinates of the bridge instead
> +		 * of the bridge and clear the error status of the bridge.
> +		 */
> +		pci_walk_bus(dev->subordinate, report_resume, &result_data);
> +		pci_cleanup_aer_uncorrect_error_status(dev);
> +	}
> +
> +	if (result == PCI_ERS_RESULT_RECOVERED) {
> +		if (pcie_wait_for_link(udev, true))
> +			pci_rescan_bus(udev->bus);
> +	} else {
> +		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +		pci_info(dev, "AER: Device recovery failed\n");
> +	}
> +
> +	pci_unlock_rescan_remove();
> +}
> +
> +/**
> + * do_nonfatal_recovery - handle nonfatal error recovery process
>   * @dev: pointer to a pci_dev data structure of agent detecting an error
> - * @severity: error severity type
>   *
>   * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
>   * error detected message to all downstream drivers within a hierarchy in
>   * question and return the returned code.
>   */
> -static void do_recovery(struct pci_dev *dev, int severity)
> +static void do_nonfatal_recovery(struct pci_dev *dev)
>  {
> -	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
> +	pci_ers_result_t status;
>  	enum pci_channel_state state;
>  
> -	if (severity == AER_FATAL)
> -		state = pci_channel_io_frozen;
> -	else
> -		state = pci_channel_io_normal;
> +	state = pci_channel_io_normal;
>  
>  	status = broadcast_error_message(dev,
>  			state,
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
> @@ -562,8 +612,10 @@ static void handle_error_source(struct pcie_device *aerdev,
>  		if (pos)
>  			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
>  					info->status);
> -	} else
> -		do_recovery(dev, info->severity);
> +	} else if (info->severity == AER_NONFATAL)
> +		do_nonfatal_recovery(dev);
> +	else if (info->severity == AER_FATAL)
> +		do_fatal_recovery(dev);
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -627,8 +679,10 @@ static void aer_recover_work_func(struct work_struct *work)
>  			continue;
>  		}
>  		cper_print_aer(pdev, entry.severity, entry.regs);
> -		if (entry.severity != AER_CORRECTABLE)
> -			do_recovery(pdev, entry.severity);
> +		if (entry.severity == AER_NONFATAL)
> +			do_nonfatal_recovery(pdev);
> +		else if (entry.severity == AER_FATAL)
> +			do_fatal_recovery(pdev);
>  		pci_dev_put(pdev);
>  	}
>  }
> -- 
> 2.7.4
> 
