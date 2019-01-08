Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B771C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1215E20661
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J/OKHInW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfAHXz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:55:58 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39524 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfAHXz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:55:57 -0500
Received: by mail-vk1-f195.google.com with SMTP id s184so1286138vkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1d7kvfyQjpYlDnRDcTNxvOWfIXsTE/6Wx43wfl7W3g=;
        b=J/OKHInWaowlLNK667YQYNdPnWnowa2zjcfLn42grgsD2x0BoGU2A1g+oaCymVBG9t
         I5Djr84efZ+6jAD0cUuDIbHSkf/deF5a1G5PgmUvgHjAcn/jWiLH5QBIPwaVX/Ig0UUW
         2ojcnt7E2ENbcbi3h1jfKLvAYr7JMrLEqiUzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1d7kvfyQjpYlDnRDcTNxvOWfIXsTE/6Wx43wfl7W3g=;
        b=Gg4SdXzQ0h9MddK806aFDBP33c9ih5h74/i9C83wA9OY7y6l2JO8644fq3cGqixmGk
         kIyLqDQduiCnxwvx30YUGBQQ8YfEUI7yE9EcVm/mR75PSBHrcQkaCtFpvpwX7UYhwOeD
         az0vM08r4cI1wbG4Wmmgxx5FyMxSc9ZHAhuyN1zZFGdvPPhF0H9UnyxjLON44YR9Nj/k
         5di33FrPrfSird/Ck3YUlqudd+EegDnfwBxEAosK1hWua5GulbmSV2k/0NuFjPqoNGzB
         8NioOz1EyVJZouzNg4qysrqnmTWUQD0Mo/YSDk4J6RBlGhwvFTbJe/LpKX/yfKxQyId2
         8eXA==
X-Gm-Message-State: AJcUukdDWLH2lDFIXbnRA7h+7GA6ZMAqMavtGzaNe48Bk87bL5qu8EYu
        1dgi8TzhqjKLjECJOpjF1YudQjiuNtk=
X-Google-Smtp-Source: ALg8bN4yO7Vn7yg1CN0t1LjijTKicTG/dzCFfXlh8CNcvC0Wgo89ENy8bLfmIIeFqmABgZzHlUEz7g==
X-Received: by 2002:a1f:490:: with SMTP id 138mr1402210vke.48.1546991756255;
        Tue, 08 Jan 2019 15:55:56 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id l197sm16677349vke.18.2019.01.08.15.55.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:55:55 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id y14so1295735vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:55:55 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr1313566vkh.92.1546991754708;
 Tue, 08 Jan 2019 15:55:54 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
 <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
 <CAGXu5j+z_yRPgE0HO=Sjo_VwwDDPJ+VLxbxwKgbb2cUAB5jmwg@mail.gmail.com> <CAPcyv4jhFGMzBrWHS_9q0Fe2MersRXz31VG3H2dJfujx1CJGhQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jhFGMzBrWHS_9q0Fe2MersRXz31VG3H2dJfujx1CJGhQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:55:42 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKrhvUduv_XUYF94YM=bBfPGNkPrZ_EkvRKB0pDY_6uOw@mail.gmail.com>
Message-ID: <CAGXu5jKrhvUduv_XUYF94YM=bBfPGNkPrZ_EkvRKB0pDY_6uOw@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Jan 8, 2019 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jan 8, 2019 at 3:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > Ah, thanks for the report! The key difference is that you don't define
> > > a "label area", so the driver bails out early and never initializes
> > > the security state.
> > >
> > > This should fix it up.
> > >
> > > diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> > > index 4890310df874..636cdb06ee17 100644
> > > --- a/drivers/nvdimm/dimm_devs.c
> > > +++ b/drivers/nvdimm/dimm_devs.c
> > > @@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
> > > *kobj, struct attribute *a, int n)
> > >
> > >         if (a != &dev_attr_security.attr)
> > >                 return a->mode;
> > > -       if (nvdimm->sec.state < 0)
> > > +       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
> > >                 return 0;
> > >         /* Are there any state mutation ops? */
> > >         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
> >
> > Okay, cool. I wasn't sure if that test needed a deeper check. :)
> >
> > Fixes: 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
> > support to Intel nvdimm")
> > Tested-by: Kees Cook <keescook@chromium.org>
> >
>
> Actually, looking closer this should have been avoided by the fact
> that __nvdimm_create() initializes the security state early and that
> nvdimm->sec.state should have saved us.
>
> I'll dig a bit deeper with your qemu config.

Maybe something goes weird with pstore stealing the region?

-- 
Kees Cook
