Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679CEC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C0A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C0A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeILFQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:16:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51458 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeILFQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:16:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CF5352A7CE;
        Tue, 11 Sep 2018 20:15:07 -0400 (EDT)
Date:   Wed, 12 Sep 2018 10:15:23 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
cc:     Frank Rowand <frank.rowand@sony.com>,
        Stan Johnson <userm57@yahoo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
In-Reply-To: <abb0dec2-da3a-2c04-0e9f-28851b22cf75@yahoo.com>
Message-ID: <alpine.LNX.2.21.1809121015070.137@nippy.intranet>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com> <1520208889-3908-2-git-send-email-frowand.list@gmail.com> <alpine.LNX.2.21.1808301025480.73@nippy.intranet> <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org> <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org> <20180910125320.GA17028@bogus> <abb0dec2-da3a-2c04-0e9f-28851b22cf75@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[The Cc list got pruned so I'm forwarding Stan's reply for the benefit of 
the list archives and any other interested parties.]

On Mon, 10 Sep 2018, Stan Johnson wrote:

> On 9/10/18 6:53 AM, Rob Herring wrote:
> 
> > ...
> > Can you try this patch (w/o Ben's patch). I think the problem is if 
> > there are no phandles, then roundup_pow_of_two is passed 0 which is 
> > documented as undefined result.
> >
> > Though, if a DT has no properties with phandles, then why are we doing a 
> > lookup in the first place?
> >
> >
> > 8<----------------------------------------------------------------------
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 9095b8290150..74eaedd5b860 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
> >  		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> >  			phandles++;
> >  
> > +	if (!phandles)
> > +		goto out;
> > +
> >  	cache_entries = roundup_pow_of_two(phandles);
> >  	phandle_cache_mask = cache_entries - 1;
> >  
> 
> Using the attached .config file, I first compiled the stock 4.18
> kernel from kernel.org; it hung at the Mac OS background screen
> on my Beige G3 Desktop using the BootX extension and the BootX.app
> from within MacOS.  I then applied the above patch, and it booted
> without any problems from both the BootX extension and using the
> BootX.app from within MacOS.
> 
> -Stan
> 
> 
