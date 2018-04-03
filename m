Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeDCSyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:54:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:21204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbeDCSyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:54:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000";
   d="scan'208";a="29264352"
Date: Tue, 3 Apr 2018 11:51:18 -0700 (PDT)
From: Shivappa Vikas <vikas.shivappa@intel.com>
X-X-Sender: vikas@vshiva-Udesk
To: Thomas Gleixner <tglx@linutronix.de>
cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 3/6] x86/intel_rdt/mba_sc: Add initialization support
In-Reply-To: <alpine.DEB.2.21.1803301154580.1478@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.10.1804031149480.27913@vshiva-Udesk>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-4-git-send-email-vikas.shivappa@linux.intel.com> <alpine.DEB.2.21.1803301154580.1478@nanos.tec.linutronix.de>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Apr 2018, Thomas Gleixner wrote:

> On Thu, 29 Mar 2018, Vikas Shivappa wrote:
>> +void setup_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
>> +{
>> +	int i;
>> +
>> +	/*
>> +	 * Initialize the Control MSRs to having no control.
>> +	 * For Cache Allocation: Set all bits in cbm
>> +	 * For Memory Allocation: Set b/w requested to 100%
>> +	 * and the b/w in MB to U32_MAX
>> +	 */
>> +	for (i = 0; i < r->num_closid; i++, dc++, dm++) {
>> +		*dc = r->membw.bw_byte ? MBA_BW_MAX_MB : r->default_ctrl;
>> +		*dm = r->default_ctrl;
>
> No! Please stop duct taping your stuff into the existing code. So far the
> ctrl value was the same as the value which was actually written into the
> MSR. With your new mode you have to split that up into the user supplied
> value and the value which gets written into the MSR.
>
> So the right thing to do is to separate the user value and the MSR value
> first and independent of the mode. Then the new mode falls into place
> naturally because r->default_ctrl and r->default_msrval are set up at mount
> time with the values which correspond to the mount mode.

will fix. I tried both and this implementation assumes what user modifies is 
the control values (because then schemata read and write is easy as user does it 
directly) but agree we can change that.

Thanks,
Vikas

>
> Thanks,
>
> 	tglx
>
