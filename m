Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54184219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X3iitrXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54184219AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934298AbeGFRxH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36938 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeGFRxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id h20-v6so9013411pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ze5h3MaQ9gYyWgCdHXF/6x+LSzIcDfJZQJg/oKaxiFY=;
        b=X3iitrXFh28Fa6oy6a3uihxUWFm5EREG41QG7MlXjSuD3wk4469l4rx8hWvOKDXIDN
         D1RbchLQRiT8AF6f9pRjyRf76M9iiNT2WbouYfwRmKrOe0jvY74IZXAwP0/y7Www59XN
         5yUayjuwL5NO5qd7kO6k0z4qxKqgbvcyOstng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ze5h3MaQ9gYyWgCdHXF/6x+LSzIcDfJZQJg/oKaxiFY=;
        b=GRBaxxBoValO4SGIQO/gpsJAOzyGU0CLXK5FA20iRDXKhVFbxSX9h7faC1sO1oACh9
         Kuhur48sMwZdacasSjqUgCeUWrznig8lPknw/LVJPIxGQAQVd8u/aAGLAdMBvEAvYfar
         Fe1beeRJ1h55tAIqvlDINSOvTnfCshY1pvbxsjmRUtJQj+PSCP7uKroTv2ZoFCb0uKUI
         Rh0/+sC/5wiq25PKkIgS4MP1XFXDPZe0dIbxnIMiblYklBuPnK2P+r5U2qbYFJlpUdXL
         Wf0hrDrgu1ls5g3RVP36Ga0FbEcVKFvvyvXwtdROcds8Yr1wyaXjnjUArPyMX6SUWD1v
         dEKQ==
X-Gm-Message-State: APt69E01LI0/E2JFyswtJir2QWSdy/sx+IXb9C/MvKZABA36rqV88q9V
        ktFjltKif97fHHL8rNkse6X7Bg==
X-Google-Smtp-Source: AAOMgpfZ8ggV2eTD26Rr1lPxEz5gPO+D91YUgugpEGheuy+P+DzpUue0bw+vIHCc5vfStstK+Rs+Bw==
X-Received: by 2002:a62:dc8f:: with SMTP id c15-v6mr11591635pfl.155.1530899583257;
        Fri, 06 Jul 2018 10:53:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p26-v6sm18682669pfi.164.2018.07.06.10.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:53:02 -0700 (PDT)
Date:   Fri, 6 Jul 2018 10:53:01 -0700
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
Message-ID: <20180706175301.GG129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
 <20180703234705.227473-6-mka@chromium.org>
 <5B3C6C2A.1070205@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B3C6C2A.1070205@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:

> Firstly,
> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> 
> devfreq already used the OPP interface as default. It means that
> the outside of 'drivers/devfreq' can disable/enable the frequency
> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> drivers disable/enable the specific frequency, the devfreq core
> consider them.
> 
> So, devfreq doesn't need to devfreq_verify_within_limits() because
> already support some interface to change the minimum/maximum frequency
> of devfreq device. 
> 
> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> to change the minimum/maximum frequency of cpu. some device driver cannot
> change the minimum/maximum frequency through OPP interface.
> 
> But, in case of devfreq subsystem, as I explained already, devfreq support
> the OPP interface as default way. devfreq subsystem doesn't need to add
> other way to change the minimum/maximum frequency.

Using the OPP interface exclusively works as long as a
enabling/disabling of OPPs is limited to a single driver
(drivers/thermal/devfreq_cooling.c). When multiple drivers are
involved you need a way to resolve conflicts, that's the purpose of
devfreq_verify_within_limits(). Please let me know if there are
existing mechanisms for conflict resolution that I overlooked.

Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
devfreq_verify_within_limits() instead of the OPP interface if
desired, however this seems beyond the scope of this series.

