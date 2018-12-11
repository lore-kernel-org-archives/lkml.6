Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CCCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E372082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E372082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeLKPEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:04:21 -0500
Received: from foss.arm.com ([217.140.101.70]:49152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbeLKPEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:04:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F741596;
        Tue, 11 Dec 2018 07:04:20 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B443F575;
        Tue, 11 Dec 2018 07:04:16 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:04:11 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v10 04/15] PM / EM: Expose the Energy Model in sysfs
Message-ID: <20181211150409.vn25xlmzonqhd4fi@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-5-quentin.perret@arm.com>
 <20181211141827.GA85618@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211141827.GA85618@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Dec 2018 at 15:18:28 (+0100), Ingo Molnar wrote:
> 
> * Quentin Perret <quentin.perret@arm.com> wrote:
> 
> > Expose the Energy Model (read-only) of all performance domains in sysfs
> > for convenience. To do so, add a kobject to the CPU subsystem under the
> > umbrella of which a kobject for each performance domain is attached.
> > 
> > The resulting hierarchy is as follows for a platform with two
> > performance domains for example:
> > 
> >    /sys/devices/system/cpu/energy_model
> >    ├── pd0
> >    │   ├── cost
> >    │   ├── cpus
> >    │   ├── frequency
> >    │   └── power
> >    └── pd4
> >        ├── cost
> >        ├── cpus
> >        ├── frequency
> >        └── power
> > 
> > In this implementation, the kobject abstraction is only used as a
> > convenient way of exposing data to sysfs. However, it could also be
> > used in the future to allocate and release performance domains in a more
> > dynamic way using reference counting.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  include/linux/energy_model.h |  2 +
> >  kernel/power/energy_model.c  | 90 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 92 insertions(+)
> 
> Why is a read-only ABI added for 'convenience'? We really don't do that 
> as ABIs are final and they come with responsibilities.
> 
> I think if this is for debug purposes it should be declared and put into 
> debugfs or so.
> 
> If it's for some other purpose that purpose should be declared.

This is basically supposed to look like the CPUFreq policy entries.
You can get things like this for CPUFreq:

  $ cat /sys/devices/system/cpu/cpufreq/policy1/scaling_available_frequencies
  450000 625000 800000 950000 1100000

And things like this for the EM:

$ cat /sys/devices/system/cpu/energy_model/pd1/power
  160 239 343 454 583

In general, I expect these two interfaces to be used for similar
purposes. Now, whether or not they should be exposed in debugfs is a
good question. I went for sysfs for consistency with CPUFreq, but I'm
not opposed to a change in this area for the EM if you feel it's
preferable.

Also, I'm happy to just drop this patch for now and to begin by not
exposing the EM at all. It's easier to expose it later than to remove it
once userspace tools depend on it.

Thanks,
Quentin
