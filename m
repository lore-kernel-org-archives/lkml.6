Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F292098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m77uBRp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F292098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeGPVqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbeGPVqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:46:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724A92086E;
        Mon, 16 Jul 2018 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531775828;
        bh=6DBwRiLN2FUonYoUzeBIDnNc4XDFdg+X5pLq2DQM5xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m77uBRp2pDv5NFrm9LZ806z2162srD0QGV9Y/+MJQ2UYOik+JKwj8Q60iFYV3zIrH
         wQTT1As+zHn/ot29iL4VZSUW9S1kvfkuUP4zPikCMAkniglJiiQ6TmoKylEou384gL
         TFhGkhGuIZbZtp41f0ipIs+YajnlmMG220kvru6E=
Date:   Mon, 16 Jul 2018 16:17:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
Message-ID: <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604155523.14906-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc maintainers of drivers that already use pcie_print_link_status()
and GPU folks]

On Mon, Jun 04, 2018 at 10:55:21AM -0500, Alexandru Gagniuc wrote:
> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor straigh
> forward.

s/straigh/straight/
In this context, I think "straightforward" should be closed up
(without the space).

> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.

This is an interesting idea.  I have two concerns:

Some drivers already do this on their own, and we probably don't want
duplicate output for those devices.  In most cases (ixgbe and mlx* are
exceptions), the drivers do this unconditionally so we *could* remove
it from the driver if we add it to the core.  The dmesg order would
change, and the message wouldn't be associated with the driver as it
now is.

Also, I think some of the GPU devices might come up at a lower speed,
then download firmware, then reset the device so it comes up at a
higher speed.  I think this patch will make us complain about about
the low initial speed, which might confuse users.

So I'm not sure whether it's better to do this in the core for all
devices, or if we should just add it to the high-performance drivers
that really care.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> Changes since v2:
>  - Check dev->is_virtfn flag
> 
> Changes since v1:
>  - Use pcie_print_link_status() instead of reimplementing logic
>  
>  drivers/pci/probe.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6fd0bcd..a88ec8c25dd5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2146,6 +2146,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	return dev;
>  }
>  
> +static void pcie_check_upstream_link(struct pci_dev *dev)
> +{
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	/* Look from the device up to avoid downstream ports with no devices. */
> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
> +		return;

Do we care about Upstream Ports here?  I suspect that ultimately we
only care about the bandwidth to Endpoints, and if an Endpoint is
constrained by a slow link farther up the tree,
pcie_print_link_status() is supposed to identify that slow link.

I would find this test easier to read as

  if (!(type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_LEG_END))
    return;

But maybe I'm the only one that finds the conjunction of inequalities
hard to read.  No big deal either way.

> +	/* Multi-function PCIe share the same link/status. */
> +	if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
> +		return;
> +
> +	pcie_print_link_status(dev);
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>  	/* Enhanced Allocation */
> @@ -2181,6 +2200,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	/* Advanced Error Reporting */
>  	pci_aer_init(dev);
>  
> +	/* Check link and detect downtrain errors */
> +	pcie_check_upstream_link(dev);
> +
>  	if (pci_probe_reset_function(dev) == 0)
>  		dev->reset_fn = 1;
>  }
> -- 
> 2.14.4
> 
