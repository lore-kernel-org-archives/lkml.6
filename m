Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZqFF7wjcJl/jj07wODDOGD8h2cGr3tdFdM+FiODkqZHecMHhl9905YKoRCOQ/BaUgafsHDO
ARC-Seal: i=1; a=rsa-sha256; t=1525959066; cv=none;
        d=google.com; s=arc-20160816;
        b=uGKsJpUmhnL+aG8a6t9bkQfWZB4xiPrFW6kAsx9EYJKT17JnzPz4L4RvLSB/hegsYm
         R0sBU9ihPtrERSJWp5IOMqTJh8xai46o0qJCldaxuVL5kWe6kKLrQi7pcgml6lQg43FT
         YvDtkdLT7e4A205SUn1nSSaPgusfzy/rQZrJd3tsp0OO5mYLk6LDDiE9KlSlzQQG/UwX
         rT9KC0Biqp8FB+NMxehwo3EDT/pfP4/aYUkQfQ1yqWWGUBCs8IHRJGkWeq8qqCSMxaE/
         C7iwzZxlL1BTaTLoGx+OB+UTKQI4wqJWGp4F0V02b2mJ2XxTTsPHO4+xxtSY345ppEM1
         Mtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=c2ALu7GyMXr87aSf0E+ZjW/XxvJicXkYo724PPYuLBw=;
        b=YKf17MapM1JAMs8xKm1yo4UGRFZ+RfdKGTfhBe7dsuxzgPwEo98V8QVfsY05/HjaRp
         tIqdMcEWFjfTUaGbxvykoRnM6INDfx/fk3A6RK9P32i1k7pEsqoBP/nai3UP/7DqA+XY
         dc2I7WUKZVB/eOCYbkIHhgY4GAMi3BC2265Zfvp9/OeJDb9qE3q7KW/cwbgxh/IF+dT4
         /jXXm54k0iVOKoTQm9+KGfx0rSEoAUyh3Lurmi2Kkn3fWoUlktV/g8BY4bzLcSrY4rSX
         bwgyls5j4xNXSV5+jRvcgPrQBFaBFFnwIubR6GT/CdUVuZKfcecvDgOh1Rx7I6SYg4iD
         wIuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ontw3a+r;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ontw3a+r;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 08:31:04 -0500
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
Subject: Re: [PATCH v15 7/9] PCI/PORTDRV: Implement generic find device
Message-ID: <20180510133104.GG173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-8-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525323838-1735-8-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417978309229425?=
X-GMAIL-MSGID: =?utf-8?q?1600084054094086559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:56AM -0400, Oza Pawandeep wrote:
> This patch implements generic pcie_port_find_device() routine.
> ...

> + * pcie_port_find_device - find the struct device
> + * @dev: PCI Express port the service devices associated with
> + * @service: For the service to find
> + *
> + * Find PCI Express port service driver associated with given service
> + */
> +struct  device *pcie_port_find_device(struct pci_dev *dev,

s/struct  device/struct device/ (remove extra space)

> +				      u32 service)
> +{
> +	struct device *device;
> +	struct portdrv_service_data pdrvs;
> +
> +	pdrvs.dev = NULL;
> +	pdrvs.service = service;
> +	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
> +
> +	device = pdrvs.dev;
> +	return device;
> +}
> +
> +/**
