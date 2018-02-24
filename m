Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x226zEVMN30miG/Ea7L9Wo8cAzuhkUr1qtbn+sG+Gs0w9+180QpWiE2RS5D6r6+tB6Q78s90H
ARC-Seal: i=1; a=rsa-sha256; t=1519430876; cv=none;
        d=google.com; s=arc-20160816;
        b=pp/4W6nKVhJAa4ZTBklL+YIq30WLvknXIQAdEt6C/WFS2OBdBZ7uHqN5z1G7vHVukJ
         F5wNLo2dbt1VWiM1NJFNsvE0X/Boy5qdW9oGjLIR4UTmCw5aVBmEfmIHNIbxjxCNDmvH
         T0QV1voavvWC7qTqD6sSr4Ytd8qrR8nrfQJFom4JKhYYVtWYO/6GcLd+f6B94qVcHmRP
         Ag7hOU7LtX5+xXXWF24HJwvBbc7Bwr3h/3QP9Q1ML6fQG16e78IFP9Jerl/8K7nz7LMl
         RhszgVbsRquMcl5bUwuYh4LKkj0AWx8371WYQN1Of1dmPg1eSiLRfpVX71wqliVPX0f6
         5uAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=QiBab4IVSpkYNVUa/SVUwkg2FrTNXcGou9Jmae7pM7k=;
        b=KdpcDAo1eqSz++G/LUBhfpDs3w/omS9XbWI2fMCETBRZPp5WEYPrJWSQN+OZwfG+05
         GfzLPfmlDcwJklP9MfNHHEKeM1kGUxs1GRpW9jG6Ww4QFqTQ1GV1uGrq4A2O9UgyfnY1
         qOCx0Sw98ugq2fbL/ZOly4okVo2th5OHu59jydqVlZEUrgIwCjbxLryARnyBjig1bWpJ
         syNCXWHn6mcyYP+tXmkPv53zBwCEBlh3WeAfKQ3JxBTPCrF9fqo4l11SeYWDrKeLpvQu
         FHdu36qhUUmifMJ5bgc30cOaSMmMkEtyW0YY+0tPuWfoPC0Ur9dsDFJM8n/nB0tbfyoV
         cF9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82CC21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 23 Feb 2018 18:07:54 -0600
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
Subject: Re: [PATCH v11 4/7] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180224000754.GR14632@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-5-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519374244-20539-5-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086415695868818?=
X-GMAIL-MSGID: =?utf-8?q?1593238750525526902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 01:54:01PM +0530, Oza Pawandeep wrote:
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the sw.
> 
> DPC driver implements link_reset callback, and calls pcie_do_recovery.

s/pcie_do_recovery/pcie_do_recovery()/

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index abc514e..f8575da 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -343,6 +343,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  void pci_enable_acs(struct pci_dev *dev);
>  
>  /* PCI error reporting and recovery */
> +#define DPC_FATAL	4

This needs to go next to the AER_FATAL, etc., definitions because
DPC_FATAL shares the namespace and they all need to have distinct
values.  I can't tell from this patch whether they do or not.

