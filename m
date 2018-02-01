Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeBATyd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:54:33 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63001
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754594AbeBATy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:54:27 -0500
X-IronPort-AV: E=Sophos;i="5.46,444,1511823600";
   d="scan'208";a="253322749"
Date: Thu, 1 Feb 2018 20:54:25 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Mathieu Malaterre <malat@debian.org>
cc: Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: cocci script for detecting alloc_apertures mem leak
In-Reply-To: <CA+7wUsz+Ud6+LFVdVs7-pPMSJmW-7opXCqs2NuYP3=enYxoD4A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1802012041460.2188@hadrien>
References: <CA+7wUsz+Ud6+LFVdVs7-pPMSJmW-7opXCqs2NuYP3=enYxoD4A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Feb 2018, Mathieu Malaterre wrote:

> Hi cocci gurus,
>
> I am wondering if coccinelle can handle detection of kzalloc mem leak
> (within alloc_apertures call) ? Typically:
>
> $ cat drivers/video/fbdev/vesafb.c
> static int vesafb_probe(struct platform_device *dev)
> [...]
>   info->apertures = alloc_apertures(1);
>
> but then:
>
> static void vesafb_destroy(struct fb_info *info)
> {
>   struct vesafb_par *par = info->par;
>
>   fb_dealloc_cmap(&info->cmap);
>   arch_phys_wc_del(par->wc_cookie);
>   if (info->screen_base)
>     iounmap(info->screen_base);
>   release_mem_region(info->apertures->ranges[0].base,
> info->apertures->ranges[0].size);
> }
>
> For reference:
>
> $ cat include/linux/fb.h
> static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
>   struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
>     + max_num * sizeof(struct aperture), GFP_KERNEL);

You could do something like this:

@nm@
identifier i,j,prb,rem;
@@

struct i j = { .prob = prb, .rem = remove, };

@a exists@
identifier nm.prb;
expression e;
@@

prb(...) { <+... e = alloc_apertures(...) ...+> }

@@
identifier nm.rem;
expression a.e;
@@

*rem(...) {
   ... when != kfree(e)
}

This is assuming that the reference to the alloc_apertures value is made
in the same way in the probe and remove function.  If this is not the
case, you have to figure out how to express some relation between them.

This is also assuming that the kfree is directly in the remove function,
not in some function called by it.  If that hypothesis does not hold, it
might be better to just report any cases where ther is no call to kfree(e)
in the whole file.  For this you could replace the last rule with:

@ok@
expression a.e;
@@

kfree(e);

@depends on !ok@
expression a.e;
@@

* e = alloc_apertures(...)

That would be checking for files that don't free the result os
alloc_apertures anywhere.

If you want to do a full interprocedural analysis, it is possible, but
more complicated.  You could look at coccinelle/demos/iteration.cocci.

julia
