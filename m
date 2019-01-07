Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C26C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96CF2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfAGUgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:36:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38846 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:36:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so1551378otl.5;
        Mon, 07 Jan 2019 12:36:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jwwNXK1Y88yrzPydfDKP0Tb8tQ0ZIKdHk/HF4vjcHY=;
        b=UTcxIzTE5Lb+nfO3thGtDYkEig/ZCOGkyvVTGDU77KVnPz3SowEtjt0sKmxmW7Mvwz
         hKbbfwot0p+JL2EFVxw/Z6Tp+hu+jx/6GS9KzmPE8OtEwryoDExVwSfORbE7FszdIG+F
         pcBBeyE65Uw0sjnZ5FrGSjxXjZUTqdy8hxw7iG0GaEoIRSiEXWCklc2N10MBiT2kOVoF
         igRo968MQ08kbVEGlYa78kf2jc59ynZI/b75Bf5CIU9O9+QNsirwIAIVtdHX0jAuf8EV
         1EuqzCY2lGu+vInI6MmW9T4zcSkEeTM+JpPpGLMv5yRBpAQGa8/jtoi4gMb1G2MN5wLF
         crXw==
X-Gm-Message-State: AJcUukcqHG9dpgU8lWv1EyiBAZSWlsPjeF/25YCHrFNznVgsw3iT5trw
        7ZIXlhBoBgHrLqRPeKVcJSPzib/HMsNBeYnW/ih70TEk
X-Google-Smtp-Source: ALg8bN4yszOjgxSlXSKGt20GU9pEnPvORHMKx643wEpkrcP2+h/zzfHWFjZOjE+zqCbQ8QA/k3b/hEf3VxfXcbeQQC0=
X-Received: by 2002:a9d:628:: with SMTP id 37mr44348033otn.58.1546893398089;
 Mon, 07 Jan 2019 12:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20190107173132.27316-1-robh@kernel.org> <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
In-Reply-To: <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 7 Jan 2019 21:36:26 +0100
Message-ID: <CA+7wUsyw8PLc2-4jnFVwkNg_u8H=FgOHQtBspKR8haLT-5NSwQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: offb: Fix OF node name handling
To:     Rob Herring <robh@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jan 7, 2019 at 9:11 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Mon, Jan 7, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
> > device_node.name") changed how the OF FB driver handles the OF node
> > name. This missed the case where the node name is passed to
> > offb_init_palette_hacks(). This results in a NULL ptr dereference
> > in strncmp and breaks any system except ones using bootx with no display
> > node.
> >
> > Fix this by making offb_init_palette_hacks() use the OF node pointer and
> > use of_node_name_prefix() helper function instead for node name
> > comparisons. This helps in moving all OF node name accesses to helper
> > functions in preparation to remove struct device_node.name pointer.
> >
> > Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
>
> Looks good to me:
>
> ...
> [    0.000000] Linux version 5.0.0-rc1+ (malat@debian.org) (gcc
> version 6.3.0 20170516 (Debian 6.3.0-18)) #21 Mon Jan 7 21:03:53 CET
> 2019
> ...
>
> So here is my :
>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Just for curiosity, why would you keep:

     if (strcmp(dp->name, "valkyrie") == 0)



> > Reported-by: Mathieu Malaterre <malat@debian.org>
> > Cc: stable@vger.kernel.org # v4.19+
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/video/fbdev/offb.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> > index 31f769d67195..057d3cdef92e 100644
> > --- a/drivers/video/fbdev/offb.c
> > +++ b/drivers/video/fbdev/offb.c
> > @@ -318,28 +318,28 @@ static void __iomem *offb_map_reg(struct device_node *np, int index,
> >  }
> >
> >  static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp,
> > -                                   const char *name, unsigned long address)
> > +                                   unsigned long address)
> >  {
> >         struct offb_par *par = (struct offb_par *) info->par;
> >
> > -       if (dp && !strncmp(name, "ATY,Rage128", 11)) {
> > +       if (of_node_name_prefix(dp, "ATY,Rage128")) {
> >                 par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
> >                 if (par->cmap_adr)
> >                         par->cmap_type = cmap_r128;
> > -       } else if (dp && (!strncmp(name, "ATY,RageM3pA", 12)
> > -                         || !strncmp(name, "ATY,RageM3p12A", 14))) {
> > +       } else if (of_node_name_prefix(dp, "ATY,RageM3pA") ||
> > +                  of_node_name_prefix(dp, "ATY,RageM3p12A")) {
> >                 par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
> >                 if (par->cmap_adr)
> >                         par->cmap_type = cmap_M3A;
> > -       } else if (dp && !strncmp(name, "ATY,RageM3pB", 12)) {
> > +       } else if (of_node_name_prefix(dp, "ATY,RageM3pB")) {
> >                 par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
> >                 if (par->cmap_adr)
> >                         par->cmap_type = cmap_M3B;
> > -       } else if (dp && !strncmp(name, "ATY,Rage6", 9)) {
> > +       } else if (of_node_name_prefix(dp, "ATY,Rage6")) {
> >                 par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
> >                 if (par->cmap_adr)
> >                         par->cmap_type = cmap_radeon;
> > -       } else if (!strncmp(name, "ATY,", 4)) {
> > +       } else if (of_node_name_prefix(dp, "ATY,")) {
> >                 unsigned long base = address & 0xff000000UL;
> >                 par->cmap_adr =
> >                         ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
> > @@ -350,7 +350,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
> >                 par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
> >                 if (par->cmap_adr)
> >                         par->cmap_type = cmap_gxt2000;
> > -       } else if (dp && !strncmp(name, "vga,Display-", 12)) {
> > +       } else if (of_node_name_prefix(dp, "vga,Display-")) {
> >                 /* Look for AVIVO initialized by SLOF */
> >                 struct device_node *pciparent = of_get_parent(dp);
> >                 const u32 *vid, *did;
> > @@ -438,7 +438,7 @@ static void __init offb_init_fb(const char *name,
> >
> >         par->cmap_type = cmap_unknown;
> >         if (depth == 8)
> > -               offb_init_palette_hacks(info, dp, name, address);
> > +               offb_init_palette_hacks(info, dp, address);
> >         else
> >                 fix->visual = FB_VISUAL_TRUECOLOR;
> >
> > --
> > 2.19.1
> >
