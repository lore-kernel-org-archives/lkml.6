Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925E8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589502083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589502083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966468AbeFSNG2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:06:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49866 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965740AbeFSNG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:06:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1402A80D;
        Tue, 19 Jun 2018 06:06:26 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0783F557;
        Tue, 19 Jun 2018 06:06:21 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:06:20 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 04/10] PM / EM: Expose the Energy Model in sysfs
Message-ID: <20180619130620.GZ17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-5-quentin.perret@arm.com>
 <20180619121643.GR2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619121643.GR2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 Jun 2018 at 14:16:43 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:24:59PM +0100, Quentin Perret wrote:
> > This exposes the Energy Model (read-only) of all frequency domains in
> > sysfs for convenience. To do so, a parent kobject is added to the CPU
> > subsystem under the umbrella of which a kobject for each frequency
> > domain is attached.
> > 
> > The resulting hierarchy is as follows for a platform with two frequency
> > domains for example:
> > 
> >    /sys/devices/system/cpu/energy_model
> >    ├── fd0
> >    │   ├── capacity
> >    │   ├── cpus
> >    │   ├── frequency
> >    │   └── power
> >    └── fd4
> >        ├── capacity
> >        ├── cpus
> >        ├── frequency
> >        └── power
> > 
> 
> Given that each FD can have multiple {freq,power} tuples and sysfs has a
> one value per file policy, how does this work?

This is meant to look a little bit like the sysfs entries of CPUFreq
policies, so you get something like this:

$ cat /sys/devices/system/cpu/energy_model/fd0/capacity 
133 250 351 428 462 
$ cat /sys/devices/system/cpu/energy_model/fd0/frequency 
533000 999000 1402000 1709000 1844000 
$ cat /sys/devices/system/cpu/energy_model/fd0/power 
28 70 124 187 245 
$ cat /sys/devices/system/cpu/energy_model/fd0/cpus
0-3


For example, CPUFreq exposes available governors and frequencies as:

$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors 
conservative ondemand userspace powersave performance schedutil

$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies 
533000 999000 1402000 1709000 1844000
