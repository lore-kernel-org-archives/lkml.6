Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF4BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD71320868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLHKS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:18:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbeLHKS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:18:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E09DACFB;
        Sat,  8 Dec 2018 10:18:54 +0000 (UTC)
Message-ID: <1544264587.3930.2.camel@suse.cz>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Mel Gorman' <mgorman@suse.de>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Date:   Sat, 08 Dec 2018 11:23:07 +0100
In-Reply-To: <001a01d48b24$9aa38c00$cfeaa400$@net>
References: <42865872.dmYH3PmblP@aspire.rjw.lan>
         T62Cgz3BqpqCWT62HgcJvj <001a01d48b24$9aa38c00$cfeaa400$@net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

sorry for the late reply, this week I was traveling.

First off, thank you for trying out MMTests; I admit the documentation is
somewhat incomplete. I'm going to give you an overview of how I run benchmarks
with MMTests and how do I print comparisons, hoping this can address your
questions.

In the last report I posted the following two tables, for instance; I'll now
show the commands I used to produce them.

>  * sockperf on loopback over UDP, mode "throughput"
>     * global-dhp__network-sockperf-unbound
>     48x-HASWELL-NUMA fixed since v2, the others greatly improved in v6.
> 
>                         teo-v1      teo-v2      teo-v3      teo-v5      teo-v6
>   -------------------------------------------------------------------------------
>   8x-SKYLAKE-UMA        1% worse    1% worse    1% worse    1% worse    10% better
>   80x-BROADWELL-NUMA    3% better   2% better   5% better   3% worse    8% better
>   48x-HASWELL-NUMA      4% better   12% worse   no change   no change   no change
> 
>   SOCKPERF-UDP-THROUGHPUT
>   =======================
>   NOTES: Test run in mode "throughput" over UDP. The varying parameter is the
>       message size.
>   MEASURES: Throughput, in MBits/second
>   HIGHER is better
> 
>   machine: 8x-SKYLAKE-UMA
> 
> 				4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0                 4.18.0
> 			       vanilla                    teo        teo-v2+backport        teo-v3+backport        teo-v5+backport        teo-v6+backport
>   -------------------------------------------------------------------------------------------------------------------------------------------------------
>   Hmean     14        70.34 (   0.00%)       69.80 *  -0.76%*       69.11 *  -1.75%*       69.49 *  -1.20%*       69.71 *  -0.90%*       77.51 *  10.20%*
>   Hmean     100      499.24 (   0.00%)      494.26 *  -1.00%*      492.74 *  -1.30%*      494.90 *  -0.87%*      497.43 *  -0.36%*      549.93 *  10.15%*
>   Hmean     300     1489.13 (   0.00%)     1472.39 *  -1.12%*     1468.45 *  -1.39%*     1477.74 *  -0.76%*     1478.61 *  -0.71%*     1632.63 *   9.64%*
>   Hmean     500     2469.62 (   0.00%)     2444.41 *  -1.02%*     2434.61 *  -1.42%*     2454.15 *  -0.63%*     2454.76 *  -0.60%*     2698.70 *   9.28%*
>   Hmean     850     4165.12 (   0.00%)     4123.82 *  -0.99%*     4100.37 *  -1.55%*     4111.82 *  -1.28%*     4120.04 *  -1.08%*     4521.11 *   8.55%*

The first table is a panoramic view of all machines, the second is a zoom into
the 8x-SKYLAKE-UMA machine where the overall benchmark score is broken down
into the various message sizes.

The first thing to do is, obviously, to gather data for each kernel. Once the
kernel is installed on the box, as you already figured out, you have to run:

  ./run-mmtests.sh --config configs/config-global-dhp__network-sockperf-unbound SOME-MNEMONIC-NAME

In my case, what I did is to run:

  # build, install and boot 4.18.0-vanilla kernel
  ./run-mmtests.sh --config configs/config-global-dhp__network-sockperf-unbound  4.18.0-vanilla

  # build, install and boot 4.18.0-teo kernel
  ./run-mmtests.sh --config configs/config-global-dhp__network-sockperf-unbound  4.18.0-teo

  # build, install and boot 4.18.0-teo-v2+backport kernel
  ./run-mmtests.sh --config configs/config-global-dhp__network-sockperf-unbound  4.18.0-teo-v2+backport

  ...

  # build, install and boot 4.18.0-teo-v6+backport kernel
  ./run-mmtests.sh --config configs/config-global-dhp__network-sockperf-unbound  4.18.0-teo-v6+backport

At this point in the work/log directory I've accumulated all the data I need
for a report. What's important to note here is that a single configuration
file (such as config-global-dhp__network-sockperf-unbound) often runs more than
a single  benchmark, according to the value of the MMTESTS variable in that
config. The config we're using has:

  export MMTESTS="sockperf-tcp-throughput sockperf-tcp-under-load sockperf-udp-throughput sockperf-udp-under-load"

