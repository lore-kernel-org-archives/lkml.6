Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E32C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219B020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FuK280of";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YZl/1M8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219B020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeFSWVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:21:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeFSWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:21:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 91F1960227; Tue, 19 Jun 2018 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529446906;
        bh=d3UVwSXgheSXP+t2MuvrAwOiX9PwVUusVRcL7MUnz3I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FuK280ofvB4DPxcqAVzYPxDAwxOVCn6ttcujWuqGFRSo2NN3atO4/SeQghrgOa6Ie
         Ya6dJFRyJ4MzEauHzXqmbxzZH7uhAzN9ld6IZ9crJdmE8W6C5QaCB4rkJdlvUj1pPt
         GcxN9X7g/o5WQy7KHKLyQm/2ESYpCFH1pnFwg0Rc=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 671E060227;
        Tue, 19 Jun 2018 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529446905;
        bh=d3UVwSXgheSXP+t2MuvrAwOiX9PwVUusVRcL7MUnz3I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YZl/1M8sU1kzCdjQLaGzKggPtJQiNqkzDvyXvbKLFc3OJ4AcnfWMxStxgTcm5avXX
         ZCsiD6HpGN4A6aazC5zygmR7RzhplGNvy6vod4cFVqstuMmygY57QY+BEHZcZDEei7
         r0VMg372m9iP0r6i+ORfbwyRYd559LEz1MH+COck=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 671E060227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180619214346.GD33049@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2593baec-8a28-a3e7-7ebf-7c21addda0b8@codeaurora.org>
Date:   Tue, 19 Jun 2018 18:21:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619214346.GD33049@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2018 5:43 PM, Bjorn Helgaas wrote:
>> Hotplug driver removes the device from system when a link down interrupt
>> is observed and performs re-enumeration when link up interrupt is observed.
>>
>> This conflicts with what this code is trying to do. Try secondary bus reset
>> only if pci_reset_slot() fails/unsupported.
> Hi Sinan,
> 
> We had a bunch of discussion here but not sure we ever reached a
> consensus.  It did seem like we'd like to avoid putting hotplug
> knowledge in drivers, though.  What do you think the path forward is?
> 

There are multiple issues. 

We discussed the need for a retrain API on this thread. However, retrain API may
not be enough for this particular usage as the device might need a full link training
sequence following firmware load including a hot reset message. I don't think we can
remove the bus reset usage in this code.

I'd like to start with a small one to address your comment here.

"I think my concern is that knowledge about this reset/link down/hotplug issue is
leaking out and we'll end up with different reset interfaces that may
or may not result in hotplug events.  This seems like a confusing API
because it's hard to explain which interface a driver should use."

I'm thinking of removing pci_reset_slot() and pci_try_reset_slot() functions
as an exported API and fold them into pci_reset_bus() and  pci_try_reset_bus()
API respectively.

This is what happens when you insert a fatal error to a hotplug slot. See multiple
link up/down messages.

/_#_[__333.699731]_pcieport_0001:00:00.0:_AER:_Uncorrected_(Fatal)_error_received:_id=0000
[  333.748116] pcieport 0001:00:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id
[  333.816044] pcieport 0001:00:00.0:   device [17cb:0404] error status/mask=00040000/00400000
[  333.871581] pcieport 0001:00:00.0:    [18] Malformed TLP          (First)
[  333.914675] pcieport 0001:00:00.0:   TLP Header: 40000001 000000ff 00000000 00000000
[  333.968397] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down
[  334.043234] iommu: Removing device 0001:01:00.4 from group 0
[  334.095952] iommu: Removing device 0001:01:00.3 from group 0
[  334.144644] iommu: Removing device 0001:01:00.2 from group 0
[  334.194653] iommu: Removing device 0001:01:00.1 from group 0
[  334.243564] pciehp 0001:00:00.0:pcie004: Slot(2): Link Up
[  334.282556] iommu: Removing device 0001:01:00.0 from group 0
[  334.330994] pciehp 0001:00:00.0:pcie004: Slot(2): Link Up event queued; currently getting powered off
[  334.890587] pciehp 0001:00:00.0:pcie004: Timeout on hotplug command 0x13f1 (issued 282900 msec ago)
[  335.070190] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down
[  335.106960] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down event queued; currently getting powered on
[  335.191119] pcieport 0001:00:00.0: AER: Device recovery failed
[  346.590153] pciehp 0001:00:00.0:pcie004: Timeout on hotplug command 0x17f1 (issued 10250 msec ago)

As a suggestion:

1. If the device belongs to a slot, do slot reset. 
2. Otherwise, do bus reset.

Since Oza's DPC/AER patch to refactor fatal error handling, both hotplug driver
and AER/DPC driver will try removing devices and perform enumeration on link events/AER events.

Perfect environment for race condition without a change.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
