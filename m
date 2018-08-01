Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B6C46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3032A20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoLgwres"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3032A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403992AbeHATAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:00:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34942 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390055AbeHATAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:00:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so11129628pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MVPd0R7IW+cQRn2pe9327ND5REdLgQmjLfFHc8fIKcU=;
        b=IoLgwresQEXljNhRavkA2mBlFppoVdYL2+iyv/rc6M20FkvgWscoygNxCGI7sg3+6C
         EZpzMBMcY5Vz0Oi8wbGXUJ62oPdyTKe5FheO+uWabuCmVDA5/dJy+QbNB3iS+K8tHIFd
         lZD6g6KMRx4AkHTD2+LzzFricrYRBm+mZpRQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MVPd0R7IW+cQRn2pe9327ND5REdLgQmjLfFHc8fIKcU=;
        b=nq/Y+jlXhgL2DuvsuQoeRbtahriK9kbZ9YKHN32PzrNqig7rkBmzDRgKqXByUDPptc
         nowmhuctCPE5sxDVGUi2vaWx8Oj7TG+y260kYT1zMKRW7DxKtk0hYg2lxnrxdf5h3Kdc
         vzutrJ6AlMmpK2j0Jg76Wx84Thz13YR3uoDILS5Nv9Pz6Z9lAiX7j0md1L1Ocys0xcNc
         189goxqrwtEpnA2q3WbUFNk/PJbiyFdiCBweYe2X5175eF3NIp3XuOtF+cT1SCoilJCD
         18uyw1QABHhgLTzOnm4cEnPggLmVkpSZjmn/aR/jgcPOYOtjyw2XOVqKGZKImpuC7w+d
         6Nww==
X-Gm-Message-State: AOUpUlEnEQLcYLImvtMa0OxIf/DZuYaZkt/+jePS43r/9Dnye5lsxz9D
        k1KvkHXtVCxD4eFLAqTc1PXlvw==
X-Google-Smtp-Source: AAOMgpfX+KAv/LC7fV7RsyqwQBF9u6cJu6ZmDU0g9Qotj+CBDeOxlwD6ml7G5pp58MHUCVnPdUL7EQ==
X-Received: by 2002:a63:314f:: with SMTP id x76-v6mr24871605pgx.373.1533143306326;
        Wed, 01 Aug 2018 10:08:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b18-v6sm21163845pgk.15.2018.08.01.10.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:08:25 -0700 (PDT)
Date:   Wed, 1 Aug 2018 10:08:24 -0700
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
Message-ID: <20180801170824.GJ68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
 <20180703234705.227473-6-mka@chromium.org>
 <5B3C6C2A.1070205@samsung.com>
 <20180706175301.GG129942@google.com>
 <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
 <20180716175050.GZ129942@google.com>
 <20180731193953.GH68975@google.com>
 <5B610B48.4030802@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B610B48.4030802@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Wed, Aug 01, 2018 at 10:22:16AM +0900, Chanwoo Choi wrote:
> On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
> > On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
> >> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
> >>> Hi Matthias,
> >>>
> >>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
> >>>> Hi Chanwoo,
> >>>>
> >>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
> >>>>
> >>>>> Firstly,
> >>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> >>>>>
> >>>>> devfreq already used the OPP interface as default. It means that
> >>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
> >>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> >>>>> drivers disable/enable the specific frequency, the devfreq core
> >>>>> consider them.
> >>>>>
> >>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
> >>>>> already support some interface to change the minimum/maximum frequency
> >>>>> of devfreq device. 
> >>>>>
> >>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> >>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
> >>>>> change the minimum/maximum frequency through OPP interface.
> >>>>>
> >>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
> >>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
> >>>>> other way to change the minimum/maximum frequency.
> >>>>
> >>>> Using the OPP interface exclusively works as long as a
> >>>> enabling/disabling of OPPs is limited to a single driver
> >>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
> >>>> involved you need a way to resolve conflicts, that's the purpose of
> >>>> devfreq_verify_within_limits(). Please let me know if there are
> >>>> existing mechanisms for conflict resolution that I overlooked.
> >>>>
> >>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
> >>>> devfreq_verify_within_limits() instead of the OPP interface if
> >>>> desired, however this seems beyond the scope of this series.
> >>>
> >>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
> >>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
> >>> happen.
> >>
> >> As long as drivers limit the max freq there is no conflict, the lowest
> >> max freq wins. I expect this to be the usual case, apparently it
> >> worked for cpufreq for 10+ years.
> >>
> >> However it is correct that there would be a conflict if a driver
> >> requests a min freq that is higher than the max freq requested by
> >> another. In this case devfreq_verify_within_limits() resolves the
> >> conflict by raising p->max to the min freq. Not sure if this is
> >> something that would ever occur in practice though.
> >>
> >> If we are really concerned about this case it would also be an option
> >> to limit the adjustment to the max frequency.
> >>
> >>> To resolve the conflict for multiple device driver, maybe OPP interface
> >>> have to support 'usage_count' such as clk_enable/disable().
> >>
> >> This would require supporting negative usage count values, since a OPP
> >> should not be enabled if e.g. thermal enables it but the throttler
> >> disabled it or viceversa.
> >>
> >> Theoretically there could also be conflicts, like one driver disabling
> >> the higher OPPs and another the lower ones, with the outcome of all
> >> OPPs being disabled, which would be a more drastic conflict resolution
> >> than that of devfreq_verify_within_limits().
> >>
> >> Viresh, what do you think about an OPP usage count?
> > 
> > Ping, can we try to reach a conclusion on this or at least keep the
> > discussion going?
> > 
> > Not that it matters, but my preferred solution continues to be
> > devfreq_verify_within_limits(). It solves conflicts in some way (which
> > could be adjusted if needed) and has proven to work in practice for
> > 10+ years in a very similar sub-system.
> 
> It is not true. Current cpufreq subsystem doesn't support external OPP
> control to enable/disable the OPP entry. If some device driver
> controls the OPP entry of cpufreq driver with opp_disable/enable(),
> the operation is not working. Because cpufreq considers the limit
> through 'cpufreq_verify_with_limits()' only.

Ok, we can probably agree that using cpufreq_verify_with_limits()
exclusively seems to have worked well for cpufreq, and that in their
overall purpose cpufreq and devfreq are similar subsystems.

The current throttler series with devfreq_verify_within_limits() takes
the enabled OPPs into account, the lowest and highest OPP are used as
a starting point for the frequency adjustment and (in theory) the
frequency range should only be narrowed by
devfreq_verify_within_limits().

> As I already commented[1], there is different between cpufreq and devfreq.
> [1] https://lkml.org/lkml/2018/7/4/80
> 
> Already, subsystem already used OPP interface in order to control
> specific OPP entry. I don't want to provide two outside method
> to control the frequency of devfreq driver. It might make the confusion.

I understand your point, it would indeed be preferable to have a
single method. However I'm not convinced that the OPP interface is
a suitable solution, as I exposed earlier in this thread (quoted
below).

I would like you to at least consider the possibility of changing
drivers/thermal/devfreq_cooling.c to devfreq_verify_within_limits().
Besides that it's not what is currently used, do you see any technical
concerns that would make devfreq_verify_within_limits() an unsuitable
or inferior solution?

> I want to use only OPP interface to enable/disable frequency
> even if we have to modify the OPP interface.

These are the concerns I raised earlier about a solution with OPP
usage counts:

"This would require supporting negative usage count values, since a OPP
should not be enabled if e.g. thermal enables it but the throttler
disabled it or viceversa.

Theoretically there could also be conflicts, like one driver disabling
the higher OPPs and another the lower ones, with the outcome of all
OPPs being disabled, which would be a more drastic conflict resolution
than that of devfreq_verify_within_limits()."

What do you think about these points?

The negative usage counts aren't necessarily a dealbreaker in a
technical sense, though I'm not a friend of quirky interfaces that
don't behave like a typical user would expect (e.g. an OPP isn't
necessarily enabled after dev_pm_opp_enable()).

I can sent an RFC with OPP usage counts, though due to the above
concerns I have doubts it will be well received.

Thanks

Matthias