which means it's running 4 different flavors of sockperf. The two tables above
are from the "sockperf-udp-throughput" variant.

Now that we've run the benchmarks for each kernel (every run takes around 75
minutes on my machines) we're ready to extract some comparison tables.
Exploring the work/log directory shows what we've got:

  $ find . -type d -name sockperf\* | sort 
  ./sockperf-tcp-throughput-4.18.0-teo
  ./sockperf-tcp-throughput-4.18.0-teo-v2+backport
  ./sockperf-tcp-throughput-4.18.0-teo-v3+backport
  ./sockperf-tcp-throughput-4.18.0-teo-v5+backport
  ./sockperf-tcp-throughput-4.18.0-teo-v6+backport
  ./sockperf-tcp-throughput-4.18.0-vanilla
  ./sockperf-tcp-under-load-4.18.0-teo
  ./sockperf-tcp-under-load-4.18.0-teo-v2+backport
  ./sockperf-tcp-under-load-4.18.0-teo-v3+backport
  ./sockperf-tcp-under-load-4.18.0-teo-v5+backport
  ./sockperf-tcp-under-load-4.18.0-teo-v6+backport
  ./sockperf-tcp-under-load-4.18.0-vanilla
  ./sockperf-udp-throughput-4.18.0-teo
  ./sockperf-udp-throughput-4.18.0-teo-v2+backport
  ./sockperf-udp-throughput-4.18.0-teo-v3+backport
  ./sockperf-udp-throughput-4.18.0-teo-v5+backport
  ./sockperf-udp-throughput-4.18.0-teo-v6+backport
  ./sockperf-udp-throughput-4.18.0-vanilla
  ./sockperf-udp-under-load-4.18.0-teo
  ./sockperf-udp-under-load-4.18.0-teo-v2+backport
  ./sockperf-udp-under-load-4.18.0-teo-v3+backport
  ./sockperf-udp-under-load-4.18.0-teo-v5+backport
  ./sockperf-udp-under-load-4.18.0-teo-v6+backport
  ./sockperf-udp-under-load-4.18.0-vanilla

Above you see a directory for each of the benchmarks in the MMTESTS variable
from before and for each kernel patch. The command to get the detailed table
at the top of this message is:

  $ ../../bin/compare-mmtests.pl --directory . \
                                 --benchmark sockperf-udp-throughput \
                                 --names 4.18.0-vanilla,4.18.0-teo,4.18.0-teo-v2+backport,4.18.0-teo-v3+backport,4.18.0-teo-v5+backport,4.18.0-teo-v6+backport \
   | grep '^.mean'

  Hmean     14        70.34 (   0.00%)       69.80 *  -0.76%*       69.11 *  -1.75%*       69.49 *  -1.20%*       69.71 *  -0.90%*       77.51 *  10.20%*
  Hmean     100      499.24 (   0.00%)      494.26 *  -1.00%*      492.74 *  -1.30%*      494.90 *  -0.87%*      497.43 *  -0.36%*      549.93 *  10.15%*
  Hmean     300     1489.13 (   0.00%)     1472.39 *  -1.12%*     1468.45 *  -1.39%*     1477.74 *  -0.76%*     1478.61 *  -0.71%*     1632.63 *   9.64%*
  Hmean     500     2469.62 (   0.00%)     2444.41 *  -1.02%*     2434.61 *  -1.42%*     2454.15 *  -0.63%*     2454.76 *  -0.60%*     2698.70 *   9.28%*
  Hmean     850     4165.12 (   0.00%)     4123.82 *  -0.99%*     4100.37 *  -1.55%*     4111.82 *  -1.28%*     4120.04 *  -1.08%*     4521.11 *   8.55%*

As you can see I'm grepping for a specific field in the table, i.e. the mean
values; some benchmarks use the harmonic mean (Hmean) and some use the
arithmetic mean (Amean). I also use to get a peek at the beginning of the table
without grepping to get nice headers to stick on top. See how the table above
only uses 1/4 of the data we collected, i.e. it only reads from the data
directories

  ./sockperf-udp-throughput-4.18.0-teo
  ./sockperf-udp-throughput-4.18.0-teo-v2+backport
  ./sockperf-udp-throughput-4.18.0-teo-v3+backport
  ./sockperf-udp-throughput-4.18.0-teo-v5+backport
  ./sockperf-udp-throughput-4.18.0-teo-v6+backport
  ./sockperf-udp-throughput-4.18.0-vanilla

note that the "--benchmark sockperf-udp-throughput" option flag gives the
first part of the directories name (the specific benchmark) while the option
flag "--names 4.18.0-vanilla,4.18.0-teo,4.18.0-teo-v2+backport,..." completes
the directory names (the kernel patches). One can use the script
compare-kernels.sh too, but I like bin/compare-mmtests.pl the most.

