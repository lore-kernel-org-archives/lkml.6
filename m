Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEAFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34C62083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34C62083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHaLsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:48:09 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46640 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeHaLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:48:08 -0400
Received: by mail-vk0-f66.google.com with SMTP id b14-v6so5153633vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 00:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATaoJc5HrFh+edTIFNvRtQHEVTOaLWUXVlaqgQ7hW7g=;
        b=C4+khcfO3ZOy1skuCfUPsvPr5XmaLkuNpkqLD8xmIzoiW7X/gvphtSFEWVftIR/o2K
         NMilfGrFf8+Kj0iElaYGDGMAv8WkJndO227jxuxf8ARtVU1fZveMjEuoG4Ytmy8hiLhy
         P7PqAfioUciMU99GxE1V3TwDpxVQOp5wR+ED0BoJPNnMhCJiomvkZkECeK8VGxat2pTr
         n74WpDQkY+1DP/2mKpn8IMg2KJk9qgziXJ1At9XK6RNXPtGeI7mnNjP3my6qpyPHZHeR
         IF/N/mlzdwx/QQTZ4EafgezjKPSdYJfRBF4NueW7BpAFGqN84vbGgRoF20FiOwbpKs/3
         s6TA==
X-Gm-Message-State: APzg51BO06MDPbyvejxZzLwj8LPfPeFaY4hIIXW+Ikx94ScpcuARHpvH
        OHwxzU9VoQuRAOKghjDZHHUgLXATw7bQXT4COngEJA==
X-Google-Smtp-Source: ANB0VdblTkmOwR/gqKfEV+p1lfA1++eV3LEKF326POnCloSbRppCttEhggudCboZEQ3F+JIFVcprJXYyIJE5gRsolF4=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr8387126vkd.10.1535701319946;
 Fri, 31 Aug 2018 00:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <9b103c232c73b223ec951994c9789326754ef7a9.1535015050.git.fthain@telegraphics.com.au>
 <CAMuHMdUFss2C_ifNxU7OH_rbY4b9zS-v9P54qAfsjYuiZa8Jiw@mail.gmail.com> <alpine.LNX.2.21.1808311707160.196@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1808311707160.196@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Aug 2018 09:41:48 +0200
Message-ID: <CAMuHMdVY-_ifL9wGgH+aC+9kjxa3i8789Zb_V_Ww3kH_cos3UA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Use correct PMU response format
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Fri, Aug 31, 2018 at 9:12 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Fri, 31 Aug 2018, Geert Uytterhoeven wrote:
> > On Fri, Aug 24, 2018 at 4:02 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > Now that the 68k Mac port has adopted the via-pmu driver, it must decode
> > > the PMU response accordingly otherwise the date and time will be wrong.
> > >
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> >
> > Looks good to me, so I will queue as a fix for v4.19.
> >
>
> Thanks!
>
> > I guess the proper Fixes tag is:
> >
> > Fixes: ebd722275f9cfc67 ("macintosh/via-pmu: Replace via-pmu68k driver
> > with via-pmu driver")
> >
> > Can you please confirm? Thanks!
> >
>
> If you want to add a 'fixes' tag, that would be it. I omitted the tag
> because a -stable tree isn't needed for this. I don't mind either way.

You never know who will backport the original series...

Thanks, applied and queued for v4.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
