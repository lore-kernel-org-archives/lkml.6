Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11415C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD6C2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfABUD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:03:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40764 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfABUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:03:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so27649290oth.7;
        Wed, 02 Jan 2019 12:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHsg2FG5gmuVBMMbiDxSZDA8VrWifS4gHbxgzJfm+do=;
        b=OxyL+salZFJmfttqyOAtjvmUU9bmlSpW9jnbMC54OPh9Mf+zj1dpDSA09xRtOh9078
         R/oEczS5DHX+4Ozgz2qZehlqz1OTvFlYJeje9mFCDdIYg9NF3d8sRHCBnCZ4ih1XGwQs
         4PQu6nl9acykK5elxjBGA1yAA1QeFKGK8cXLfMDhX8lGv50jutXs1yhiI3A94udiOAEm
         paFYUUv/h90j/1fLVkzQGCn2Ee5KdyrQRfamotZ+GqBu4k9NTw5nRKytOTshXPRvuJ0e
         VyYl8d/pVFxN2DXZI51bcnr5DzucBC/GoE+iDloktuVRfiL5SsvtpXsvg1kGNbBizgo3
         Bnsw==
X-Gm-Message-State: AJcUukcyr96lqWDpwLc+e9iEAN0IbSzNiikF2JWv2VNRY76NSeUCImjm
        75T36gb5ksMc0brnmQCk6IFMq7mtLLOCgHpeqV4=
X-Google-Smtp-Source: ALg8bN4rlLOUHOAt1YKwANgVIW5VDAh4ihwDJzHMVoO3d6T1G8jFx74s2TANoeX2DJ8vU0pn6J9LHCFrvtHbD5j6AeQ=
X-Received: by 2002:a9d:24c5:: with SMTP id z63mr32953422ota.320.1546459438049;
 Wed, 02 Jan 2019 12:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20181207125844.18775-1-malat@debian.org> <CA+7wUszBpmd2r18WZVjAXv2xq+ySrnKTqaRT7bGcHa71_M_j7g@mail.gmail.com>
In-Reply-To: <CA+7wUszBpmd2r18WZVjAXv2xq+ySrnKTqaRT7bGcHa71_M_j7g@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 2 Jan 2019 21:03:45 +0100
Message-ID: <CA+7wUsxN664BUjetUX3LhjN4JvZAAWY_Atv2d_eE9_UFGGwg2Q@mail.gmail.com>
Subject: Re: [PATCH] video: offb: Pass actual name in offb_init_palette_hacks
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     "# v4 . 11" <stable@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Elimar Riesebieter <riesebie@lxtec.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej,

Do you need an Acked-by from Rob, or can you take it in the next round
of fixes for v4.20 ?

Just to repeat myself, previous code would call
offb_init_palette_hacks(), which in turn would do:

       if (dp && !strncmp(name, "ATY,Rage128", 11)) {

with name=NULL.

Thanks

On Thu, Dec 20, 2018 at 5:10 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Rob, any comment ?
>
> On Fri, Dec 7, 2018 at 1:59 PM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > This is a partial revert of commit 5c63e407aaab ("fbdev: Convert to
> > using %pOFn instead of device_node.name"). This is the minimal work to
> > get a Mac Mini G4 back to a bootable state. The function
> > offb_init_palette_hacks would need to handle the case where `name` has
> > been set to NULL.
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
> > Cc: stable@vger.kernel.org # v4.19+
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >  drivers/video/fbdev/offb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> > index 31f769d67195..6e75851f8142 100644
> > --- a/drivers/video/fbdev/offb.c
> > +++ b/drivers/video/fbdev/offb.c
> > @@ -648,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
> >                 /* kludge for valkyrie */
> >                 if (strcmp(dp->name, "valkyrie") == 0)
> >                         address += 0x1000;
> > -               offb_init_fb(no_real_node ? "bootx" : NULL,
> > +               offb_init_fb(no_real_node ? "bootx" : dp->name,
> >                              width, height, depth, pitch, address,
> >                              foreign_endian, no_real_node ? NULL : dp);
> >         }
> > --
> > 2.19.2
> >
