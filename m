Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB74C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5412D21A16
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ass2ArMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5412D21A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeHFU5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:57:04 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40342 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHFU5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:57:04 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so6012710plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H5GhVnpbHaajzFOzkq/F7dSiVRG+cprdSbaw60KFe7o=;
        b=ass2ArMu9eC/Ck34FPUmY8YoYafLKvdcUJRgTp0i2J0oioksIxpqK0nlJZ2BfUIQKw
         3nnjpIOSUndeTgxj3X0VWBroC5zMNneXNhoqFeIvK9ug6OgT9f64lRd/p5kNOUJajwOv
         OfmKSGE/zezQCN2tMo5I4birjefgLoWNCKzDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H5GhVnpbHaajzFOzkq/F7dSiVRG+cprdSbaw60KFe7o=;
        b=rhxtQqXeo4FkAHHHHiEv5aX2E30x4sLTocy/X021V//lhYrMc/PIdZg7t/fdKMMO9S
         KvEO7v8rhVOB+axPh1Uq67jMnSoOoNiWUE2QPpKiKwvMpBOX9p+Ovk/Kyq+MxysArzKU
         SqzpMA/BY0SNd84qzuWR6v7OAEeL9n2cWpwHLk5416L0TcRNYIFBIedLvLpTRwgBCqfp
         oZmyPxv76CbDAK1YJ+m9i+T5YVfn2yqQkKM9NABa2YKTpYhRFZ2pN+wxH2pW9yVYW+aU
         R03hEGArSeJivrVkc8iDDFuzW7AeaQjbhIVHcmVsVXu2/f16uwzhq65/Bg8tbzJeTNnj
         oFxw==
X-Gm-Message-State: AOUpUlFfTwiOyS6+eO8uNGzCV2V97T4GKPKyKgHyZdzPiADsOPQCIv8h
        Seh33MYX45iWf4/pXPGU1xBcyA==
X-Google-Smtp-Source: AAOMgpdtlZWXoRbL/K+7TccJYFM+dwvVk9V0Xf6cuzTz0Do2ngLdc6yU90MQaToeBNje6JYO/lcNNg==
X-Received: by 2002:a17:902:530a:: with SMTP id b10-v6mr15290651pli.101.1533581200138;
        Mon, 06 Aug 2018 11:46:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y27-v6sm30940231pff.181.2018.08.06.11.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 11:46:39 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:46:38 -0700
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
Message-ID: <20180806184638.GA160295@google.com>
References: <5B3C6C2A.1070205@samsung.com>
 <20180706175301.GG129942@google.com>
 <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
 <20180716175050.GZ129942@google.com>
 <20180731193953.GH68975@google.com>
 <5B610B48.4030802@samsung.com>
 <20180801170824.GJ68975@google.com>
 <5B626563.1090302@samsung.com>
 <20180802231343.GS68975@google.com>
 <5B639A49.3060804@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B639A49.3060804@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Fri, Aug 03, 2018 at 08:56:57AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 08월 03일 08:13, Matthias Kaehlcke wrote:
