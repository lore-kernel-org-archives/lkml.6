Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D9C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61241280C4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfCqnF5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61241280C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934241AbeF3A5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 20:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755091AbeF3A5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 20:57:20 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8B8280C4;
        Sat, 30 Jun 2018 00:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530320240;
        bh=ZZg5zPuu2IzYemSYo2JLZccnFHgur4vPESMpdPn8Qg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JfCqnF5imsAwQ1Sf1jYHCfOQAyqGnKkAB4bMuRKglpRoy/gtvsugmFh71wwTfetaN
         k03XUtR2rgrlSpC1yCUDmgsfq47ts6cs6MZhjlJI5A5gOYDXKvmgZvbL7wrYl2WMYV
         DfiWLa3+qF1BFIRO8Yf9HBm7Wkbyusmwm3CZ7i3k=
Date:   Fri, 29 Jun 2018 19:57:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
Message-ID: <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180614122146.62118-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180614122146.62118-1-christian.koenig@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 02:21:45PM +0200, Christian König wrote:
> Resize BARs after resume to the expected size again.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
> CC: stable@vger.kernel.org      # v4.15+

I applied both of these to pci/resource for v4.19, thanks!  It'd be nice to
have them in v4.18, but since it's not a regression and the problem has
been there since v4.15, I'm not sure I could justify it.

> ---
>  drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bd6f156dc3cf..d4685090378b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
>  	}
>  }
>  
> +static void pci_restore_rebar_state(struct pci_dev *pdev)
> +{
> +	unsigned int pos, nbars, i;
> +	u32 ctrl;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
> +		    PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +	for (i = 0; i < nbars; i++, pos += 8) {
> +		struct resource *res;
> +		int bar_idx, size;
> +
> +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> +		res = pdev->resource + bar_idx;
> +		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
> +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
> +		ctrl |= size << 8;
> +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> +	}
> +}
> +
>  /**
>   * pci_restore_state - Restore the saved state of a PCI device
>   * @dev: - PCI device that we're dealing with
> @@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_pri_state(dev);
>  	pci_restore_ats_state(dev);
>  	pci_restore_vc_state(dev);
> +	pci_restore_rebar_state(dev);
>  
>  	pci_cleanup_aer_error_status_regs(dev);
>  
> -- 
> 2.14.1
> 
