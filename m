Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2B026F90
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkSl0Xod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2B026F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967876AbeF1S15 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966340AbeF1S14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:27:56 -0400
Received: from localhost (unknown [146.7.4.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35D625272;
        Thu, 28 Jun 2018 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530210476;
        bh=7TqJQmI+4f2mDDdpqOv3VmukRmgPSkpiKbm7emSNBy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkSl0XodEOOt23IMP251kNN3wfmm5Ik7ef/fWtbbVyIHL2YRnx6K5UboxbPGKrh/x
         j51rD/npX4SotvASCd7TegEGGRVg6xaVJYRGQKmYyT7zUZmevTkhyFdfl0Znw+u43Z
         8jLKAcW445fOSUvh67QjRgwDCtka2Y6orN2iYhx0=
Date:   Thu, 28 Jun 2018 13:27:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
Message-ID: <20180628182755.GC120578@bhelgaas-glaptop.roam.corp.google.com>
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

I added 

  Fixes: d6895ad39f3b ("drm/amdgpu: resize VRAM BAR for CPU access v6")
  Fixes: 276b738deb5b ("PCI: Add resizable BAR infrastructure")

Per the bugzilla, the bug was bisected to d6895ad39f3b, which appeared
in v4.16.  But 276b738deb5b appeared in v4.15, so I'm OK with the
v4.15+ stable tag.

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
