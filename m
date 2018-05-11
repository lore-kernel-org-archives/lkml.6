Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AB8JxZqFkrJtznyf0SqCB2VUrgVxNy+ez9HpbqUxoS9lG6R2Eng1Ii5uHp3T7j0o2KpxaUU/svzM
ARC-Seal: i=1; a=rsa-sha256; t=1526043540; cv=none;
        d=google.com; s=arc-20160816;
        b=fztA82qV1rziNOG8vQweseEymaQMFtkoths6umVIFYaMKG5JWdH8Er5ZJhGzw6VqQp
         29fSalpy4tIviT09delGX8LBDd12R1Ra79+JR8X5DoLfga776UGKxVJIT3c9YuZpn6rP
         hQTvtA4o9hg1RAk2s1zMzTuVCXhwAYN0wcF5T2plw8gfrK78s4v1z5vV1GabUrBTKymU
         Qe2aRJG2x96aZSL9fKchWasHq4qKZ5NIl1ilmiSdSH/0vWJhSOxeCvkggcJ/OvKCkQO4
         6hI9Wrop0GvkhKL8Batw7JbzkTFGqBbAXfHqbIHilYesjB6pD0/lJLAC+Sjpiw0ld9Mb
         7TSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=4UmHbiaxj5l0n8coErbxRXN4tERTFM5/blMDH4l1jPs=;
        b=hXGkjRTpWxJV6YZVQBrjvd6JbYN+pZa71dB1E8xyRrowLgMeSAyqmfjSudYIN6xXN1
         t4PD74WQatVQQWqR8b7GSmyNqJclRYLDbcj/c6OXyZF+/WCwTnpcigzeHv53ZL4f0nu0
         +O97DDylp6y2ARsmpbv52bOUGYX2luFjROYL9IYzntjk1V0544EE1LszgYlmTDRSqE/x
         O5t+X0VYkf1awQeC/a1O8wN91Q1J3NBLapteUcvxv3vjUPUYnBPSl9WJq2OxNWjGCu9u
         7TWr8Dh//RJwO+u9NI/UcXEIbqDTJ0YfhE0etzH7Nhd1wfd/8ppyapYqKdqDiruVFEme
         Hy9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Fri, 11 May 2018 14:58:57 +0200
From: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20180511125857.GA23225@wunner.de>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-6-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526035408-31328-6-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111757123236?=
X-GMAIL-MSGID: =?utf-8?q?1600172631722680872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 06:43:24AM -0400, Oza Pawandeep wrote:
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

Any reason not to simply call

	pci_walk_bus(udev->subordinate, pci_dev_set_disconnected, NULL);

before the list_for_each_entry_safe_reverse() iteration, instead of
calling it for each device on the subordinate bus and for each
device's children?  Should be semantically identical, saves 3 LoC
and saves wasted cycles of acquiring pci_bus_sem over and over again
for each device on the subordinate bus.

Thanks,

Lukas
