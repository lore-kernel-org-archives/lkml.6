Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeC2OfE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:35:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:15219 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeC2OfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:35:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37895689"
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <20180329134723.GA4043@hirez.programming.kicks-ass.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8a24d82e-a8dd-2f35-4764-a58fd6c64ae8@linux.intel.com>
Date: Thu, 29 Mar 2018 07:34:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329134723.GA4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 06:47 AM, Peter Zijlstra wrote:
> The issue is that HPC workloads care about cache-size-per-cpu measure,
> and the way they go about obtaining that is reading the cache-size and
> dividing it by the h-weight of the cache-mask.

That works, but only if the memory being accessed is slice/node-local.
If it's spread across the package, it'll be wrong.

But, the HPC folks are the ones that are the most likely to have good
NUMA affinity, so that would seem to point us in the direction of both
halving the size and the mask so that the LLC _looks_ split to userspace.

> Now the patch does in fact change the cache-mask as exposed to
> userspace, it however does _NOT_ change the cache-size. This means that
> anybody using the values from sysfs to compute size/weight, now gets
> double the value they ought to get.
> 
> So either is must not change the llc-mask, or also change the llc-size.

IOW, don't make it look like we've either doubled or halved the exposed
size of the llc.

> Which then leads to the conclusion that the current:
> 
>> +             /* Do not use LLC for scheduler decisions: */
>> +             return false;
> 
> is wrong. Also, that comment is *completely* wrong, since the return
> value has *nothing* to do with scheduler decisions

OK, got it.  That comment betrayed my ignorance.  I'm glad we put it there.

What should we say, though?

             /*
	      * false means 'c' does not share the LLC of 'o'.
	      * Note: this decision gets reflected all the way
	      * out to userspace
	      */
             return false;
