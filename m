Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9D422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9D422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeKNTkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:40:21 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43825 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:40:21 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so9082365vsc.10;
        Wed, 14 Nov 2018 01:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2D/532f6U7JNqc01EFV7GEaHY5+uaSp0bTtF+9ijWDg=;
        b=T7S7mXOk1LRMxEk9yigE13sjvQT+5Jf/T/qyLJTrB6Ih7shP/MGRBM9gKkp9HgrtaJ
         t75QMBfAnRevNK9bbutmZiov7by2EkRZLJOQS10ekOZ28uAILyLHCP3/WPdk2Ajvm0PF
         +IOPi5molT+5GqIxV50xvkn0pqS/l6LFPBUNJe+DKM1htk2is3VS1sE/uLHIvTXfGcrP
         7Eik17HodNv87hkW1d3cHXdTdRzSagRgfK25EUE/qzXgQEX78us6CJjiNqVcuzAmqrtJ
         MCDk3NvbyZkm3fv81BtipZHq9n/xBobJMAO2o7gN/aDmfT5nT5rr+6vbimFTFSFSCCt+
         znMw==
X-Gm-Message-State: AGRZ1gJ4HbYkc02PfO/OwZUiUoehIa4qkV/mvD2PHgiLyvdC0jQa8JlS
        VoICXRkl/cxf+49HkmZY2gmSYVl5mRiwcWQntPKvLw==
X-Google-Smtp-Source: AJdET5dbUjnJt4z5B1T3oULeARm0sRcpnK9P3PuHLgKD7JZsJ6YNrmt+zDQB44LIQAg+ooywqBBiMqxE0Wnck7RrMYk=
X-Received: by 2002:a67:c202:: with SMTP id i2mr430246vsj.11.1542188272259;
 Wed, 14 Nov 2018 01:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20181113124744.7769-1-geert+renesas@glider.be>
 <1090034354.41357.1542177021922@webmail.strato.com> <CAMuHMdV=1GL43ogU3PO6u8x6f2gX-vdgBVON2+t+1QUJtj=Tkg@mail.gmail.com>
 <1542187561.4095.1.camel@pengutronix.de>
In-Reply-To: <1542187561.4095.1.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Nov 2018 10:37:40 +0100
Message-ID: <CAMuHMdXyud10A0mv0VeV+o1jJH8K012rGztD0vi26aFg4ZzxYA@mail.gmail.com>
Subject: Re: [PATCH] reset: Add reset_control_get_count()
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     uli@fpond.eu, Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Wed, Nov 14, 2018 at 10:26 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Wed, 2018-11-14 at 09:58 +0100, Geert Uytterhoeven wrote:
> > On Wed, Nov 14, 2018 at 7:30 AM Ulrich Hecht <uli@fpond.eu> wrote:
> > > On November 13, 2018 at 1:47 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > > Currently the reset core has internal support for counting the number of
> > > > resets for a device described in DT.  Generalize this to devices using
> > > > lookup resets, and export it for public use.
> > > >
> > > > This will be used by generic drivers that need to be sure a device is
> > > > controlled by a single, dedicated reset line (e.g. vfio-platform).
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > > > --- a/drivers/reset/core.c
> > > > +++ b/drivers/reset/core.c
> > > > +/**
> > > > + * of_reset_control_get_count - Count number of resets available with a device
> > >
> > > Should be "reset_control_get_count", without of_ prefix.
> >
> > Oops, thanks for catching!
> >
> > Philipp: Do you want a v2 or incremental, or can you fix it up yourself?
>
> No need, I'll fix it up.

Thanks, and sorry for the typo.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
