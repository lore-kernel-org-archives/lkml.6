Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969233AbeEXLnU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:43:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969169AbeEXLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:43:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE70E601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <82656e20-e821-1944-3399-1667ceb27719@codeaurora.org>
Date: Thu, 24 May 2018 07:43:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/2018 6:57 PM, Sinan Kaya wrote:
>> The crash seems to indicate that the hpsa device attempted a DMA after
>> we cleared the Root Port's PCI_COMMAND_MASTER, which means
>> hpsa_shutdown() didn't stop DMA from the device (it looks like *most*
>> shutdown methods don't disable device DMA, so it's in good company).
> All drivers are expected to shutdown DMA and interrupts in their shutdown()
> routines. They can skip removing threads, data structures etc. but DMA and
> interrupt disabling are required. This is the difference between shutdown()
> and remove() callbacks.

I found this note yesterday to see why we are not disabling the devices in the
PCI core itself. 

pci_device_remove()

	/*
	 * We would love to complain here if pci_dev->is_enabled is set, that
	 * the driver should have called pci_disable_device(), but the
	 * unfortunate fact is there are too many odd BIOS and bridge setups
	 * that don't like drivers doing that all of the time.
	 * Oh well, we can dream of sane hardware when we sleep, no matter how
	 * horrible the crap we have to deal with is when we are awake...
	 */ 

Ryan, can you discard the previous patch and test this one instead? remove() path
in hpsa driver seems to call pci_disable_device() via 

hpsa_remove_one()
	hpsa_free_pci_init()

but nothing on the shutdown path.

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 4ed3d26..3823f04 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -8651,6 +8651,7 @@ static void hpsa_shutdown(struct pci_dev *pdev)
        h->access.set_intr_mask(h, HPSA_INTR_OFF);
        hpsa_free_irqs(h);                      /* init_one 4 */
        hpsa_disable_interrupt_mode(h);         /* pci_init 2 */
+       pci_disable_device(h->pdev);
 }



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
