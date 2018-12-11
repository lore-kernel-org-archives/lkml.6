Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639C3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8B82084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544511494;
	bh=6zcVvbr8JGU5yyY++Zj7+SSmlt6zOr8mHaWHy7ty/NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MStIF7w7sIK2CDattwYcJ/fhgWWI6i8qjPX0WjPbOv9pujQeQClMm1RuD9U/2upeI
	 x3JdF4y0OtT3bKy3J+jlR0tC/2FHbjHOBPaFA6fyslhx12THWfDhGBpzFVdtDSAZFW
	 ggboE+0C8z3kgoMLCiLZvAa6L2eJFtCVV4t3Zg2w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B82084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLKG6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:58:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeLKG6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:58:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356492082F;
        Tue, 11 Dec 2018 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544511491;
        bh=6zcVvbr8JGU5yyY++Zj7+SSmlt6zOr8mHaWHy7ty/NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+KAtT87xI/tM2P4xmCKL41sG1q/8QKQZTqvtWGeB3/zHszZqEg7amICRDTq1kWkK
         wm0JdPnDrZ9xehgspP3G+rfSMfI02O3bsIZtqAXamX3Fu5czAMWw+Yf3lIhqPpGs4d
         /qg0yfUsPzfMKOiNoznG97mhzMQNtyP8IrowB0oc=
Date:   Tue, 11 Dec 2018 07:58:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        evgreen@chromium.org, Linux PM <linux-pm@vger.kernel.org>,
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
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
Message-ID: <20181211065808.GB5161@kroah.com>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
 <20181206145547.GA7884@kroah.com>
 <CAJZ5v0gP50tmq4ZzB7LLSaWGWjGjK31y=qFg5PS9B7c2XQ+DyQ@mail.gmail.com>
 <6923d6ed-e357-b083-1830-8396d788efe5@linaro.org>
 <CAJZ5v0jZMqFwYgnfRz04ELLRk=0U8Uv=acw0t9Azxk_HYL0gSQ@mail.gmail.com>
 <9a3aae02-c7e0-97e3-2330-af4fccee6c14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3aae02-c7e0-97e3-2330-af4fccee6c14@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:50:00PM +0200, Georgi Djakov wrote:
> On 12/10/18 13:00, Rafael J. Wysocki wrote:
> > On Mon, Dec 10, 2018 at 11:18 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 12/10/18 11:04, Rafael J. Wysocki wrote:
> >>> On Thu, Dec 6, 2018 at 3:55 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> >>>>> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >>>>>>
> >>>>>> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> >>>>>> graphics, modem). These cores are talking to each other and can generate a
> >>>>>> lot of data flowing through the on-chip interconnects. These interconnect
> >>>>>> buses could form different topologies such as crossbar, point to point buses,
> >>>>>> hierarchical buses or use the network-on-chip concept.
> >>>>>>
> >>>>>> These buses have been sized usually to handle use cases with high data
> >>>>>> throughput but it is not necessary all the time and consume a lot of power.
> >>>>>> Furthermore, the priority between masters can vary depending on the running
> >>>>>> use case like video playback or CPU intensive tasks.
> >>>>>>
> >>>>>> Having an API to control the requirement of the system in terms of bandwidth
> >>>>>> and QoS, so we can adapt the interconnect configuration to match those by
> >>>>>> scaling the frequencies, setting link priority and tuning QoS parameters.
> >>>>>> This configuration can be a static, one-time operation done at boot for some
> >>>>>> platforms or a dynamic set of operations that happen at run-time.
> >>>>>>
> >>>>>> This patchset introduce a new API to get the requirement and configure the
> >>>>>> interconnect buses across the entire chipset to fit with the current demand.
> >>>>>> The API is NOT for changing the performance of the endpoint devices, but only
> >>>>>> the interconnect path in between them.
> >>>>>
> >>>>> For what it's worth, we are ready to land this in Chrome OS. I think
> >>>>> this series has been very well discussed and reviewed, hasn't changed
> >>>>> much in the last few spins, and is in good enough shape to use as a
> >>>>> base for future patches. Georgi's also done a great job reaching out
> >>>>> to other SoC vendors, and there appears to be enough consensus that
> >>>>> this framework will be usable by more than just Qualcomm. There are
> >>>>> also several drivers out on the list trying to add patches to use this
> >>>>> framework, with more to come, so it made sense (to us) to get this
> >>>>> base framework nailed down. In my experiments this is an important
> >>>>> piece of the overall power management story, especially on systems
> >>>>> that are mostly idle.
> >>>>>
> >>>>> I'll continue to track changes to this series and we will ultimately
> >>>>> reconcile with whatever happens upstream, but I thought it was worth
> >>>>> sending this note to express our "thumbs up" towards this framework.
> >>>>
> >>>> Looks like a v11 will be forthcoming, so I'll wait for that one to apply
> >>>> it to the tree if all looks good.
> >>>
> >>> I'm honestly not sure if it is ready yet.
> >>>
> >>> New versions are coming on and on, which may make such an impression,
> >>> but we had some discussion on it at the LPC and some serious questions
> >>> were asked during it, for instance regarding the DT binding introduced
> >>> here.  I'm not sure how this particular issue has been addressed here,
> >>> for example.
> >>
> >> There have been no changes in bindings since v4 (other than squashing
> >> consumer and provider bindings into a single patch and fixing typos).
> >>
> >> The last DT comment was on v9 [1] where Rob wanted confirmation from
> >> other SoC vendors that this works for them too. And now we have that
> >> confirmation and there are patches posted on the list [2].
> > 
> > OK
> > 
> >> The second thing (also discussed at LPC) was about possible cases where
> >> some consumer drivers can't calculate how much bandwidth they actually
> >> need and how to address that. The proposal was to extend the OPP
> >> bindings with one more property, but this is not part of this patchset.
> >> It is a future step that needs more discussion on the mailing list. If a
> >> driver really needs some bandwidth data now, it should be put into the
> >> driver and not in DT. After we have enough consumers, we can discuss
> >> again if it makes sense to extract something into DT or not.
> > 
> > That's fine by me.
> > 
> > Admittedly, I have some reservations regarding the extent to which
> > this approach will turn out to be useful in practice, but I guess as
> > long as there is enough traction, the best way to find out it to try
> > and see. :-)
> > 
> > From now on I will assume that this series is going to be applied by Greg.
> 
> That was the initial idea, but the problem is that there is a recent
> change in the cmd_db API (needed by the sdm845 provider driver), which
> is going through arm-soc/qcom/drivers. So either Greg pulls also the
> qcom-drivers-for-4.21 tag from Andy or the whole series goes via Olof
> and Arnd. Maybe there are other options. I don't have any preference and
> don't want to put extra burden on any maintainers, so i am ok with what
> they prefer.

Let me take the time later this week to review the code, which I haven't
done in a while...

thanks,

greg k-h
