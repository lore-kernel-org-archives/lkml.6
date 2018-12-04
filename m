Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410422081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL1vk9Gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410422081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLDPla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:41:30 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44849 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:41:29 -0500
Received: by mail-yb1-f195.google.com with SMTP id j145so2104268ybg.11;
        Tue, 04 Dec 2018 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xgcnniEi3cakcE727WvELEsEGC4aDPm4MmIpgNfpB58=;
        b=sL1vk9Gy/RJ68XGyR3+kq4O4zlNFry/zuM4a81P6mxQIebk6cxBHwPw0ujh1tliHYN
         45+4kpnfnnHb3V9L2lqCPyVElOAQ4nc5zluJPu/f7rbbrUuR73FTtrRngxZubOr8KgIP
         GOy+rHUYERYCLJb/IpcxCBfhv1UnoCCSZQjzg36y1cy2QAuXTxayyD0ld+4Qj0qTl6At
         i7545xT3hxU1JYBR2t0Z6f/xffSlcUOTPwePvEeMO6YiKY476XnnbrsMBCb8TyfUTcBS
         zemK5QvKglvaQkvRfqDErEjehwqF7i4OLBexMAcDGotr7Bl+1h62Woy0EOpAXBkf1i4z
         JTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xgcnniEi3cakcE727WvELEsEGC4aDPm4MmIpgNfpB58=;
        b=VtUhPcdfah/QN9Oo3Q/30U9fpwufyRtFNtAhK1QUAPX0uKn5BpCPdM+SlNkFq3CIrD
         vhpeQvxKukperZn+hat72XtJzzfg5sR2c55pIM3i1OZDx0VKZtHJugeADuKStx0wXvmc
         TWMHhXAlGXN2zkk1LcmzAHQv1pNrl84cuC288OAQ8CYN3tXcrssjE/P9XMA9RWtDZ/Lu
         jSjHAZqFruSm6kJDwOIRfRz9FH+BMBt1HR9R7A7BKY8BQD50LdMelOcYnSvoPjGSVBqX
         qVoPKncGIG0YY8mzyw3PP4dpb960ZAPcXE3kbpu/UTYdnSrrMQ/2UtiYiTFrYwBrqFSG
         y1gA==
X-Gm-Message-State: AA+aEWYznQNTUQeRMTXvi2LU/9YFu4fJeToV7BQ6h3FOYJCg339kOp2Z
        QfUcNe5LpwpPp3bc3J0Umw==
X-Google-Smtp-Source: AFSGD/XxBmmLIV7flljLMZ9s/H2Ypp8fV2ZOvHr24mISarWSNFj/Ye6zUno7DICdd9mJDdkFlOzpoQ==
X-Received: by 2002:a25:f608:: with SMTP id t8-v6mr19330159ybd.522.1543938087904;
        Tue, 04 Dec 2018 07:41:27 -0800 (PST)
Received: from 960 ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id i13sm4935496ywe.53.2018.12.04.07.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:41:27 -0800 (PST)
Message-ID: <c1345856d250351a5d8e81bb723ce5ac26ff8dd5.camel@gmail.com>
Subject: Re: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Tue, 04 Dec 2018 10:41:26 -0500
In-Reply-To: <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
         <20181203185344.3521-3-ayman.bagabas@gmail.com>
         <s5h8t16jut7.wl-tiwai@suse.de>
         <CAHp75VcqiKaWYwMGJcehE9RAC56GExdK5skky2S-eUPs+ekgaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 21:17 +0200, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 9:04 PM Takashi Iwai <tiwai@suse.de> wrote:
> > On Mon, 03 Dec 2018 19:53:39 +0100,
> > Ayman Bagabas wrote:
> > > +     if (code == 0x80) {
> > > +             acpi_status status;
> > > +             acpi_handle handle;
> > > +             unsigned long long result;
> > > +             union acpi_object args[1];
> > > +             struct acpi_object_list arg_list = {
> > > +                     .pointer = args,
> > > +                     .count = ARRAY_SIZE(args),
> > > +             };
> > > +
> > > +             args[0].type = ACPI_TYPE_INTEGER;
> > > +             args[0].integer.value = 0;
> > > +
> > > +             status = acpi_get_handle(NULL, "\\WMI0", &handle);
> > > +             if (ACPI_FAILURE(status)) {
> > > +                     dev_err(&wdev->dev, "Unable to get ACPI
> > > handle\n");
> > > +                     return;
> > > +             }
> > > +
> > > +             status = acpi_evaluate_integer(NULL, "WQ00",
> > > &arg_list, &result);
> > 
> > I guess you need to pass handle here?  In the earlier version, you
> > passed \\WMI0.WQ00, so it worked with NULL handle.  But now it's no
> > longer so...
> 
> I think in this case we don't need to have a separate call to get
> handle and try to get integer directly. In either we will have an
> error case if method  / namespace / etc is not found.

Agree.

> 
> > Other than that, it looks OK to me.
> >   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks.

> > 
> > But, you don't need to rush too much.  Instead, better to test your
> > own patches and make sure that they really work before submitting
> > the
> > final version.
> 
> Yes, I will wait couple of days for v10 in hope it will be tested
> carefully.

You're right, I will test it more and make sure everything work as
expected.

> 

