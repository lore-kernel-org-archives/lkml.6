Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEBDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7662080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549622554;
	bh=23fpqr1xFE0go2/8+KOsOEgnM788dpuvqQKOyU0h9xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E7FfV4/GsZyOZ0tCuo4KRH05hBwztCzqH4TN37D2Q1RDtM72HRxWMfryu/3MxSXkb
	 7X7YJI5n0MNTnuKbFVyRgczr3yasYjraXqZ06pWaafDdp3AnHWVShYA9DPn0hW/0iI
	 sSihyRS5N7QkF7MHqWKMqxVQaEEqDAIi2qmgvWGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfBHKmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:42:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39936 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHKmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:42:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so5058623oth.7;
        Fri, 08 Feb 2019 02:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EP9I9wZegAeBvx7ax3FI65LK3eR2rTPkHdcR23z8Omk=;
        b=U8AzMjTVF37rTyOVHUoJy7+WZNulRrei0QFLO698a0nuRGWYzXlQ1Mt1yZo5QAeagu
         PDUDp7vryqiJZpN0R0/JujHHK40xYmrbpcJ1s3AVseWe8zrPulUoDt+LmpdRdPDwlZOL
         XtW+bsGqpM5FeiFt37OcsUdI0h9/dgopwicqhK4prcDoSTPAvhGmdjG+8VbKghhOqEiA
         VldhTzKBNv9umpcxGu8J8ZOtkR15u3KHYhJ+HZ+fbTcSleSRLPnsd4iGuIx6CJWZLcLh
         /58R5Y0SGwLEOPrcJ/FLe48vhEzRwwUjyFXOqB8PNhUzhWWMFXzaX0JrO+QsLqD0/enz
         7KNA==
X-Gm-Message-State: AHQUAuaaXbQwnUGMkyAjh16cheDchA4vcIjPGoOcJVA5BuZ+IWhHEu6J
        Bq6NXhBD/7xS1i/6R+WqwacM2F8pTj4nkfIATsFO/g==
X-Google-Smtp-Source: AHgI3IYVb+rLjv8JEVAlI8qTLDrdHsC9ANp6wvO1nsOP2VqWq19x4y72scBFeYg4VlyhQU5zqL2uy+Yk8GSzpqWJjFs=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr12642451oti.258.1549622551979;
 Fri, 08 Feb 2019 02:42:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com> <20190208103133.ysvaroyniuc3k4i5@vireshk-i7>
In-Reply-To: <20190208103133.ysvaroyniuc3k4i5@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 11:42:20 +0100
Message-ID: <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 11:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 11:22, Rafael J. Wysocki wrote:
> > There are cpufreq driver suspend and resume callbacks, maybe use them?
> >
> > The driver could do the I2C transactions in its suspend/resume
> > callbacks and do nothing in online/offline if those are part of
> > system-wide suspend/resume.
>
> These are per-policy things that we need to do, not sure if driver
> suspend/resume is a good place for that. It is more for a case where
> CPU 0-3 are in one policy and 4-7 in another. Now 1-7 are
> hot-unplugged during system suspend and hotplugged later on. This is
> more like complete removal/addition of devices instead of
> suspend/resume.

No, it isn't.  We don't remove devices on offline.  We migrate stuff
away from them and (opportunistically) power them down.

If this is system suspend, the driver kind of knows that offline will
take place, so it can prepare for it.  Likewise, when online takes
place during system-wide resume, it generally is known that this is
system-wide resume (there is a flag to indicate that in CPU hotplug),
it can be "smart" and avoid accessing suspended devices.  Deferring
the frequency set up until the driver resume time should do the trick
I suppose.
