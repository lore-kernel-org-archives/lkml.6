Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E4CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CFB20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CFB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJPV1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:27:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeJPV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:27:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F3380D;
        Tue, 16 Oct 2018 06:36:33 -0700 (PDT)
Received: from queper01-lin (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FF873F5D3;
        Tue, 16 Oct 2018 06:36:29 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:36:24 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v8 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Message-ID: <20181016133451.w2y3gwj2c56cvy5c@queper01-lin>
References: <20181016101513.26919-1-quentin.perret@arm.com>
 <20181016101513.26919-11-quentin.perret@arm.com>
 <20181016125058.GD9130@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016125058.GD9130@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 16 Oct 2018 at 14:50:58 (+0200), Juri Lelli wrote:
> Hi,
> 
> On 16/10/18 11:15, Quentin Perret wrote:
> 
> [...]
> 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index cc02050fd0c4..481309a11174 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -466,6 +466,17 @@ static struct ctl_table kern_table[] = {
> >  		.extra1		= &one,
> >  	},
> >  #endif
> > +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > +	{
> > +		.procname	= "sched_energy_aware",
> > +		.data		= &sysctl_sched_energy_aware,
> > +		.maxlen		= sizeof(unsigned int),
> > +		.mode		= 0644,
> > +		.proc_handler	= sched_energy_aware_handler,
> > +		.extra1		= &zero,
> > +		.extra2		= &one,
> > +	},
> > +#endif
> 
> Doesn't this need to be documented in Documentation/sysctl/kernel.txt?

Right, that'd be a good practice indeed. What do you think about the
patch below ?

> Also, do we want a kernel parameter as well to be able to disable this
> at boot?

Yeah, why not. But I guess we could always add that later if need be ?

Thanks,
Quentin

---
From: Quentin Perret <quentin.perret@arm.com>
Date: Tue, 16 Oct 2018 14:26:06 +0100
Subject: [PATCH] sched: Document sched_energy_aware sysctl

Add a new entry to Documentation/sysctl/kernel.txt explaining how
the new 'sched_energy_aware' knob should be used.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 Documentation/sysctl/kernel.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 37a679501ddc..36bee799ee9e 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -78,6 +78,7 @@ show up in /proc/sys/kernel:
 - reboot-cmd                  [ SPARC only ]
 - rtsig-max
 - rtsig-nr
+- sched_energy_aware
 - seccomp/                    ==> Documentation/userspace-api/seccomp_filter.rst
 - sem
 - sem_next_id		      [ sysv ipc ]
@@ -872,6 +873,17 @@ rtsig-nr shows the number of RT signals currently queued.
 
 ==============================================================
 
+sched_energy_aware:
+
+Enables/disables Energy Aware Scheduling (EAS). EAS starts
+automatically on platforms where it can run (that is,
+platforms with asymmetric CPU topologies and having an Energy
+Model available). If your platform happens to meet the
+requirements for EAS but you do not want to use it, change
+this value to 0.
+
+==============================================================
+
 sched_schedstats:
 
 Enables/disables scheduler statistics. Enabling this feature

