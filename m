Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx48s3q3Ks0qnM3/Z3kox96ss3v2HlPB+SVwkv21rHB2yDvdYuc4iIfwpDFc92oCnT5AJ2S3U
ARC-Seal: i=1; a=rsa-sha256; t=1523369347; cv=none;
        d=google.com; s=arc-20160816;
        b=a1eCfwpGHBjvUoLoOsaGBbUrrcRmIGpZeyIb97Kajqb7+slb/7IsXM9Rq4QJtwhLmI
         M6QQJNA5nJSA7B7ljk5GeaeNeb2P1m6gQyD+hLaSJBpKGEakJ/tDB+y2P4kbiIs6J9IU
         KRgZPctVJG2Iy8Bezqes2vcSQoLU8/tZvIk4RwW9RLkbvWRQBB+CangQTO3gRnAYt4YE
         tN7UmZ6WSrpR9odfYZdCUjN4G/oStUhd6wSBqRA9ZYw4GYCuc6zCQt3sTn3VrMH2/JS8
         rjD4G/jnxx9sxTe15MpJ4sQ+S1Bb2VYtp6iGJUwMBaE1PIwN/3aANm0DGLAmFKXSAxzE
         wvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=uSPRzC/9Pq7rqgLqjqUPgiYg0Xa9+2gOyoxwES/t2po=;
        b=o7kSVj2guLmCxAx6c31HAlgpF43eXKmiyGgN+Ya6uDzFeYGWS0Yv1wUCc1HQPxf2cV
         zrTOW40O2UEH+htUs8+789i8htXzsGG2iqL3aGVH7vdwTn9SYSPz+XryY2a8WDWL7P1N
         PFKvoMCSeODRCCA3buYQEyZR30oIfkcBVRegnuVkDY8G3UDLT8BNxnD6xqFvHMK/SkJy
         xiXiX0FWOgd947KFU3MqYWqXJYcKNs3QeQbkOooXTRC58xjoSjv5Xrbfs/YEDBJPOdiX
         9t8dtfXHtDYhwbrb+z9tz45b0uLfh75b53n7yvcVu5t15Z0LqKVOu948edsuT0saE6Vz
         93YA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ITMpiIpj;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ITMpiIpj;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 10 Apr 2018 16:08:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Quentin Perret <quentin.perret@arm.com>
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
Message-ID: <20180410140853.GG4082@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180410125105.GC4043@hirez.programming.kicks-ass.net>
 <20180410135640.GB3866@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410135640.GB3866@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1597368537044290779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 02:56:41PM +0100, Quentin Perret wrote:
> > So in the last thread there was some discussion about this; in
> > particular on how this related to schedutil and if we should tie it into
> > that.
> > 
> > I think for starters tying it to schedutil is not a bad idea; ideally
> > people _should_ migrate towards using that.
> > 
> > Also; I think it makes sense to better integrate cpufreq and the
> > energy-model values like what rjw already suggested, such that maybe we
> > can have cpufreq_driver_resolve_freq() return a structure containing the
> > relevant information for the selected frequency.
> 
> I guess if we want to do that in the wake-up path, we would also need to
> add a new parameter to it to make sure we don't actually call into
> cpufreq_driver->resolve_freq() ...
> 
> But then, we could sort of rely on cpufreq_schedutil.c::get_next_freq()
> to replace find_cap_state() ... Is this what you had in mind ?

Yes, something along those lines; we could also of course factor
get_next_freq() into two parts.

> > But implementing the frequency selection thing in multiple places like
> > now sounds like a very bad idea to me.
> 
> Understood. Making sure we share the same code everywhere might have
> consequences though. I guess we'll have to either accept the cost of
> function calls in the wake-up path, or to accept to inline those
> functions for ex. Or maybe you had something else in mind ?
> 
> Anyways, that's probably another good discussion topic for OSPM
> next week :-)

Yes, that wants a wee bit of discussion. Ideally we'd have a shared data
structure we can iterate instead of a chain of indirect calls.
