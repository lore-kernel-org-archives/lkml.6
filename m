Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A94EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160A425D8D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMM75r+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160A425D8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeGBNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbeGBNt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:49:59 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C9625D8D;
        Mon,  2 Jul 2018 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530539398;
        bh=F05uWfQIsRNnbY+4wpaFAydpqoxZMhOCKqTa6VWH0Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMM75r+o/yCJTQIsFaAKDbJD1BZ0JOgn1IeKf/2g8dXlIq4AxpOP60GbF1nd2pPrS
         3iXWKFLYhzjW7azRwIjCWftiau1hKAq8emEe5rlNN3ZP8uiKEaF/eEL7oZVmfVkcJz
         HeVTy4o0NrQ/jqtsAjgXIklIw618pAs6isLQITls=
Date:   Mon, 2 Jul 2018 08:49:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     christian.koenig@amd.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: fix restoring resized BAR state on resume
Message-ID: <20180702134957.GA43045@bhelgaas-glaptop.roam.corp.google.com>
References: <20180614122146.62118-1-christian.koenig@amd.com>
 <20180630005718.GJ40928@bhelgaas-glaptop.roam.corp.google.com>
 <064ebaf7-8953-fd29-a688-26a5646111a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <064ebaf7-8953-fd29-a688-26a5646111a0@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 03:20:59PM +0200, Christian König wrote:
> Am 30.06.2018 um 02:57 schrieb Bjorn Helgaas:
> > On Thu, Jun 14, 2018 at 02:21:45PM +0200, Christian König wrote:
> > > Resize BARs after resume to the expected size again.
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199959
> > > CC: stable@vger.kernel.org      # v4.15+
> > I applied both of these to pci/resource for v4.19, thanks!  It'd be nice to
> > have them in v4.18, but since it's not a regression and the problem has
> > been there since v4.15, I'm not sure I could justify it.
> 
> Well it is a regression. The change to enable this in the upstream driver
> was added in 4.16, but a good bunch of people also compile our backported
> DKMS module.
> 
> And now those people are complaining that the driver stopped working after
> resume in 4.15 with the DKMS module and with 4.16 with the upstream module.
> 
> Alternatively I can disable resizing from the driver from kernels older than
> v4.19.

Feel free to help justify including this in v4.18 by providing the
details of the regression and the relevant commits.  If this is
something that worked in v4.17, and some commit we merged for
v4.18-rc1 broke it, it would be a slam dunk to include the fix for
v4.18.  I took a quick look through the commits we added in v4.18-rc1
but didn't see anything obvious.

Obviously, putting a fix in v4.18 doesn't help the people running
v4.15 or v4.16.  The stable backports *will* help with that, and we
already have the tag for that.

The current trajectory we're on is that these are headed for
v4.19-rc1, and soon after they appear there, they will be backported
to the v4.15-v4.18 stable kernels.

Bjorn

> > > ---
> > >   drivers/pci/pci.c | 28 ++++++++++++++++++++++++++++
> > >   1 file changed, 28 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index bd6f156dc3cf..d4685090378b 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1159,6 +1159,33 @@ static void pci_restore_config_space(struct pci_dev *pdev)
> > >   	}
> > >   }
> > > +static void pci_restore_rebar_state(struct pci_dev *pdev)
> > > +{
> > > +	unsigned int pos, nbars, i;
> > > +	u32 ctrl;
> > > +
> > > +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> > > +	if (!pos)
> > > +		return;
> > > +
> > > +	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> > > +	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
> > > +		    PCI_REBAR_CTRL_NBAR_SHIFT;
> > > +
> > > +	for (i = 0; i < nbars; i++, pos += 8) {
> > > +		struct resource *res;
> > > +		int bar_idx, size;
> > > +
> > > +		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
> > > +		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
> > > +		res = pdev->resource + bar_idx;
> > > +		size = order_base_2((resource_size(res) >> 20) | 1) - 1;
> > > +		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
> > > +		ctrl |= size << 8;
> > > +		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> > > +	}
> > > +}
> > > +
> > >   /**
> > >    * pci_restore_state - Restore the saved state of a PCI device
> > >    * @dev: - PCI device that we're dealing with
> > > @@ -1174,6 +1201,7 @@ void pci_restore_state(struct pci_dev *dev)
> > >   	pci_restore_pri_state(dev);
> > >   	pci_restore_ats_state(dev);
> > >   	pci_restore_vc_state(dev);
> > > +	pci_restore_rebar_state(dev);
> > >   	pci_cleanup_aer_error_status_regs(dev);
> > > -- 
> > > 2.14.1
> > > 
> 
