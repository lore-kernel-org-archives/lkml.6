Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521749423; cv=none;
        d=google.com; s=arc-20160816;
        b=GJZqda+uxkk733L05G3eOqPrHtq6tHteHbMgyNu46bsvH4bdtEXIRv8Y1eboOHx8w2
         oizdGJblWxvDt98jPEI6lFd0WcPZvKayciCTGvhLpR3MOC3jhFKxtF7e3Qp3A4CaeI/p
         DZEYu8PXDFGHLdDi/n3X+oYvDyxnIRWPVbMQ6mgRrXwekx+0qIAr9t7Q6wT0XlxFmGLz
         HpQBKV+ztutrRgj29SangyAxnlE8ndjicWWu2vI++v5m8WrIWtCIvHAynmRSHMJ988xI
         hWvCpClAlx/xybI6/blW4cAPjNScvowZDOpuZE96vANnDKU8sSdf3I+olEuzEBNTF+Fb
         8WKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=g9QSkMS50Tn9JXVs8T5RMOvPOaEWxtXO1mgEQUlaV3w=;
        b=d3uL10AAN+RieIzDpcOEF7GSjTChl2QNSHXe8zkROM8V6fDgu5vWi6Ur+RQtXmexWh
         T4rsj6gVPg56386CDYOX11NjkO4oDeTg2XVKyt7uV1i11pTuRuF2j2gYwk9LHYGw2xgr
         9NjKuJ+RjrJ6twlwGCHcPVGuVAP2qJ6lZbCUy4IuTVr1SqMIs5PlbaLGAir8IXL42/o6
         Yr3+RouEB0ArZDvQFb+UlGVg7HbD3sQjak23Tqy/u36uiud4Nrc95BxPG4ydPzLPgbcx
         6w/kf2uxrDoiSSdWyuIpJtb0e//QyKVqIdAz/5xigWePQKrRCH5jarQOs1j+JIeHHzpu
         w3fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DJAnvynr;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DJAnvynr;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELu9lFe0sQjNTbrHUDP3Z4mwDuixSPluUxeFA5MKUEUL/v/Q0QHDbdF+2wUyLdwDegY87OIO3/oPBOCbzlHpaKc=
MIME-Version: 1.0
In-Reply-To: <20180321153518.GC13951@e110439-lin>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com> <20180321153518.GC13951@e110439-lin>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 22 Mar 2018 13:10:22 -0700
Message-ID: <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
	Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595669924141649877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 8:35 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> [...]
>
>> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>>                       break;
>>               }
>>
>> +             /*
>> +              * Energy-aware task placement is performed on the highest
>> +              * non-overutilized domain spanning over cpu and prev_cpu.
>> +              */
>> +             if (want_energy && !sd_overutilized(tmp) &&
>> +                 cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
>> +                     energy_sd = tmp;
>> +
>
> Not entirely sure, but I was trying to understand if we can avoid to
> modify the definition of want_affine (in the previous chunk) and move
> this block before the previous "if (want_affine..." (in mainline but
> not in this chunk), which will became an else, e.g.
>
>         if (want_energy && !sd_overutilized(tmp) &&
>                 // ...
>         else if (want_energy && !sd_overutilized(tmp) &&
>                 // ...
>
> Isn't that the same?
>
> Maybe there is a code path I'm missing... but otherwise it seems a
> more self contained modification of select_task_rq_fair...

Just replying to this here Patrick instead of the other thread.

I think this is the right place for the block from Quentin quoted
above because we want to search for the highest domain that is
!overutilized and look among those for the candidates. So from that
perspective, we can't move the block to the beginning and it seems to
be in the right place. My main concern on the other thread was
different, I was talking about the cases where sd_flag & tmp->flags
don't match. In that case, sd = NULL would trump EAS and I was
wondering if that's the right thing to do...

thanks,

- Joel

[...]
