Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4/oxmabHzeEN8YRw0iJbrAkjznrxOqtDOUIMe6WJsX2YcShZiq75SrCyfO++6pKwS82Jb4e
ARC-Seal: i=1; a=rsa-sha256; t=1523368606; cv=none;
        d=google.com; s=arc-20160816;
        b=UzDYGCtHhGTmW2xSQpRpHB43U5dRHoitupjARqQN3NduhlBSdbqI8h23iZpqmL+nKc
         hZqIHLbBDvCr7qIaYop9MGoAEtbFwoQ+QZkrfSoptldSOzwg37/2ZuoH7ReJ8MSejfAB
         DFhPL/S6OQkB+sZPtcqSzKu0K9OzrEqi2EjqLVhFm4hibGFTgpVmslaB2FQa1XjqjwSt
         l1uOsqz18mBAnxxsDFizdYFB+KOfKNw2a7taxSJmxXjp6/mvHnD0T6HZS6tkqLz9Imfn
         IniXP0yq3CNwLjaALzoVm6kvUxW3DpUrdvCaT/djn9Y8sb4eUWq3RfB8AT1TjhkiTw0B
         HZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=tG/OVs4d9vYQy9otdxqzxNkFQNrkxn+SlkTec2hVYi8=;
        b=mJ9gmo7zB64FiFSQOm8An8g2cc3pxQXbR49V3totZ8MCbZe/yGcKxahwSEfJEAwOA3
         nhgzu/ZBHqMrWnsN/6EAlTp302d30rGwxARJ5HkOehf+hM6hXAlHgUPJY1TNutx644ST
         eWKCr9O0ZV5qekO8ycbHAfq+4DIuyFx2vu8T1U3T3FcebSpvtBSWVPHbMopp1z5paqQI
         +r1C9Ip+c+QM5b1H9yDasV4eJFl2zr0GQCwjYbeM25/29C7dd36ZfyMjEz51Az2X7TMS
         mzkozRmHOqyTFVWGX8J92Na3bb62jEK9+nMzMdGwHSMCej/m5Z1c2XEcZkWUW/IyfeaH
         Cw4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Tue, 10 Apr 2018 14:56:41 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180410135640.GB3866@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180410125105.GC4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410125105.GC4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1597367760309194089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 10 Apr 2018 at 14:51:05 (+0200), Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:
> > +static inline
> > +struct capacity_state *find_cap_state(int cpu, unsigned long util)
> > +{
> > +	struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
> > +	struct capacity_state *cs = NULL;
> > +	int i;
> > +
> > +	util += util >> 2;
> > +
> > +	for (i = 0; i < em->nr_cap_states; i++) {
> > +		cs = &em->cap_states[i];
> > +		if (cs->cap >= util)
> > +			break;
> > +	}
> > +
> > +	return cs;
> > +}
> 
> So in the last thread there was some discussion about this; in
> particular on how this related to schedutil and if we should tie it into
> that.
> 
> I think for starters tying it to schedutil is not a bad idea; ideally
> people _should_ migrate towards using that.
> 
> Also; I think it makes sense to better integrate cpufreq and the
> energy-model values like what rjw already suggested, such that maybe we
> can have cpufreq_driver_resolve_freq() return a structure containing the
> relevant information for the selected frequency.

I guess if we want to do that in the wake-up path, we would also need to
add a new parameter to it to make sure we don't actually call into
cpufreq_driver->resolve_freq() ...

But then, we could sort of rely on cpufreq_schedutil.c::get_next_freq()
to replace find_cap_state() ... Is this what you had in mind ?

> 
> But implementing the frequency selection thing in multiple places like
> now sounds like a very bad idea to me.

Understood. Making sure we share the same code everywhere might have
consequences though. I guess we'll have to either accept the cost of
function calls in the wake-up path, or to accept to inline those
functions for ex. Or maybe you had something else in mind ?

Anyways, that's probably another good discussion topic for OSPM
next week :-)

Thanks,
Quentin
