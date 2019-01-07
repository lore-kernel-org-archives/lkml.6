Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B13C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4592173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfAGULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:11:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44812 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:11:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so1460573otl.11;
        Mon, 07 Jan 2019 12:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lOblw1N7cwFwlkpRrdrYmdvQFW4L6Eubu1aiaDtAc4=;
        b=bI9W9p1gLCdGEPe2laKZh4n9KTew3iuVJM3kJLagGuVIR/uN5CX9zFLw9Gll8JYRSj
         yNeNbcArAGcIUHW+0efuk4TL4jOJhAWIj4OM2Uu6RtbNV2L6Up5JxmcnL7U80q+5oDxT
         xmZCU8NRwgzww1J/zzZrW4ALpuZJQ12VsjO++cqZijkg72q1nOK5qDL9EowfwkDhd/KK
         pMcG795szEAzGbPoy3ykY6H/zvP4hoG4HsMPA3jSntZgY0tyvwDmbXoQ/t9TunSjL5uc
         qgh3Vfw5xe4leiAEJbFBTwkIrYbwrs8Ljh6/Z1XGLHWf5+5iIlpt3xpiB+sHfoQxMIQ4
         ineg==
X-Gm-Message-State: AJcUukf0mrYKVF+O1FWZvnfRCumT5bRBNuzdZkp29mWn2PdNpX9cXkhw
        u2oCAbSAmQuFGybNl2rN4mtnr1g/IRChmBEKS2JDgW6C
X-Google-Smtp-Source: ALg8bN6bi7JY1Xz+VbibohgA8h52Z8bAmSfTiVHbDZnpli/Yf0k+sSfd65idpv40/aLUqJZrQBaDNMWDfrsaAG01zMU=
X-Received: by 2002:a9d:628:: with SMTP id 37mr44295884otn.58.1546891906114;
 Mon, 07 Jan 2019 12:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20190107173132.27316-1-robh@kernel.org>
In-Reply-To: <20190107173132.27316-1-robh@kernel.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 7 Jan 2019 21:11:33 +0100
Message-ID: <CA+7wUswqMNc1js6hyszYKVOeXrVPVDYLxSmZ97Uaqqo7u0Z9vQ@mail.gmail.com>
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

On Mon, Jan 7, 2019 at 6:31 PM Rob Herring <robh@kernel.org> wrote:
>
> Commit 5c63e407aaab ("fbdev: Convert to using %pOFn instead of
> device_node.name") changed how the OF FB driver handles the OF node
> name. This missed the case where the node name is passed to
> offb_init_palette_hacks(). This results in a NULL ptr dereference
> in strncmp and breaks any system except ones using bootx with no display
> node.
>
> Fix this by making offb_init_palette_hacks() use the OF node pointer and
> use of_node_name_prefix() helper function instead for node name
> comparisons. This helps in moving all OF node name accesses to helper
> functions in preparation to remove struct device_node.name pointer.
>
> Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")

Looks good to me:

...
[    0.000000] Linux version 5.0.0-rc1+ (malat@debian.org) (gcc
version 6.3.0 20170516 (Debian 6.3.0-18)) #21 Mon Jan 7 21:03:53 CET
2019
...

So here is my :

Tested-by: Mathieu Malaterre <malat@debian.org>

Thanks

> Reported-by: Mathieu Malaterre <malat@debian.org>
> Cc: stable@vger.kernel.org # v4.19+
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/video/fbdev/offb.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 31f769d67195..057d3cdef92e 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -318,28 +318,28 @@ static void __iomem *offb_map_reg(struct device_node *np, int index,
>  }
>
>  static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp,
> -                                   const char *name, unsigned long address)
> +                                   unsigned long address)
>  {
>         struct offb_par *par = (struct offb_par *) info->par;
>
> -       if (dp && !strncmp(name, "ATY,Rage128", 11)) {
> +       if (of_node_name_prefix(dp, "ATY,Rage128")) {
>                 par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
>                 if (par->cmap_adr)
>                         par->cmap_type = cmap_r128;
> -       } else if (dp && (!strncmp(name, "ATY,RageM3pA", 12)
> -                         || !strncmp(name, "ATY,RageM3p12A", 14))) {
> +       } else if (of_node_name_prefix(dp, "ATY,RageM3pA") ||
> +                  of_node_name_prefix(dp, "ATY,RageM3p12A")) {
>                 par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
>                 if (par->cmap_adr)
>                         par->cmap_type = cmap_M3A;
> -       } else if (dp && !strncmp(name, "ATY,RageM3pB", 12)) {
> +       } else if (of_node_name_prefix(dp, "ATY,RageM3pB")) {
>                 par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
>                 if (par->cmap_adr)
>                         par->cmap_type = cmap_M3B;
> -       } else if (dp && !strncmp(name, "ATY,Rage6", 9)) {
> +       } else if (of_node_name_prefix(dp, "ATY,Rage6")) {
>                 par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
>                 if (par->cmap_adr)
>                         par->cmap_type = cmap_radeon;
> -       } else if (!strncmp(name, "ATY,", 4)) {
> +       } else if (of_node_name_prefix(dp, "ATY,")) {
>                 unsigned long base = address & 0xff000000UL;
>                 par->cmap_adr =
>                         ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
> @@ -350,7 +350,7 @@ static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp
>                 par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
>                 if (par->cmap_adr)
>                         par->cmap_type = cmap_gxt2000;
> -       } else if (dp && !strncmp(name, "vga,Display-", 12)) {
> +       } else if (of_node_name_prefix(dp, "vga,Display-")) {
>                 /* Look for AVIVO initialized by SLOF */
>                 struct device_node *pciparent = of_get_parent(dp);
>                 const u32 *vid, *did;
> @@ -438,7 +438,7 @@ static void __init offb_init_fb(const char *name,
>
>         par->cmap_type = cmap_unknown;
>         if (depth == 8)
> -               offb_init_palette_hacks(info, dp, name, address);
> +               offb_init_palette_hacks(info, dp, address);
>         else
>                 fix->visual = FB_VISUAL_TRUECOLOR;
>
> --
> 2.19.1
>
