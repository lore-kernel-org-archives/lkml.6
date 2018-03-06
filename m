Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCFKhJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:37:09 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:32458 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:37:07 -0500
X-IronPort-AV: E=Sophos;i="5.47,431,1515456000";
   d="scan'208";a="710603536"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/2] PCI/IOV: Store more data about VFs into the SRIOV
 struct
Thread-Topic: [PATCH v3 1/2] PCI/IOV: Store more data about VFs into the SRIOV
 struct
Thread-Index: AQHTsaSzivhNtpfUU0WqUXkbOks3dqO9ec6AgAWRB4A=
Date: Tue, 6 Mar 2018 10:37:02 +0000
Message-ID: <1520332621.28771.13.camel@amazon.de>
References: <1519939897-14596-1-git-send-email-karahmed@amazon.de>
         <20180302213639.GC202062@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180302213639.GC202062@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A100DE232BE91542B1D481DD5FEA1399@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w26AbFZx006759

On Fri, 2018-03-02 at 15:36 -0600, Bjorn Helgaas wrote:
> On Thu, Mar 01, 2018 at 10:31:36PM +0100, KarimAllah Ahmed wrote:
> > 
> > Store more data about PCI VFs into the SRIOV to avoid reading them from the
> > config space of all the PCI VFs. This is specially a useful optimization
> > when bringing up thousands of VFs.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> 
> Applied to pci/virtualization for v4.17, thanks!
> 
> I removed the pci_sriov.device field, which seemed to be unused, and
> tweaked a few other things, so make sure I didn't break anything.

Yup, still looks good (and works) for me. Thanks.

> Here's what I have currently applied:
> 
> commit e17b7b429b095200f93ad37c4efeb7a99b6fce3b
> Author: KarimAllah Ahmed <karahmed@amazon.de>
> Date:   Thu Mar 1 22:31:36 2018 +0100
> 
>     PCI/IOV: Use VF0 cached config registers for other VFs
>     
>     Cache some config data from VF0 and use it for all other VFs instead of
>     reading it from the config space of each VF.  We assume these items are the
>     same across all associated VFs:
>     
>       Revision ID
>       Class Code
>       Subsystem Vendor ID
>       Subsystem ID
>     
>     This is an optimization when enabling SR-IOV on a device with many VFs.
>     
>     Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>     [bhelgaas: changelog, simplify comments, remove unused "device"]
>     Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 677924ae0350..30bf8f706ed9 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -114,6 +114,29 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
>  	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
>  }
>  
> +static void pci_read_vf_config_common(struct pci_dev *virtfn)
> +{
> +	struct pci_dev *physfn = virtfn->physfn;
> +
> +	/*
> +	 * Some config registers are the same across all associated VFs.
> +	 * Read them once from VF0 so we can skip reading them from the
> +	 * other VFs.
> +	 *
> +	 * PCIe r4.0, sec 9.3.4.1, technically doesn't require all VFs to
> +	 * have the same Revision ID and Subsystem ID, but we assume they
> +	 * do.
> +	 */
> +	pci_read_config_dword(virtfn, PCI_CLASS_REVISION,
> +			      &physfn->sriov->class);
> +	pci_read_config_byte(virtfn, PCI_HEADER_TYPE,
> +			     &physfn->sriov->hdr_type);
> +	pci_read_config_word(virtfn, PCI_SUBSYSTEM_VENDOR_ID,
> +			     &physfn->sriov->subsystem_vendor);
> +	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
> +			     &physfn->sriov->subsystem_device);
> +}
> +
>  int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  {
>  	int i;
> @@ -136,13 +159,17 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	virtfn->devfn = pci_iov_virtfn_devfn(dev, id);
>  	virtfn->vendor = dev->vendor;
>  	virtfn->device = iov->vf_device;
> +	virtfn->is_virtfn = 1;
> +	virtfn->physfn = pci_dev_get(dev);
> +
> +	if (id == 0)
> +		pci_read_vf_config_common(virtfn);
> +
>  	rc = pci_setup_device(virtfn);
>  	if (rc)
> -		goto failed0;
> +		goto failed1;
>  
>  	virtfn->dev.parent = dev->dev.parent;
> -	virtfn->physfn = pci_dev_get(dev);
> -	virtfn->is_virtfn = 1;
>  	virtfn->multifunction = 0;
>  
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> @@ -163,10 +190,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	sprintf(buf, "virtfn%u", id);
>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>  	if (rc)
> -		goto failed1;
> +		goto failed2;
>  	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
>  	if (rc)
> -		goto failed2;
> +		goto failed3;
>  
>  	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
>  
> @@ -174,11 +201,12 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  
>  	return 0;
>  
> -failed2:
> +failed3:
>  	sysfs_remove_link(&dev->dev.kobj, buf);
> +failed2:
> +	pci_stop_and_remove_bus_device(virtfn);
>  failed1:
>  	pci_dev_put(dev);
> -	pci_stop_and_remove_bus_device(virtfn);
>  failed0:
>  	virtfn_remove_bus(dev->bus, bus);
>  failed:
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fcd81911b127..db76933be859 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -271,6 +271,10 @@ struct pci_sriov {
>  	u16		driver_max_VFs;	/* Max num VFs driver supports */
>  	struct pci_dev	*dev;		/* Lowest numbered PF */
>  	struct pci_dev	*self;		/* This PF */
> +	u32		class;		/* VF class */
> +	u8		hdr_type;	/* VF header type */
> +	u16		subsystem_vendor; /* VF subsystem vendor */
> +	u16		subsystem_device; /* VF subsystem device */
>  	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
>  	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a1cddca37793..78deb950bda1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1461,7 +1461,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	struct pci_bus_region region;
>  	struct resource *res;
>  
> -	if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
> +	if (dev->is_virtfn)
> +		hdr_type = dev->physfn->sriov->hdr_type;
> +	else if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
>  		return -EIO;
>  
>  	dev->sysdata = dev->bus->sysdata;
> @@ -1484,7 +1486,10 @@ int pci_setup_device(struct pci_dev *dev)
>  		     dev->bus->number, PCI_SLOT(dev->devfn),
>  		     PCI_FUNC(dev->devfn));
>  
> -	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
> +	if (dev->is_virtfn)
> +		class = dev->physfn->sriov->class;
> +	else
> +		pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
>  	dev->revision = class & 0xff;
>  	dev->class = class >> 8;		    /* upper 3 bytes */
>  
> @@ -1524,8 +1529,13 @@ int pci_setup_device(struct pci_dev *dev)
>  			goto bad;
>  		pci_read_irq(dev);
>  		pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
> -		pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
> -		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
> +		if (dev->is_virtfn) {
> +			dev->subsystem_vendor = dev->physfn->sriov->subsystem_vendor;
> +			dev->subsystem_device = dev->physfn->sriov->subsystem_device;
> +		} else {
> +			pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
> +			pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
> +		}
>  
>  		/*
>  		 * Do the ugly legacy mode stuff here rather than broken chip
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
