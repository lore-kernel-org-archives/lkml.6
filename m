Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrp5Nr1ghBwZuXYWOSItlwt9497fo/XbS+ykCAcVvSXO0247ofm+rRyqE+vEP9j9uuEP6g4
ARC-Seal: i=1; a=rsa-sha256; t=1526052878; cv=none;
        d=google.com; s=arc-20160816;
        b=gikLZJ45k2GbgZyGQNP81PbrTEQ1TUAOnykpiWQfM1MXtH4bnyr6XqrvPh6hHwi824
         oHP/4oiEcgG9t0YuSXLNxYuZQUZi3JFqhwZF4d4JdZ8V0tX3WYovaeDfRa+AX5eFFXBL
         qQqzOIUznCBjAhGhIDsUmxBIB7D0z6bzy2B8HaY5TkxA4Zr6URZtSIyAoB6KCjlLBIBX
         J77QJU3xUzx56PT8jsNGf9XiAhZOJJxOxCvhgFj5sSxn/mNXZj2D06hx6/djeSnH02l1
         1TzUkXv2WQSY75iWZZc9CSF5lyYeAyf/3PED/dr9nvQnUU3RTyq97asglvJpRYEMfkGX
         sB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=LGz7BYwWbw6p5r0CSYDzo52kVfVLViMmlaI1luq1U6A=;
        b=GiqutuhoZAYWbxHTPB0vEmn1F4XA4LadxUOfl3C6ckzoNXzqTvtNEy/rw/soo6lnoA
         fKo6iwH9WekF3CT0Z7kfxZwutKigSTkUFeAdVmiaIEcdjQPNa2SQGcFM1GedmoNjeDoF
         O0NrolsGzHD9cd2Dj5C0CgCKtRigkRpzLgLLgy4V8B/FYatSfgPv31d5RMPBufgUdICU
         erL3l3HzNHmKfBmyEmez/DyJUkxWbxXwIV/kLMCxKrAZ0D7Mc9sqtMgpIOoiDHnSnOfi
         J6TJbOPg+Ly7ITnIMPgStqOwrDQ07+wGCj3JLXoyLiRZszo/A0fi83FnCwG1U8bQLADJ
         kU0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=iCg2cfnX;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RWU+VTGf;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=iCg2cfnX;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RWU+VTGf;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 11 May 2018 21:04:36 +0530
From: poza@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v16 5/9] PCI/AER: Factor out error reporting from AER
In-Reply-To: <20180511125857.GA23225@wunner.de>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-6-git-send-email-poza@codeaurora.org>
 <20180511125857.GA23225@wunner.de>
Message-ID: <7317531a7a85404d590008a27131955f@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111757123236?=
X-GMAIL-MSGID: =?utf-8?q?1600182422624276417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-11 18:28, Lukas Wunner wrote:
> On Fri, May 11, 2018 at 06:43:24AM -0400, Oza Pawandeep wrote:
>> +void pcie_do_fatal_recovery(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *udev;
>> +	struct pci_bus *parent;
>> +	struct pci_dev *pdev, *temp;
>> +	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
>> +	struct aer_broadcast_data result_data;
>> +
>> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>> +		udev = dev;
>> +	else
>> +		udev = dev->bus->self;
>> +
>> +	parent = udev->subordinate;
>> +	pci_lock_rescan_remove();
>> +	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>> +				 bus_list) {
>> +		pci_dev_get(pdev);
>> +		pci_dev_set_disconnected(pdev, NULL);
>> +		if (pci_has_subordinate(pdev))
>> +			pci_walk_bus(pdev->subordinate,
>> +				     pci_dev_set_disconnected, NULL);
>> +		pci_stop_and_remove_bus_device(pdev);
>> +		pci_dev_put(pdev);
>> +	}
> 
> Any reason not to simply call
> 
> 	pci_walk_bus(udev->subordinate, pci_dev_set_disconnected, NULL);
> 
> before the list_for_each_entry_safe_reverse() iteration, instead of
> calling it for each device on the subordinate bus and for each
> device's children?  Should be semantically identical, saves 3 LoC
> and saves wasted cycles of acquiring pci_bus_sem over and over again
> for each device on the subordinate bus.
> 
> Thanks,
> 
> Lukas

Well this is borrowed code from DPC driver, hence I thought to keep the 
same.
but to me it looks like its taking care of PCIe switch where is goes 
through all the subordinates, and which could turn out to be more 
swicthes down the line, and son on...
it goes all the way down to the tree
Am I missing something here ?
