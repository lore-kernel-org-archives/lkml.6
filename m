Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED7CC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C0621A60
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AXafgkH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C0621A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeHGCfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:35:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43722 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHGCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:35:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so6305135plv.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 17:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vECcfxgut9kZrHfCV6nrqNGnH/WTi5YcrX9BcHCs8jA=;
        b=AXafgkH1VXraR8MWLVDKh2NlcZ+j/8eIjo6YPc+o07C/B0rwuN0ohxvg+BbtEudp6U
         hJkCc9uKSOCqj6QJzxxJU9xtbA3r3S7oo1lbE/mJj2/qUZkgPSoRscSp41bDg2gYbKPc
         yb7lkQCjkfV2C0IhEbWAJ2WqZqWxEAmnqApuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vECcfxgut9kZrHfCV6nrqNGnH/WTi5YcrX9BcHCs8jA=;
        b=K5BEhmj/p+NZoYyh+8ev5THj2cf9QjDiIlYnS9ijxV1LQoOJdUSzN5AFsdifcQ/uOD
         j/oW91umXjaDn1IjUjyxX0hZNA+fmleAgAJAcBB2PyT6kZ5En5p2judiGFoYrdplAazN
         zYpKGBuDMknegC0bApN5XdTZDjoNGsHSKpLus909UVYwSQRgpDpILXNKRRW8cxdTOU5b
         CIBNmJZ5rRfp9DDB6+RNiXqBtWqmj7lLxiVgX2ntXLUoQ/ayBIdzNjbDMuLcCj1Lvx71
         gJjZ0yoc9v99DfqVtZbXW2lvLQPLP3Wlrl6fL6jIkLWoLyz0VNdjaZotlWT7jxqWWCjQ
         C1AA==
X-Gm-Message-State: AOUpUlEKGHr3rvPaj/wdo/1xt7jCHPMvXmpF/mx8W8bD018vfzxLY9sk
        qAyVNHrUEf1IY4G6J0aQNgnvmA==
X-Google-Smtp-Source: AAOMgpdPzO1bweo5ro/7ifnm8P7OkDSbK3JxJEhplztBcUcjyEGKfCDnHFZRRyjSe89nDpCO/nIm9w==
X-Received: by 2002:a17:902:9696:: with SMTP id n22-v6mr15800691plp.212.1533601421498;
        Mon, 06 Aug 2018 17:23:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id d75-v6sm7829552pfd.49.2018.08.06.17.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 17:23:40 -0700 (PDT)
Date:   Mon, 6 Aug 2018 17:23:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
Message-ID: <20180807002340.GC160295@google.com>
References: <20180731193953.GH68975@google.com>
 <5B610B48.4030802@samsung.com>
 <20180801170824.GJ68975@google.com>
 <5B626563.1090302@samsung.com>
 <20180802231343.GS68975@google.com>
 <CGME20180802234831epcas5p3951e8f64381a27d40865d339878751d1@epcas5p3.samsung.com>
 <20180802234820.GU68975@google.com>
 <5B639E76.6050901@samsung.com>
 <20180806192111.GB160295@google.com>
 <5B68CC34.8040102@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B68CC34.8040102@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Tue, Aug 07, 2018 at 07:31:16AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 07일 04:21, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Fri, Aug 03, 2018 at 09:14:46AM +0900, Chanwoo Choi wrote:
