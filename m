Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELs1xV5gJgA6M9JZ+nG0tQf5T7Z3M50F+bgA0WO3xI+wwio+ceFDeR8HcYB/pZCR3Rb58Zqt
ARC-Seal: i=1; a=rsa-sha256; t=1521820071; cv=none;
        d=google.com; s=arc-20160816;
        b=jdWFtiqCDRQ+GXR26UBHjIyLfBJYjkJRgrIPT1pmWjVSB1jfAV/1Dj75u5pE7zIEsw
         adoHrVm2oqSIcfTPCdIFC/czYKX6U4347BLgRqoiZtC/o6CNsebl35FNEjNZ45Y5G7Z4
         H3B33RcduiDekpboTyQhEhJUMDbWsFbPcg2oqP+2/Ekv/qj8BWvLWW6GZ1/+yKciqFbc
         cScVCW4Iwl+gHM7p9NcJjg997FhiaoynoJEpiSDR7ex1IHxLOyO6cFCjK8vwKNfe/PA4
         IsXEJmhEFJ3g187MVcl7Jhk/sxRsOJAWpPK+jr5XAicqk/xZWxOWbMGAHaXEyN/kv5Qc
         nOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=j+D6Dk11sfbiZ9uIiDasbzzzpYQ/xThEZ5wjHKMqZwE=;
        b=V3ubxJYzYBaiM3J+M+mBr1OTd7shxIM+k39roGxQmWs9U6uMesKHz1PBkqsvKYk7E8
         CsHkT1eQcfVdrRtX6XLdmkmqLiJEnc2dWcP8dsJbPZ8ckDKKYkCJ3tBgGVgzBJlPyADS
         +WyjGfOyl/cclqpYevTlr/7NEjjQTx4MZ+tSnopvua7RYqb5hk1a/n9wUDUhsepNwyuO
         DT/ys23VFPK1EX8TjmJT1qevzgbEd/0UzpoK+8A9d+xuCkxJtqImc/Gl1LBAm107ICWx
         MDDGBgUBm2JPFwiuVvYRpKyUiAeVnE4rwjlA0sgq8bDlh6vQuB7N8ZvQr4N8r9bMwYus
         ohEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Fri, 23 Mar 2018 15:47:45 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
 <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595744003039309832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:
> On Wed, Mar 21, 2018 at 8:35 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > [...]
> >
> >> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >>                       break;
> >>               }
> >>
> >> +             /*
> >> +              * Energy-aware task placement is performed on the highest
> >> +              * non-overutilized domain spanning over cpu and prev_cpu.
> >> +              */
> >> +             if (want_energy && !sd_overutilized(tmp) &&
> >> +                 cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
> >> +                     energy_sd = tmp;
> >> +
> >
> > Not entirely sure, but I was trying to understand if we can avoid to
> > modify the definition of want_affine (in the previous chunk) and move
> > this block before the previous "if (want_affine..." (in mainline but
> > not in this chunk), which will became an else, e.g.
> >
> >         if (want_energy && !sd_overutilized(tmp) &&
> >                 // ...
> >         else if (want_energy && !sd_overutilized(tmp) &&
> >                 // ...
> >
> > Isn't that the same?
> >
> > Maybe there is a code path I'm missing... but otherwise it seems a
> > more self contained modification of select_task_rq_fair...
> 
> Just replying to this here Patrick instead of the other thread.
> 
> I think this is the right place for the block from Quentin quoted
> above because we want to search for the highest domain that is
> !overutilized and look among those for the candidates. So from that
> perspective, we can't move the block to the beginning and it seems to
> be in the right place. My main concern on the other thread was
> different, I was talking about the cases where sd_flag & tmp->flags
> don't match. In that case, sd = NULL would trump EAS and I was
> wondering if that's the right thing to do...

You mean if SD_BALANCE_WAKE isn't set on sched_domains?

The current code seems to rely on that flag to be set to work correctly.
Otherwise, the loop might bail out on !want_affine and we end up doing
the find_energy_efficient_cpu() on the lowest level sched_domain even if
there is higher level one which isn't over-utilized.

However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is set so
sd == NULL shouldn't be possible? This only holds as long as we only
want EAS for asymmetric systems.
