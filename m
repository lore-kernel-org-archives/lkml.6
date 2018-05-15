Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeEOFMs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:12:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43561 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeEOFMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:12:46 -0400
X-Google-Smtp-Source: AB8JxZoErpeOByaoJNs3EAB7Pk+ByVTbkXt74wt/R/cyktlQPDhnpJe8cpS6goC9S0qY61yavyl2Qg==
Date: Tue, 15 May 2018 10:42:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH V2] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180515051241.xdrjj6u4ssqcatvy@vireshk-i7>
References: <1525948458-23488-1-git-send-email-daniel.lezcano@linaro.org>
 <1525955163-14556-1-git-send-email-daniel.lezcano@linaro.org>
 <20180511093221.z5jfv4bo5kcdrzp4@vireshk-i7>
 <20180511115539.GC29062@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511115539.GC29062@mai>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-18, 13:55, Daniel Lezcano wrote:
> On Fri, May 11, 2018 at 03:02:21PM +0530, viresh kumar wrote:
> > On 10-05-18, 14:26, Daniel Lezcano wrote:
> > > +int idle_injection_start(struct idle_injection_device *ii_dev)
> > > +{
> > > +	if (!atomic_read(&ii_dev->idle_duration_ms))
> > > +		return -EINVAL;
> > > +
> > > +	if (!atomic_read(&ii_dev->run_duration_ms))
> > > +		return -EINVAL;
> > 
> > You are required to have them as atomic variables to take care of the
> > races while they are set ? 
> 
> The race is when you change the values, while the idle injection is acting and
> you read those values in the idle injection thread function.
> 
> > What about getting the durations as arguments to this routine then ?
> 
> May be I missed your point but I don't think that will change the above.

Well, it can. Can you explain the kind of use-cases you have in mind ?

For example, what I assumed to be the usecase was:

idle_injection_start(iidev, idle_duration, run_duration);

and then at some point of time:

idle_injection_stop(iidev);


With this, you would be required to stop the idle injection stuff to
reconfigure the durations. And then you will never have a race which
you mentioned above.

What you are trying to do is something like this:

idle_injection_set_duration(idle_duration, run_duration);
idle_injection_start(iidev);

and then at some point of time:
idle_injection_set_duration(idle_duration2, run_duration2);

and then at some point of time:
idle_injection_stop(iidev);

I am not sure if we would ever want to do something like this. Or if
stopping the idle injection to start it again is that bad of an idea.

> > > +struct idle_injection_device *
> > > +idle_injection_register(struct cpumask *cpumask, const char *name)
> > > +{
> > > +	struct idle_injection_device *ii_dev;
> > > +	struct smp_hotplug_thread *smp_hotplug_thread;
> > > +	char *idle_injection_comm;
> > > +	int cpu, ret;
> > > +
> > > +	ret = -ENOMEM;
> > 
> > Maybe merge it earlier only ?
> 
> What do you mean ? int ret = -ENOMEM ?

Yes.

-- 
viresh
