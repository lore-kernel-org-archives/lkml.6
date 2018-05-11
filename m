Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AB8JxZr6oms9xeGLK5JaQxrIYEuK508U4LXhz44Qx28G5pxbghsjysRYgVjN1zgQv3VTNwqLcLfg
ARC-Seal: i=1; a=rsa-sha256; t=1526055084; cv=none;
        d=google.com; s=arc-20160816;
        b=fGUo2r/Bpu60rxCKv/IfLS1dqNnnGD22QTUllcdgHvwVVXniGyWEuL6fU5zJY7PYxo
         XEt3qNf964QhdSHwalzsqEnPB8aB9B5agd8mJqSMfutvDQWxfJWP09WrJvz82DP0WC8Z
         PXZpR/cFtrgfc1gijheBX1dvLPVmxn8dRga4S5uGSXqKzVchsq6aR2rKf2/SzWovoM3H
         8n2qvHUdf41QG9qMIv5uf/7B9FQAdQxNYO75xjb8Rdbh2Csb3fTEwugZoroQhuWYGN/u
         ZM5p8VACAfHl1h6A7IBusxu1mPC3JzXgAE19vjLcHiIq5Xg4dZlkkECMtoyEBBnbXFCU
         y7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=lhpXCwwaxshKPWafHJpZUTUZ1Ob+HxadHkwD+/Wq3Y0=;
        b=I6cJMvAdb+kCVm2mLViId1vJGSeeF3HWxP8wBEy6i2wAL/Jpe4NCAgOYCRiRjaHS2C
         BWREvp24ay/dFDlIyGWC94mczEYqYUmEGyC2mQF8Y+8g7szPNILuvFbaEvgdKSjhNlNq
         NbS6rm7u8gaQJNrAfrUECw9oncpDPAupixHRPNR5MGO9lXxKb3SUuerOBk5X9FANFbmG
         066+T9ObRO9oPRJCswXZqVrSTKUEdHP5ur3utdq7ufAV9AskEJV5CjRqzU3RtVQMptKd
         pLQaNovG6HAbief++mN6ihuF7pOLozRkjs7DgcOCZ4usD2+2YGjqE3+p3xE7fCD+IbBo
         nZtw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jKGngqfR;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dTl6fp2i;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jKGngqfR;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dTl6fp2i;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 11 May 2018 21:41:22 +0530
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
In-Reply-To: <20180511155422.GA333@wunner.de>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-6-git-send-email-poza@codeaurora.org>
 <20180511125857.GA23225@wunner.de>
 <7317531a7a85404d590008a27131955f@codeaurora.org>
 <20180511155422.GA333@wunner.de>
Message-ID: <78a5edb7e5f785a14dd4241f53b69933@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111757123236?=
X-GMAIL-MSGID: =?utf-8?q?1600184736130400697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-11 21:24, Lukas Wunner wrote:
> On Fri, May 11, 2018 at 09:04:36PM +0530, poza@codeaurora.org wrote:
>> On 2018-05-11 18:28, Lukas Wunner wrote:
>> >On Fri, May 11, 2018 at 06:43:24AM -0400, Oza Pawandeep wrote:
>> >>+void pcie_do_fatal_recovery(struct pci_dev *dev)
>> >>+{
>> >>+	struct pci_dev *udev;
>> >>+	struct pci_bus *parent;
>> >>+	struct pci_dev *pdev, *temp;
>> >>+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
>> >>+	struct aer_broadcast_data result_data;
>> >>+
>> >>+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
>> >>+		udev = dev;
>> >>+	else
>> >>+		udev = dev->bus->self;
>> >>+
>> >>+	parent = udev->subordinate;
>> >>+	pci_lock_rescan_remove();
>> >>+	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>> >>+				 bus_list) {
>> >>+		pci_dev_get(pdev);
>> >>+		pci_dev_set_disconnected(pdev, NULL);
>> >>+		if (pci_has_subordinate(pdev))
>> >>+			pci_walk_bus(pdev->subordinate,
>> >>+				     pci_dev_set_disconnected, NULL);
>> >>+		pci_stop_and_remove_bus_device(pdev);
>> >>+		pci_dev_put(pdev);
>> >>+	}
>> >
>> >Any reason not to simply call
>> >
>> >	pci_walk_bus(udev->subordinate, pci_dev_set_disconnected, NULL);
>> >
>> >before the list_for_each_entry_safe_reverse() iteration, instead of
>> >calling it for each device on the subordinate bus and for each
>> >device's children?  Should be semantically identical, saves 3 LoC
>> >and saves wasted cycles of acquiring pci_bus_sem over and over again
>> >for each device on the subordinate bus.
>> 
>> Well this is borrowed code from DPC driver, hence I thought to keep 
>> the
>> same.
>> but to me it looks like its taking care of PCIe switch where is goes 
>> through
>> all the subordinates, and which could turn out to be more swicthes 
>> down the
>> line, and son on...
>> it goes all the way down to the tree
> 
> ... which is precisely what the one line I suggested above does.
> 
> You don't need to respin for this alone as far as I'm concerned,
> but please post a follow-up refactoring patch.  I have a patch
> in the pipeline which makes the same change in pciehp, hence this
> caught my eye.
> 
> Thanks,
> 
> Lukas

Thanks Lukas, I will keep this in my pipeline as an optimization.
appreciate your input.

Regards,
Oza.
