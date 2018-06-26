Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68271C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B898C2694A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B898C2694A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeFZX4f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:56:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:1613 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752209AbeFZX4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:56:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 16:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,276,1526367600"; 
   d="scan'208";a="50794618"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2018 16:56:30 -0700
Message-ID: <9ae4955e8026e1ddf0567e5cc210c5713668b631.camel@linux.intel.com>
Subject: Re: [PATCH v2 10/21] cpufreq: intel_pstate: use match_string()
 helper
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Date:   Tue, 26 Jun 2018 16:56:30 -0700
In-Reply-To: <1633797.WhvbXNE1Nx@aspire.rjw.lan>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
         <1527765086-19873-11-git-send-email-xieyisheng1@huawei.com>
         <1633797.WhvbXNE1Nx@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 17:23 +0200, Rafael J. Wysocki wrote:
> On Thursday, May 31, 2018 1:11:15 PM CEST Yisheng Xie wrote:
> > match_string() returns the index of an array for a matching string,
> > which can be used instead of open coded variant.
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> > ---
> > v2:
> >  - add Reviewed-by tag.
> > 
> >  drivers/cpufreq/intel_pstate.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > performance
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 17e566af..d701e26 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -645,21 +645,18 @@ static ssize_t
> > store_energy_performance_preference(
> >  {
> >  	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
> >  	char str_preference[21];
> > -	int ret, i = 0;
> > +	int ret;
> >  
> >  	ret = sscanf(buf, "%20s", str_preference);
> >  	if (ret != 1)
> >  		return -EINVAL;
> >  
> > -	while (energy_perf_strings[i] != NULL) {
> > -		if (!strcmp(str_preference,
> > energy_perf_strings[i])) {
> > -			intel_pstate_set_energy_pref_index(cpu_dat
> > a, i);
> > -			return count;
> > -		}
> > -		++i;
> > -	}
> > +	ret = match_string(energy_perf_strings, -1,
> > str_preference);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -	return -EINVAL;
> > +	intel_pstate_set_energy_pref_index(cpu_data, ret);
> > +	return count;
> >  }
> >  
> >  static ssize_t show_energy_performance_preference(
> > 
> 
> Srinivas, any concerns?
> 
