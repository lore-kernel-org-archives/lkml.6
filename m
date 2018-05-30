Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755150AbeE3Elk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:41:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeE3Elg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:41:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0554A6028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] PCI: Add pci=safemode option
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
Date: Tue, 29 May 2018 21:41:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530043103.GA19734@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/2018 9:31 PM, Greg Kroah-Hartman wrote:
> On Tue, May 29, 2018 at 11:19:41PM -0400, Sinan Kaya wrote:
>> Adding pci=safemode kernel command line parameter to turn off all PCI
>> Express service driver as well as all optional PCIe features such as LTR,
>> Extended tags, Relaxed Ordering etc.
>>
>> Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
>> reconfigured with by the kernel in case BIOS hands off a broken
>> configuration.
> 
> Why not fix the BIOS?  That's what sane platforms do :)
> 
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>>  drivers/pci/pci.c                               | 7 +++++++
>>  drivers/pci/pci.h                               | 2 ++
>>  drivers/pci/pcie/portdrv_core.c                 | 2 +-
>>  drivers/pci/probe.c                             | 6 ++++++
>>  5 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 641ec9c..247adbb 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3153,6 +3153,8 @@
>>  		noari		do not use PCIe ARI.
>>  		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
>>  				do not use PCIe ATS (and IOMMU device IOTLB).
>> +		safemode	turns of all optinal PCI features. Useful
>> +				for bringup/troubleshooting.
> 
> s/optinal/optional/ ?

sure.

> 
> And you should explain what exactly in PCI is "optional".  Who defines
> this and where is that list and what can go wrong if those options are
> not enabled?

Bjorn and I discussed the need for such a "safe" mode feature when you
want to bring up PCI for a platform. You want to turn off everything as
a starter and just stick to bare minimum.

I can add a few words describing them. The goal of this option is to keep
base PCI features with MSI only. Things like PME, AER, ASPM, Extended
Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. safemode
is certainly not intended for production environments. 

I can taint the kernel as a suggestion.

I defined minimum as just booting a device and to be able to do DMA traffic
only with 0 optimization

> 
> In looking at your patch, I can't determine that at all, so there's no
> way that someone just looking at this sentence will be able to
> understand.
> 
> thanks,
> 
> greg k-h
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
