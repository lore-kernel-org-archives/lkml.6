Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAADC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD61213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD61213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeJDClc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:41:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:47470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeJDClb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:41:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 12:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="94378585"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.135]) ([10.24.14.135])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2018 12:51:38 -0700
Subject: Re: [PATCH 2/3] x86/intel_rdt: CBM overlap should also check for
 overlap with CDP peer
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, tony.luck@intel.com, jithu.joseph@intel.com,
        gavin.hindman@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1537987801.git.reinette.chatre@intel.com>
 <262e12b66c238517c4766190dd493d937825f563.1537987801.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1810030848580.1435@nanos.tec.linutronix.de>
 <6fc60e52-8f93-6135-78c0-254676c0c375@intel.com>
 <alpine.DEB.2.21.1810032138290.27796@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cd0877d5-e860-21f7-0f5f-e348d996e45c@intel.com>
Date:   Wed, 3 Oct 2018 12:51:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810032138290.27796@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 10/3/2018 12:43 PM, Thomas Gleixner wrote:
> On Wed, 3 Oct 2018, Reinette Chatre wrote:
>> On 10/3/2018 12:02 AM, Thomas Gleixner wrote:
>>>> +{
>>>> +	struct rdt_resource *r_cdp;
>>>> +	struct rdt_domain *d_cdp;
>>>> +	bool ret;
>>>> +
>>>> +	ret = _rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive);
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>>   	if (__rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive))
>>> 		return true;
>>>
>>>> +
>>>> +	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) == 0)
>>>> +		return _rdtgroup_cbm_overlaps(r_cdp, d_cdp, _cbm,
>>>> +					      closid, exclusive);
>>>
>>> 	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
>>> 		return false;
>>>
>>> 	return __rdtgroup_cbm_overlaps(r_cpd, d_cdp, _cbm, closid, exclusive);
>>>
>>> Makes the whole thing more obvious.
>>
>> I think a different change is needed to support the request from your
>> review of the first patch to propagate that unthinkable error where only
>> one of the CDP peers could have an rdt_domain associated with it.
>>
>> In the above that error in question from rdt_cdp_peer_get() will be lost.
>>
>> I could do the following in support of propagating that error (note that
>> in support of the code below __rdtgroup_cbm_overlaps() also changes to
>> return int instead of bool):
>>
>> int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>>                           u32 cbm, int closid, bool exclusive)
>> {
>>         struct rdt_resource *r_cdp;
>>         struct rdt_domain *d_cdp;
>>         int ret;
>>
>>         if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
>>                 return 1;
>>
>>         ret = rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
>>         if (ret == -ENOENT) {
>>                 return 0;
>>         } else if (ret == -EINVAL) {
>>                 rdt_last_cmd_puts("Error finding CDP peer\n");
>>                 return ret;
>>         } else {
>>                 return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm,
>>                                                 closid, exclusive);
>>         }
>>
>>         return -EINVAL;
>> }
>>
>> With the above change in rdtgroup_cbm_overlaps() the call sites then
>> change to for example:
>>
>>         ret = rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true);
>>         if (ret < 0) {
>>                 /* last_cmd_status already populated with error */
>>                 return -EINVAL;
>>         } else if (ret == 1) {
>>                 rdt_last_cmd_puts("overlaps with exclusive group\n");
>>                 return -EINVAL;
>>         }
>>         /* fall through when no overlap detected */
>>
>> Would this be acceptable?
> 
> We really have to think about that whether it's worth it. Looking at the
> resulting code I doubt it. Then I'd rather prefer the warnon and the
> simpler code. But either way works for me.

Thank you very much. I'll resubmit with the changes you prefer.

Reinette

