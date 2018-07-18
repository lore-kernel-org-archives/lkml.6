Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942FAECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D7120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo7VnMc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeGSAJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbeGSAJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:09:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B682084E;
        Wed, 18 Jul 2018 23:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531956575;
        bh=hfBF04FkaF+8jRfxk9yETUJz7z/XJxZdKmGvWCYinoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qo7VnMc2jY2Q4l6bDDOEoed0euZ7vXw2HgPWyC1t4aOpbbTnsF5SRDcH0qU1Vx1Jx
         XZgmw92j2Bt3vdNS7o3tQeYn5N+JslEI6ZkNxrMAAh8jzyrg+pa3WJO2Kk41QNknRD
         j2zj0xUUzOaNAP71ZV/La3GllYcFvy1fkNC0cNqk=
Date:   Wed, 18 Jul 2018 18:29:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 5/6] PCI: Deprecate pci_reset_bus() and
 pci_reset_slot() functions
Message-ID: <20180718232934.GK128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
 <1530572336-20296-6-git-send-email-okaya@codeaurora.org>
 <20180718223027.GI128988@bhelgaas-glaptop.roam.corp.google.com>
 <3d664a22-7362-07ec-584d-b38829a22ba2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d664a22-7362-07ec-584d-b38829a22ba2@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:36:29PM -0700, Sinan Kaya wrote:
> On 7/18/2018 3:30 PM, Bjorn Helgaas wrote:
> > On Mon, Jul 02, 2018 at 06:58:54PM -0400, Sinan Kaya wrote:
> > > pci_reset_bus() and pci_reset_slot() functions are not being used by
> > > any code. Remove them from the kernel in favor of pci_try_reset_bus()
> > > and pci_try_reset_slot() functions.
> > > 
> > > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > > ---
> > >   drivers/pci/pci.c   | 55 ++---------------------------------------------------
> > >   include/linux/pci.h |  2 --
> > >   2 files changed, 2 insertions(+), 55 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index a31e6db..7e3f2e9 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -4784,9 +4784,9 @@ int pci_probe_reset_slot(struct pci_slot *slot)
> > >   EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
> > >   /**
> > > - * pci_reset_slot - reset a PCI slot
> > > + * __pci_try_reset_slot - Try to reset a PCI slot
> > >    * @slot: PCI slot to reset
> > > - *
> > > + *`
> > 
> > Is this "*`" intentional or a typo?  I can't find it in kernel-doc.rst
> > (but it's full of ` and maybe I missed it).
> 
> Typo.

Great, I fixed it.
