Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB372C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D1920883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D1920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeKHBVs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:21:48 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33790 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeKHBVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:21:48 -0500
Received: by mail-ua1-f65.google.com with SMTP id s26so6023579uao.0;
        Wed, 07 Nov 2018 07:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QVVdEaZmS3MnBpU2Y+sUL1gFnyn2n5QwnVAAM3Xv++s=;
        b=c90CV5Dcv3NbBpadxYg1SVR4uvqTlf9qvhBdCiuSi51eeaFxz6GA1pxurEAYnbrwUI
         sMcEeUpHCSSiWMNg4cd6Mg+j98ABO22FzbhDov5MWTdQsF3rSSMlNp3s7sJI8oa4fMe3
         xOnMx8YWXXBOchAwmz0cyhrOEbzc3cRFMACGXjrMciUJYoUJME+zjWQLbSd7mfHA4gEx
         kSMLPJGQNapZqVuiEVv/L9KA9ZAedwFRVRsGoi5ctGKAC2uHzoYEBdpa5FOgTjbR3bQ2
         Rhyld1TJ5A6f5xNMYZiitMxBIlNhOkb3mPFmAB2YQ3VRi6aCobojTkKTu54xNmSoMeId
         pPnQ==
X-Gm-Message-State: AGRZ1gKSdegOJvgF4AJY23Z6UakK8Vdf+L8etLg1RuW5ILBCsCW8fNiW
        yy8q0Nf72K0Y55Noz8PaN+U+iNdBFGEWtkDZuShPdvuo
X-Google-Smtp-Source: AJdET5dR+P7uo8ynIQTVCdwvF53fWfe+J761Aus2ChWzwDGpPOkt3ykXl9vz9K2xPxkdSRuETiGJ+Nk7CTiufwsGihw=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr312960uae.75.1541605852266;
 Wed, 07 Nov 2018 07:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com> <20181107153418.cge2dj5zmztahxrf@8bytes.org>
In-Reply-To: <20181107153418.cge2dj5zmztahxrf@8bytes.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Nov 2018 16:50:40 +0100
Message-ID: <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,

On Wed, Nov 7, 2018 at 4:34 PM Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Nov 07, 2018 at 01:22:52PM +0000, Robin Murphy wrote:
> > On 2018-11-07 1:18 pm, Geert Uytterhoeven wrote:
> > > Fix this by checking if the domain's context already exists, before
> > > trying to destroy it.
> >
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> Does this need a Fixes-tag? If so, which patch should be in that tag?

I think this bug has been present since the initial version of the driver, but
this failure mode has probably never been tested before.

It only got triggered by the combination of commits 6c2fb2ea76361da9
("of/device: Set bus DMA mask as appropriate") and b4ebe6063204da58
("dma-direct: implement complete bus_dma_mask handling"), which is being
fixed by "of/device: Really only set bus DMA mask when
appropriate" (https://patchwork.kernel.org/patch/10670177/).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
