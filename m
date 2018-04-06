Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeDFBKM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:10:12 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:54746
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751482AbeDFBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:10:10 -0400
X-ASG-Debug-ID: 1522977005-093b7e10b331920001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Thread-Topic: [PATCH v2] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
X-ASG-Orig-Subj: Re: [PATCH v2] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Thread-Index: AQHTy/XJXfOHf7atGkaXAZEUhTEY6KPv42oAgAKGiwA=
Date: Fri, 6 Apr 2018 01:10:07 +0000
Message-ID: <1522977004.8366.11.camel@hxt-semitech.com>
References: <1522833380-18438-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180404103600.GJ3572@vireshk-i7>
In-Reply-To: <20180404103600.GJ3572@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.127.0.11]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <DD0DEEB3AD2AD545BEC636038F947F1F@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1522977005
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5020 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49625
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kumar,

On Wed, 2018-04-04 at 16:06 +0530, Viresh Kumar wrote:
> On 04-04-18, 17:16, Shunyong Yang wrote:
> > 
> > When multiple cpus are related in one cpufreq policy, the first
> > online
> > cpu will be chosen by default to handle cpufreq operations. Let's
> > take
> > cpu0 and cpu1 as an example.
> > 
> > When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's
> > perf
> > capabilities should be initialized. Otherwise, perf capabilities
> > are 0s
> > and speed change can not take effect.
> > 
> > This patch copies perf capabilities of the first online cpu to
> > other
> > shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > ---
> > 
> > Changes in v2:
> >   -Add unlikely in cpu comparison per Kumar's comments.
> >   -Fix coding style per Kumar's comments.
> > 
> > Changes in v1:
> >   -Drop RFC tag,
> >      The original RFC link,
> >      https://patchwork.kernel.org/patch/10299055/.
> > 
> >      This patch solves same issue as RFC above.
> > 
> >      Patch name is changed as code is too much different with RFC
> > above.
> > 
> >   -Remove extra init() per Viresh Kumar's comments and only handle
> >    CPPC CPUFREQ_SHARED_TYPE_ANY case.
> > 
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c
> > b/drivers/cpufreq/cppc_cpufreq.c
> > index 8f7b21a4d537..679e43b9c980 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -164,9 +164,20 @@ static int cppc_cpufreq_cpu_init(struct
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
> > -	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
> > +
> > +		for_each_cpu(i, policy->cpus) {
> > +			if (unlikely(i == policy->cpu))
> > +				continue;
> > +
> > +			memcpy(&all_cpu_data[i]->perf_caps,
> > +			       &cpu->perf_caps,
> > +			       sizeof(cpu->perf_caps));
> I think this can be written in two lines without violating the 80
> columns rule.

The memcpy() is split in three lines (the three "+"). And I rechecked
it by downloading from

https://patchwork.kernel.org/patch/10322305/

and apply to code. The maximum column number is 59. 
And I re-run checkpatch.pl and it passed.
I am not sure why it is over 80 columns in your tool. 

> 
> > 
> > +		}
> > +	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL)
> > {
> >  		/* Support only SW_ANY for now. */
> >  		pr_debug("Unsupported CPU co-ord type\n");
> >  		return -EFAULT;
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for your ACK.

Thanks.
Shunyong.


> 
