Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C832081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C832081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeLKDEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:04:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:25976 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbeLKDEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:04:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 19:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="97756301"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.160.132])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2018 19:04:45 -0800
Date:   Tue, 11 Dec 2018 11:12:21 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     joeyli <jlee@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads
 on idle cpus
Message-ID: <20181211031220.GA23975@chenyu-desktop>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
 <20181210063153.GO5327@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210063153.GO5327@linux-l9pv.suse>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,
On Mon, Dec 10, 2018 at 02:31:53PM +0800, joeyli wrote:
> Hi Chen Yu and ACPI experts,
> 
> On Sat, May 05, 2018 at 07:53:22PM +0800, Chen Yu wrote:
> > According to current implementation of acpi_pad driver,
> > it does not make sense to spawn any power saving threads
> > on the cpus which are already idle - it might bring
> > unnecessary overhead on these idle cpus and causes power
> > waste. So verify the condition that if the number of 'busy'
> > cpus exceeds the amount of the 'forced idle' cpus is met.
> > This is applicable due to round-robin attribute of the
> > power saving threads, otherwise ignore the setting/ACPI
> > notification.
> > 
> > Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
> > Suggested-by: Len Brown <lenb@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Lenny Szubowicz <lszubowi@redhat.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Rui Zhang <rui.zhang@intel.com>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Do you have any news for this patch? Why it did not merged by kernel
> maineline?
> 
We are evaluating if this could be integrated into idle injection framework.
May I know if there's any requirement/background from SUSE on this?

Best,
Ryan(Yu)
> Thanks a lot!
> Joey Lee
> 
> > ---
> >  drivers/acpi/acpi_pad.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> > index 552c1f7..515e60e 100644
> > --- a/drivers/acpi/acpi_pad.c
> > +++ b/drivers/acpi/acpi_pad.c
> > @@ -254,12 +254,62 @@ static void set_power_saving_task_num(unsigned int num)
> >  	}
> >  }
> >  
> > +/*
> > + * Extra acpi_pad threads should not be created until
> > + * the requested idle count is less than/equals to the
> > + * number of the busy cpus - it does not make sense to
> > + * throttle the idle cpus.
> > + */
> > +#define SAMPLE_INTERVAL_JIF	20
> > +
> > +static u64 get_idle_time(int cpu)
> > +{
> > +	u64 idle, idle_usecs = -1ULL;
> > +
> > +	idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> > +
> > +	if (idle_usecs == -1ULL)
> > +		idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
> > +	else
> > +		idle = idle_usecs * NSEC_PER_USEC;
> > +
> > +	return idle;
> > +}
> > +
> > +static bool idle_nr_valid(unsigned int num_cpus)
> > +{
> > +	int busy_nr = 0, i = 0, load_thresh = 100 - idle_pct;
> > +
> > +	if (!num_cpus)
> > +		return true;
> > +
> > +	for_each_online_cpu(i) {
> > +		u64 wall_time, idle_time;
> > +		unsigned int elapsed_delta, idle_delta, load;
> > +
> > +		wall_time = jiffies64_to_nsecs(get_jiffies_64());
> > +		idle_time = get_idle_time(i);
> > +		/* Wait and see... */
> > +		schedule_timeout_uninterruptible(SAMPLE_INTERVAL_JIF);
> > +
> > +		idle_delta = get_idle_time(i) - idle_time;
> > +		elapsed_delta = jiffies64_to_nsecs(get_jiffies_64()) - wall_time;
> > +		idle_delta = (idle_delta > elapsed_delta) ? elapsed_delta : idle_delta;
> > +		load = 100 * (elapsed_delta - idle_delta) / elapsed_delta;
> > +		if (load >= load_thresh)
> > +			busy_nr++;
> > +	}
> > +
> > +	return (busy_nr >= num_cpus) ? true : false;
> > +}
> > +
> >  static void acpi_pad_idle_cpus(unsigned int num_cpus)
> >  {
> >  	get_online_cpus();
> >  
> >  	num_cpus = min_t(unsigned int, num_cpus, num_online_cpus());
> > -	set_power_saving_task_num(num_cpus);
> > +	if (idle_nr_valid(num_cpus))
> > +		set_power_saving_task_num(num_cpus);
> >  
> >  	put_online_cpus();
> >  }
> > -- 
> > 2.7.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
