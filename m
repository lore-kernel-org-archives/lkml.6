Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23B520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23B520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeIFMry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:47:54 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:48371 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeIFMrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:47:53 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 49FE430002258;
        Thu,  6 Sep 2018 10:13:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 214F854F8A9; Thu,  6 Sep 2018 10:13:37 +0200 (CEST)
Date:   Thu, 6 Sep 2018 10:13:37 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] thunderbolt: Initialize after IOMMUs
Message-ID: <20180906081337.3mosfpfggfmoj633@wunner.de>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
 <20180903132012.23531-2-mika.westerberg@linux.intel.com>
 <20180905084746.xmckzskxzsdliz3e@wunner.de>
 <20180905094602.GH2283@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905094602.GH2283@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:46:02PM +0300, Mika Westerberg wrote:
> On Wed, Sep 05, 2018 at 10:47:46AM +0200, Lukas Wunner wrote:
> > On Mon, Sep 03, 2018 at 04:20:12PM +0300, Mika Westerberg wrote:
> > > If IOMMU is enabled and Thunderbolt driver is built into the kernel
> > > image, it will be probed before IOMMUs are attached to the PCI bus.
> > > Because of this DMA mappings the driver does will not go through IOMMU
> > > and start failing right after IOMMUs are enabled.
> > > 
> > > For this reason move the Thunderbolt driver initialization happen at
> > > rootfs level.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/thunderbolt/nhi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > > index 88cff05a1808..5cd6bdfa068f 100644
> > > --- a/drivers/thunderbolt/nhi.c
> > > +++ b/drivers/thunderbolt/nhi.c
> > > @@ -1191,5 +1191,5 @@ static void __exit nhi_unload(void)
> > >  	tb_domain_exit();
> > >  }
> > >  
> > > -fs_initcall(nhi_init);
> > > +rootfs_initcall(nhi_init);
> > >  module_exit(nhi_unload);
> > 
> > I think the dependency on the IOMMU should be open coded by returning
> > -EPROBE_DEFER from the ->probe hook if it's not yet attached.
> > Shuffling around initcall order is just applying duct tape.
> 
> It is not a dependency. The same thing can happen with any other driver
> if they happen to initialize any DMA with the device before IOMMUs are
> initialized.
> 
> > Commit acb40d841257 already changed module_init() to fs_initcall()
> > and now it has to be changed again.  Shows how fragile this is.
> 
> It is a bit fragile but I don't see any other way to handle this than
> trusting on the link ordering. Both -EPROBE_DEFER and device_links are
> out of the question AFAICT.

So with this patch, you rely on the linker ordering nhi_init() after
ir_dev_scope_init(), however to the best of my knowledge the link
order is not guaranteed.

In that sense, commit acb40d841257 was already flawed because it
executed nhi_init() at "fs" initcall level, the *same* level used by
map_properties() in drivers/firmware/efi/apple-properties.c, which
retrieves the DROM device property needed by tb_drom_copy_efi().

That was arguably a regression which the above patch cures because
"rootfs" is guaranteed to run after "fs".  Still, the fragility
remains that ir_dev_scope_init() isn't guaranteed to run before
nhi_init().

Looking at commit acb40d841257, which started this, I'm wondering
why you did not simply export tbnet_init() and call it from the
thunderbolt driver after the property stuff has been fully set up?
After all, thunderbolt-net is useless without thunderbolt or am I
missing something?  Then you could revert back to module_init().

Thanks,

Lukas
