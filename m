Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70503ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181D920856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpO1vNL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181D920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGSXpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbeGSXpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:45:33 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C8420684;
        Thu, 19 Jul 2018 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532041218;
        bh=yLliuZbTiVqAFsbQKE/0bIZPS0/qXbrwqiwzrVBu918=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpO1vNL9T9GFf/OE65oOQXIwtqD+hxrGcnJ/NIeIiLHN3WbzQxBnT7zjnpmvSysyl
         bH3HPRVD9TTCrqDheSVHP2LwAAwf8WzI6AknvfEXLfobEI2mq+KQ02J+k+FTrncFOh
         N0Fk9nlHR/R4WWoehnTb6+u5rGxYm/7VeRMiLgsg=
Date:   Thu, 19 Jul 2018 18:00:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     poza@codeaurora.org
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix issues and cleanup for ERR_FATAL and
 ERR_NONFATAL
Message-ID: <20180719230016.GQ128988@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <35f60c57a8e8fe9503d63a62fd4776bf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f60c57a8e8fe9503d63a62fd4776bf@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 09:23:47AM +0530, poza@codeaurora.org wrote:
> On 2018-07-19 01:14, Bjorn Helgaas wrote:
> > This is a v3 of Oza's patches [1].  It's available at [2] if you prefer
> > git.
> > 
> > v3 changes:
> >   - Add pci_aer_clear_fatal_status() to clear ERR_FATAL bits, only
> > called
> >     from pcie_do_fatal_recovery().  Moved to first in series to avoid a
> >     window where ERR_FATAL recovery only clears ERR_NONFATAL bits.
> > Visible
> >     only inside the PCI core.
> >   - Instead of having pci_cleanup_aer_uncorrect_error_status() do
> > different
> >     things based on dev->error_state, use this only for ERR_NONFATAL
> > bits.
> >     I didn't change the name because it's used by many drivers.
> >   - Rename pci_cleanup_aer_error_device_status() to
> >     pci_aer_clear_device_status(), make it void, and make it visible
> > only
> >     inside the PCI core.
> >   - Remove pcie_portdrv_err_handler.slot_reset altogether instead of
> > making
> >     it a stub function.  Possibly pcie_portdrv_err_handler could be
> > removed
> >     completely?
> > 
> > [1]
> > https://lkml.kernel.org/r/1529661494-20936-1-git-send-email-poza@codeaurora.org
> > [2]
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/06-22-oza-aer
> > 
> > ---
> > 
> > Bjorn Helgaas (1):
> >       PCI/AER: Clear only ERR_FATAL status bits during fatal recovery
> > 
> > Oza Pawandeep (6):
> >       PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery
> >       PCI/AER: Factor out ERR_NONFATAL status bit clearing
> >       PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
> >       PCI/AER: Clear device status bits during ERR_FATAL and
> > ERR_NONFATAL
> >       PCI/AER: Clear device status bits during ERR_COR handling
> >       PCI/portdrv: Remove pcie_portdrv_err_handler.slot_reset
> > 
> > 
> >  drivers/pci/pci.h              |    5 ++++
> >  drivers/pci/pcie/aer.c         |   47
> > +++++++++++++++++++++++++++-------------
> >  drivers/pci/pcie/err.c         |   15 +++++--------
> >  drivers/pci/pcie/portdrv_pci.c |   25 ---------------------
> >  4 files changed, 43 insertions(+), 49 deletions(-)
> 
> looks good to me.
> Thanks for the corrections.
> some x86 compilation errors, you want me to to fix it and push v4 ?

I fixed those already.  I moved these all to the pci/aer branch for
v4.19.  I'll merge them into "next" soon.  Thanks!

Bjorn
