Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCVFfl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:35:41 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:52398
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752159AbeCVFfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:35:39 -0400
X-ASG-Debug-ID: 1521696933-093b7e165f0acf0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [RFC PATCH] cpufreq: Calling init() of cpufreq_driver  when
 policy inactive cpu online
Thread-Topic: [RFC PATCH] cpufreq: Calling init() of cpufreq_driver  when
 policy inactive cpu online
X-ASG-Orig-Subj: Re: [RFC PATCH] cpufreq: Calling init() of cpufreq_driver  when
 policy inactive cpu online
Thread-Index: AQHTwP6U6ZQQ/zJohEOIsN2GkOzEtaPbFBOAgAAi9IA=
Date: Thu, 22 Mar 2018 05:35:20 +0000
Message-ID: <1521696919.2792.19.camel@hxt-semitech.com>
References: <1521627703-7728-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180322033013.3mqhf2fnbaqfdgay@vireshk-mac-ubuntu>
In-Reply-To: <20180322033013.3mqhf2fnbaqfdgay@vireshk-mac-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.61]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E4FF37E2230D24F8E932C2C01AA3AC1@hxt-semitech.com>
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1521696933
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7060 1.0000 1.4146
X-Barracuda-Spam-Score: 1.41
X-Barracuda-Spam-Status: No, SCORE=1.41 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49196
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2M5Zwq2024605

Hi, Kumar

On Thu, 2018-03-22 at 11:30 +0800, Viresh Kumar wrote:
> On 21-03-18, 18:21, Shunyong Yang wrote:
> > 
> > When multiple cpus are related in one cpufreq policy, the first
> > online cpu
> > will be chosen by default to handle cpufreq operations. In a CPPC
> > case,
> > let's take two related cpus, cpu0 and cpu1 as an example.
> > 
> > After system start, cpu0 is the first online cpu. Cpufreq policy
> > will be
> > allocated and init() in cpufreq_driver will be called to initialize
> > cpu0's
> > perf capabilities and policy parameters.
> Not exactly. The init() is called to initialize stuff for all the
> CPUs that
> should be part of policy->related_cpus after init() has returned. So
> you should
> initialize perf capabilities for all of them.

In page 533 of ACPI 6.2 specificaiton, it says,

"Starting with ACPI Specification 6.2, all _CPC registers can be in
PCC, System Memory, System IO, or Functional Fixed Hardware address
spaces. OSPM support for this more flexible register space scheme is
indicated by the “Flexible Address Space for CPPC Registers” _OSC bit."

As _CPC register maybe in System Memory, System IO, or Functional Fixed
Hardware address spaces. I am not sure all architecture implementing
CPPC can return correct value before CPU come into online. That's the
reason I add the extra init() call.

BTW, I've tested on QDF2400 platform and it return correct value when
cpu1 is offline.

Do you know whether firmware can guarantee correct perf capabilities
regardless of CPU online/offline?

> 
> > 
> > When cpu1 is online, current code
> > will not call init() in cpufreq_driver as policy has been allocated
> > and
> > activated by cpu0. So, cpu1's perf capabilities are not initialized
> > (all 0s).
> > 
> > When cpu0 is offline, policy->cpu will be shifted to cpu1. As
> > cpu1's perf
> > capabilities are 0s, speed change will not take effect when setting
> > speed.
> > 
> > This patch adds calling init() of cpufreq_driver when policy
> > inactive cpu
> > comes to online.
> No CPU should be inactive here, its just that you haven't initialized
> it
> properly.
> 

I mean the policy is handled(active) by the first online cpu's (cpu0)
perf capabilities. Not handled (inactive) by the one's just come into
online (cpu1). Sorry for this.

Thanks.
Shunyong.


> And we are not going to call init() multiple times for a group of
> CPUs. That's
> not what the purpose of init() is.
> 
