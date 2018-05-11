Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AB8JxZprcQBa/yyBChAdeIJ/I4aHmml1UW8DYp3g7Spqz+t4yMbLI8MkqZKfBDh3zW6fiZSHtH0o
ARC-Seal: i=1; a=rsa-sha256; t=1526054063; cv=none;
        d=google.com; s=arc-20160816;
        b=G96+bv+TwZBeBlu5p3t06PatXEzLCtxxOcREj5K79iGaeybLbkO8x6cHhue2Tv1L36
         /d7LFYLa1PVpubGtwVH737bo8seEBQtixxjSLw4GK0J8+Wm5xRno5a70OiUY0yA0iRmx
         GeOYa34rdzWgPFPOjP7Tzm0YOOUn6o5b/xUSzXx8Z6xsGcoJIOu25H0gKNbew7ZnpP7/
         qP8jPsGW99falPtKrwc4CjGYh7o8dV7yh5VNVcvTpBRWPIhJIFsDDHfWbsx0DzzAbD10
         AQvkpAlXNpz1QkQINnOSKilHgXfmVbY+lKpS9KuU7462Tg/3u0t/HH3EZpn5E8WWA29N
         gd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nrTlRtV0Vwy55WEW1X/TbYVaZYiQmHDOQ+M2tdCSOiA=;
        b=FeoMELvvmjUZcjLl4P0pr2fSSI9FVhRqJL37JVUtgo5HHu/pB7LSMoQD8s7whbqNAa
         j5fpW/EqqCpGaBcIuVzBmGp3Imi3cf1VnbvChXlxs4faQHK18+f52gqit1q6GHTakySC
         r4r3b93hxGCnV9R44GVzO7SIEII/AL1APP8tb3H+t5DAvB3CMNnYlYDErE1O5Dy1Lfqd
         Dy4YFbB8SWIdqP23EqR+tYlR2k9WK/6OS6S82GPSzOJO2oxs06DvN/v+hxB4WEsQrh0v
         3zzrZKR0aLFQL842n3iSjjP0zf/bbhZbJ5EyfTbyYDSivTB22L894YULI0kpHDptZVy9
         svBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Fri, 11 May 2018 17:54:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: poza@codeaurora.org
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
Message-ID: <20180511155422.GA333@wunner.de>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-6-git-send-email-poza@codeaurora.org>
 <20180511125857.GA23225@wunner.de>
 <7317531a7a85404d590008a27131955f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7317531a7a85404d590008a27131955f@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111757123236?=
X-GMAIL-MSGID: =?utf-8?q?1600183665768391594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 09:04:36PM +0530, poza@codeaurora.org wrote:
> On 2018-05-11 18:28, Lukas Wunner wrote:
> >On Fri, May 11, 2018 at 06:43:24AM -0400, Oza Pawandeep wrote:
> >>+void pcie_do_fatal_recovery(struct pci_dev *dev)
> >>+{
> >>+	struct pci_dev *udev;
> >>+	struct pci_bus *parent;
> >>+	struct pci_dev *pdev, *temp;
> >>+	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
> >>+	struct aer_broadcast_data result_data;
> >>+
> >>+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> >>+		udev = dev;
> >>+	else
> >>+		udev = dev->bus->self;
> >>+
> >>+	parent = udev->subordinate;
> >>+	pci_lock_rescan_remove();
> >>+	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> >>+				 bus_list) {
> >>+		pci_dev_get(pdev);
> >>+		pci_dev_set_disconnected(pdev, NULL);
> >>+		if (pci_has_subordinate(pdev))
> >>+			pci_walk_bus(pdev->subordinate,
> >>+				     pci_dev_set_disconnected, NULL);
> >>+		pci_stop_and_remove_bus_device(pdev);
> >>+		pci_dev_put(pdev);
> >>+	}
> >
> >Any reason not to simply call
> >
> >	pci_walk_bus(udev->subordinate, pci_dev_set_disconnected, NULL);
> >
> >before the list_for_each_entry_safe_reverse() iteration, instead of
> >calling it for each device on the subordinate bus and for each
> >device's children?  Should be semantically identical, saves 3 LoC
> >and saves wasted cycles of acquiring pci_bus_sem over and over again
> >for each device on the subordinate bus.
> 
> Well this is borrowed code from DPC driver, hence I thought to keep the
> same.
> but to me it looks like its taking care of PCIe switch where is goes through
> all the subordinates, and which could turn out to be more swicthes down the
> line, and son on...
> it goes all the way down to the tree

... which is precisely what the one line I suggested above does.

You don't need to respin for this alone as far as I'm concerned,
but please post a follow-up refactoring patch.  I have a patch
in the pipeline which makes the same change in pciehp, hence this
caught my eye.

Thanks,

Lukas
