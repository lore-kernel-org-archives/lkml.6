Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B273C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047AE2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047AE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeK2Urz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:47:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38224 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2Urz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:47:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so1080606oii.5;
        Thu, 29 Nov 2018 01:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3ijAJ5sLAr78eVQku4aR6EkHIiBZBHl3N8/WC3LbLg=;
        b=FTEIod/15tTTDV08t16Akdsbmhsk9+ggnzOiqBWkX7pzmMcknKAAA8++pcc786kvSm
         h0J3rsh99WfhobVpidPixTWNpS7+C+YBPo5leP4sQW8TzncSMMNzYKihDfuP/4V12O2/
         CQJ9dJm8xrG+jhGzBFbse2+lsXNrf0C0sDpS6owIn+21HRT8pmXqEr0Cs2LzGwB0j6tO
         5+Qjb5AWfCwEHyNccJOWLQFq/Wn1mLIwgn38XTXltHxY+Dr+2NEOYvqaFoWvsdJ7FbWI
         mjrW5N0DKnLd9+sHuKLwwzzMkG3kHK2bLEbia34GI3EHk+5F2rJOpF8DQgo3Ku/hhEsD
         dm2g==
X-Gm-Message-State: AA+aEWavjWlKwoUFcMDPxjIC41e1/XMQHUDQ0cjZYqvu9N2rH+Njkk8G
        De3UXEvpD6DMScMyqprlkpyWrZOg+LENYKdmFpY=
X-Google-Smtp-Source: AFSGD/UYocwIThObiiYbLrpz95S1A9Kdbtkv6K9fQl59/fDpIWEdbhLo7o6wPKm2XlXbxoTfKsi1d4v2d3463i/xuws=
X-Received: by 2002:aca:d7c6:: with SMTP id o189-v6mr455879oig.33.1543484589284;
 Thu, 29 Nov 2018 01:43:09 -0800 (PST)
MIME-Version: 1.0
References: <002c01d48770$eba6efa0$c2f4cee0$@net>
In-Reply-To: <002c01d48770$eba6efa0$c2f4cee0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Nov 2018 10:42:56 +0100
Message-ID: <CAJZ5v0gTdK-NKkrL7UGCvt14DsvCJabbKAETjxAkFFPmSzmjtA@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Thu, Nov 29, 2018 at 12:20 AM Doug Smythies <dsmythies@telus.net> wrote:
>
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
>
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
>
> I might try to get some histogram information at a later date.

Thank you for the results, much appreciated!
