Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E61C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FD82147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKKtnr2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeHPXWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:22:24 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99488213A2;
        Thu, 16 Aug 2018 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534450912;
        bh=VTbjId63JiCpm8KcFwHQ3Bu8PILedgHcfYHqMtcgSNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKKtnr2VIE5U82wLcPfrUdoQjGw18+FOWUZ2lml11qj0mXQayRkGHIFsWAHHFVJr/
         ORehNTLTiyhJL7/zXvg+06TmXJdzpf1liS3zFSB5chtpGcYXGLd47NmmBpe8Q52taJ
         EEKKWIlWrLFyZThpBLn8sUVMMtJV8qHikZFPx9pg=
Date:   Thu, 16 Aug 2018 15:21:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        teika kazura <teika@gmx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
Message-ID: <20180816202151.GA10316@bhelgaas-glaptop.roam.corp.google.com>
References: <6401388.2t0qD3iTOr@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6401388.2t0qD3iTOr@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:56:46PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 26112ddc254c (PCI / ACPI / PM: Resume bridges w/o drivers on
> suspend-to-RAM) attempted to fix a functional regression resulting
> from commit c62ec4610c40 (PM / core: Fix direct_complete handling
> for devices with no callbacks) by resuming PCI bridges without
> drivers (that is, "parallel PCI" ones) during system-wide suspend if
> the target system state is not ACPI S0 (working state).
> 
> That turns out insufficient, however, as it is reported that, at
> least in one case, the platform firmware gets confused if a PCIe
> root port is suspended before entering the ACPI S3 sleep state.
> 
> For this reason, drop the driver check from acpi_pci_need_resume()
> and resume all bridges (including PCIe ports with drivers) during
> system-wide suspend if the target system state is not ACPI S0.
> 
> [If the target system state is ACPI S0, it means suspend-to-idle
>  and the platform firmware is not going to be invoked to actually
>  suspend the system, so there is no need to resume the bridges in
>  that case.]
> 
> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
> Reported-by: teika kazura <teika@gmx.com>
> Tested-by: teika kazura <teika@gmx.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200675
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+: 26112ddc254c (PCI / ACPI / PM: Resume bridges ...)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for doing this.  I don't like dependencies on the PCIe
PM/AER/hotplug/etc features being implemented as a "driver" because
they could be implemented in the PCI core directly.

> ---
>  drivers/pci/pci-acpi.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -632,13 +632,11 @@ static bool acpi_pci_need_resume(struct
>  	/*
>  	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend over
>  	 * system-wide suspend/resume confuses the platform firmware, so avoid
> -	 * doing that, unless the bridge has a driver that should take care of
> -	 * the PM handling.  According to Section 16.1.6 of ACPI 6.2, endpoint
> +	 * doing that.  According to Section 16.1.6 of ACPI 6.2, endpoint
>  	 * devices are expected to be in D3 before invoking the S3 entry path
>  	 * from the firmware, so they should not be affected by this issue.
>  	 */
> -	if (pci_is_bridge(dev) && !dev->driver &&
> -	    acpi_target_system_state() != ACPI_STATE_S0)
> +	if (pci_is_bridge(dev) && acpi_target_system_state() != ACPI_STATE_S0)
>  		return true;
>  
>  	if (!adev || !acpi_device_power_manageable(adev))
> 
