Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDF5208E6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQyN4kcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDF5208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933582AbeGJOZf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933248AbeGJOZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:25:33 -0400
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com [209.85.223.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8055D208EB;
        Tue, 10 Jul 2018 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531232732;
        bh=WlMdukPgFwSkuWWb8wrENR4MzxrTG+/bptYqAKYZJoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQyN4kcMIEI/9YXiusuhuZpPS59iKY5Vl3zVy7VOdPCQRHasDxCMTuQEa2xWg7Dnl
         BOMjYfPvUoO0qdNUaQEYCeSNKuu0uHUNBi4w/CZ1WCDaZB4hyYw8drb4foADFv4mhl
         xIMBh+yDr9cOsmVUAbYFgfnoTsOOs1LQlRsUvrRs=
Received: by mail-io0-f172.google.com with SMTP id z19-v6so20528360ioh.4;
        Tue, 10 Jul 2018 07:25:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlG+7QZ83j4ZILtDWps/tmbfn+onXRGgZQbuRSK2wPMttCIPHTtG
        +jJPpxz6h1jVg8+5OaFnaL/TH6cqAO3L7pvC6w==
X-Google-Smtp-Source: AAOMgpfjucOjF5ncQnx7sjhgeGeoS1jHUQmRc52RnEQpRSohuKIDk/l2zhmZukoQZuo9xQCBznR2Dmq/jhn6aNctRb4=
X-Received: by 2002:a6b:6403:: with SMTP id t3-v6mr22075554iog.111.1531232731831;
 Tue, 10 Jul 2018 07:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180709154153.15742-1-robh@kernel.org> <20180709154153.15742-7-robh@kernel.org>
 <CAPDyKFoN1=16dGKmkFp6Khgs5zx+BguOs3qOcm+rAZw=b38JVg@mail.gmail.com>
In-Reply-To: <CAPDyKFoN1=16dGKmkFp6Khgs5zx+BguOs3qOcm+rAZw=b38JVg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Jul 2018 08:25:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dcwZHKFGy+BGOyV+Yyz0qgmeq8zoT=DkB+c+DsXdApQ@mail.gmail.com>
Message-ID: <CAL_Jsq+dcwZHKFGy+BGOyV+Yyz0qgmeq8zoT=DkB+c+DsXdApQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] PM / Domains: Stop deferring probe at the end of initcall
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 9 July 2018 at 17:41, Rob Herring <robh@kernel.org> wrote:
> > All PM domain drivers must be built-in (at least those using DT), so
> > there is no point deferring probe after initcalls are done. Continuing
> > to defer probe may prevent booting successfully even if managing PM
> > domains is not required. This can happen if the user failed to enable
> > the driver or if power-domains are added to a platform's DT, but there
> > is not yet a driver (e.g. a new DTB with an old kernel).
> >
> > Call the driver core function driver_deferred_probe_check_init_done()
> > instead of just returning -EPROBE_DEFER to stop deferring probe when
> > initcalls are done.
> >
> > Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v4:
> >  - Add Rafael's ack
> >
> > v3:
> >   - Update to new function name
> >
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 4925af5c4cf0..8c12213875c6 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> >                 mutex_unlock(&gpd_list_lock);
> >                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >                         __func__, PTR_ERR(pd));
> > -               return -EPROBE_DEFER;
> > +               return driver_deferred_probe_check_state(dev);
> >         }
>
> This isn't the only error path where -EPROBE_DEFER may be returned
> during attach in genpd.

Yes, but I think this is the only place you can fail to get the PD
device from DT. The case we care about is properties exist in the DT,
but no driver exists.

What would cause deferring in the latter cases?

Rob
