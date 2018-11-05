Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37648C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E948C2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fT4erdXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E948C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbeKFF5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:57:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42775 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKFF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:57:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so7165975lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FZ8s5aKfDwlJNdJcWlLAE6LArb1N5yIZ0EC2lmcFmEA=;
        b=fT4erdXnzB1k2faJbI790n7K8zvw8KODz+eTUaZqZudgsD4ggtWIWBfRu5X/Rkf/xI
         dQF319VN+RSIw9S4IWEdhlbFC8HykAXzvAi56yjZmNbLxqTLD6bu55yp4moAf2Ji5Gbr
         x9BihZZnavzq/EL5y71DjFe/imZBoXWVlMZcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FZ8s5aKfDwlJNdJcWlLAE6LArb1N5yIZ0EC2lmcFmEA=;
        b=smGWg7lHGXj3YBW0eGH7fPPB/nOI2a76y1FiJPD8XzURZHGaF1Bq5+TBUkbAOvAZ3f
         iNIX1Pzx/BrOhBHtzcf7g0Se1KloEsN4CHC6iKxM+vsIb8RwRD73w2T6jgCwMrPCLsTP
         gPpYqsagC3tdlqVm+oqPrL2Ic2OGSZ9qfMiDS1V++jJO999IH/k0618i/ajARPLdU8tF
         aVJh+lUpwUMx1P0F0GRT35MtkgABj7w3Ou40MBifN6AMsI/K4C3x7MDKob8ij2K2AtZ6
         yiKVta3Ibg6bXgu7EjG1ul49sjAqRrMJu1s4e4bsy/LEG85hWN1U2eShk3iTEOUVauVl
         XFJg==
X-Gm-Message-State: AGRZ1gKenGeyG3LbboIbOhYkSGpqS42Nvj0xt1YRUoZMnu3CF3DMjI/2
        /413+CZrsxRYIVT6zD2hC/DB+9rZLnc=
X-Google-Smtp-Source: AJdET5cP66rQoR/YTS1VEnAlkTWFtopYDMDo9F9SarzhqykGtXIkas8xXoM4xvHgcqHUrISGQy2SCA==
X-Received: by 2002:a19:c396:: with SMTP id t144mr13202251lff.110.1541450148882;
        Mon, 05 Nov 2018 12:35:48 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 26-v6sm6153332lje.18.2018.11.05.12.35.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:35:48 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id v5so2186116lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 12:35:47 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr14111322lfa.135.1541450146877;
 Mon, 05 Nov 2018 12:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <1540943443.196084.131.camel@acm.org>
 <CAE=gft4xwXuJ=aHbF08SxFxtSRX_6KBzPHxCCMbA6F7RnGQ8jA@mail.gmail.com>
 <CAPUE2uuhfk7kstwO2kp_Rs=9QQPgGQGY+QqR76zpZpTkKp5Mig@mail.gmail.com> <1541174532.196084.146.camel@acm.org>
In-Reply-To: <1541174532.196084.146.camel@acm.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 5 Nov 2018 12:35:09 -0800
X-Gmail-Original-Message-ID: <CAE=gft4pdgmfdE4N7W1TeKQxJpexxasbx2spzBOQQbx6JwusZQ@mail.gmail.com>
Message-ID: <CAE=gft4pdgmfdE4N7W1TeKQxJpexxasbx2spzBOQQbx6JwusZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
To:     bvanassche@acm.org
Cc:     Gwendal Grignou <gwendal@chromium.org>, axboe@kernel.dk,
        asavery@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 9:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2018-11-01 at 15:44 -0700, Gwendal Grignou wrote:
> > On Thu, Nov 1, 2018 at 11:15 AM Evan Green <evgreen@chromium.org> wrote:
> > >
> > > On Tue, Oct 30, 2018 at 4:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > > >
> > > > On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
> > > > > This series addresses some errors seen when using the loop
> > > > > device directly backed by a block device. The first change plumbs
> > > > > out the correct error message, and the second change prevents the
> > > > > error from occurring in many cases.
> > > >
> > > > Hi Evan,
> > > >
> > > > Can you provide some information about the use case? Why do you think that
> > > > it would be useful to support backing a loop device by a block device? Why
> > > > to use the loop driver instead of dm-linear for this use case?
> > > >
> > >
> > > Hi Bart,
> > > In our case, the Chrome OS installer uses the loop device to map
> > > slices of the disk that will ultimately represent partitions [1]. I
> > > believe it has been doing install this way for a very long time, and
> > > has been working well. It actually continues to work, but on block
> > > devices that don't support discard operations, things are a tiny bit
> > > bumpy. This series is meant to smooth out those bumps. As far as I
> > > knew this was a supported scenario.
> > >
> > > -Evan
> > > [1] https://chromium.googlesource.com/chromiumos/platform/installer/+/master/chromeos-install
> >
> > The code has moved to
> > https://chromium.googlesource.com/chromiumos/platform2/+/master/installer/chromeos-install
> > but the idea is the same. We create a loop device to abstract the
> > persistent destination. The destination can be a block device or a
> > file. The later case is used for creating master images to be flashed
> > on memory chip before soldering on the production line.
> > It is handy when the final device is 4K block aligned but the builder
> > is using 512b block aligned device, we can mount a device over a file
> > that will behave like the real device we will flash the image on.
>
> Hi Evan and Gwendal,
>
> Since this is a new use case for the loop driver you may want to add a test
> for this use case to the blktests project. Many block layer contributors run
> these tests to verify their own block layer changes. Contributing a blktests
> test for this new use case will make it easier for others to verify that
> their changes do not break your use case.
>

Good idea. Thanks Bart.

> Bart.