> >> Hi Matthias,
> >>
> >> On 2018년 08월 03일 08:48, Matthias Kaehlcke wrote:
> >>> On Thu, Aug 02, 2018 at 04:13:43PM -0700, Matthias Kaehlcke wrote:
> >>>> Hi Chanwoo,
> >>>>
> >>>> On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
> >>>>> Hi Matthias,
> >>>>>
> >>>>> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
> >>>>>> Hi Chanwoo,
> >>>>>>
> >>>>>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
> >>>>>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
> >>>>>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
> >>>>>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
> >>>>>>>>>> Hi Matthias,
> >>>>>>>>>>
> >>>>>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> >>>>>>>>>>> Hi Chanwoo,
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> Firstly,
> >>>>>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> >>>>>>>>>>>>
> >>>>>>>>>>>> devfreq already used the OPP interface as default. It means that
> >>>>>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
> >>>>>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> >>>>>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
> >>>>>>>>>>>> consider them.
> >>>>>>>>>>>>
> >>>>>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
> >>>>>>>>>>>> already support some interface to change the minimum/maximum frequency
> >>>>>>>>>>>> of devfreq device. 
> >>>>>>>>>>>>
> >>>>>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> >>>>>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
> >>>>>>>>>>>> change the minimum/maximum frequency through OPP interface.
> >>>>>>>>>>>>
> >>>>>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
> >>>>>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
> >>>>>>>>>>>> other way to change the minimum/maximum frequency.
> >>>>>>>>>>>
> >>>>>>>>>>> Using the OPP interface exclusively works as long as a
> >>>>>>>>>>> enabling/disabling of OPPs is limited to a single driver
> >>>>>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> >>>>>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
> >>>>>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
> >>>>>>>>>>> existing mechanisms for conflict resolution that I overlooked.
> >>>>>>>>>>>
> >>>>>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> >>>>>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
> >>>>>>>>>>> desired, however this seems beyond the scope of this series.
> >>>>>>>>>>
> >>>>>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
> >>>>>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
> >>>>>>>>>> happen.
> >>>>>>>>>
> >>>>>>>>> As long as drivers limit the max freq there is no conflict, the lowest
> >>>>>>>>> max freq wins. I expect this to be the usual case, apparently it
> >>>>>>>>> worked for cpufreq for 10+ years.
> >>>>>>>>>
> >>>>>>>>> However it is correct that there would be a conflict if a driver
> >>>>>>>>> requests a min freq that is higher than the max freq requested by
> >>>>>>>>> another. In this case devfreq_verify_within_limits() resolves the
> >>>>>>>>> conflict by raising p->max to the min freq. Not sure if this is
> >>>>>>>>> something that would ever occur in practice though.
> >>>>>>>>>
> >>>>>>>>> If we are really concerned about this case it would also be an option
> >>>>>>>>> to limit the adjustment to the max frequency.
> >>>>>>>>>
> >>>>>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
> >>>>>>>>>> have to support 'usage_count' such as clk_enable/disable().
> >>>>>>>>>
> >>>>>>>>> This would require supporting negative usage count values, since a OPP
> >>>>>>>>> should not be enabled if e.g. thermal enables it but the throttler
> >>>>>>>>> disabled it or viceversa.
> >>>>>>>>>
> >>>>>>>>> Theoretically there could also be conflicts, like one driver disabling
> >>>>>>>>> the higher OPPs and another the lower ones, with the outcome of all
> >>>>>>>>> OPPs being disabled, which would be a more drastic conflict resolution
> >>>>>>>>> than that of devfreq_verify_within_limits().
> >>>>>>>>>
> >>>>>>>>> Viresh, what do you think about an OPP usage count?
> >>>>>>>>
> >>>>>>>> Ping, can we try to reach a conclusion on this or at least keep the
> >>>>>>>> discussion going?
> >>>>>>>>
> >>>>>>>> Not that it matters, but my preferred solution continues to be
> >>>>>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
> >>>>>>>> could be adjusted if needed) and has proven to work in practice for
> >>>>>>>> 10+ years in a very similar sub-system.
> >>>>>>>
> >>>>>>> It is not true. Current cpufreq subsystem doesn't support external OPP
> >>>>>>> control to enable/disable the OPP entry. If some device driver
> >>>>>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
> >>>>>>> the operation is not working. Because cpufreq considers the limit
> >>>>>>> through 'cpufreq_verify_with_limits()' only.
> >>>>>>
> >>>>>> Ok, we can probably agree that using cpufreq_verify_with_limits()
> >>>>>> exclusively seems to have worked well for cpufreq, and that in their
> >>>>>> overall purpose cpufreq and devfreq are similar subsystems.
> >>>>>>
> >>>>>> The current throttler series with devfreq_verify_within_limits() takes
> >>>>>> the enabled OPPs into account, the lowest and highest OPP are used as
> >>>>>> a starting point for the frequency adjustment and (in theory) the
> >>>>>> frequency range should only be narrowed by
> >>>>>> devfreq_verify_within_limits().
> >>>>>>
> >>>>>>> As I already commented[1], there is different between cpufreq and devfreq.
> >>>>>>> [1] https://lkml.org/lkml/2018/7/4/80
> >>>>>>>
> >>>>>>> Already, subsystem already used OPP interface in order to control
> >>>>>>> specific OPP entry. I don't want to provide two outside method
> >>>>>>> to control the frequency of devfreq driver. It might make the confusion.
> >>>>>>
> >>>>>> I understand your point, it would indeed be preferable to have a
> >>>>>> single method. However I'm not convinced that the OPP interface is
> >>>>>> a suitable solution, as I exposed earlier in this thread (quoted
> >>>>>> below).
> >>>>>>
> >>>>>> I would like you to at least consider the possibility of changing
> >>>>>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
> >>>>>> Besides that it's not what is currently used, do you see any technical
> >>>>>> concerns that would make devfreq_verify_within_limits() an unsuitable
> >>>>>> or inferior solution?
> >>>>>
> >>>>> As we already discussed, devfreq_verify_within_limits() doesn't support
> >>>>> the multiple outside controllers (e.g., devfreq-cooling.c).
> >>>>
> >>>> That's incorrect, its purpose is precisely that.
> >>>>
> >>>> Are you suggesting that cpufreq with its use of
> >>>> cpufreq_verify_within_limits() (the inspiration for
> >>>> devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
> >>>> and other drivers when receiving a CPUFREQ_ADJUST event, essentially
> >>>> what I am proposing with DEVFREQ_ADJUST.
> >>>>
> >>>> Could you elaborate why this model wouldn't work for devfreq? "OPP
> >>>> interface is mandatory for devfreq" isn't really a technical argument,
> >>>> is it mandatory for any other reason than that it is the interface
> >>>> that is currently used?
> >>>>
> >>>>> After you are suggesting the throttler core, there are at least two
> >>>>> outside controllers (e.g., devfreq-cooling.c and throttler driver).
> >>>>> As I knew the problem about conflict, I cannot agree the temporary
> >>>>> method. OPP interface is mandatory for devfreq in order to control
> >>>>> the OPP (frequency/voltage). In this situation, we have to try to
> >>>>> find the method through OPP interface.
> >>>>
> >>>> What do you mean with "temporary method"?
> >>>>
> >>>> We can try to find a method through the OPP interface, but at this
> >>>> point I'm not convinced that it is technically necessary or even
> >>>> preferable.
> >>>>
> >>>> Another inconvenient of the OPP approach for both devfreq-cooling.c
> >>>> and the throttler is that they have to bother with disabling all OPPs
> >>>> above/below the max/min (they don't/shouldn't have to care), instead
> >>>> of just telling devfreq the max/min.
> >>>
> >>> And a more important one: both drivers now have to keep track which
> >>> OPPs they enabled/disabled previously, done are the days of a simple
> >>> dev_pm_opp_enable/disable() in devfreq_cooling. Certainly it is
> >>> possible and not very complex to implement, but is it really the
> >>> best/a good solution?
> >>
> >>
> >> As I replied them right before, Each outside driver has their own throttling
> >> policy to control OPP entries. They don't care the requirement of other
> >> driver and cannot know the requirement of other driver. devfreq core can only
> >> recognize them and then only consider enabled OPP entris without disabled OPP entries.
> >>
> >> For example1,
> >>        | devfreq-cooling| throttler
> >> ---------------------------------------
> >> 500Mhz | disabled       | disabled
> >> 400Mhz | disabled       | disabled
> >> 300Mhz |                | disabled
> >> 200Mhz |                |
> >> 100Mhz |                |
> >> => devfreq driver can use only 100/200Mhz
> >>
> >>
> >> For example2,
> >>        | devfreq-cooling| throttler
> >> ---------------------------------------
> >> 500Mhz | disabled       | disabled
> >> 400Mhz | disabled       |
> >> 300Mhz | disabled       |
> >> 200Mhz |                |
> >> 100Mhz |                |
> >> => devfreq driver can use only 100/200Mhz
> >>
> >>
> >> For example3,
> >>        | devfreq-cooling| throttler
> >> ---------------------------------------
> >> 500Mhz | disabled       | disabled
> >> 400Mhz |                |
> >> 300Mhz |                |
> >> 200Mhz |                | disabled
> >> 100Mhz |                | disabled
> >> => devfreq driver can use only 300/400Mhz
> > 
> > These are all cases without conflicts, my concern is about this:
> > 
> >>        | devfreq-cooling| throttler
> >> ---------------------------------------
> >> 500Mhz | disabled       |
> >> 400Mhz | disabled       |
> >> 300Mhz |                | disabled
> >> 200Mhz |                | disabled
> >> 100Mhz |                | disabled
> >> => devfreq driver can't use any frequency?
> 
> There are no any enabled frequency. Because device driver
> (devfreq-cooling, throttler) disable all frequencies.
> 
> Outside drivers(devfreq-cooling, throttler) can enable/disable
> specific OPP entries. As I already commented, each outside driver
> doesn't consider the policy of other device driver about OPP entries.

And wouldn't it be preferable to have an interface that tries to avoid
this situation in the first place and has a clear policy for conflict
resolution?

> OPP interface is independent on devfreq and just control OPP entries.
> After that, devfreq just consider the only enabled OPP entries.
> 
> > 
> > Actually my above comment wasn't about this case, but about the
> > added complexity in devfreq-cooling.c and the throttler:
> > 
> > A bit simplified partition_enable_opps() currently does this:
> > 
> > for_each_opp(opp) {
> >   if (opp->freq <= max)
> >      opp_enable(opp)
> >   else
> >      opp_disable(opp)
> > }
> > 
> > With the OPP usage/disable count this doesn't work any longer. Now we
> > need to keep track of the enabled/disabled state of the OPP, something
> > like:
> > 
> > dev_pm_opp_enable(opp) {
> >   if (opp->freq <= max) {
> >     if (opp->freq > prev_max)
> >       opp_enable(opp)
> >   } else {
> >     if (opp->freq < prev_max)
> >       opp_disable(opp)
> >   }
> > }
> > 
> > And duplicate the same in the throttler (and other possible
> > drivers). Obviously it can be done, but is there really any gain
> > from it?
> > 
> > Instead they just could do:
> > 
> > devfreq_verify_within_limits(policy/freq_pair, 0, max_freq)
> > 
> > without being concerned about implementation details of devfreq.
> > 
> 
> I don't think so.

What are you referring to, the change that I claim that will be needed
in partition_enable_opps() when OPPs have usage/disable counts? If so,
how do you avoid that the function doesn't enable/disable an OPP that
was already enabled/disabled in the previous iteration?

> dev_pm_opp_enable()/dev_pm_opp_disable() have to consider only one
> OPP entry without any other OPP entry.

I agree with this :)

