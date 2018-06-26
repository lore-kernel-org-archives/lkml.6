Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11CBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953B526BDC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqpvHWtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953B526BDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965796AbeFZOBU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965453AbeFZOBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:01:17 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0161126BD8;
        Tue, 26 Jun 2018 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530021677;
        bh=MoXQpgF3OXhS7yt7o4ogMKb3ds1jAeeJ+5AonA1371c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqpvHWtmi7hxo9LWPz1tY4/97tI1xMA81JuJoY+fCtnlLMFxAgYByoGOV3GZlPbQL
         IPUXMLIvQT1QOVFmo7+hr6v+0zl3bXdWsnIHLMCCAiCTV9xSM88NtsB8cEo5J73MUj
         jPN+bJ6xBdTMt/Ff9FXjO6/e2+lIVYAUagL2D4cA=
Date:   Tue, 26 Jun 2018 09:01:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on
 suspend-to-RAM
Message-ID: <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35587465.8Nave9aG7d@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
> handling for devices with no callbacks) introduced a system suspend
> regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
> port) to stay in D3 over suspend-to-RAM, which is a side effect of
> setting power.direct_complete for the children of that bridge that
> have no PM callbacks.
> 
> On the majority of systems PCI bridges are not allowed to be
> runtime-suspended (the power/control sysfs attribute is set to "on"
> for them by default), but user space can change that setting and if
> it does so and a given bridge has no children with PM callbacks, the
> direct_complete optimization will be applied to it and it will stay
> in suspend over system suspend.  Apparently, that confuses the

"stay in D3 over system suspend"? (just to be explicit about what "in
suspend" means)

> platform firmware on the affected machine and that may very well
> happen elsewhere, so avoid the direct_complete optimization for
> PCI bridges with no drivers (if there is a driver, it should take
> care of the PM handling) on suspend-to-RAM altogether (that should
> not matter for suspend-to-idle as platform firmware is not involved
> in it).
> 
> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
> Reported-by: n0000b.n000b@gmail.com
> Tested-by: n0000b.n000b@gmail.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci-acpi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -638,6 +638,14 @@ static bool acpi_pci_need_resume(struct
>  	if (acpi_target_system_state() == ACPI_STATE_S0)
>  		return false;
>  
> +	/*
> +	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
> +	 * confuses the platform firmware, so avoid doing that, unless the
> +	 * bridge has a driver that should take care of PM handling.
> +	 */
> +	if (pci_is_bridge(dev) && !dev->driver)
> +		return true;

It sounds like the question of whether leaving a bridge in D3 confuses
the firmware has a platform-specific answer.  How does the driver PM
handling know how to do the right thing?  Does it need to know whether
it's safe to put the device in D3?  Or maybe a device is never put in
D3 for system suspend if it has a driver?

But I'm just kibbitzing; since you merged c62ec4610c40, I'm happy if
you also merge this:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  	return !!adev->power.flags.dsw_present;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
