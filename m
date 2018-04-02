Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeDBKAt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:00:49 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:59646
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754130AbeDBKAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:00:47 -0400
X-ASG-Debug-ID: 1522663242-093b7e10b30c1a0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Thread-Topic: [PATCH] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
X-ASG-Orig-Subj: Re: [PATCH] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Thread-Index: AQHTxnej2cVTpFHCIEicwJJ9iRTflKPsj6EAgAAwPYA=
Date: Mon, 2 Apr 2018 10:00:42 +0000
Message-ID: <1522663241.8018.3.camel@hxt-semitech.com>
References: <1522229514-14377-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180402070802.GE4714@vireshk-i7>
In-Reply-To: <20180402070802.GE4714@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.69]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <13C51476FCD5504D862AD055F20F9A28@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1522663242
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5294 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49513
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kumar,

On Mon, 2018-04-02 at 12:38 +0530, Viresh Kumar wrote:
> On 28-03-18, 17:31, Shunyong Yang wrote:
> > 
> > When multiple cpus are related in one cpufreq policy, the first
> > online
> > cpu will be chosen by default to handle cpufreq operations. Let's
> > take
> > cpu0 and cpu1 as an example.
> > 
> > When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's
> > should
> > be initialized. Otherwise, perf capabilities are 0s and speed
> > change can
> > not take effect.
> > 
> > This patch copies perf capabilities of the first online cpu to
> > other
> > shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > ---
> > 
> > The original RFC link,
> >   https://patchwork.kernel.org/patch/10299055/.
> > 
> > This patch solves same issue as RFC above.
> > 
> > Patch name is changed as code is too much different with RFC above.
> > 
> > Remove extra init() per Viresh Kumar's comments and only handle
> > CPPC CPUFREQ_SHARED_TYPE_ANY case.
> > 
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c
> > b/drivers/cpufreq/cppc_cpufreq.c
> > index 8f7b21a4d537..dc625a93a58e 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -164,8 +164,18 @@ static int cppc_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency =
> > cppc_get_transition_latency(cpu_num);
> >  	policy->shared_type = cpu->shared_type;
> >  
> > -	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> > +	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
> > +		int i;
> > +
> >  		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> > +
> > +		for_each_cpu(i, policy->cpus) {
> > +			if (i != policy->cpu)
> I would rather do:
> 
>                         if (unlikely(i == policy->cpu))
>                                 continue;

Thanks. Will change in v2.

> > 
> > +				memcpy(&all_cpu_data[i]-
> > >perf_caps,
> > +				       &cpu->perf_caps,
> > +				       sizeof(cpu->perf_caps));
> > +		}
> > +	}
> >  	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
> It should be:
> 
>   	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL)
> {
> 

Thanks. Will change in v2. I ignored this as checkpatch.pl reports
nothing here.

Thanks.
Shunyong.


> > 
> >  		/* Support only SW_ANY for now. */
> >  		pr_debug("Unsupported CPU co-ord type\n");
> And thanks for making it work this way.
> 