Now, the overview table. To get the overall score for, say, teo-v3, what the
script does is to compute ratios between v3 and the baseline for all message
sizes, and then taking the geometric mean of the results. The geometric mean is
chosen because it has the nice property that the geometric mean of ratios is
equal to the ratios of geometric means, which is:

  gmean(ratio(v3, baseline))

is the same as

  gmean(v3) / gmean(baseline)

where v3 and baseline are list of values (results for each message length) and
ratio() is a function that takes component-wise ratios of lists. It would be
awkward is our mean function didn't have that property, you would get
different results depending on the order of your operations (first ratio then
mean, or vice-versa).

I get overview tables running the same compare-mmtests.pl command above, but
adding the --print-ratio option flag.

  $ ../../bin/compare-mmtests.pl --print-ratio \
                                 --directory . \
                                 --benchmark sockperf-udp-throughput \
                                 --names 4.18.0-vanilla,4.18.0-teo,4.18.0-teo-v2+backport,4.18.0-teo-v3+backport,4.18.0-teo-v5+backport,4.18.0-teo-v6+backport

I then look at the very last line of the output, which in this case is

  Gmean Higher    1.00    0.99    0.99    0.99    0.99    1.10

"Gmean" in there reminds me that I'm looking at geometric means; "Higher" is
to say that "higher ratio is better" (remember that sockperf-udp-throughput
measures throughput), then the first ratio is always 1.00 because that's the
reference baseline. Then I have v1, v2, v3, v5 and v6 (I omitted the
headers). All versions have a 1% regression except v6 which is a 10% gain. If
it was a lower-is-better type of test, the interpretation of those number
would be reversed.


Some specific remarks you raise:

On Mon, 2018-12-03 at 08:23 -0800, Doug Smythies wrote:
> ...
> My issue is that I do not understand the output or how it
> might correlate with your tables.
> 
> I get, for example:
> 
>    3    1   1     0.13s     0.68s     0.80s  1003894.302 1003779.613
>    3    1   1     0.16s     0.64s     0.80s  1008900.053 1008215.336
>    3    1   1     0.14s     0.66s     0.80s  1009630.439 1008990.265
> ...
> 
> But I don't know what that means, nor have I been able to find
> a description anywhere.
> 
> In the README file, I did see that for reporting I am 
> somehow supposed to use compare-kernels.sh, but
> I couldn't figure that out.

I don't recognize this output. I hope the illustration above can clarify how
MMTests is used.

> By the way, I am running these tests as a regular user, but
> they seem to want to modify:
> 
> /sys/kernel/mm/transparent_hugepage/enabled
> 
> which requires root privilege. I don't really want to mess
> with that stuff for these tests.

As Mel said, in this case the warning is harmless but I understand that
requesting root permissions is annoying. At times the framework has to modify
some settings and that may require root; on one side we are careful to undo
all modifications applied to a machine for the purpose of testing after the
benchmark is completed, but is also true that MMTests has evolved over time to
be used on lab machines that can be redeployed to a clean known state at the
push of a button. The convenience of assuming root far outweighs the
limitations of this approach.

Another less then ideal characteristic of MMTests is that it downloads the
sources of benchmarks from external URLs which you, as a user, may or may not
trust. We have vetted all those URLs and determined that they represent the
canonical source for a given benchmark, but are not ultimately responsible for
their content. Inside our organization we have a mirror for the content of all
of them (the external URL is accessed only as a fallback), but when people
outside of SUSE use MMTests that's what they get.

> I had the thought that I should be able to get similar
> results as your "8x-SKYLAKE-UMA" on my test computer,
> i7-2600K. Or that at least it was worth trying, just
> to see.

Uhm. That may or may not happen. It's true that your i7-2600K and
8x-SKYLAKE-UMA have the same number of cores and threads, and that the size of
the L3 cache is the same, but the https://ark.intel.com website tells me that
they are from different microarchitecture generations: i7-2600K is a Sandy
Bridge and 8x-SKYLAKE-UMA is a Skylake. Given that the timeline of Intel
microarchitectures is Sandy Bridge (2011), Haswell (2013), Broadwell (2015)
and Skylake (2016), i7-2600K might have more in common with my 48x-HASWELL-NUMA
than it has 8x-SKYLAKE-UMA.

It might seems odd to compare a 48 threads machine with an 8 threads one, but
if you look at MMTests configurations you'll notice that we try to "normalize"
over available resources such as amount of memory or number of cores. We
generally try to explore the space of parameters from "light workload" to
machine saturation; then we average the results, as you see in the
illustration above. This might offer you an alternate viewpoint if what you
get if i7-2600K doesn't match your expectation.


Thanks,
Giovanni
