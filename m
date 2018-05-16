Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZo0BOP8TzassApy0bnD5Wq4VujW8A9NR6ulN6u7mQy2CR/sUj/WNiPZs5TgDFMRB0bWenCI
ARC-Seal: i=1; a=rsa-sha256; t=1526429186; cv=none;
        d=google.com; s=arc-20160816;
        b=sCstph0FJd4xUeK7F5kQB8WNpaLYMaBuztX14FTN/nLIZ55uF79djGoYyck7AEuy9k
         QEJ2ruOc3UDYbVdyxbAJeMpPSQOswZDG0SRul4wG7+4Y3xbe0V9pZalHkEjRYS00VKQw
         WcG6dUJDCiMVDtcYOYsasLcMQUxaD2ni+hiHOzGo6e6G0sVLYCoBtBhNoHTmSTvrNR1i
         Mxe1+b0Fm8rx6ChgmfMee/tq6ubWi4T/UA7uF0eTW77LUyi5rl9lqkErGZ0FAemS51fY
         S4mZ4N2uFNxgpRAqZG4RntXkSv+pqzq/i+hzfW3jQ1IQRSYH1DpywUAi8GFnaJZhFXyo
         aVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nkXBQNGZy2UEgzaXDecwAwnDv32aqAitFTYtFKRqUTo=;
        b=ti+9oo2DINdyujnr2EOmLRLJNNkA6kkocTUG2J5RbUMGqFuf0SdRhWYu+2iXa4dbqZ
         nSvWWMVxG7jlwvEfedgGzlCeUZ6W1LzKo1o4sZQFMYPWMFUr156IROXNkT2tPawzXIGa
         6fpyWhtLypomPs6H79WpcEj9URLszVbHT7KmZakP3Ux56+m8hgMghACDe8uTXXC6hvgv
         3yuEFF5lgvRmGsxTBrrzprujv1EzflZwQzFQ222JCUZR0bBKdGD/flW0DIRK3k0mH3zT
         gCOwzQocPes0FO+Wq1BuuPRGzf4ZXsaiyq/GMXYBfjIQ7LuFd//u1BfVkYQIsGYUTVDo
         fA8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BOgFBCYF;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BOgFBCYF;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 15 May 2018 19:06:24 -0500
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
Subject: Re: [PATCH v16 5/9] PCI/AER: Factor out error reporting from AER
Message-ID: <20180516000624.GD11156@bhelgaas-glaptop.roam.corp.google.com>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-6-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526035408-31328-6-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111757123236?=
X-GMAIL-MSGID: =?utf-8?q?1600577010189638561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 06:43:24AM -0400, Oza Pawandeep wrote:
> This patch factors out error reporting callbacks, which are currently
> tightly coupled with AER.
> 
> DPC should be able to register callbacks and attempt recovery when DPC
> trigger event occurs.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

> +static int report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	pci_ers_result_t vote;
> +	const struct pci_error_handlers *err_handler;
> +	struct aer_broadcast_data *result_data;
> +
> +	result_data = (struct aer_broadcast_data *) data;
> +
> +	device_lock(&dev->dev);
> +	dev->error_state = result_data->state;
> +
> +	if (!dev->driver ||
> +		!dev->driver->err_handler ||
> +		!dev->driver->err_handler->error_detected) {
> +		if (result_data->state == pci_channel_io_frozen &&
> +			dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> +			/*
> +			 * In case of fatal recovery, if one of down-
> +			 * stream device has no driver. We might be
> +			 * unable to recover because a later insmod
> +			 * of a driver for this device is unaware of
> +			 * its hw state.
> +			 */
> +			pci_printk(KERN_DEBUG, dev, "device has %s\n",
> +				   dev->driver ?
> +				   "no AER-aware driver" : "no driver");
> +		}
> +
> +		/*
> +		 * If there's any device in the subtree that does not
> +		 * have an error_detected callback, returning
> +		 * PCI_ERS_RESULT_NO_AER_DRIVER prevents calling of
> +		 * the subsequent mmio_enabled/slot_reset/resume
> +		 * callbacks of "any" device in the subtree. All the
> +		 * devices in the subtree are left in the error state
> +		 * without recovery.
> +		 */
> +
> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> +		else
> +			vote = PCI_ERS_RESULT_NONE;
> +	} else {
> +		err_handler = dev->driver->err_handler;
> +		vote = err_handler->error_detected(dev, result_data->state);
> +#if defined(CONFIG_PCIEAER)
> +		pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> +#endif

> +static int report_slot_reset(struct pci_dev *dev, void *data)
> +{
> +	pci_ers_result_t vote;
> +	const struct pci_error_handlers *err_handler;
> +	struct aer_broadcast_data *result_data;
> +
> +	result_data = (struct aer_broadcast_data *) data;
> +
> +	device_lock(&dev->dev);
> +	if (!dev->driver ||
> +		!dev->driver->err_handler ||
> +		!dev->driver->err_handler->slot_reset)
> +		goto out;
> +
> +	err_handler = dev->driver->err_handler;
> +	vote = err_handler->slot_reset(dev);
> +	result_data->result = merge_result(result_data->result, vote);
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +static int report_resume(struct pci_dev *dev, void *data)
> +{
> +	const struct pci_error_handlers *err_handler;
> +
> +	device_lock(&dev->dev);
> +	dev->error_state = pci_channel_io_normal;
> +
> +	if (!dev->driver ||
> +		!dev->driver->err_handler ||
> +		!dev->driver->err_handler->resume)
> +		goto out;
> +
> +	err_handler = dev->driver->err_handler;
> +	err_handler->resume(dev);
> +#if defined(CONFIG_PCIEAER)
> +	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
> +#endif

> +void pcie_do_fatal_recovery(struct pci_dev *dev)
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
> +
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
> +		pci_info(dev, "Device recovery successful\n");
> +	} else {
> +#if defined(CONFIG_PCIEAER)
> +		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +#endif

I don't think this is the optimal resolution for this problem.

It is true that we only call this function if either

  CONFIG_PCIEAER=y or
  CONFIG_PCIE_DPC=y

and furthermore that CONFIG_PCIE_DPC depends on CONFIG_PCIEAER, so in
either case, pci_uevent_ers() is present, since it is conditional on

  #if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)

But the #ifdef here seems unnecessarily complicated.  I think it would be
better to change the #ifdef around the definition of pci_uevent_ers().
Then we wouldn't need the several #ifdefs in this file.
