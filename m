Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521854037; cv=none;
        d=google.com; s=arc-20160816;
        b=MmauQrAJDsjtl1tH+qQHq8bTs/NipsKn1l10QHFS142oJADsHEOCff4zZ+xBTfI5Dn
         5Zs3aBxTyUgsEpcsBb9LA19cIYpFqEXcGjUdtOYjtpMOdOxI0b3BqJwbsOkmM0y5l/n2
         u1wF7aOQaedXHU42dUR3inzlP+YneKwjcxEwzdvd1l2laxro17huqUb+8Ebqk/oS+Pqv
         UffouMh8vwqY5B9x/8mVPu6FqVinjj+YnEPx2cYP107vpCduOGkOyglSty0LObT1cM7A
         5wekD9yBoJlFDR6LjDueEsksndQ749dYEwkGrPagMoJMupoUIFA4s0rbmL6Q43XJOmYb
         3TaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zi7XLDws8ZZ3Y9boerJs+GnLXPMT18HD2jd6rlW5WbI=;
        b=WaeDV1BroBqtYv/uwjMvWqauwze70nRjfmZN5+kUarABJQtUYKKj+4HiTf00m1fAGu
         HxP1KMTP+VBp0iSAQXCs4Lq7cEUh3Lts3qgmfbQ7j4HY1V2jGw/cVHKOEGOEiGyrU0jV
         UBDxjyZe85DVJ3F2QBsKjnXeva3Ajc1P1bfUBb280s8W1nSCZZDa3vz+5nmi/Weoxukj
         4yNIBRk8J8d+QhvuVwWhUUcr9UlGhp2NofS6x5VJzLO0xpxEuHC9+fOLB+CKuPKTGqea
         pZ60Nooy7i9ZHtFdOW7kBbiebzkKx/691u7YhL8HuUBjtOfBsbdrGxKrl4ARJ+qxDP7A
         8UtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OlzVDNeD;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OlzVDNeD;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELuu2ZQJQQEiBEkKYpSMrWSTZP/Vg1rWeMRGLl6bfoKYzMtVvmdZAsROCKkvbZG45YblgEL18mkqlUezs7ECe7A=
MIME-Version: 1.0
In-Reply-To: <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com> <20180321153518.GC13951@e110439-lin>
 <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com> <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 23 Mar 2018 18:13:56 -0700
Message-ID: <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>, Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595779619375361617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Morten,

On Fri, Mar 23, 2018 at 8:47 AM, Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
> On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:
>> On Wed, Mar 21, 2018 at 8:35 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>> > [...]
>> >
>> >> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>> >>                       break;
>> >>               }
>> >>
>> >> +             /*
>> >> +              * Energy-aware task placement is performed on the highest
>> >> +              * non-overutilized domain spanning over cpu and prev_cpu.
>> >> +              */
>> >> +             if (want_energy && !sd_overutilized(tmp) &&
>> >> +                 cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
>> >> +                     energy_sd = tmp;
>> >> +
>> >
>> > Not entirely sure, but I was trying to understand if we can avoid to
>> > modify the definition of want_affine (in the previous chunk) and move
>> > this block before the previous "if (want_affine..." (in mainline but
>> > not in this chunk), which will became an else, e.g.
>> >
>> >         if (want_energy && !sd_overutilized(tmp) &&
>> >                 // ...
>> >         else if (want_energy && !sd_overutilized(tmp) &&
>> >                 // ...
>> >
>> > Isn't that the same?
>> >
>> > Maybe there is a code path I'm missing... but otherwise it seems a
>> > more self contained modification of select_task_rq_fair...
>>
>> Just replying to this here Patrick instead of the other thread.
>>
>> I think this is the right place for the block from Quentin quoted
>> above because we want to search for the highest domain that is
>> !overutilized and look among those for the candidates. So from that
>> perspective, we can't move the block to the beginning and it seems to
>> be in the right place. My main concern on the other thread was
>> different, I was talking about the cases where sd_flag & tmp->flags
>> don't match. In that case, sd = NULL would trump EAS and I was
>> wondering if that's the right thing to do...
>
> You mean if SD_BALANCE_WAKE isn't set on sched_domains?

Yes.

> The current code seems to rely on that flag to be set to work correctly.
> Otherwise, the loop might bail out on !want_affine and we end up doing
> the find_energy_efficient_cpu() on the lowest level sched_domain even if
> there is higher level one which isn't over-utilized.
>
> However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is set so
> sd == NULL shouldn't be possible? This only holds as long as we only
> want EAS for asymmetric systems.

Yes, I see you had topology code that set SD_BALANCE_WAKE for ASYM. It
makes sense to me then, thanks for the clarification.

Still I feel it is a bit tedious/confusing when reading code to draw
the conclusion about why sd is checked first before doing
find_energy_efficient_cpu (and that sd will != NULL for ASYM systems).
If energy_sd is set, then we can just proceed with EAS without
checking that sd != NULL. This function in mainline is already pretty
confusing as it is :-(

Regards,

- Joel
