Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7EB21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfB0GIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:08:24 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:17368
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbfB0GIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:08:24 -0500
X-IronPort-AV: E=Sophos;i="5.58,418,1544482800"; 
   d="scan'208";a="297446552"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 07:08:21 +0100
Date:   Wed, 27 Feb 2019 07:08:20 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Sergei Shtylyov (sergei.shtylyov@cogentembedded.com)" 
        <sergei.shtylyov@cogentembedded.com>
Subject: RE: question about drivers/phy/renesas/phy-rcar-gen2.c
In-Reply-To:   <TY2PR01MB481259F0AFBF6DEF9565792CD8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1902270707570.2826@hadrien>
References: <alpine.DEB.2.21.1902030759010.19281@hadrien>   <TY2PR01MB4812FA6549BA23233D9670CBD87B0@TY2PR01MB4812.jpnprd01.prod.outlook.com> <alpine.DEB.2.20.1902261000420.3499@hadrien>  
 <TY2PR01MB481259F0AFBF6DEF9565792CD8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2019, Yoshihiro Shimoda wrote:

> Hello,
>
> > From: Julia Lawall, Sent: Tuesday, February 26, 2019 6:01 PM
> >
> > On Tue, 26 Feb 2019, Yoshihiro Shimoda wrote:
> >
> > > Hello,
> > > (Sergei made this code, so I added his email as CC)
> > >
> > > I'm sorry for the delayed response.
> > >
> > > > From: Julia Lawall, Sent: Sunday, February 3, 2019 4:03 PM
> > > >
> > > > Hello,
> > > >
> > > > I was wondering whether phy-rcar-gen2.c would use dynamically allocated
> > > > device nodes?
> > >
> > > I'm sorry, but what is "dynamically allocated device nodes"?
> >
> > Device nodes for which there will be a meor leak if one doesn't put
> > of_node_put.
>
> Thank you. I understood it.
>
> > julia
> >
> > >
> > > Best regards,
> > > Yoshihiro Shimoda
> > >
> > > >  If so, it looks like the following code could cause a
> > > > use-after-free, due to not incrementing th reference count:
> > > >
> > > > 	for_each_child_of_node(dev->of_node, np) {
> > > > 		struct rcar_gen2_channel *channel = drv->channels + i;
> > > > 		u32 channel_num;
> > > > 		int error, n;
> > > >
> > > > 		channel->of_node = np;
>
> IIUC, since the channel->of_node will be used for comparing the pointer
> in rcar_gen2_phy_xlate(), it is not use-after-free.
> However, the for_each_child_of_node() in rcar_gen2_phy_probe() will return
> without of_put_node() at error paths. So, I'll submit a bugfix patch later.
>
> Thank you very much for your report!

Thanks for taking care of it.

julia

>
> Best regards,
> Yoshihiro Shimoda
>
> > > > 		...
> > > > 	}
> > > >
> > > > On the other hand, if the reference cound it incrememnted, preventing
> > > > memory leaks in the case where the probe function fails would entail some
> > > > complex rewriting of the code, so I thought it would be better to ask
> > > > first.
> > > >
> > > > thanks,
> > > > julia
> > >
>
