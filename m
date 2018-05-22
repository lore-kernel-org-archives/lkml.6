Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEVKC3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:02:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40252 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEVKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:02:26 -0400
X-Google-Smtp-Source: AB8JxZrdQVJ96aJTCi4Hbdiq7uloTFdRgWjxSKeYpWQsDf6S91kmS2E3/2L46+TjKqq5zsynN0mzkSnez+m20FoP5M4=
MIME-Version: 1.0
In-Reply-To: <20180521161346.GB14065@joelaf.mtv.corp.google.com>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521051424.mljwmisvrvi6yyc4@vireshk-i7> <CAJZ5v0jbJ3HfLyP6VZ2PuG0q1n=faX3G98ruwK-o1ro+gv7B9w@mail.gmail.com>
 <20180521161346.GB14065@joelaf.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 12:02:24 +0200
X-Google-Sender-Auth: Z4TAX-EtT-k6ZPlnTCJzWwBBE6s
Message-ID: <CAJZ5v0hucyBEyWoz8nS=6pfwt8Yd5Wi+39=2WGFgfJobv7=qPQ@mail.gmail.com>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when
 kthread kicked
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 6:13 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, May 21, 2018 at 10:29:52AM +0200, Rafael J. Wysocki wrote:
>> On Mon, May 21, 2018 at 7:14 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 18-05-18, 11:55, Joel Fernandes (Google.) wrote:
>> >> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> >>
>> >> Currently there is a chance of a schedutil cpufreq update request to be
>> >> dropped if there is a pending update request. This pending request can
>> >> be delayed if there is a scheduling delay of the irq_work and the wake
>> >> up of the schedutil governor kthread.
>> >>
>> >> A very bad scenario is when a schedutil request was already just made,
>> >> such as to reduce the CPU frequency, then a newer request to increase
>> >> CPU frequency (even sched deadline urgent frequency increase requests)
>> >> can be dropped, even though the rate limits suggest that its Ok to
>> >> process a request. This is because of the way the work_in_progress flag
>> >> is used.
>> >>
>> >> This patch improves the situation by allowing new requests to happen
>> >> even though the old one is still being processed. Note that in this
>> >> approach, if an irq_work was already issued, we just update next_freq
>> >> and don't bother to queue another request so there's no extra work being
>> >> done to make this happen.
>> >
>> > Now that this isn't an RFC anymore, you shouldn't have added below
>> > paragraph here. It could go to the comments section though.
>> >
>> >> I had brought up this issue at the OSPM conference and Claudio had a
>> >> discussion RFC with an alternate approach [1]. I prefer the approach as
>> >> done in the patch below since it doesn't need any new flags and doesn't
>> >> cause any other extra overhead.
>> >>
>> >> [1] https://patchwork.kernel.org/patch/10384261/
>> >>
>> >> LGTMed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >> LGTMed-by: Juri Lelli <juri.lelli@redhat.com>
>> >
>> > Looks like a Tag you just invented ? :)
>>
>> Yeah.
>>
>> The LGTM from Juri can be converned into an ACK silently IMO.  That
>> said I have added Looks-good-to: tags to a couple of commits. :-)
>
> Cool, I'll covert them to Acks :-)

So it looks like I should expect an update of this patch, right?

Or do you prefer the current one to be applied and work on top of it?

> [..]
>> >> v1 -> v2: Minor style related changes.
>> >>
>> >>  kernel/sched/cpufreq_schedutil.c | 34 ++++++++++++++++++++++++--------
>> >>  1 file changed, 26 insertions(+), 8 deletions(-)
>> >>
>> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> >> index e13df951aca7..5c482ec38610 100644
>> >> --- a/kernel/sched/cpufreq_schedutil.c
>> >> +++ b/kernel/sched/cpufreq_schedutil.c
>> >> @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>> >>           !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>> >>               return false;
>> >>
>> >> -     if (sg_policy->work_in_progress)
>> >> -             return false;
>> >> -
>> >>       if (unlikely(sg_policy->need_freq_update)) {
>> >>               sg_policy->need_freq_update = false;
>> >>               /*
>> >> @@ -128,7 +125,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>> >>
>> >>               policy->cur = next_freq;
>> >>               trace_cpu_frequency(next_freq, smp_processor_id());
>> >> -     } else {
>> >> +     } else if (!sg_policy->work_in_progress) {
>> >>               sg_policy->work_in_progress = true;
>> >>               irq_work_queue(&sg_policy->irq_work);
>> >>       }
>> >> @@ -291,6 +288,13 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>> >>
>> >>       ignore_dl_rate_limit(sg_cpu, sg_policy);
>> >>
>> >> +     /*
>> >> +      * For slow-switch systems, single policy requests can't run at the
>> >> +      * moment if update is in progress, unless we acquire update_lock.
>> >> +      */
>> >> +     if (sg_policy->work_in_progress)
>> >> +             return;
>> >> +
>> >
>> > I would still want this to go away :)
>> >
>> > @Rafael, will it be fine to get locking in place for unshared policy
>> > platforms ?
>>
>> As long as it doesn't affect the fast switch path in any way.
>
> I just realized that on a single policy switch that uses the governor thread,
> there will be 1 thread per-CPU. The sugov_update_single will be called on the
> same CPU with interrupts disabled.

sugov_update_single() doesn't have to run on the target CPU.

> In sugov_work, we are doing a
> raw_spin_lock_irqsave which also disables interrupts. So I don't think
> there's any possibility of a race happening on the same CPU between the
> frequency update request and the sugov_work executing. In other words, I feel
> we can drop the above if (..) statement for single policies completely and
> only keep the changes for the shared policy. Viresh since you brought up the
> single policy issue initially which made me add this if statememnt, could you
> let me know if you agree with what I just said?

Which is why you need the spinlock too.
