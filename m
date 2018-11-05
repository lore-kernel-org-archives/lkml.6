Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3CCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8665120882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8665120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbeKFE3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:29:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:50882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387695AbeKFE3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:29:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 503DFB0EC;
        Mon,  5 Nov 2018 19:07:55 +0000 (UTC)
Message-ID: <1541445118.3441.4.camel@suse.cz>
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor
 for tickless systems
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Mel Gorman' <mgorman@suse.de>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>
Date:   Mon, 05 Nov 2018 20:11:58 +0100
In-Reply-To: <000301d472c2$49f28740$ddd795c0$@net>
References: FyDag8LEB6DhgFyDfglTus <000301d472c2$49f28740$ddd795c0$@net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 08:39 -0700, Doug Smythies wrote:
> 
> I have been testing this V2 against a baseline that includes all
> of the pending menu patches. My baseline kernel is somewhere
> after 4.19, at 345671e.
> 
> A side note:
> Recall that with the menu patch set tests, I found that the baseline
> reference performance for the pipe test on one core had changed
> significantly (worse - Kernel 4.19-rc1). Well, now it has changed
> significantly again (better, and even significantly better than it
> was for 4.18). 4.18 ~4.8 uSec/loop; 4.19 ~5.2 uSec/loop; 4.19+
> (345671e) 4.2 uSec/loop.
> 
> This V2 is pretty good. All of the tests that I run gave similar
> performance and power use between the baseline reference and V2.
> I couldn't find any issues with the decay stuff, and I tried.
> (sorry, I didn't do pretty graphs.)
> 
> After reading Giovanni's reply the other day, I tried the
> Phoronix dbench test: 12 clients resulted in similar performance,
> But TEOv2 used a little less processor package power; 256 clients
> had about -7% performance using TEOv2, but (my numbers are not
> exact) also used less processor package power.

Uhm, I see. The results I've got vary between machines; that could
depend on the CPU type. What is your machine processor model (or
microarchitecture, see the search box at the website https://ark.intel.com ),
and how many logical cores does it have?

For the record, in my previous email I wrote that my script runs dbench with
up to NUMCPUS*8 clients, but that's misleading; indeed for the 48-cores
machines I had runs with 1, 2, 4, 8, 16, 32 and 64 clients.
https://lore.kernel.org/lkml/1541010981.3423.2.camel@suse.cz/

The sequence is generated with

    CLIENT=1
    DBENCH_MAX_CLIENTS=$((NUMCPUS*8))

    while [ $CLIENT -le $DBENCH_MAX_CLIENTS ]; do

            ./bin/dbench [...] $CLIENT

            if [ $CLIENT -lt $NUMCPUS ]; then
                    CLIENT=$((CLIENT*2))
            else
                    CLIENT=$((CLIENT*8))
            fi
    done

In practice the max number of clients I get is slightly below NUMCPUS*2 to
reach saturation. I write this as I read you ran it with 256 clients but I
never went that high.

> 
> On 2018.10.31 11:36 Giovanni Gherdovich wrote:
> 
> > Something I'd like to do now is verify that "teo"'s predictions
> > are better than "menu"'s; I'll probably use systemtap to make
> > some histograms of idle times versus what idle state was chosen
> > -- that'd be enough to compare the two.
> 
> I don't know what a "systemtap" is, but I have (crude) tools to
> post process trace data into histograms data. I did 5 minute
> traces during the 12 client Phoronix dbench test and plotted
> the results, [1]. Sometimes, to the right of the autoscaled
> graph is another with fixed scaling. Better grouping of idle
> durations with TEOv2 are clearly visible.
> 
> ... Doug
> 
> [1] http://fast.smythies.com/linux-pm/k419p/histo_compare.htm

Oh, that's interesting, thanks. Can you post the break-even residency times and
exit latencies for your CPUs? On my Skylake test machine I get this from sysfs:

$ cd /sys/devices/system/cpu/cpu0/cpuidle
$ for state in * ; do
echo -e \
"STATE: $state\t\
DESC: $(cat $state/desc)\t\
NAME: $(cat $state/name)\t\
LATENCY: $(cat $state/latency)\t\
RESIDENCY: $(cat $state/residency)"
done

STATE: state0   DESC: CPUIDLE CORE POLL IDLE    NAME: POLL      LATENCY: 0      RESIDENCY: 0
STATE: state1   DESC: MWAIT 0x00        NAME: C1        LATENCY: 2      RESIDENCY: 2
STATE: state2   DESC: MWAIT 0x01        NAME: C1E       LATENCY: 10     RESIDENCY: 20
STATE: state3   DESC: MWAIT 0x10        NAME: C3        LATENCY: 70     RESIDENCY: 100
STATE: state4   DESC: MWAIT 0x20        NAME: C6        LATENCY: 85     RESIDENCY: 200
STATE: state5   DESC: MWAIT 0x33        NAME: C7s       LATENCY: 124    RESIDENCY: 800
STATE: state6   DESC: MWAIT 0x40        NAME: C8        LATENCY: 200    RESIDENCY: 800

At the bottom of the email at
https://lore.kernel.org/lkml/4168371.zz0pVZtGOY@aspire.rjw.lan/
Rafael explains how the sysfs residencies are important to understand the
histograms.

Thanks,
Giovanni
