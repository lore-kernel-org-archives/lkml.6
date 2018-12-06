Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC48C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CC520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108153;
	bh=KhuHcI54qejZzgMJEA/PeUcsTUuPrybT0KJnwKINenI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gMdzhj8XJ2xa8cwGulLI+C6UQXcAbMeJw8SI1jguvrZukzGkthpEfFapTUvtXGi8w
	 ySU7LFkj6yYdeIaobpw3gTmEtmmV/OAOJCRGRrOtacSRYKrriefM+mv3gvrvE4iZkz
	 6FKZltH8c/VY6l0JDf7RbnRSs7JLloOdrvfVdY8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CC520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLFOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeLFOzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:55:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2CE20850;
        Thu,  6 Dec 2018 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544108149;
        bh=KhuHcI54qejZzgMJEA/PeUcsTUuPrybT0KJnwKINenI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vz/fJM7LCn16OuyLD8ZRCP5nbDjwcVOD6TYrKuqudnKPDQgDhKhjw91HDknvYdmSY
         k2TEFHPb4VGhFS1Wa8D8dDtN1VipJLXz6bAbDMb+71Rqjat7zFCTl+lRo3oKNIVj/r
         8TtGNPx6opuT06JVtCKt1S4ZHBZW2B7iHb4boVE8=
Date:   Thu, 6 Dec 2018 15:55:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     georgi.djakov@linaro.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v10 0/8] Introduce on-chip interconnect API
Message-ID: <20181206145547.GA7884@kroah.com>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4jUjr3oDAZrM=-orLM-YoVAwa+e=crDDC_p9ArGE1dig@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:41:35PM -0800, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:03 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >
> > Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> > graphics, modem). These cores are talking to each other and can generate a
> > lot of data flowing through the on-chip interconnects. These interconnect
> > buses could form different topologies such as crossbar, point to point buses,
> > hierarchical buses or use the network-on-chip concept.
> >
> > These buses have been sized usually to handle use cases with high data
> > throughput but it is not necessary all the time and consume a lot of power.
> > Furthermore, the priority between masters can vary depending on the running
> > use case like video playback or CPU intensive tasks.
> >
> > Having an API to control the requirement of the system in terms of bandwidth
> > and QoS, so we can adapt the interconnect configuration to match those by
> > scaling the frequencies, setting link priority and tuning QoS parameters.
> > This configuration can be a static, one-time operation done at boot for some
> > platforms or a dynamic set of operations that happen at run-time.
> >
> > This patchset introduce a new API to get the requirement and configure the
> > interconnect buses across the entire chipset to fit with the current demand.
> > The API is NOT for changing the performance of the endpoint devices, but only
> > the interconnect path in between them.
> 
> For what it's worth, we are ready to land this in Chrome OS. I think
> this series has been very well discussed and reviewed, hasn't changed
> much in the last few spins, and is in good enough shape to use as a
> base for future patches. Georgi's also done a great job reaching out
> to other SoC vendors, and there appears to be enough consensus that
> this framework will be usable by more than just Qualcomm. There are
> also several drivers out on the list trying to add patches to use this
> framework, with more to come, so it made sense (to us) to get this
> base framework nailed down. In my experiments this is an important
> piece of the overall power management story, especially on systems
> that are mostly idle.
> 
> I'll continue to track changes to this series and we will ultimately
> reconcile with whatever happens upstream, but I thought it was worth
> sending this note to express our "thumbs up" towards this framework.

Looks like a v11 will be forthcoming, so I'll wait for that one to apply
it to the tree if all looks good.

thanks,

greg k-h
