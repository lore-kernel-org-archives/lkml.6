Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932342AbeBSXAW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:00:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:17575 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbeBSXAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:00:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="19314940"
Subject: Re: [RFC PATCH V2 11/22] x86/intel_rdt: Associate pseudo-locked
 regions with its domain
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802192218370.1853@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <7bd1f8e8-116f-bdb2-23d2-a94f9a21e028@intel.com>
Date: Mon, 19 Feb 2018 15:00:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802192218370.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/19/2018 1:19 PM, Thomas Gleixner wrote:
> On Tue, 13 Feb 2018, Reinette Chatre wrote:
> 
>> After a pseudo-locked region is locked it needs to be associated with
>> the RDT domain representing the pseudo-locked cache so that its life
>> cycle can be managed correctly.
>>
>> Only a single pseudo-locked region can exist on any cache instance so we
>> maintain a single pointer to a pseudo-locked region from each RDT
>> domain.
> 
> Why is only a single pseudo locked region possible? 

The setup of a pseudo-locked region requires the usage of wbinvd. If a
second pseudo-locked region is thus attempted it will evict the
pseudo-locked data of the first.

> 
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  arch/x86/kernel/cpu/intel_rdt.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
>> index 060a0976ac00..f0e020686e99 100644
>> --- a/arch/x86/kernel/cpu/intel_rdt.h
>> +++ b/arch/x86/kernel/cpu/intel_rdt.h
>> @@ -187,6 +187,8 @@ struct mbm_state {
>>  	u64	prev_msr;
>>  };
>>  
>> +struct pseudo_lock_region;
>> +
>>  /**
>>   * struct rdt_domain - group of cpus sharing an RDT resource
>>   * @list:	all instances of this resource
>> @@ -205,6 +207,7 @@ struct mbm_state {
>>   * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
>>   * @new_ctrl:	new ctrl value to be loaded
>>   * @have_new_ctrl: did user provide new_ctrl for this domain
>> + * @plr:	pseudo-locked region associated with this domain
>>   */
>>  struct rdt_domain {
>>  	struct list_head	list;
>> @@ -220,6 +223,7 @@ struct rdt_domain {
>>  	u32			*ctrl_val;
>>  	u32			new_ctrl;
>>  	bool			have_new_ctrl;
>> +	struct pseudo_lock_region	*plr;
> 
> Please keep the tabular fashion of the struct declaration intact.

Will fix.

Reinette
