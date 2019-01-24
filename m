Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B54C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0419218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAXWFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:05:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34312 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAXWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:05:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so6236179oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 14:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5tQLrNBrItaK0hC2Nvv+YFkPTPszLDrsmZmu8dfKsk=;
        b=ZQ+KxOTp2pvDf0/Tsv9zoQ+Csgx3AqEN6EZRpN+2O86Vw9AtBIm5jWz2Vl1pk+HDrE
         TtqcB1i/lEE4GS840mpOb9jIvzYpSwM6TYkY4M2Msztxfn4U6rDyKJhfYc8+2mkj6m8v
         +ufZaNMpL6a9Xbee2tPfeZand2/8jeESF9wPEYQVC5FvbcKhz/kX1DbL32TXJ6GKXMjU
         FfrrYRT2tGgUtUiCrw9MUujLL3ldef9u4NN3hQlIcDTgrQ7a44crlmsmCSQZkDjKpCq0
         vvAIA9QNJF4Rm6ztkUzqJiCxHI7XuPQJe9Hj/dTPoZwsfSAk6+Y+3Cc0t5AUl/qD+RtA
         oRpw==
X-Gm-Message-State: AJcUukei3yqhGtf1BVzL16CJnf3v28hYwGGQiboKNjEpW9rdvQJrpwbA
        gb/2H7mANRtGDzislomAd72oRDWBua+nrvSXL8CunA==
X-Google-Smtp-Source: ALg8bN53VKMdq3V/UcV5ldX1qcNBPivFpk6Rql0AvlvPJWFSKmAWZu07+hgPJYDHYPBtzYIwRVuUNjAcIyJJ/Ay3LCU=
X-Received: by 2002:aca:de03:: with SMTP id v3mr2459381oig.152.1548367543671;
 Thu, 24 Jan 2019 14:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20180904152333.21640-1-colin.king@canonical.com> <2d84fcfa-67af-ec76-5821-162004113bf3@canonical.com>
In-Reply-To: <2d84fcfa-67af-ec76-5821-162004113bf3@canonical.com>
From:   Ben Skeggs <bskeggs@redhat.com>
Date:   Fri, 25 Jan 2019 08:05:29 +1000
Message-ID: <CABDvA==mnccSCBSpO2-ksnStKN8Zw-Ryuj2qY5970NbTjn9-OA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/bios/dp: make array vsoff static, shrinks
 object size
To:     Colin Ian King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 3:26 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> ping?
I've pushed this, and the others you pinged about, to my tree.

Thank you,
Ben.

>
> On 04/09/2018 16:23, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Don't populate the array vsoff on the stack but instead make it
> > static. Makes the object code smaller by 67 bytes:
> >
> > Before:
> >    text          data     bss     dec     hex filename
> >    5753           112       0    5865    16e9 .../nouveau/nvkm/subdev/bios/dp.o
> >
> > After:
> >    text          data     bss     dec     hex filename
> >    5622           176       0    5798    16a6 .../nouveau/nvkm/subdev/bios/dp.o
> >
> > (gcc version 8.2.0 x86_64)
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
> > index 3133b28f849c..b099d1209be8 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
> > @@ -212,7 +212,7 @@ nvbios_dpcfg_match(struct nvkm_bios *bios, u16 outp, u8 pc, u8 vs, u8 pe,
> >       u16 data;
> >
> >       if (*ver >= 0x30) {
> > -             const u8 vsoff[] = { 0, 4, 7, 9 };
> > +             static const u8 vsoff[] = { 0, 4, 7, 9 };
> >               idx = (pc * 10) + vsoff[vs] + pe;
> >               if (*ver >= 0x40 && *ver <= 0x41 && *hdr >= 0x12)
> >                       idx += nvbios_rd08(bios, outp + 0x11) * 40;
> >
>
