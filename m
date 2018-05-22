Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEVL1h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:27:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53878 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeEVL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:27:34 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Joel Fernandes (Google.)" <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        Claudio Scordino <claudio@evidence.eu.com>, kernel-team@android.com,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when kthread kicked
Date: Tue, 22 May 2018 13:26:55 +0200
Message-ID: <1572088.N2D3R5Hx9f@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0hucyBEyWoz8nS=6pfwt8Yd5Wi+39=2WGFgfJobv7=qPQ@mail.gmail.com>
References: <20180518185501.173552-1-joel@joelfernandes.org> <20180521161346.GB14065@joelaf.mtv.corp.google.com> <CAJZ5v0hucyBEyWoz8nS=6pfwt8Yd5Wi+39=2WGFgfJobv7=qPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 22, 2018 12:02:24 PM CEST Rafael J. Wysocki wrote:
> On Mon, May 21, 2018 at 6:13 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Mon, May 21, 2018 at 10:29:52AM +0200, Rafael J. Wysocki wrote:
> >> On Mon, May 21, 2018 at 7:14 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> > On 18-05-18, 11:55, Joel Fernandes (Google.) wrote:
> >> >> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >> >>
> >> >> Currently there is a chance of a schedutil cpufreq update request to be
> >> >> dropped if there is a pending update request. This pending request can
> >> >> be delayed if there is a scheduling delay of the irq_work and the wake
> >> >> up of the schedutil governor kthread.
> >> >>
> >> >> A very bad scenario is when a schedutil request was already just made,
> >> >> such as to reduce the CPU frequency, then a newer request to increase
> >> >> CPU frequency (even sched deadline urgent frequency increase requests)
> >> >> can be dropped, even though the rate limits suggest that its Ok to
> >> >> process a request. This is because of the way the work_in_progress flag
> >> >> is used.
> >> >>
> >> >> This patch improves the situation by allowing new requests to happen
> >> >> even though the old one is still being processed. Note that in this
> >> >> approach, if an irq_work was already issued, we just update next_freq
> >> >> and don't bother to queue another request so there's no extra work being
> >> >> done to make this happen.
> >> >
> >> > Now that this isn't an RFC anymore, you shouldn't have added below
> >> > paragraph here. It could go to the comments section though.
> >> >
> >> >> I had brought up this issue at the OSPM conference and Claudio had a
> >> >> discussion RFC with an alternate approach [1]. I prefer the approach as
> >> >> done in the patch below since it doesn't need any new flags and doesn't
> >> >> cause any other extra overhead.
> >> >>
> >> >> [1] https://patchwork.kernel.org/patch/10384261/
> >> >>
> >> >> LGTMed-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> >> LGTMed-by: Juri Lelli <juri.lelli@redhat.com>
> >> >
> >> > Looks like a Tag you just invented ? :)
> >>
> >> Yeah.
> >>
> >> The LGTM from Juri can be converned into an ACK silently IMO.  That
> >> said I have added Looks-good-to: tags to a couple of commits. :-)
> >
> > Cool, I'll covert them to Acks :-)
> 
> So it looks like I should expect an update of this patch, right?
> 
> Or do you prefer the current one to be applied and work on top of it?

Well, sorry, I can't apply this one as it is racy.