> > Hi Chanwoo,
> > 
> > On Thu, Aug 02, 2018 at 10:58:59AM +0900, Chanwoo Choi wrote:
> >> Hi Matthias,
> >>
> >> On 2018년 08월 02일 02:08, Matthias Kaehlcke wrote:
> >>> Hi Chanwoo,
> >>>
> >>> On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
> >>>> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
> >>>>> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
> >>>>>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
> >>>>>>> Hi Matthias,
> >>>>>>>
> >>>>>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> >>>>>>>> Hi Chanwoo,
> >>>>>>>>
> >>>>>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> >>>>>>>>
> >>>>>>>>> Firstly,
> >>>>>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> >>>>>>>>>
> >>>>>>>>> devfreq already used the OPP interface as default. It means that
> >>>>>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
> >>>>>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> >>>>>>>>> drivers disable/enable the specific frequency, the devfreq core
> >>>>>>>>> consider them.
> >>>>>>>>>
> >>>>>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
> >>>>>>>>> already support some interface to change the minimum/maximum frequency
> >>>>>>>>> of devfreq device. 
> >>>>>>>>>
> >>>>>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> >>>>>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
> >>>>>>>>> change the minimum/maximum frequency through OPP interface.
> >>>>>>>>>
> >>>>>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
> >>>>>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
> >>>>>>>>> other way to change the minimum/maximum frequency.
> >>>>>>>>
> >>>>>>>> Using the OPP interface exclusively works as long as a
> >>>>>>>> enabling/disabling of OPPs is limited to a single driver
> >>>>>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> >>>>>>>> involved you need a way to resolve conflicts, that's the purpose of
> >>>>>>>> devfreq_verify_within_limits(). Please let me know if there are
> >>>>>>>> existing mechanisms for conflict resolution that I overlooked.
> >>>>>>>>
> >>>>>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> >>>>>>>> devfreq_verify_within_limits() instead of the OPP interface if
> >>>>>>>> desired, however this seems beyond the scope of this series.
> >>>>>>>
> >>>>>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
> >>>>>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
> >>>>>>> happen.
> >>>>>>
> >>>>>> As long as drivers limit the max freq there is no conflict, the lowest
> >>>>>> max freq wins. I expect this to be the usual case, apparently it
> >>>>>> worked for cpufreq for 10+ years.
> >>>>>>
> >>>>>> However it is correct that there would be a conflict if a driver
> >>>>>> requests a min freq that is higher than the max freq requested by
> >>>>>> another. In this case devfreq_verify_within_limits() resolves the
> >>>>>> conflict by raising p->max to the min freq. Not sure if this is
> >>>>>> something that would ever occur in practice though.
> >>>>>>
> >>>>>> If we are really concerned about this case it would also be an option
> >>>>>> to limit the adjustment to the max frequency.
> >>>>>>
> >>>>>>> To resolve the conflict for multiple device driver, maybe OPP interface
> >>>>>>> have to support 'usage_count' such as clk_enable/disable().
> >>>>>>
> >>>>>> This would require supporting negative usage count values, since a OPP
> >>>>>> should not be enabled if e.g. thermal enables it but the throttler
> >>>>>> disabled it or viceversa.
> >>>>>>
> >>>>>> Theoretically there could also be conflicts, like one driver disabling
> >>>>>> the higher OPPs and another the lower ones, with the outcome of all
> >>>>>> OPPs being disabled, which would be a more drastic conflict resolution
> >>>>>> than that of devfreq_verify_within_limits().
> >>>>>>
> >>>>>> Viresh, what do you think about an OPP usage count?
> >>>>>
> >>>>> Ping, can we try to reach a conclusion on this or at least keep the
> >>>>> discussion going?
> >>>>>
> >>>>> Not that it matters, but my preferred solution continues to be
> >>>>> devfreq_verify_within_limits(). It solves conflicts in some way (which
> >>>>> could be adjusted if needed) and has proven to work in practice for
> >>>>> 10+ years in a very similar sub-system.
> >>>>
> >>>> It is not true. Current cpufreq subsystem doesn't support external OPP
> >>>> control to enable/disable the OPP entry. If some device driver
> >>>> controls the OPP entry of cpufreq driver with opp_disable/enable(),
> >>>> the operation is not working. Because cpufreq considers the limit
> >>>> through 'cpufreq_verify_with_limits()' only.
> >>>
> >>> Ok, we can probably agree that using cpufreq_verify_with_limits()
> >>> exclusively seems to have worked well for cpufreq, and that in their
> >>> overall purpose cpufreq and devfreq are similar subsystems.
> >>>
> >>> The current throttler series with devfreq_verify_within_limits() takes
> >>> the enabled OPPs into account, the lowest and highest OPP are used as
> >>> a starting point for the frequency adjustment and (in theory) the
> >>> frequency range should only be narrowed by
> >>> devfreq_verify_within_limits().
> >>>
> >>>> As I already commented[1], there is different between cpufreq and devfreq.
> >>>> [1] https://lkml.org/lkml/2018/7/4/80
> >>>>
> >>>> Already, subsystem already used OPP interface in order to control
> >>>> specific OPP entry. I don't want to provide two outside method
> >>>> to control the frequency of devfreq driver. It might make the confusion.
> >>>
> >>> I understand your point, it would indeed be preferable to have a
> >>> single method. However I'm not convinced that the OPP interface is
> >>> a suitable solution, as I exposed earlier in this thread (quoted
> >>> below).
> >>>
> >>> I would like you to at least consider the possibility of changing
> >>> drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
> >>> Besides that it's not what is currently used, do you see any technical
> >>> concerns that would make devfreq_verify_within_limits() an unsuitable
> >>> or inferior solution?
> >>
> >> As we already discussed, devfreq_verify_within_limits() doesn't support
> >> the multiple outside controllers (e.g., devfreq-cooling.c).
> > 
> > That's incorrect, its purpose is precisely that.
> > 
> > Are you suggesting that cpufreq with its use of
> > cpufreq_verify_within_limits() (the inspiration for
> > devfreq_verify_within_limits()) is broken? It is used by cpu_cooling.c
> > and other drivers when receiving a CPUFREQ_ADJUST event, essentially
> > what I am proposing with DEVFREQ_ADJUST.
> > 
> > Could you elaborate why this model wouldn't work for devfreq? "OPP
> 
> I don't mention that this model is not working. As I already commented[1],
> devfreq used OPP interface to control OPP entry on outside of devfreq driver.
> Because devfreq used OPP interface, I hope to provide only OPP method
> to control the frequency on outside of devfreq.
> [1] https://lkml.org/lkml/2018/7/4/80
> 
> > interface is mandatory for devfreq" isn't really a technical argument,
> > is it mandatory for any other reason than that it is the interface
> > that is currently used?
> 
> In case of controlling the frequency, OPP interface is mandatory for devfreq.
> 
> cpufreq used cpufreq_verify_within_limit(). If outside driver disable
> specific OPP entry, cpufreq don't consider them because after getting the frequency
> from devicetree, cpufreq don't use the OPP interface for disabling/enabling.
> Only if outside driver used cpufreq_verify_within_limit(), cpufreq consider
> the range of minimum/maximum frequency. cpufreq core doesn't use 'dev_pm_opp_find_*'
> function. It means that cpufreq code doesn't consider the statue of opp_diable/enable.
> 
> devfreq used OPP interface.  If outside driver disable specific OPP entry, devfreq consider them. 

