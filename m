Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF091ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7052064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f69vUUng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7052064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJJBHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:07:18 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44156 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJJBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:07:18 -0400
Received: by mail-vk1-f195.google.com with SMTP id b2-v6so593485vkd.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn+LAQuKpXXAJd1XDrQ9rpJaQnh2Y9vgJgOmoRdmONs=;
        b=f69vUUngqAuZT2J/fTSrHAWbbzo2kellpSItiAQNRttRjT/xha3l+kZ+HSLXCnorba
         X0PJCjorSrXbEFlGdZIssR5LHk/RjHrRW+edoBfTztfLGr4PRHxi3gNK8rkJNSkN/unn
         ydr3kNjCqyJdc2uszJzvIUTZz/skYE4hKeS/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn+LAQuKpXXAJd1XDrQ9rpJaQnh2Y9vgJgOmoRdmONs=;
        b=cpVvgFk6ZGDVnNmaO8j92DvpJGAACLjgNV4f8A419nNArACoqca1Jwf/TkaARhMQTz
         BZ8mipUQrjfM0yei7fQ84iltUJUiNPKpHH2MfDy1mqvlbi24XZtUN/cX3t3aa0q1SxmU
         QCB125eAuekHN0o1INqcmZrFYw0hOHzQH8hDh0VqgSLJ+ztg/TzBuJtNuR0axZQnocwe
         DaVDTVq+1sSrPmJdOKN2Tyggu9wvilDwi1hBZQCJV20Pay7QG/aa1aNwCuqsK07dKoOs
         fDLIM2jpdFY27L9Zg4Bhow/kvSDgjZFJpYvIUHF/Wn3XG94OCgSKYrqa0NOsqXM2Bxrm
         mGMQ==
X-Gm-Message-State: ABuFfoisq8/deqHJltu/OGiCgaUI2audvbo0US5t45enZNNxLwqsA9rP
        WYPY5tpYJisCVLDIpMVd+cOr8zrWhVk=
X-Google-Smtp-Source: ACcGV62ijiKsbyrYO/3BtVc5BjNvcaOOBVFWS2ePIhSlPa0eRa0bGxPecJVKyD1o6EGjLydYdVNlmQ==
X-Received: by 2002:a1f:b215:: with SMTP id b21-v6mr5514176vkf.0.1539107350153;
        Tue, 09 Oct 2018 10:49:10 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id f188-v6sm3223494vke.53.2018.10.09.10.49.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 10:49:08 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id m5so2390232vsk.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:49:08 -0700 (PDT)
X-Received: by 2002:a67:1141:: with SMTP id 62-v6mr10837852vsr.213.1539107347783;
 Tue, 09 Oct 2018 10:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org> <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com> <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
In-Reply-To: <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Oct 2018 10:48:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com>
Message-ID: <CAD=FV=U-ZZQhFKR9kxYnw=F1j+dExrsgFvjabYJ8AVmBDM4eXA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 9, 2018 at 9:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2018-10-08 16:52:36)
> > Hi,
> >
> > On Mon, Oct 8, 2018 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > +       mas->irq = platform_get_irq(pdev, 0);
> > > > +       if (mas->irq < 0) {
> > > > +               ret = mas->irq;
> > > > +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> > > > +               goto spi_geni_probe_runtime_disable;
> > > > +       }
> > >
> > > Nitpick: If you got the irq earlier before allocating anything then nothing has
> > > to be put on failure path.
> >
> > I think this might have been in response to previous feedback from you
> > suggesting that we should get the irq as late as possible.  Ah, here
> > ya go:
> >
> > https://lkml.kernel.org/r/153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com
>
> Yes I suggested we register for the irq as last as possible, but I
> didn't suggest calling platform_get_irq() this late. It could be called
> earlier so that if there isn't any irq then nothing to do besides return
> failure.

Ah, you're suggesting separating the platform_get_irq() and the
request_irq() so that we call platform_get_irq() as the first thing in
the function but don't do the request_irq() until later.  Yeah, that
could be done and I guess if you feel strongly about it I wouldn't
object to the change, but I don't feel it buys us a lot and I kind of
like keeping the two next to each other.  Specifically why I don't
think it buys us a lot:

1. You still need the "dev_err" print, right?  platform_get_irq()
doesn't automatically print errors for you I think.

2. You now need a local variable "irq".  By putting the
platform_get_irq() before the memory allocation you now can't store it
directly in mas->irq.  We could try using "ret" as a temporary
variable but that seems worse in this case since it'd be a bit
fragile.

3. You don't get rid of any error labels / error handling so we don't
really save any code

When I tried this my diffstat says 8 lines added and 7 removed, so a
net increase in LOC FWIW.  I'm relying in gmail so my patch will be
whitespace-damaged (sigh), but you can find a clean one at:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/e0325d618e209c22379e3a4269c14627b19243a8%5E%21/#F0

...the basic idea is this though:

@@ -543,6 +543,13 @@
   struct spi_geni_master *mas;
   struct resource *res;
   struct geni_se *se;
+  int irq;
+
+  irq = platform_get_irq(pdev, 0);
+  if (irq < 0) {
+    dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+    return irq;
+  }

   spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
   if (!spi)
@@ -553,6 +560,7 @@
   mas->dev = &pdev->dev;
   mas->se.dev = &pdev->dev;
   mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
+  mas->irq = irq;
   se = &mas->se;

   spi->bus_num = -1;
@@ -589,13 +597,6 @@
   if (ret)
     goto spi_geni_probe_runtime_disable;

-  mas->irq = platform_get_irq(pdev, 0);
-  if (mas->irq < 0) {
-    ret = mas->irq;
-    dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
-    goto spi_geni_probe_runtime_disable;
-  }
-
   ret = request_irq(mas->irq, geni_spi_isr,
       IRQF_TRIGGER_HIGH, "spi_geni", spi);
   if (ret)


-Doug
