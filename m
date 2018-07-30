Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7DA16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A2720881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pcdKQhzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A2720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeG3Sap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:30:45 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:53478 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3Sao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1532969691; x=1564505691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fM7CeMs8kaPwZvcZmIf/lAvP8PbPgJnuEWdZDS7WcQE=;
  b=pcdKQhzp3WndL0SKwuyh4UJ+Dl82R0INzWKU7wplJ/28wWC2F/hopdDj
   udsrV8LtbTxvOAEW023DlzC5E4LzYEJYtVxWbWboF/kybU5klFmxtVerY
   +wJs1z07/5hux7fKR6shHcP1aOQltqIUbgJQWDuF7A5Vw/evEIALNFHvP
   I=;
X-IronPort-AV: E=Sophos;i="5.51,422,1526342400"; 
   d="scan'208";a="752237316"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 16:44:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6UGiIpB098426
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 30 Jul 2018 16:44:20 GMT
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Jul 2018 16:44:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Jul 2018 16:44:18 +0000
Received: from localhost (10.55.160.54) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 30 Jul 2018 16:44:18 +0000
Date:   Mon, 30 Jul 2018 09:44:17 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
Message-ID: <20180730164417.GE15414@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180726155656.14873-1-eduval@amazon.com>
 <CAJZ5v0gFQebGMpS0jzJOi7Ft+C7JTTKyiKgDhNj39BrCuQdH1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gFQebGMpS0jzJOi7Ft+C7JTTKyiKgDhNj39BrCuQdH1g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:15:48AM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 26, 2018 at 5:56 PM, Eduardo Valentin <eduval@amazon.com> wrote:
> > System instability are seen during resume from hibernation when system
> > is under heavy CPU load. This is due to the lack of update of sched
> > clock data,
> 
> Isn't that the actual bug?
> 
> > and the scheduler would then think that heavy CPU hog
> > tasks need more time in CPU, causing the system to freeze
> > during the unfreezing of tasks. For example, threaded irqs,
> > and kernel processes servicing network interface may be delayed
> > for several tens of seconds, causing the system to be unreachable.
> >
> > Situation like this can be reported by using lockup detectors
> > such as workqueue lockup detectors:
> >
> > [root@ip-172-31-67-114 ec2-user]# echo disk > /sys/power/state
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
> >  kernel:BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
> >  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 57s!
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
> >  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 57s!
> >
> > Message from syslogd@ip-172-31-67-114 at May  7 18:29:06 ...
> >  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 403s!
> >
> > The fix for this situation is to mark the sched clock as unstable
> > as early as possible in the resume path, leaving it unstable
> > for the duration of the resume process.
> 
> I would rather call it a workaround.

ok.

> 
> > This will force the
> > scheduler to attempt to align the sched clock across CPUs using
> > the delta with time of day, updating sched clock data. In a post
> > hibernation event, we can then mark the sched clock as stable
> > again, avoiding unnecessary syncs with time of day on systems
> > in which TSC is reliable.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Eduardo Valentin <eduval@amazon.com>
> > Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> > Cc: Rajvi Jingar <rajvi.jingar@intel.com>
> > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >
> > Hey,
> >
> > No changes from first attempt, no pressure on resending. The RESEND
> > tag is just because I missed linux-pm in the first attempt.
> >
> > BR,
> >
> >  arch/x86/kernel/tsc.c       | 29 +++++++++++++++++++++++++++++
> >  include/linux/sched/clock.h |  5 +++++
> >  kernel/sched/clock.c        |  4 ++--
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 8ea117f8142e..f197c9742fef 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/timex.h>
> >  #include <linux/static_key.h>
> > +#include <linux/suspend.h>
> >
> >  #include <asm/hpet.h>
> >  #include <asm/timer.h>
> > @@ -1377,3 +1378,31 @@ unsigned long calibrate_delay_is_known(void)
> >         return 0;
> >  }
> >  #endif
> > +
> > +static int tsc_pm_notifier(struct notifier_block *notifier,
> > +                          unsigned long pm_event, void *unused)
> > +{
> > +       switch (pm_event) {
> > +       case PM_HIBERNATION_PREPARE:
> > +               clear_sched_clock_stable();
> > +               break;
> 
> This is too early IMO.  This happens before hibernation starts, even
> before the image is created.

Yeah, I think, as long as it is marked, it should be fine.

> 
> > +       case PM_POST_HIBERNATION:
> > +               /* Set back to the default */
> > +               if (!check_tsc_unstable())
> > +                       set_sched_clock_stable();
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +};
> 
> If anything like this is the way to go, which honestly I doubt, I
> would prefer it to be done in hibernate() in the !in_suspend case.
> 

The problem is more in the unfreeze of tasks..

> But why does it only affect hibernation?  Do we do something extra for
> system-wide suspend/resume that is not done for hibernation?

I don't think we do anything special in hibernation per si. 
Only thing is the unfreezing of tasks seams to get confused when 
CPU hog tasks are present. 
> 

-- 
All the best,
Eduardo Valentin
