Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025452147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfBSRd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:33:27 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20118 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbfBSRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:33:26 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544482800"; 
   d="scan'208";a="370069650"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 18:33:24 +0100
Date:   Tue, 19 Feb 2019 18:33:22 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Tony Lindgren <tony@atomide.com>
cc:     Peng Hao <peng.hao2@zte.com.cn>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        wen.yang99@zte.com.cn
Subject: Re: [PATCH] arm/mach-omap2/display: fix possible object reference
 leak
In-Reply-To: <20190219170516.GL15711@atomide.com>
Message-ID: <alpine.DEB.2.20.1902191830490.27989@hadrien>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn> <20190219170516.GL15711@atomide.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2019, Tony Lindgren wrote:

> Hi,
>
> Adding devicetree list, Julia, Rob and Tomi to Cc.
>
> * Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> > of_find_device_by_node() takes a reference to the struct device
> > when it finds a match via get_device.When returning error we should
> > call put_device.
> >
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > ---
> >  arch/arm/mach-omap2/display.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> > index f86b72d..c6aa9ed 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
> >  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> >  	if (r) {
> >  		pr_err("Unable to populate DSS submodule devices\n");
> > +		put_device(&pdev->dev);
> >  		return r;
> >  	}
>
> In general, if the device tree node is never used afterwards,
> should this be just:
>
> 	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
> 	of_node_put(dev_node);
> 	if (r) {
> 		...
> 	}
>
> If so, Julia might have a Coccinelle recpipe for it?

Unfortunately this is not really an ideal case for Coccinelle, because
node is the result of calling a local function and Coccinelle doesn't by
default do any interprocedural analysis.  It is possible to write a rule
that explicitly looks for one function that returns a device node and then
the pattern of its usage in the caller, though.

julia
