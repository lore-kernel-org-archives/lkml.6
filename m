Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEEC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9787420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547507439;
	bh=9SNnASljukIC5blwvYczalqgRrBtCVRxih5L3rZpUcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUhWAcHQf3pev3xGwqoSwGpo5+TWVoO2t8EkZqQgibue+nfl06qjV+Rl/XR5BT/Ki
	 XfwUXnsadQZOZ86hRPt2tVWmDRKg0PcCcVSnIq6wTMaZUmjRlBixiRE0CMQ9lU0OVd
	 kSvIh7yKbfb0wZcWz/8Gg+bVDOxd/TSo1JeSgSSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfANXKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfANXKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:10:37 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6AB20657;
        Mon, 14 Jan 2019 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547507437;
        bh=9SNnASljukIC5blwvYczalqgRrBtCVRxih5L3rZpUcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WrF0L09AggoyDkmxquCagm33sDZfhl8/JjXIbo5x6ydtks6tb1g6PcGmknK5xSGPA
         68TneWZd+qCAIhi+4TeuzrIVtvIm7CKaNgSGLgxdu5pTYelTm7mEU8OPv2n4HNKTA8
         i7GkpnKms1/ly2hGCSKl17I6AFFk2JAWYwAqzC2M=
Date:   Mon, 14 Jan 2019 17:10:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: pciehp: Assign ctrl->slot_ctrl before
 writing it to hardware
Message-ID: <20190114231025.GD33971@google.com>
References: <20190107130940.83680-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107130940.83680-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:09:40PM +0300, Mika Westerberg wrote:
> Shameerali reported that running v4.20-rc1 as QEMU guest, the PCIe
> hotplug port times out during boot:
> 
>   pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1016 msec ago)
>   pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x03f1 (issued 1024 msec ago)
>   pciehp 0000:00:01.0:pcie004: Failed to check link status
>   pciehp 0000:00:01.0:pcie004: Timeout on hotplug command 0x02f1 (issued 2520 msec ago)
> 
> The issue was bisected down to commit 720d6a671a6e ("PCI: pciehp: Do not
> handle events if interrupts are masked") and was further analyzed by the
> reporter to be caused by the fact that pciehp first updates the hardware
> and only then cache the ctrl->slot_ctrl in pcie_do_write_cmd(). If the
> interrupt happens before we cache the value, pciehp_isr() reads value 0
> and decides that the interrupt was not meant for it causing the above
> timeout to trigger.
> 
> Fix by moving ctrl->slot_ctrl assignment to happen before it is written
> to the hardware.
> 
> Fixes: 720d6a671a6e ("PCI: pciehp: Do not handle events if interrupts are masked")
> Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to pci/hotplug for v5.1, thanks!

> ---
> The original patch was sent 14 Nov 2018 but was never applied so resending.
> 
>   https://patchwork.kernel.org/patch/10682715/
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7dd443aea5a5..cd9eae650aa5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -156,9 +156,9 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  	slot_ctrl |= (cmd & mask);
>  	ctrl->cmd_busy = 1;
>  	smp_mb();
> +	ctrl->slot_ctrl = slot_ctrl;
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>  	ctrl->cmd_started = jiffies;
> -	ctrl->slot_ctrl = slot_ctrl;
>  
>  	/*
>  	 * Controllers with the Intel CF118 and similar errata advertise
> -- 
> 2.19.2
> 
