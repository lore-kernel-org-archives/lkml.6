Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeDWR2a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:28:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60062 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755286AbeDWR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:28:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD9E0600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
To: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rajat Jain <rajatja@google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
 <290e9530-dcde-9c10-7ae0-59ac4c509db4@codeaurora.org>
 <20180420140049.GP28657@bhelgaas-glaptop.roam.corp.google.com>
 <20180420090420.03fb1e6c@w520.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <10d9cf68-29ed-d205-a25f-b8dade53cdd8@codeaurora.org>
Date: Mon, 23 Apr 2018 13:28:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420090420.03fb1e6c@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/2018 11:04 AM, Alex Williamson wrote:
> Is there a concern here about whether the endpoint device driver or the
> PCI core really knows better about link retraining?  This makes me
> remember my unfinished (and need to revisit) Pericom quirk[1] where
> errata in the PCIe switch requires that upstream and downstream links
> are balanced (ie. same link rate) or else enabling ACS results in
> packets not properly flowing through the switch.  If an endpoint driver
> starts deciding to retrain links, overriding quirks in the PCI core,
> then such topology manipulation isn't possible.  Why does the
> driver .probe() function think it can retrain at a higher link rate
> than PCI core?  Thanks,

The example given is for some serdes firmware load to happen in probe and
then performing a retrain to reach to a better speed.

It becomes a chicken and egg problem. 

1. Endpoint HW trains to gen1 by default pre-boot.
2. PCI core enumerates the device.
3. Endpoint driver gets loaded
4. Driver does the firmware programming followed by a link retrain.

I think it is the responsibility of the PCI core to provide reset APIs.
However, expecting endpoint drivers to be knowledgeable about hotplug is
too much.

We can certainly contain AER change into pci directory by moving the slot
reset function to drivers/pci.h file.

But, we need to think about what to do about VFIO and other endpoint
initiated reset cases. My suggestion was to move this into a single API and
remove all other APIs from include/linux/pci.h.

Coming back to this patch...

Do we need a retrain API with the speed that driver wants to reach to?
API can return what was actually accomplished. The quirk from Alex can
run inside this API to make a decision on what speed do we actually want
to reach to for a given PCI topology by reprogramming the target link speed
field.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
