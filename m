Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeDDSmN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:42:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:60169 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbeDDSmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:42:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="213939365"
Subject: Re: [PATCH v4] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Alison Schofield <alison.schofield@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20180403211230.GA12842@alison-desk.jf.intel.com>
 <2d00edef-c8bf-2fc6-c342-274a0681e225@linux.intel.com>
 <20180404173848.GA10518@alison-desk.jf.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <d179ced2-e862-0a67-e653-39c0cb55dbaf@linux.intel.com>
Date: Wed, 4 Apr 2018 11:42:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180404173848.GA10518@alison-desk.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 10:38 AM, Alison Schofield wrote:
> On Wed, Apr 04, 2018 at 10:24:49AM -0700, Tim Chen wrote:
>> On 04/03/2018 02:12 PM, Alison Schofield wrote:
>>
>>> +
>>> +	/*
>>> +	 * topology_sane() considers LLCs that span NUMA nodes to be
>>> +	 * insane and will display a warning message. Bypass the call
>>> +	 * to topology_sane() for snc_cpu's to avoid that warning.
>>> +	 */
>>> +
>>> +	if (!topology_same_node(c, o) && x86_match_cpu(snc_cpu)) {
>>> +		/* Indicate that package has NUMA nodes inside: */
>>> +		x86_has_numa_in_package = true;
>>
>> Why does the x86_has_numa_in_package has to be set here when it would have
>> been done later in set_cpu_sibling_map?
> 
> Tim,
> I had that same thought when you commented on it previously. After 
> discussing w DaveH, decided that match_llc() and match_die(c,0)
> could be different and chose to be (cautiously) redundant.
> alisons

If it is redundant, I suggest it be removed, and only added if
there is truly a case where the current logic 

                if (match_die(c, o) && !topology_same_node(c, o))
                        x86_has_numa_in_package = true;

fails.  And also the modification of this logic should be at the
same place for easy code maintenance. 

Tim  

> 
> 
> 
>>
>>> +
>>> +		/*
>>> +		 * false means 'c' does not share the LLC of 'o'.
>>> +		 * Note: this decision gets reflected all the way
>>> +		 * out to userspace.
>>> +		 */
>>> +
>>> +		return false;
>>
>> Thanks.
>>
>> Tim
