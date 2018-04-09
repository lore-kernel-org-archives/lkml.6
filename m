Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx49SIL36rEB+2qSiEs8851yOGkHC+NlM/zQY3Q5UK3Kg4uthbTTJoiSw2Gq8YAFv1XWlhY6q
ARC-Seal: i=1; a=rsa-sha256; t=1523316158; cv=none;
        d=google.com; s=arc-20160816;
        b=bgEaJhDmVfsh3G8m0QYut8fKHw6+EP+d7HkE1edcjE9h2k+JCZOLoNGI8l0l/Cfq5g
         YZY7fmnrJJNvXR2pzOjHT+S6Bqgc6Y0X7+j0T39rbxkvwwvmeRYJy6wGixkZXZ3afqVv
         AbBaznWVYczJo1XiM0M3yVo2yff25vN5fKu/vAAiE7CjTj/8JlKBgMBgQSQbpBJfGYyF
         xHa1RzrdDsEXM2zDb1H9yVqSZ9/6UcQcbB6o8gB4QYS5zcORbS+5xdHN5kq24NkmkPyE
         THyMQj3iLQYMWN8+XvMR3X/fTyIBHEZd5f9bIYWdg9kC16KaKJrJOMrn+H1G+glTifyI
         PiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Eo+mlPlXjY7llQmGuN3kaKYMctoEi/BeYviAMmr1IbM=;
        b=FJygc2Ta48oS5srlGgsKUOjOwcHTszMYdUt/uJ+hW8PlSWxptXmenxp74fGcI8Hoex
         Wnp87yCp7vpcXS/6xReCTZb/HOyfaxrffolj66dGt3IbC88eW4k0b8jkUIvWzyrl34Id
         7y+9szhw9/mEwHqspvAdV17UM1CgSdZYpLQemW5CnOcRAU9Ga1/3aQePmJZqdMS0dKMQ
         Hkw6XTg22OPn7tg7cdI0EOsp6fCXuGGvNvv4UOb9SSlVU1ghGoOSYBx4pmCFGht0tVxf
         y6MqL7gbkW2vtYlxJJlcw7aFUFb0CM4NPKhENesSJ5balsV+R+0TW85wjjUjFKAQv6e3
         A44w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="190133576"
Date: Mon, 9 Apr 2018 17:25:28 -0600
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
Subject: Re: [PATCH v13 5/6] PCI: Unify wait for link active into generic PCI
Message-ID: <20180409232528.GE6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-6-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284914-2037-6-git-send-email-poza@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280028398870927?=
X-GMAIL-MSGID: =?utf-8?q?1597312763905134062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:53AM -0400, Oza Pawandeep wrote:
> +/**
> + * pcie_wait_for_link - Wait for link till it's active/inactive
> + * @pdev: Bridge device
> + * @active: waiting for active or inactive ?
> + *
> + * Use this to wait till link becomes active or inactive.
> + */
> +bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
> +{
> +	int timeout = 1000;
> +	bool ret;
> +	u16 lnk_status;
> +
> +	for (;;) {
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +		if (ret == active)
> +			return true;
> +		if (timeout <= 0)
> +			break;
> +		timeout -= 10;
> +	}

This is missing an msleep(10) at each iteration.

> +
> +	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
> +		 active ? "set" : "cleared");
> +
> +	return false;
> +}