> dev_pm_opp_enable()/dev_pm_opp_disable() can never know the other
> OPP entries. After some driver(devfreq-cooling.c and throttler) 
> enable or disable specific OPP entries, the remaining OPP entry 
> with enabled state will be considered on devfreq driver.

Having multiple drivers (or even a single one) enable and disable
OPPs independently and at the time of their choosing sounds like a
recipe for race conditions.

What happens if e.g. the devfreq core calls
dev_pm_opp_find_freq_ceil/floor() and right after returning another
driver disables the OPP? devfreq uses the disabled OPP. Probably not a
big deal if disabling the OPP is only a semantic question, but I
imagine there can be worse scenarios. Currently the only user of
dev_pm_opp_disable() besides devfreq_cooling.c is imx6q-cpufreq.c, and
it is well behaved and only disables OPPs during probe().

I keep missing a clear answer to the question in which sense
manipulating the OPPs in devfreq_cooling.c is superior over narrowing
down the frequency during DEVFREQ_ADJUST, which would avoid potential
races and allow to resolve conflicts. Does it allow for some
functionality that couldn't be achieved otherwise, does it make the
code significantly less complex, is some integration with the OPP
subsystem needed that I'm overlooking, is it more efficient, ...?

I'm not just insisting because I'm stubborn. I'd be happy to use any
interface that fits the bill, or to adjust one to fit the bill, but as
of now I mainly see drawbacks on the OPPs side and haven't seen
convincing arguments that it is really needed in devreq_cooling.c or a
better solution.

Cheers

Matthias
