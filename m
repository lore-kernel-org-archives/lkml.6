Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB04C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2E3213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfBZJBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:01:08 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:19229
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfBZJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:01:08 -0500
X-IronPort-AV: E=Sophos;i="5.58,415,1544482800"; 
   d="scan'208";a="297336832"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 10:01:06 +0100
Date:   Tue, 26 Feb 2019 10:01:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
cc:     Julia Lawall <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Sergei Shtylyov (sergei.shtylyov@cogentembedded.com)" 
        <sergei.shtylyov@cogentembedded.com>
Subject: RE: question about drivers/phy/renesas/phy-rcar-gen2.c
In-Reply-To:   <TY2PR01MB4812FA6549BA23233D9670CBD87B0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1902261000420.3499@hadrien>
References: <alpine.DEB.2.21.1902030759010.19281@hadrien>   <TY2PR01MB4812FA6549BA23233D9670CBD87B0@TY2PR01MB4812.jpnprd01.prod.outlook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Feb 2019, Yoshihiro Shimoda wrote:

> Hello,
> (Sergei made this code, so I added his email as CC)
>
> I'm sorry for the delayed response.
>
> > From: Julia Lawall, Sent: Sunday, February 3, 2019 4:03 PM
> >
> > Hello,
> >
> > I was wondering whether phy-rcar-gen2.c would use dynamically allocated
> > device nodes?
>
> I'm sorry, but what is "dynamically allocated device nodes"?

Device nodes for which there will be a meor leak if one doesn't put
of_node_put.

julia

>
> Best regards,
> Yoshihiro Shimoda
>
> >  If so, it looks like the following code could cause a
> > use-after-free, due to not incrementing th reference count:
> >
> > 	for_each_child_of_node(dev->of_node, np) {
> > 		struct rcar_gen2_channel *channel = drv->channels + i;
> > 		u32 channel_num;
> > 		int error, n;
> >
> > 		channel->of_node = np;
> > 		...
> > 	}
> >
> > On the other hand, if the reference cound it incrememnted, preventing
> > memory leaks in the case where the probe function fails would entail some
> > complex rewriting of the code, so I thought it would be better to ask
> > first.
> >
> > thanks,
> > julia
>
