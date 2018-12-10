Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE4AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56E208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544432668;
	bh=6nJCV0p1SzV+2m+6UNT0mULOt4p07SHbB9dSjJ+VNwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tiFzVNjB5RHR67C5qjwC0iizNGKzIKEeQv20CK8Mg9xOxMJjp2ZtZbTRCFRm2doDr
	 FgqWb6r8/DVvhKirm/l2PudtxuBVh1GEP80l7n82iYrct64VvA47J82RIQyiou/+32
	 TihN9o08QzbwpLcoQvvIEZ5VZv4OEOC4oID1NN3k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA56E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeLJJE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:04:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46675 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeLJJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:04:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so9638764otm.13;
        Mon, 10 Dec 2018 01:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZGCtl0s42CEQU4yKwqXBNJBWb6cemdDrQzpSV1gBDA=;
        b=bD87PoaVK7/uj+tgku9n3oyyva3pe9ot/ibWiWBnnb4e4BuOtemWfH3fi7JtIjXED4
         BWS2YdA6lWnDGM3wJGKeyb3FzZF9T4rj2sQgVQLW6yUAVQMNAQ6K31oSDqLuEFHcqT7x
         mSSDL5KVrSqlAZNyGk/fN1Fk87uiX8hRSQKfORUZhZBUyH142KuaYBvgFOyX0twNfdKF
         zgNThSl8kHhGtuaoXSidEQWp1nTYg5jAbsiMJFm5z9B7UkWCE1gZW5O2JDdo0Vl5huv+
         nfERk1Ydjz2gZ1mRB/NtCdM9+UccCfA7qXlaaPuFPDSLNw8syf7P65a/pn9ACg+4OQIu
         m1XQ==
X-Gm-Message-State: AA+aEWYT4jpccYgOKT/H+XfEa21QHp3BB2RzVLcqzngkIBk2HgPjfZ6h
        8wcLElqdT0ijiqVy9gFsbloHY/qOH5vVvZ7l0wQ=
X-Google-Smtp-Source: AFSGD/XMrN+ZNiu+5/9BaKlMFVsJ9gKo2Ptl5fpkQsAXDBdepuHeiZLtqINJ9PaLN6JxPFwHqtON3h2IbPPafGDBaMk=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr7720286otn.200.1544432665576;
 Mon, 10 Dec 2018 01:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com> <20181206145547.GA7884@kroah.com>
In-Reply-To: <20181206145547.GA7884@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Dec 2018 10:04:14 +0100
Message-ID: <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     evgreen@chromium.org, Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        bjorn.andersson@linaro.org,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, maxime.ripard@bootlin.com,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> > On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> > >
> > > Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> > > graphics, modem). These cores are talking to each other and can generate a
> > > lot of data flowing through the on-chip interconnects. These interconnect
> > > buses could form different topologies such as crossbar, point to point buses,
> > > hierarchical buses or use the network-on-chip concept.
> > >
> > > These buses have been sized usually to handle use cases with high data
> > > throughput but it is not necessary all the time and consume a lot of power.
> > > Furthermore, the priority between masters can vary depending on the running
> > > use case like video playback or CPU intensive tasks.
> > >
> > > Having an API to control the requirement of the system in terms of bandwidth
> > > and QoS, so we can adapt the interconnect configuration to match those by
> > > scaling the frequencies, setting link priority and tuning QoS parameters.
> > > This configuration can be a static, one-time operation done at boot for some
> > > platforms or a dynamic set of operations that happen at run-time.
> > >
> > > This patchset introduce a new API to get the requirement and configure the
> > > interconnect buses across the entire chipset to fit with the current demand.
> > > The API is NOT for changing the performance of the endpoint devices, but only
> > > the interconnect path in between them.
> >
> > For what it's worth, we are ready to land this in Chrome OS. I think
> > this series has been very well discussed and reviewed, hasn't changed
> > much in the last few spins, and is in good enough shape to use as a
> > base for future patches. Georgi's also done a great job reaching out
> > to other SoC vendors, and there appears to be enough consensus that
> > this framework will be usable by more than just Qualcomm. There are
> > also several drivers out on the list trying to add patches to use this
> > framework, with more to come, so it made sense (to us) to get this
> > base framework nailed down. In my experiments this is an important
> > piece of the overall power management story, especially on systems
> > that are mostly idle.
> >
> > I'll continue to track changes to this series and we will ultimately
> > reconcile with whatever happens upstream, but I thought it was worth
> > sending this note to express our "thumbs up" towards this framework.
>
> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
> it to the tree if all looks good.

I'm honestly not sure if it is ready yet.

New versions are coming on and on, which may make such an impression,
but we had some discussion on it at the LPC and some serious questions
were asked during it, for instance regarding the DT binding introduced
here.  I'm not sure how this particular issue has been addressed here,
for example.

Thanks,
Rafael
