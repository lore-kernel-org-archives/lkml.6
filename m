Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B320C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FE7214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FE7214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeLFIWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:22:37 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37201 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeLFIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:22:37 -0500
Received: by mail-vs1-f68.google.com with SMTP id h18so13793192vsj.4;
        Thu, 06 Dec 2018 00:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyMpN9L9fxIZFHpAuON/WqfSYnIuPqCZgtnI350Cz2w=;
        b=faHdKBERx3IX+hOcaLymRgO1H05gyPZwTLoiqm03FUWJo1OJs4jqIeiMgvMcFSPwX/
         NnSzAcddl+1f9Vk4xkFlFZL8yghssuoI921oIgE2KrEcgN3dN9OiOdMGSnJQYpAD8aS9
         u7+6lExwxT0SKMLsfrhTeoDx2cdnX6mav87L5AOlUCSbT4CLP1xDqgyTqLtmm1sKCdgr
         vFrBy6GJkegJDiJTzglBB025naWFJoqnRxhxcbfQF/BFxCRefx+SZsMKNYU1451HhNyH
         /OWfjh0b8pMnSrxXwANEJxvRsdjplA65p5mjH8q7hQMOutdkMBcnBjuk3fOwy6aECPwe
         2lGw==
X-Gm-Message-State: AA+aEWbDyMA3H0rD4oNPkxzKRVEgjpMm7en/Ho6zh7lq1QrmMjxyV28Y
        yJ5bxaCk4Xj3vLz6I+JcDOwzo+tPEC30s+mEYLM=
X-Google-Smtp-Source: AFSGD/UeOYPQDfJDtBk/6P1aAinS5os4YNjdhl88nRtCI39jJQcr5u1nbGyiR5jZD/utku6vjnxn65NTR+oO41y9wxc=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr12454908vsm.152.1544084555910;
 Thu, 06 Dec 2018 00:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20181205153945.13767-1-geert+renesas@glider.be>
 <20181205153945.13767-5-geert+renesas@glider.be> <20181205212112.2ls6ta27ok3yiyco@verge.net.au>
In-Reply-To: <20181205212112.2ls6ta27ok3yiyco@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 09:22:24 +0100
Message-ID: <CAMuHMdW9kt3QyoJRkKA6c8OpCB7N-jEAo=qcxjhmy3nD2a0A9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] soc: renesas: rcar-sysc: Fix power domain control
 after system resume
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Wed, Dec 5, 2018 at 10:21 PM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Dec 05, 2018 at 04:39:45PM +0100, Geert Uytterhoeven wrote:
> > To control power to a power domain, the System Controller (SYSC) needs
> > the corresponding interrupt source to be enabled, but masked, to prevent
> > the CPU from receiving it.
> >
> > Currently this is handled in the driver's probe() routine, and set up
> > for every domain present, even if it will not be controlled directly by
> > SYSC (CPU domains are powered through the APMU on R-Car Gen2 and later).
> >
> > On R-Car Gen3, PSCI powers down the SoC during system suspend, thus
> > loosing any configured interrupt state.  Hence after system resume, power
> > domains not controlled through the APMU (e.g. A3IR, A3VC, A3VP) fail to
> > power up.
>
> I corrected the spelling of losing when applying this patch.

Checkpatch complained about that as well, so I did some investigation, and
decided to keep it... Was I wrong?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
