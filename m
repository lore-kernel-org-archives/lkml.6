Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx48LVIFuhR0Rb4OntOQ3lZ4rTVyLb5V/zVzgMcDsjIV+CZ3jGsQaBnnGcGynK7t4dEB2acWu
ARC-Seal: i=1; a=rsa-sha256; t=1523316426; cv=none;
        d=google.com; s=arc-20160816;
        b=T2HHVN13cCMC39m9QHkVdAkWFGdNKkcYgrKtIKRKK2S4b9zeWZ6GSYR9VWcqj9W2Kd
         faljyOwjoPoLYzN2V7owsfwztx11o1djkYzT7cIiCZRYlsXM9Ra9K2QdhtTjS30L6STm
         Mm9w8PvhR9SEP+qJeh0tnIinBeif/EWCzc5NTVJa6alR1ECXp9l30rgk/DMEbqiFaiRq
         4PB/Rp4QH+Hb+uG8UVlblIsEsdxsPGUA52+hYuOghgl5XdJ/ynAXk4Xnpct0gzF/ZVuK
         CNiBEwvvf2H+94b+ADS0aYbbjgTkcVweWPuK6Lz9FpAjSQaVRnqqrzEFXMaZyeuason4
         VffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hur4UmyYo+zFJSX68+5bSxv6OL3M6K6CmFGcsLvToCw=;
        b=zI4+LEHZj4KmTlUvhlJecRY/VS07H12HMW15WUxFQLF7fuXpwXpov/LF2a5OlxnEzd
         WMmnweVbnNL8vqvtD5Bh2BKBjHxER5JLQu+cgKrNC/91lcmhCH3PK9sQrm7eTXJfiOWw
         1weElEDBeCfgNf5Z1dsrnAeVhVKHtMoT47hxB2IDpW8jdxmtiJJw9R6ewvHFaYu++IiW
         /6hVcUPoDpsD5jsRS3cGVNboocAKiCngBX4+hNPwK+VcKlIXot7m1I5X4QPZT/hOfjdr
         voR9iopwAnaoxo2bN/HXlIcA85fjtM1nLzjYp+zTdG0TPfyYkwym9ISzNNFrBfuwib0K
         jNSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="45549195"
Date: Mon, 9 Apr 2018 17:29:57 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 4/6] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180409232957.GF6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-5-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-5-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027376446464?=
X-GMAIL-MSGID: =?utf-8?q?1597313045966759411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:52AM -0400, Oza Pawandeep wrote:
> +static int find_dpc_dev_iter(struct device *device, void *data)
> +{
> +	struct pcie_port_service_driver *service_driver;
> +	struct device **dev;
> +
> +	dev = (struct device **) data;
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

The only caller of this doesn't seem to care to use struct device. This
should probably just extract struct dpc_dev directly from in here.
