Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeE2JsE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:48:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40640 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbeE2Jrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:47:55 -0400
X-Google-Smtp-Source: ADUXVKK7faXpiwFXjPwT+7sIHgCP0SCVXzbykZRexqpHELsg9LCQnJiMzTPjnRKgcEvvU4sHRqo+NA==
Date: Tue, 29 May 2018 11:47:50 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joelaf@google.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180529094750.GC8985@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
 <20180528101234.GA1293@localhost.localdomain>
 <20180529050833.GA226378@joelaf.mtv.corp.google.com>
 <20180529063158.GB8985@localhost.localdomain>
 <CAKfTPtBuB42SX4HoPcCc02fWKoL=TULEci0-bFRrXT=jvMQTtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBuB42SX4HoPcCc02fWKoL=TULEci0-bFRrXT=jvMQTtA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/18 08:48, Vincent Guittot wrote:
> On 29 May 2018 at 08:31, Juri Lelli <juri.lelli@redhat.com> wrote:
> > On 28/05/18 22:08, Joel Fernandes wrote:
> >> On Mon, May 28, 2018 at 12:12:34PM +0200, Juri Lelli wrote:
> >> [..]
> >> > > +
> >> > > + util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
> >> > > +
> >> > > + return util;
> >> >
> >> > Anyway, just a quick thought. I guess we should experiment with this a
> >> > bit. Now, I don't unfortunately have a Arm platform at hand for testing.
> >> > Claudio, Luca (now Cc-ed), would you be able to fire some tests with
> >> > this change?
> >> >
> >> > Oh, adding Joel and Alessio as well that experimented with DEADLINE
> >> > lately.
> >>
> >> I also feel that for power reasons, dl.util_avg shouldn't drive the OPP
> >> beyond what the running bandwidth is, or atleast do that only if CFS tasks
> >> are running and being preempted as you/Vincent mentioned in one of the
> >> threads.
> >
> > It's however a bit awkward that we might be running at a higher OPP when
> > CFS tasks are running (even though they are of less priority). :/
> 
> Even if cfs task has lower priority that doesn't mean that we should
> not take their needs into account.
> In the same way, we run at max OPP as soon as a RT task is runnable

Sure. What I fear is a little CFS utilization generating spikes because
dl.util_avg became big when running DL tasks. Not sure that can happen
though because such DL tasks should be throttled anyway.
