Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521936742; cv=none;
        d=google.com; s=arc-20160816;
        b=NmaGrk6Fq/JEn9UlarKG+KXuYegOjetg1o/rVWSwwQnBx9WGKgcWl7gg+N3bRcioqb
         PdbMo2FaC3zVenLRnP62nhSqNWvY6MqIbe34aUVc/Lk50FHbejRhvUSpypLCNy3IqAnq
         tGVd0BKvupovTUu+pzN8jqHMATOY3YxUtP/HB2GdiElpA8wQchvpQzNJl/Q/wq7N6wea
         LrPwKF6uy5g81vwV9GSI4dUb6Ogcks3uYna/6YGyX+ZdPnAKr3OAjc1x0RstR7snkCXZ
         noL3TBCwPFFktw0GEGrJSARLzwixhpMOEVaRkv59DzxpwXBHm9yNt9bERnj9e/h5o6/0
         NwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JZvNnb5hENdS5DcCL7+X22Cblh2fGwDmQxtZtirFia0=;
        b=eo0/AJds1/lRK0K8u6/QHm544jOANxrm9uvq2yT20yUyY3oCGWkdUQHpQ/G1LjyFvA
         844kD8eF173TLxJ1i6L45WVtd3Lqs82wuvzhSlarJuTlmExE/V4ZMh3NrHOmyRCVJqd8
         Pp5pqXK3Jj/knwMXkxZgRmQ1TX66yTRVzWypHtAcGLwILOPxbCfry/nOq2JV/f/NbfwA
         50HLLyrXCCUo0pDs5SWyyIaIb4N8zAiGVj810+TP1XXAZzmzFdfA57qgi7cVstoYY0ac
         hgzbk92xe/tMyyKoSaarIno491rnFiBHzXDKhBPGrRMjB6e4aqGSrF+tp6NtegTZh6bq
         cIWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vaUz3vdo;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=vaUz3vdo;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/JCj6T6mBnbHyqb7uO2MzdhroM1ax5qr8s+vL4FpmMG0cz8fqpF7M9rS2XaTXe+IwH5s2Vev3hgHbn8RxOY1s=
MIME-Version: 1.0
In-Reply-To: <20180324014757.GC1317@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com> <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
 <20180322180623.GE13951@e110439-lin> <CAJWu+oohaZbdk5oWZjLC-t1oY3cO3UuxbqvjgN+L+Do0mAag3Q@mail.gmail.com>
 <20180324014757.GC1317@queper01-VirtualBox>
From: Joel Fernandes <joelaf@google.com>
Date: Sat, 24 Mar 2018 17:12:20 -0700
Message-ID: <CAJWu+oqVYFT2fNw6nOE2z4sHLU9+o+ZdyfF3XHNo86K9kZJsUw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
To: Quentin Perret <quentin.perret@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
	Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595866342064634911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 6:47 PM, Quentin Perret <quentin.perret@arm.com> wrote:
> On Thursday 22 Mar 2018 at 13:19:03 (-0700), Joel Fernandes wrote:
>> On Thu, Mar 22, 2018 at 11:06 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> >> > @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>> >> >                         break;
>> >> >                 }
>> >> >
>> >> > +               /*
>> >> > +                * Energy-aware task placement is performed on the highest
>> >> > +                * non-overutilized domain spanning over cpu and prev_cpu.
>> >> > +                */
>> >> > +               if (want_energy && !sd_overutilized(tmp) &&
>> >> > +                   cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
>> >>
>> >> Shouldn't you check for the SD_ASYM_CPUCAPACITY flag here for tmp level?
>> >
>> > ... and this then should be covered by the previous check in
>> > wake_energy(), which sets want_energy.
>>
>> Right, but in a scenario which probably doesn't exist today where we
>> have both SD_ASYM_CPUCAPACITY and !SD_ASYM_CPUCAPACITY domains in the
>> hierarchy for which want_energy = 1, I was thinking if its more future
>> proof to check it and not make assumptions...
>
> So we can definitely have cases where SD_ASYM_CPUCAPACITY is not set at all
> sd levels. Today, on mobile systems, this flag is typically set only at DIE
> level for big.LITTLE platforms, and not at MC level.
> We enable EAS if we find _at least_ one domain that has this flag in the
> hierarchy, just to make sure we don't enable EAS for symmetric platform.
> It's just a way to check a property about the topology when EAS starts, not
> really a way to actually select the sd at which we do scheduling at
> runtime.

Yes Ok you're right we do have the ASYM flag set at some sd levels but
not others at the moment. Sorry about the hasty comment. I understand
what you're doing now, I am Ok with that.

thanks,

- Joel
