Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cWjfF01OGVtGdwAAmS7hNA
	; Thu, 07 Jun 2018 15:35:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 27879608BF; Thu,  7 Jun 2018 15:35:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 95C4C6074D;
	Thu,  7 Jun 2018 15:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95C4C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935130AbeFGPfs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:35:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:14092 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934108AbeFGPfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:35:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 08:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="55529755"
Received: from sandybridge-desktop.sh.intel.com (HELO sandybridge-desktop) ([10.239.160.116])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2018 08:35:39 -0700
Date: Thu, 7 Jun 2018 23:40:52 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        Artem S Tashkinov <t.artem@mailcity.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH][RFC] sched: cpufreq: Fix long idle judgement logic in
 load calculation
Message-ID: <20180607154051.GA19168@sandybridge-desktop>
References: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
 <20180607044543.d7pswad5tshw26lc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607044543.d7pswad5tshw26lc@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,
thanks for the comment,
On Thu, Jun 07, 2018 at 10:15:43AM +0530, Viresh Kumar wrote:
> On 07-06-18, 11:17, Chen Yu wrote:
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index 871bf9c..9792c80 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
> >  			 * calls, so the previous load value can be used then.
> >  			 */
> >  			load = j_cdbs->prev_load;
> > -		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
> > +		} else if (((int)idle_time > 0) && unlikely(idle_time > 2 * sampling_rate &&
> 
> Yes the figures are insane, but if the idle time is around 36 minutes, the
> conversion to int will make a positive value look negative and we will exit the
> conditional block. And if we don't think that we will ever get such insane idle
> times or we don't want to care about them, then what about doing this instead:
> 
> 		} else if ((unlikely((int)idle_time > 2 * sampling_rate &&
> 
> same below.
> 
Yes, this would be more straightforward.

Best,
Yu
> -- 
> viresh
