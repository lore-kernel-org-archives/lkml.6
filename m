Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4/5PZ97Xe6JFm3Le5VT+4HQKA0jmZ0TGGdkgROoWAG+Swujw+9zFBdXXDs3W/xuL5nY1Sid
ARC-Seal: i=1; a=rsa-sha256; t=1523361304; cv=none;
        d=google.com; s=arc-20160816;
        b=0dIhcvhK7aMjGqFcRZllOo1cMkE/8MWBKAiXIA/bBcPPMY6rVNn/u2iQ/X6phU3J9y
         dqkkg85r2rhNTBsI5spi5jrhB8R63B0j2d35njiEUup8UXWBj1O4xU+lS3WyWCMM0lBl
         gKV1UwWVBy8J1fuGsZpQ0HuwAHRFNt4Vcx3ape+I0oZY8roUphmpYCGBhVunyUn0k1//
         gWiJWP6BWhkPxM4W/OTAyc6RC4kuT/cwN6kmxmxVVxPwHVnd9NGufsw7Fe0tsHHQsdgT
         YGoWQWuteicHFm01QEwx5JWAmivITY+SwqGa9KTz+8f2b7/1eNCBw4ULHZvf6Y2Z2583
         viEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kNUQ8mH7lxvqXddoMmUwBHX6YBzBWA5S/Z80+u75PJU=;
        b=gbvkxOotAtzDIj4CncD0Gpk0pfcctAgTZT4/zl7Eic5HqIEHKaU8oN41Wssri3xeLh
         so9kCE6wOpKFq0/cf/aowzuGPkJatkdB6wOZAOheYfrrEXWhwVJx/EMvvRuPrF+eteSj
         EGBJ9v9eTe46mepLnGZaXNz8PcvULmTdY0rrf8PDjVyehdxcHZ+fasjtIQ0dgRP0S0Vi
         t/X7l+rUtEPeI+CTSLcG5bwxPntJI2fBsT0sFWquUBQNhiYoLxk9Vums0O4JhFPFqLvG
         QVKaZvKRS0pP/pm/DCU9X6Rwl0RArRE77AqIBJ3uHRt/ydyieNlL+CY+HUQFsjoXry2K
         P7xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kwECHkuq;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kwECHkuq;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 10 Apr 2018 13:54:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
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
Subject: Re: [RFC PATCH v2 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180410115457.GB4043@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-3-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011681114649781?=
X-GMAIL-MSGID: =?utf-8?q?1597360103460522422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:03PM +0100, Dietmar Eggemann wrote:
> +		/*
> +		 * Build the energy model of one CPU, and link it to all CPUs
> +		 * in its frequency domain. This should be correct as long as
> +		 * they share the same micro-architecture.
> +		 */

Aside from the whole PM_OPP question; you should assert that assumption.
Put an explicit check for the uarch in and FAIL the init if that isn't
met.

I don't think it makes _ANY_ kind of sense to share a frequency domain
across uarchs and we should be very clear we're not going to support
anything like that.

I know DynamiQ strictly speaking allows that, but since it's insane, we
should consider that a bug in DynamiQ.