What exactly is this 'outside driver' you are referring? The driver
that 'owns' the devfreq device, e.g. a GPU driver? Or just any
non-devfreq driver, like devfreq-cooling.c?

If it's the first case then this isn't currently working as intended
when the devfreq device is used as a cooling device, since the cooling
device would overwrite the state set by the 'owner' in
partition_enable_opps().

> When find available minimum frequency, devfreq used OPP interface. (find_available_min_freq)
> When find available maximum frequency, devfreq used OPP interface. (find_available_max_freq)
> When make freq_table of devfreq device, devfreq used OPP interface. (set_freq_table)
> When outside driver disable or enable OPP entry, devfreq receives the notification
>  from OPP interface and then update the scaling_min_freq/scaling_max_freq by using
>  OPP interface. (devfreq_notifier_call)
> At this point of using scaling_min_freq/scaling_max_freq on devfreq, it indicates
> that devfreq used OPP interface because devfref tried to find scaling_min_freq/scaling_max_freq
> through OPP interface.
> 
> If outside driver use OPP interface in order to control frequency,
> devfreq core is well working without any modification of devfreq
> core.

Thanks for elaborating!

I understand that this is how it currently works, but unless I'm
missing something about the outside driver disabling an OPP I still
essentially read this as 'the OPP interface is mandatory because it's
what is currently used by the devfreq core to limit the frequency
range', rather than that using the OPP interface allows to provide a
particular feature or is inherently better in some other way.

I don't propose to completely strip the OPP interface out of devfreq,
but mainly to switch devfreq-cooling.c to
devfreq_verify_within_limits() to avoid having two mechanisms for
limiting the frequency range. Besides being simpler this would allow
to support the case where the 'owner' disables a certain OPP and
devfreq respects that. The code required in the devfreq core to
support this would be minimal (this patch).

