Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41977C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E7A218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeLSJjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:39:18 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45838 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:39:17 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so4210632vsh.12;
        Wed, 19 Dec 2018 01:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuCpSMpWIEaYjQlh0UJtISg8gGP4dUwfsuw6wy6uFmw=;
        b=JvypdjZQAfQRU/xxr15TP2QQRuk7Oh5dnGonuaK38P3h+XmCuywzqW2pn8UCduS05t
         IGtP6ojoh0K2WeLA6HqfizoRiAXhAchjpw1FSgTp2+FysatO+ZA7obwz+q6CLR3ELmuN
         HUp+65wFgVuGATauLjhuAP7TPRJh24piGbn1vxNJX93KDabo/bGtjjd8/xQPVP/kI1JL
         l0RVENOh/EfdlezGcco0Lbtm9M+WE64Bf1lxYqUSF+MHstol5LgIGHX5g3eHIi2oknSl
         rcflm0jgQkvgZnx7+c7sOvkvFgGb71pSdAJrdUOpn/dJIeBM7JyY17i7gNdHOexvdw9J
         GLBA==
X-Gm-Message-State: AA+aEWbl3c18DTJDxShvfc8Sh6KhVFF/cd7FDl8juJ5hM+zhWepHk2p9
        CAlcsPVu/O0IaC3GPbR6yCKS3RkT97EyebElgnM=
X-Google-Smtp-Source: AFSGD/XijFguxsVpS8nAuQ/qBpS26KM2u/bsI7OaRhAOaAO3LpAu/iQ3iPUGkeFRZ8K+nBru+5U/MrJaNIDf8FE7tOs=
X-Received: by 2002:a67:c202:: with SMTP id i2mr9058755vsj.11.1545212356638;
 Wed, 19 Dec 2018 01:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com> <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
 <20181218233354.pie5i3lvrrhq5q2c@ninjato>
In-Reply-To: <20181218233354.pie5i3lvrrhq5q2c@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Dec 2018 10:39:05 +0100
Message-ID: <CAMuHMdWH-bh=cfZhxrD6MYfqFUYroai5WbyYZ6+H4MQeubN=PA@mail.gmail.com>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Peter Rosin <peda@axentia.se>, Hans de Goede <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Dec 19, 2018 at 12:34 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > +   unsigned int is_suspended:1;    /* owned by the I2C core */
> >
> > When more stuff is added to this bit field (which always happens at
> > some point) updates to all members of the bit field will have to use
> > the same root-adapter-locking, or we will suffer from RMW-races. So
> > this feels like an invitation for future disaster. Maybe a comment
> > about that to remind our future selves? Or perhaps the bit field
> > should be avoided altogether?
>
> Changed to bool. Thanks!

Does that help, given bool is smaller than the CPUs word size?
Is it Alpha that cannot do atomic operations on bytes?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
