Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E25BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F10205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F10205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeIEOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:15:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:50621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeIEOPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:15:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 02:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,333,1531810800"; 
   d="scan'208";a="70493450"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 05 Sep 2018 02:46:03 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Sep 2018 12:46:02 +0300
Date:   Wed, 5 Sep 2018 12:46:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] thunderbolt: Initialize after IOMMUs
Message-ID: <20180905094602.GH2283@lahna.fi.intel.com>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
 <20180903132012.23531-2-mika.westerberg@linux.intel.com>
 <20180905084746.xmckzskxzsdliz3e@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905084746.xmckzskxzsdliz3e@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:47:46AM +0200, Lukas Wunner wrote:
> On Mon, Sep 03, 2018 at 04:20:12PM +0300, Mika Westerberg wrote:
> > If IOMMU is enabled and Thunderbolt driver is built into the kernel
> > image, it will be probed before IOMMUs are attached to the PCI bus.
> > Because of this DMA mappings the driver does will not go through IOMMU
> > and start failing right after IOMMUs are enabled.
> > 
> > For this reason move the Thunderbolt driver initialization happen at
> > rootfs level.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/nhi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > index 88cff05a1808..5cd6bdfa068f 100644
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -1191,5 +1191,5 @@ static void __exit nhi_unload(void)
> >  	tb_domain_exit();
> >  }
> >  
> > -fs_initcall(nhi_init);
> > +rootfs_initcall(nhi_init);
> >  module_exit(nhi_unload);
> 
> What if the rootfs is located on a Thunderbolt-attached drive and
> the thunderbolt driver needs to establish tunnels to that drive
> before rootfs can be accessed?  Doesn't the above break such a setup?

No, then you put the driver as part of your initrd.

> I think the dependency on the IOMMU should be open coded by returning
> -EPROBE_DEFER from the ->probe hook if it's not yet attached.
> Shuffling around initcall order is just applying duct tape.

It is not a dependency. The same thing can happen with any other driver
if they happen to initialize any DMA with the device before IOMMUs are
initialized.

> Commit acb40d841257 already changed module_init() to fs_initcall()
> and now it has to be changed again.  Shows how fragile this is.

It is a bit fragile but I don't see any other way to handle this than
trusting on the link ordering. Both -EPROBE_DEFER and device_links are
out of the question AFAICT.
