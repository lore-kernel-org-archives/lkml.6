Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F774C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0075E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeLCMyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:54:50 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:42410 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeLCMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:54:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,310,1539648000"; 
   d="scan'208";a="82686855"
Date:   Mon, 3 Dec 2018 13:53:46 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dwayne Litzenberger <dlitz@dlitz.net>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 2/2] xen-pciback: Allow enabling/disabling
 expansion ROM
Message-ID: <20181203125346.qjxhuepu3nhnc7wp@mac>
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
 <a05e3cf451d692dc4b1c81c8b5d66fc75d1fa325.1543772656.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a05e3cf451d692dc4b1c81c8b5d66fc75d1fa325.1543772656.git-series.marmarek@invisiblethingslab.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 06:47:33PM +0100, Marek Marczykowski-Górecki wrote:
> From: Dwayne Litzenberger <dlitz@dlitz.net>
> 
> Newer AMD GPUs store their initialization routines as bytecode on the
> ROM.  This fixes the following initialization error inside the VM when
> doing PCI passthrough:
> 
>     radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
>     radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
>     [drm:radeon_get_bios [radeon]] *ERROR* Unable to locate a BIOS ROM
>     radeon 0000:00:05.0: Fatal error during GPU init
> 
> Signed-off-by: Dwayne Litzenberger <dlitz@dlitz.net>
> ---
>  drivers/xen/xen-pciback/conf_space_header.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
> index 697d0a8..bc145d3 100644
> --- a/drivers/xen/xen-pciback/conf_space_header.c
> +++ b/drivers/xen/xen-pciback/conf_space_header.c
> @@ -150,21 +150,21 @@ static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
>  	if ((value | ~PCI_ROM_ADDRESS_MASK) == ~0U)
>  		bar->which = 1;
>  	else {
> -		u32 tmpval;
> -		err = pci_read_config_dword(dev, offset, &tmpval);
> +		u32 newval = bar->val;

Naming this newval is quite confusing IMO, since at this point it's
actually the old value.

> +
> +		/* Allow enabling/disabling rom, if present */
> +		if (newval & PCI_ROM_ADDRESS_MASK) {
> +			newval &= ~PCI_ROM_ADDRESS_ENABLE;
> +			newval |= value & PCI_ROM_ADDRESS_ENABLE;
> +		}
> +		err = pci_write_config_dword(dev, offset, newval);
>  		if (err)
>  			goto out;
> -		if (tmpval != bar->val && value == bar->val) {
> -			/* Allow restoration of bar value. */
> -			err = pci_write_config_dword(dev, offset, bar->val);
> -			if (err)
> -				goto out;
> -		}
> +		bar->val = newval;

I'm not sure there's much value in storing this, the only difference
is the setting of the enable bit, which is ignored anyway.

Thanks, Roger.