> Secondly,
> This patch send the 'struct devfreq_policy' instance as the data
> when sending the notification as following:
> 
> 	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
> 			DEVFREQ_ADJUST, policy);
> 
> But, I think that if devfreq core sends the 'struct devfreq_freq_limits'
> instance instead of 'struct devfreq_policy', it is enough.
> Because receiver of DEVFREQ_ADJUST just will use the min_freq/max_freq variables.
> 
> So, I tried to find the cpufreq's case. The some device drivers using
> CPUFREQ_POLICY_NOTIFIER uses following variables of 'struct cpufreq_policy'.
> It means that receiver of CPUFREQ_POLICY_NOTIFIER don't need to other
> information/variables except for min/max frequency.
> 
> - policy->min
> - policy->max
> - policy->cpuinfo.max_freq
> - policy->cpuinfo.min_freq
> - policy->cpu : not related to devfreq)
> - policy->related_cpus : not related to devfreq)
> 
> - list of device drivers using CPUFREQ_POLICY_NOTIFIER (linux kernel is v4.18-rc1)
> $ grep -rn "CPUFREQ_POLICY_NOTIFIER" .
> ./drivers/macintosh/windfarm_cpufreq_clamp.c
> ./drivers/thermal/cpu_cooling.c
> ./drivers/thermal/cpu_cooling.c
> ./drivers/acpi/processor_thermal.c
> ./drivers/acpi/processor_thermal.c
> ./drivers/acpi/processor_perflib.c
> ./drivers/acpi/processor_perflib.c
> ./drivers/base/arch_topology.c
> ./drivers/base/arch_topology.c
> ./drivers/video/fbdev/sa1100fb.c
> ./drivers/video/fbdev/pxafb.c
> ./drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> ./drivers/cpufreq/cpufreq.c
> ./drivers/cpufreq/cpufreq.c
> ./drivers/cpufreq/cpufreq.c
> ./drivers/cpufreq/cpufreq.c

Thanks for your investigation.

I decided to mirror the cpufreq interface for consistency, but I agree
that 'struct devfreq_freq_limits' could be passed instead of the
policy object. I'm fine with changing that.

> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> > Policy notifiers are called before a frequency change and may narrow
> > the min/max frequency range in devfreq_policy, which is used to adjust
> > the target frequency if it is beyond this range.
> > 
> > Also add a few helpers:
> >  - devfreq_verify_within_[dev_]limits()
> >     - should be used by the notifiers for policy adjustments.
> >  - dev_to_devfreq()
> >     - lookup a devfreq strict from a device pointer
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Changes in v5:
> > - none
> > 
> > Changes in v4:
> > - Fixed typo in commit message: devfreg => devfreq
> > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > 
> > Changes in v3:
> > - devfreq.h: fixed misspelling of struct devfreq_policy
> > 
> > Changes in v2:
> > - performance, powersave and simpleondemand governors don't need changes
> >   with "PM / devfreq: Don't adjust to user limits in governors"
> > - formatting fixes
> > ---
> >  drivers/devfreq/devfreq.c | 48 ++++++++++++++++++++++-------
> >  include/linux/devfreq.h   | 65 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 102 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 21604d6ae2b8..4cbaa7ad1972 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -72,6 +72,21 @@ static struct devfreq *find_device_devfreq(struct device *dev)
> >  	return ERR_PTR(-ENODEV);
> >  }
> >  
> > +/**
> > + * dev_to_devfreq() - find devfreq struct using device pointer
> > + * @dev:	device pointer used to lookup device devfreq.
> > + */
> > +struct devfreq *dev_to_devfreq(struct device *dev)
> > +{
> > +	struct devfreq *devfreq;
> > +
> > +	mutex_lock(&devfreq_list_lock);
> > +	devfreq = find_device_devfreq(dev);
> > +	mutex_unlock(&devfreq_list_lock);
> > +
> > +	return devfreq;
> > +}
> > +
> >  static unsigned long find_available_min_freq(struct devfreq *devfreq)
> >  {
> >  	struct dev_pm_opp *opp;
> > @@ -269,20 +284,21 @@ int update_devfreq(struct devfreq *devfreq)
> >  	if (!policy->governor)
> >  		return -EINVAL;
> >  
> > +	policy->min = policy->devinfo.min_freq;
> > +	policy->max = policy->devinfo.max_freq;
> 
> Why don't you consider 'policy->user.max/min_freq' as following?
> As I already commented, I think that 'struct devfreq_freq_limits' is enough
> instead of 'struct devfreq_policy'.
> 
> 	->max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
> 	->min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);

You mean limiting the frequency range with user.min/max before
DEVFREQ_ADJUST instead of adjusting it afterwards? That's fine with
me.

Thanks

Matthias