> >> After you are suggesting the throttler core, there are at least two
> >> outside controllers (e.g., devfreq-cooling.c and throttler driver).
> >> As I knew the problem about conflict, I cannot agree the temporary
> >> method. OPP interface is mandatory for devfreq in order to control
> >> the OPP (frequency/voltage). In this situation, we have to try to
> >> find the method through OPP interface.
> > 
> > What do you mean with "temporary method"?
> 
> this expression might be not proper. Please ignore this expression.
> 
> > 
> > We can try to find a method through the OPP interface, but at this
> > point I'm not convinced that it is technically necessary or even
> > preferable.
> 
> I replied it about this as following.
> 
> > 
> > Another inconvenient of the OPP approach for both devfreq-cooling.c
> > and the throttler is that they have to bother with disabling all OPPs
> > above/below the max/min (they don't/shouldn't have to care), instead
> > of just telling devfreq the max/min.
> 
> I think it doesn't matter. We can enable/disable the OPP entry by traversing.
> partition_enable_opps() in drivers/thermal/devfreq-cools.c have already done so.
> 
> > 
> >> We can refer to regulator/clock. Multiple device driver can use
> >> the regulator/clock without any problem. I think that usage of OPP
> >> is similiar with regulator/clock. As you mentioned, maybe OPP
> >> would handle the negative count. Although opp_enable/opp_disable()
> >> have to handle the negative count and opp_enable/opp_disable()
> >> can support the multiple usage from device drivers, I think that
> >> this approach is right.
> > 
> > The regulator/clock approach with the typical usage counts seems more
> > intuitive to me, personally I wouldn't write an interface with
> > negative usage count if I could reasonably avoid it.
> 
> I think the use of negative usage count is not problem if it's required.
> 
> > 
> >>>> I want to use only OPP interface to enable/disable frequency
> >>>> even if we have to modify the OPP interface.
> >>>
> >>> These are the concerns I raised earlier about a solution with OPP
> >>> usage counts:
> >>>
> >>> "This would require supporting negative usage count values, since a OPP
> >>> should not be enabled if e.g. thermal enables it but the throttler
> >>> disabled it or viceversa.
> >>
> >> Already replied	about negative usage count. I think that negative usage count
> >> is not problem if this approach could resolve the issue.
> >>
> >>>
> >>> Theoretically there could also be conflicts, like one driver disabling
> >>> the higher OPPs and another the lower ones, with the outcome of all
> >>> OPPs being disabled, which would be a more drastic conflict resolution
> >>> than that of devfreq_verify_within_limits()."
> >>>
> >>> What do you think about these points?
> >>
> >> It depends on how to use OPP interface on multiple device driver.
> >> Even if devfreq/opp provides the control method, outside device driver
> >> are misusing them. It is problem of user.
> > 
> > I wouldn't call it misusing if two independent drivers take
> > contradictory actions on an interface that doesn't provide
> > arbitration. How can driver A know that it shouldn't disable OPPs a, b
> > and c because driver B disabled d, e and f? Who is misusing the
> > interface, driver A or driver B?
> 
> Each outside driver has their own throttling policy to control OPP entries.
> They don't care the requirement of other driver and cannot know the requirement
> of other driver. devfreq core can only recognize them.
> 
> > 
> >> Instead, if we use the OPP interface, we can check why OPP entry
> >> is disabled or enabled through usage count.
> >>
> >>>
> >>> The negative usage counts aren't necessarily a dealbreaker in a
> >>> technical sense, though I'm not a friend of quirky interfaces that
> >>> don't behave like a typical user would expect (e.g. an OPP isn't
> >>> necessarily enabled after dev_pm_opp_enable()).
> >>>
> >>> I can sent an RFC with OPP usage counts, though due to the above
> >>> concerns I have doubts it will be well received.
> >>
> >> Please add me to Cc list.
> > 
> > Will do
> 
> OK. Thanks.

This might take a bit for a few reasons. Before posting anything I
would like to experiment a bit with it and find time to do so between
other tasks (admittedly I'm also procrastinating a bit, because I'm
unconvinced). And I will be out of office for two weeks starting
nextweek, it's probably not the best to post and then disapear from
the discussion. I might post the RFC if I can advance it in the next
48 hours, otherwise I think it is better to delay until I'm back from
vacation.

Cheers

Matthias
