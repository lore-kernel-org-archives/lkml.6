Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957A62081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957A62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLCXwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:52:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59285 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeLCXwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:52:35 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id ff620aba00623980; Tue, 4 Dec 2018 00:52:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Mel Gorman' <mgorman@suse.de>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 04 Dec 2018 00:52:22 +0100
Message-ID: <5184824.HpJbX5HyQW@aspire.rjw.lan>
In-Reply-To: <002c01d48770$eba6efa0$c2f4cee0$@net>
References: <002c01d48770$eba6efa0$c2f4cee0$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 29, 2018 12:20:07 AM CET Doug Smythies wrote:
> On 2018.11.23 02:36 Rafael J. Wysocki wrote:
> 
> v5 -> v6:
>  * Avoid applying poll_time_limit to non-polling idle states by mistake.
>  * Use idle duration measured by the governor for everything (as it likely is
>    more accurate than the one measured by the core).
> 
> -- above missing-- (see follow up e-mail from Rafael)
> 
>  * Rename SPIKE to PULSE.
>  * Do not run pattern detection upfront.  Instead, use recent idle duration
>    values to refine the state selection after finding a candidate idle state.
>  * Do not use the expected idle duration as an extra latency constraint
>    (exit latency is less than the target residency for all of the idle states
>    known to me anyway, so this doesn't change anything in practice).
> 
> Hi Rafael,
> 
> I did some minimal testing on teov6, using kernel 4.20-rc3 as my baseline
> reference kernel.
> 
> Test 1: Phoronix bdench test, all options: 1, 6, 12, 48, 128, 256 clients.
> 
> Note: because it uses the disk, the dbench test is somewhat non-repeatable.
> However, if particular attention is paid to not doing anything else with
> the disk between tests, then it seems to be repeatable to within about 6%.
> 
> Anyway no significant difference observed between kernel 4.20-rc3 and the
> same with the teov6 patch.
> 
> Test 2: Pipe test, non cross core. (And idle state 0 test, really)
> I ran 4 pipe tests, 1 for each of my 4 cores, @2 CPUs per core.
> Thus, pretty much only idle state 0 was ever used.
> Processor package power was similar for both kernels.
> teov6 entered/exited idle state 0 about 60,984 times/second/cpu.
> -rc3 entered/exited idle state 0 about 62,806 times/second/cpu.
> There was a difference in percentage time spent in idle state 0,
> with kernel 4.20-rc3 spending 0.2441% in idle state 0 verses
> teov6 at 0.0641%.
> 
> For throughput, teov6 was 1.4% faster.

This may indicate that teov6 is somewhat too aggressive.

> Test 3: was an attempt to sweep through a preference for
> all idle states.
> 
> 40 threads were launched with nothing to do except sleep
> for a variable duration of 1 to 500 uSec, each step was
> run for 1 minute. With 1 minute idle before the test and a few
> minutes idle after, the total test duration was about 505 minutes.
> Recall that when one asks for a short sleep of 1 uSec, they actually
> get about 50 uSec, due to overheads. So I use 40 threads in an attempt
> to get the average time between wakeup events per CPU down somewhat.
> 
> The results are here:
> http://fast.smythies.com/linux-pm/k420/k420-pn-sweep-teo6-2.htm

And, so long as my understanding of the graphs is correct, the results
here indicate that teov6 tends to prefer relatively shallow idle states
which is good for performance (at least with some workloads), but not
necessarily for energy-efficiency.

I will send a v7 of TEO with some changes to make it a bit more
energy-efficient with respect to the v6.

Thanks,
Rafael

