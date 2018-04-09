Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx48ZMPihRWtmFYHm98c1xgNjcP5N7Dhxgy8ujEsetOGWU7Id7OIsepxRGvxwD/ShIn8cjyo6
ARC-Seal: i=1; a=rsa-sha256; t=1523287966; cv=none;
        d=google.com; s=arc-20160816;
        b=KghTNXhjye0HyYfObAfAJKujUzV3E7XoN90d7e63PWnIdQa33EK91MYT9z+1/oMutT
         aVNgyDphztyxi9gnKQP1tc9KZlxLcInx3N8aYoHZUWffiWM4qes+EBB+FHGMw1iwjRNK
         3QFOLXiOwXoFuVyNuFoW8BoDdzQMgx/RYGbHtUoRWJGOgIY5sXkB/ODw2OYAA1Wf9x+o
         EUY34/4IoA5ubXoKQCsdnxOzl+KtMGRJyHP6vSPubVC5+hkLqC4Fro8mCR4e8USQsRfv
         EgLJhMWDziTrNpqr+p9KTGmOsgk+2BAtc3r0SQ4nzjNEkxnJ5GAqUG0zGzoJzRj11FAG
         dd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=NOl0zw4jUepmJD7CM24FH6GHdvdIbJxz7aNV453UEus=;
        b=siAX+Qdfypru3xL10cbxx/NzV2hlwi0jJnDVAJq/qzFDRnAZmwGS6qQ+C3j5uKWqYm
         Ltafrnrol1U3AOm9RnnzDzyTyYbyNUEEOAtHM/TKXUJC/JMSGo66quTnvC4mArBRa+A6
         cGtmijgcHs1TtAZJ4nH8PIN/3uxew/O3oeSf2nQzRrtfQxk39Rv0RQ7O+RMxWYqGM9Xf
         i9Edpt7ii6eEG1tAbABsBjoDFFCbjaWJIT3mUl0yBNmSSEY9OEqZyXyshBsccG1kKC0/
         Phw4tO9Dkpi1fVYw6ctBQaTLLRfi9qrLz0G9Uvnvvw+/u3qAV5pXB4WmhtaauRlhkQeB
         ppEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=yPwuVk+6;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=yPwuVk+6;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 9 Apr 2018 17:32:33 +0200
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
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180409153233.GA4082@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1597283202285431144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:

> In this specific patch, we are basically trying to figure out the
> boundaries of frequency domains, and the power consumed by each CPU
> at each OPP, to make them available to the scheduler. The important
> thing here is that, in both cases, we rely on the OPP library to
> keep the code as platform-agnostic as possible.

AFAICT the only users of this PM_OPP stuff is a bunch of ARM platforms.
Granted, body else has build a big.little style system, so that might
all be fine I suppose.

It won't be until some !ARM chip comes along that we'll know how
generically usable any of this really is.

> In the case of the frequency domains for example, the cpufreq driver is
> in charge of specifying the CPUs that are sharing frequencies. That
> information can come from DT, or SCPI, or SCMI, or whatever -- we
> probably shouldn't have to care about that from the scheduler's
> standpoint. That's why using dev_pm_opp_get_sharing_cpus() is handy,
> the OPP library gives us the digested information we need.

So I kinda would've expected to just ask cpufreq, that after all already
knows these things. Why did we need to invent this pm_opp thing?

Cpufreq has a tons of supported architectures, pm_opp not so much.

> The power values (dev_pm_opp_get_power) we use right now are those
> already used by the thermal subsystem (IPA), which means we don't have

I love an IPA style beer, but I'm thinking that's not the same IPA,
right :-)

> to introduce any new DT binding whatsoever. In a close future, the power
> values could also come from other sources (SCMI for ex), and again it's
> probably not the scheduler's job to care about those things, so the OPP
> library is helping us again. As mentioned in the notes, as of today, this
> approach has dependencies on other patches relating to these things which
> are already on the list [1].

Is there any !ARM thermal driver? (clearly I'm not up-to-date on things
thermal).
