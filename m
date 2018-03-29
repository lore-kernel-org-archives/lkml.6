Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeC2NpO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:45:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:25532 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeC2NpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:45:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37876468"
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Thomas Gleixner <tglx@linutronix.de>,
        Alison Schofield <alison.schofield@intel.com>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <aa369ee2-6557-8e3f-e2b4-d347b27825a6@linux.intel.com>
Date: Thu, 29 Mar 2018 06:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 06:16 AM, Thomas Gleixner wrote:
>> This is OK at least on the hardware we are immediately concerned about
>> because the LLC sharing happens at both the slice and at the package
>> level, which are also NUMA boundaries.
> So that addresses the scheduler interaction, but it still leaves the
> information in the sysfs files unchanged. See cpu/intel_cacheinfo.c.  There
> are applications which use that information so it should be correct.

Were you thinking of shared_cpu_list/map?  The information in there is
correct for core->off-package access.  It is not correct for
core->on-package access, unless that access is perfectly interleaved
across both package "slices".

We could try to add an attribute or two to clarify this situation.  But,
similar to the CPUID leaves, I don't think we actually have a precise
way to describe the way the cache actually works here.
