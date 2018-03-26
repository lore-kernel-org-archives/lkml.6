Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCZVob (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:44:31 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:45118 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCZVo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:44:29 -0400
X-Google-Smtp-Source: AIpwx48at7rfhnz4rnOVGrhFnHT/+OiKx5blyafJ3LtzpPdET2kLEArFJ6oGZK7jPmATO+hIlYg5ox4a5aKodE0rX9o=
MIME-Version: 1.0
In-Reply-To: <1522081932.6308.54.camel@surriel.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan> <4731938.EeADOapqQb@aspire.rjw.lan>
 <1522008952.6308.46.camel@surriel.com> <5810003.D8QGLjubHr@aspire.rjw.lan> <1522081932.6308.54.camel@surriel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Mar 2018 23:44:28 +0200
X-Google-Sender-Auth: KPgN-8_ny9WmPdbtm9L8g946ja8
Message-ID: <CAJZ5v0itoXKB+46w+yb1N5zyYF4bNsZ-1dgm2KqF2oDM426M6w@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 6:32 PM, Rik van Riel <riel@surriel.com> wrote:
> On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
>> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
>> >
>> > I plan to try two more things:
>> >
>> > 1) Disable polling on SMT systems, with
>> >    the idea that putting one thread to
>> >    sleep with monitor/mwait in C1 will
>> >    allow the other thread to run faster.
>>
>> Sounds plausible.
>
> Plausible, but wrong. Tests showed that CPU use
> during the peak load of this test increased from
> about 71% to about 78% with this change, or just
> under 10% increase relative to the baseline.
>
> Coincidentally, that is the same CPU use increase
> I have seen with the poll_idle() changes. Not sure
> if that means anything...
>
>> > 2) Insert more cpu_relax() calls into the
>> >    main loop, so the CPU core spends more
>> >    of its time in cpu_relax() and less
>> >    time doing other things:
>>
>> Well, maybe it's a matter of doing cpu_relax() between any other bits
>> of
>> significant computation in there:
>
> I tried that, as well, and some other variations.
>
> Every single change to poll_idle() that I tried
> seems to result in a 9-10% relative increase in
> CPU use during the peak load of the test.
>
> During the busiest parts of the load, every CPU
> sees on the order of 20k context switches a second.

Hmm.  Basically, you are saying that

while (something)
    cpu_relax();

is measurably less overhead than

while (something) {
    cpu_relax();
    check something else;
    cpu_relax();
}

which honestly makes me wonder how this is possible at all.

Unless, that is, the Doug's theory actually matches the reality and
the difference is related to the fact that the "something else" causes
the loop to terminate after fewer steps.

Which in turn causes poll_idle() to return to the outer loop in
do_idle() and *that* is enough overhead to explain what you are
seeing.

So, it looks like after the change causing the poll_idle() loop to
terminate in fewer steps (which is generally good for power and also
for performance in some workloads) you are measuring the overhead of
the outer loop in do_idle() instead of the overhead of the loop in
poll_idle() itself.

With that in mind (and I'm going to assume that this is the case until
I see convincing evidence to the contrary), it seems to me that your
workload will be unhappy if *any* changes are made to poll_idle(), but
we simply have to change it, because today it is kind of a design
disaster.
