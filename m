Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeEVRHY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:07:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43395 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeEVRHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:07:20 -0400
X-Google-Smtp-Source: AB8JxZp/46+TK03+tvwxPMFOhPstuZrBjIjNGrs54PMXma7Cvo5C7f2bwBXnXUNLsAhT6IfAmNn/UlFN884L3WSyhIA=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j99Lwj0hnVoCX3Unz8UvP-cP1rmggjdonTVSwsrZmasg@mail.gmail.com>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180521051424.mljwmisvrvi6yyc4@vireshk-i7> <CAJZ5v0jbJ3HfLyP6VZ2PuG0q1n=faX3G98ruwK-o1ro+gv7B9w@mail.gmail.com>
 <20180521161346.GB14065@joelaf.mtv.corp.google.com> <CAJZ5v0hucyBEyWoz8nS=6pfwt8Yd5Wi+39=2WGFgfJobv7=qPQ@mail.gmail.com>
 <CAJZ5v0j99Lwj0hnVoCX3Unz8UvP-cP1rmggjdonTVSwsrZmasg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 19:07:19 +0200
X-Google-Sender-Auth: To1Yy9FraXaW77phCQQwFlDOfTU
Message-ID: <CAJZ5v0hSniC7ca8L7wUhvZfp2HJngoY43DcA94Z=niUiTrdRuA@mail.gmail.com>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when
 kthread kicked
To: Joel Fernandes <joel@joelfernandes.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
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

On Tue, May 22, 2018 at 5:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, May 22, 2018 at 12:02 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Mon, May 21, 2018 at 6:13 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>> On Mon, May 21, 2018 at 10:29:52AM +0200, Rafael J. Wysocki wrote:
>>>> On Mon, May 21, 2018 at 7:14 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>> > On 18-05-18, 11:55, Joel Fernandes (Google.) wrote:
>>>> >> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>>> >>
>>>> >> Currently there is a chance of a schedutil cpufreq update request to be
>>>> >> dropped if there is a pending update request. This pending request can
>>>> >> be delayed if there is a scheduling delay of the irq_work and the wake
>>>> >> up of the schedutil governor kthread.
>>>> >>
>>>> >> A very bad scenario is when a schedutil request was already just made,
>>>> >> such as to reduce the CPU frequency, then a newer request to increase
>>>> >> CPU frequency (even sched deadline urgent frequency increase requests)
>>>> >> can be dropped, even though the rate limits suggest that its Ok to
>>>> >> process a request. This is because of the way the work_in_progress flag
>>>> >> is used.
>>>> >>
>>>> >> This patch improves the situation by allowing new requests to happen
>>>> >> even though the old one is still being processed. Note that in this
>>>> >> approach, if an irq_work was already issued, we just update next_freq
>>>> >> and don't bother to queue another request so there's no extra work being
>>>> >> done to make this happen.
>>>> >
>>>> > Now that this isn't an RFC anymore, you shouldn't have added below
>>>> > paragraph here. It could go to the comments section though.
>>>> >
>>>> >> I had brought up this issue at the OSPM conference and Claudio had a
>>>> >> discussion RFC with an alternate approach [1]. I prefer the approach as
>>>> >> done in the patch below since it doesn't need any new flags and doesn't
>>>> >> cause any other extra overhead.
>>>> >>
>>>> >> [1] https://patchwork.kernel.org/patch/10384261/
>>>> >>
>>>> >> LGTMed-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> >> LGTMed-by: Juri Lelli <juri.lelli@redhat.com>
>>>> >
>>>> > Looks like a Tag you just invented ? :)
>>>>
>>>> Yeah.
>>>>
>>>> The LGTM from Juri can be converned into an ACK silently IMO.  That
>>>> said I have added Looks-good-to: tags to a couple of commits. :-)
>>>
>>> Cool, I'll covert them to Acks :-)
>>
>> So it looks like I should expect an update of this patch, right?
>>
>> Or do you prefer the current one to be applied and work on top of it?
>>
>
> [cut]
>
>>>
>>> I just realized that on a single policy switch that uses the governor thread,
>>> there will be 1 thread per-CPU. The sugov_update_single will be called on the
>>> same CPU with interrupts disabled.
>>
>> sugov_update_single() doesn't have to run on the target CPU.
>
> Which sadly is a bug IMO. :-/

My bad.

sugov_update_single() runs under rq->lock, so it need not run on a
target CPU so long as the CPU running it can update the frequency for
the target and there is the requisite check for that in
sugov_should_update_freq().

That means that sugov_update_single() will not run concurrently on two
different CPUs for the same target, but it may be running concurrently
with the kthread (as pointed out by Viresh).

>>> In sugov_work, we are doing a
>>> raw_spin_lock_irqsave which also disables interrupts. So I don't think
>>> there's any possibility of a race happening on the same CPU between the
>>> frequency update request and the sugov_work executing. In other words, I feel
>>> we can drop the above if (..) statement for single policies completely and
>>> only keep the changes for the shared policy. Viresh since you brought up the
>>> single policy issue initially which made me add this if statememnt, could you
>>> let me know if you agree with what I just said?
>>
>> Which is why you need the spinlock too.
>
> And you totally have a point.

Not really, sorry about that.

It is necessary to take the spinlock in the non-fast-switch case,
because of the possible race with the kthread, so something like my
patch at https://patchwork.kernel.org/patch/10418551/ is needed after
all.
