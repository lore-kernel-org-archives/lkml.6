Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B061820879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 23:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne3Vq7E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B061820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeI3GUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 02:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeI3GUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 02:20:24 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43A6520895;
        Sat, 29 Sep 2018 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538264996;
        bh=K+Kjgwa3ujL/hQTNqUPRv2o3gKjqYCnFMztaLDhbPrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ne3Vq7E24sLQ+C4wARCAntj7eoVwOMgWCLUf5qr/lCFvhBU4OMVy2VDr8n26fMp30
         kHkiTdaasznRS1l5HlmBjcWTqXNLcLbh3mNumwJlY6WK7zAuMR0RZjD7/uxNXp2hAO
         WjgNTwMtg/rEzbX5XqpEjBGRwqrxGMfS7mfNDBT8=
Received: by mail-qk1-f170.google.com with SMTP id 204-v6so5406927qkd.5;
        Sat, 29 Sep 2018 16:49:56 -0700 (PDT)
X-Gm-Message-State: ABuFfojcnkEVAmvWx49eXZae3ar3jYtyhdbnmP0xKe7SzxZEi+zvq+ov
        /Mp4eZ2ihiEVE4AIufKYgaZNCP5L/joquPFOsA==
X-Google-Smtp-Source: ACcGV63Cc9qw/2srwM3W6umFJNJBHTzubhWy2IBd65PZAoAF2+68ZTwgtdj3kQXFW4Cq2vh8bGZ1nkPnSMUgr9B0YGQ=
X-Received: by 2002:a37:56c7:: with SMTP id k190-v6mr3405755qkb.29.1538264995367;
 Sat, 29 Sep 2018 16:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com> <20180922160523.16b399fc@archlinux>
 <20180926224618.GA32126@bogus> <20180928093618.GA24536@Eros>
 <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com> <20180929121034.6c5e5826@archlinux>
In-Reply-To: <20180929121034.6c5e5826@archlinux>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 29 Sep 2018 18:49:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLNGua++ESBgf5qSqoLdLwq8awyFr29pYR=JVBOwX3eAg@mail.gmail.com>
Message-ID: <CAL_JsqLNGua++ESBgf5qSqoLdLwq8awyFr29pYR=JVBOwX3eAg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Song Qiang <songqiang1304521@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 6:10 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 28 Sep 2018 18:52:13 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Fri, Sep 28, 2018 at 4:36 AM Song Qiang <songqiang1304521@gmail.com> wrote:
> > >
> > > On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
> > > > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> > > > > On Tue, 18 Sep 2018 16:24:22 +0800
> > > > > Song Qiang <songqiang1304521@gmail.com> wrote:
> > > > >
> > > > > > The first version of this driver issues a measuring request and polling
> > > > > > for a status register in the device for measuring completes.
> > > > > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > > > > indicate that new measurement is ready. This patch adds support for
> > > > > > using this mechanisim to reduce cpu cost.
> > > > > >
> > > > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > > > > Hi Song.
> > > > >
> > > > > Looks correct in principal but a few things to tidy up before
> > > > > this is ready to apply.
> > > > >
> > > > > Also we have an unrelated change in here to check the devices ID.
> > > > > That should be in it's own patch.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Jonathan
> > > > > > ---
> > > > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
> > > >
> > > > This should have been split with the complete binding in one patch
> > > > rather than piecemeal driver feature by feature.
> > > >
> > >
> > > Hi Rob,
>
> Hi Rob, Song,
>
> > >
> > > A few days ago when I was submitting this driver, I didn't do it very
> > > well, the function of this driver is limited. I added interrupt support
> > > the next day after you acked my first patch. I thought it's not polite
> > > to add something after someone acked that patch, so I send the interrupt
> > > support as a second patch. The first patch is merged to togreg now, but
> > > this doesn't. I don't know when can I add new functions to the code that
> > > just merged to togreg branch, could you offer some suggestions?
> >
> > You just needed to state why you didn't add a ack. But really, just
> > don't send things except as RFC until they are "done".
>
> The RFC bit actually disagree on.  This driver could be considered 'done'
> with just patch 1.  The driver worked, it was useful. When the early
> versions of that patch came out Song had no idea how much work it would
> be to add interrupt support.  As it turns out it was simple - it often isn't :(

I meant specifically in the context of this getting revised within a
number of days. I agree that drivers don't have to be complete, but
bindings should be as complete as possible. You can't foresee
everything, but I don't think that applies in this case.

> > What to do next depends on Jonathan and whether he wants a follow-up
> > patch or he will drop the first one.
>
> Yeah. I should have picked up on the binding in the second patch and merged
> it.  I'd seen the first patch a few times before so was happy with it and
> applied before actually looking at the second.
>
> If they had come in separate series in my view the partial binding then
> extend with 'optional' elements is fine.  The number of times I've discovered
> issues with documentation of hardware that would have made any binding written
> from the docs wrong is non trivial. So in my view it is always a gamble to
> write bindings until you have tested they work.  I have not problem with
> people who are confident and want to add them from the start though.

Well, if they were broken is some way, I don't think backwards
compatibility matters and we can still fix things. I'm not talking
about complex cases here. It is pretty trivial to determine whether a
device has an interrupt or not.

>
> Obviously this only works for optional elements.
>
> So follow up patch for 'optional' stuff is fine by me.  The only real
> issue to my mind here is that they were in the same series, so we should
> have seen a separate precursor patch giving the binding for all of it.

Certainly, that can't be avoided sometimes and is fine. It's really
the time frame for this particular case and reviewer bandwidth.

Rob