>  void pcie_do_recovery(struct pci_dev *dev, int severity);
>  
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 38e40c6..5c01c63 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/pcieport_if.h>
>  #include "../pci.h"
>  #include "aer/aerdrv.h"
> +#include "portdrv.h"
>  
>  struct dpc_dev {
>  	struct pcie_device	*dev;
> @@ -45,6 +46,58 @@ struct dpc_dev {
>  	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>  };
>  
> +static int find_dpc_dev_iter(struct device *device, void *data)
> +{
> +	struct pcie_port_service_driver *service_driver;
> +	struct device **dev = (struct device **) data;;
> +
> +	if (device->bus == &pcie_port_bus_type && device->driver) {
> +		service_driver = to_service_driver(device->driver);
> +		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
> +			*dev = device;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
> +{
> +	struct device *dev = NULL;
> +
> +	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
> +
> +	return dev;
> +}

Ugh.  You're not responsible for this and you don't need to do
anything, but hanging the struct dpc_dev off the struct pcie_device
and then having to grub around like this to locate it from the pci_dev
is just ... clunky.  OK, rant over, sorry :)

> +static int find_dpc_service_iter(struct device *device, void *data)
> +{
> +	struct pcie_port_service_driver *service_driver;
> +	struct pcie_port_service_driver **drv =
> +		(struct pcie_port_service_driver **) data;
> +
> +	if (device->bus == &pcie_port_bus_type && device->driver) {
> +		service_driver = to_service_driver(device->driver);
> +		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
> +			*drv = service_driver;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct pcie_port_service_driver *pci_find_dpc_service(struct pci_dev *dev)
> +{
> +	struct pcie_port_service_driver *drv = NULL;
> +
> +	device_for_each_child(&dev->dev, &drv, find_dpc_service_iter);
> +
> +	return drv;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_dpc_service);

No module uses this, so it doesn't need to be exported.

This is a clone of find_aer_service().  Can you add a preliminary patch to
make a generic "find service" interface that accepts the service type
(PCIE_PORT_SERVICE_AER, PCIE_PORT_SERVICE_DPC) as a parameter?

This whole "find service" thing is ugly as sin.  You're not responsible for
cleaning it up, but maybe we can at least limit the proliferation of it.

>  static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  {
>  	unsigned long timeout = jiffies + HZ;
> @@ -82,12 +135,25 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>  		dev_warn(dev, "Link state not disabled for DPC event\n");
>  }
>  
> -static void dpc_work(struct work_struct *work)
> +/**
> + * dpc_reset_link - reset link DPC  routine

s/  / / (remove extra space)

> + * @dev: pointer to Root Port's pci_dev data structure
> + *
> + * Invoked by Port Bus driver when performing link reset at Root Port.
> + */
> +static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {
> -	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> -	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
>  	struct pci_bus *parent = pdev->subordinate;
> -	u16 cap = dpc->cap_pos, ctl;
> +	struct pci_dev *dev, *temp;
> +	struct dpc_dev *dpc;
> +	struct pcie_device *pciedev;
> +	struct device *devdpc;
> +	u16 cap, ctl;
> +
> +	devdpc = pci_find_dpc_dev(pdev);
> +	pciedev = to_pcie_device(devdpc);
> +	dpc = get_service_data(pciedev);
> +	cap = dpc->cap_pos;
>  
>  	pci_lock_rescan_remove();
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> @@ -104,21 +170,31 @@ static void dpc_work(struct work_struct *work)
>  
>  	dpc_wait_link_inactive(dpc);
>  	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
> -		return;
> +		return PCI_ERS_RESULT_DISCONNECT;
>  	if (dpc->rp_extensions && dpc->rp_pio_status) {
>  		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
>  				       dpc->rp_pio_status);
>  		dpc->rp_pio_status = 0;
>  	}
>  
> -	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> +	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
>  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
> -			      ctl | PCI_EXP_DPC_CTL_INT_EN);
> +				ctl | PCI_EXP_DPC_CTL_INT_EN);

Align "ctl" with "pdev".

> +	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> +static void dpc_work(struct work_struct *work)
> +{
> +	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> +	struct pci_dev *pdev = dpc->dev->port;
> +
> +	/* From DPC point of view error is always FATAL. */
> +	pcie_do_recovery(pdev, DPC_FATAL);
> +}
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
>  	struct device *dev = &dpc->dev->device;
> @@ -297,6 +373,7 @@ static void dpc_remove(struct pcie_device *dev)
>  	.service	= PCIE_PORT_SERVICE_DPC,
>  	.probe		= dpc_probe,
>  	.remove		= dpc_remove,
> +	.reset_link     = dpc_reset_link,
>  };
>  
>  static int __init dpc_service_init(void)
> diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
> index f830975..1ea4b9a 100644
> --- a/drivers/pci/pcie/pcie-err.c
> +++ b/drivers/pci/pcie/pcie-err.c
> @@ -19,6 +19,7 @@
>  #include <linux/aer.h>
>  #include <linux/pcieport_if.h>
>  #include "portdrv.h"
> +#include "./../pci.h"
>  
>  static DEFINE_MUTEX(pci_err_recovery_lock);
>  
> @@ -181,7 +182,7 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> -static pci_ers_result_t reset_link(struct pci_dev *dev)
> +static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
>  {
>  	struct pci_dev *udev;
>  	pci_ers_result_t status;
> @@ -195,9 +196,17 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  		udev = dev->bus->self;
>  	}
>  
> +
> +	/* Use the service driver of the component firstly */
> +#if IS_ENABLED(CONFIG_PCIE_DPC)

#ifdef CONFIG_PCIE_DPC

> +	if (severity == DPC_FATAL)
> +		driver = pci_find_dpc_service(udev);
> +#endif
>  #if IS_ENABLED(CONFIG_PCIEAER)
> -	/* Use the aer driver of the component firstly */
> -	driver = pci_find_aer_service(udev);
> +	if (severity == AER_FATAL ||
> +	    severity == AER_NONFATAL ||
> +	    severity == AER_CORRECTABLE)

This change (to check for AER_FATAL, etc) looks like it belongs in a
different patch.  This patch doesn't change any places that set the
severity.

> +		driver = pci_find_aer_service(udev);
>  #endif
>  
>  	if (driver && driver->reset_link) {
> @@ -287,7 +296,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
>  
>  	mutex_lock(&pci_err_recovery_lock);
>  
> -	if (severity == AER_FATAL)
> +	if (severity == AER_FATAL ||
> +	    severity == DPC_FATAL)
>  		state = pci_channel_io_frozen;
>  	else
>  		state = pci_channel_io_normal;
> @@ -297,10 +307,14 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
>  			"error_detected",
>  			report_error_detected);
>  
> -	if (severity == AER_FATAL) {
> -		result = reset_link(dev);
> +	if (severity == AER_FATAL ||
> +	    severity == DPC_FATAL) {
> +		result = reset_link(dev, severity);
>  		if (result != PCI_ERS_RESULT_RECOVERED)
>  			goto failed;
> +		else if (severity == DPC_FATAL)
> +			goto resume;
> +
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER)
> @@ -324,6 +338,7 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
> +resume:
>  	broadcast_error_message(dev,
>  				state,
>  				"resume",
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 4f1992d..b013e24 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -80,4 +80,5 @@ static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
>  #endif /* !CONFIG_ACPI */
>  
>  struct pcie_port_service_driver *pci_find_aer_service(struct pci_dev *dev);
> +struct pcie_port_service_driver *pci_find_dpc_service(struct pci_dev *dev);
>  #endif /* _PORTDRV_H_ */
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
> a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
