Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FE521476
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FE521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJDBGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:06:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:16211 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDBGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:06:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 11:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="94355446"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.135]) ([10.24.14.135])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2018 11:16:42 -0700
Subject: Re: [PATCH 2/3] x86/intel_rdt: CBM overlap should also check for
 overlap with CDP peer
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, tony.luck@intel.com, jithu.joseph@intel.com,
        gavin.hindman@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1537987801.git.reinette.chatre@intel.com>
 <262e12b66c238517c4766190dd493d937825f563.1537987801.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1810030848580.1435@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6fc60e52-8f93-6135-78c0-254676c0c375@intel.com>
Date:   Wed, 3 Oct 2018 11:16:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810030848580.1435@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 10/3/2018 12:02 AM, Thomas Gleixner wrote:
> On Wed, 26 Sep 2018, Reinette Chatre wrote:
>>  /**
>> - * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
>> + * _rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
>>   * @r: Resource to which domain instance @d belongs.
>>   * @d: The domain instance for which @closid is being tested.
>>   * @cbm: Capacity bitmask being tested.
>> @@ -1049,8 +1048,8 @@ static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
>>   *
>>   * Return: false if CBM does not overlap, true if it does.
>>   */
>> -bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>> -			   u32 _cbm, int closid, bool exclusive)
>> +static bool _rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>> +				   u32 _cbm, int closid, bool exclusive)
> 
> Existing issue. The documentation uses @cbm, but the argument is _cbm.

Thanks for spotting this.

> 
> Also please make this __rdtgroup_cbm_overlaps(). Double underscores are
> standing more out.

Will do.

> 
>>  {
>>  	unsigned long *cbm = (unsigned long *)&_cbm;
>>  	unsigned long *ctrl_b;
>> @@ -1087,6 +1086,44 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>>  	return false;
>>  }
>>  
>> +/**
>> + * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
>> + * @r: Resource to which domain instance @d belongs.
>> + * @d: The domain instance for which @closid is being tested.
>> + * @cbm: Capacity bitmask being tested.
>> + * @closid: Intended closid for @cbm.
>> + * @exclusive: Only check if overlaps with exclusive resource groups
>> + *
>> + * Resources that can be allocated using a CBM can use the CBM to control
>> + * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
>> + * for overlap. Overlap test is not limited to the specific resource for
>> + * which the CBM is intended though - when dealing with CDP resources that
>> + * share the underlying hardware the overlap check should be performed on
>> + * the CDP resource sharing the hardware also.
>> + *
>> + * Refer to description of _rdtgroup_cbm_overlaps() for the details of the
>> + * overlap test.
>> + *
>> + * Return: true if CBM overlap detected, false if there is no overlap
>> + */
>> +bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>> +			   u32 _cbm, int closid, bool exclusive)
> 
> Ditto. And here is no reason for using _cbm.

Thanks for spotting this also, will do.

> 
>> +{
>> +	struct rdt_resource *r_cdp;
>> +	struct rdt_domain *d_cdp;
>> +	bool ret;
>> +
>> +	ret = _rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive);
>> +	if (ret)
>> +		return ret;
> 
>   	if (__rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive))
> 		return true;
> 
>> +
>> +	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) == 0)
>> +		return _rdtgroup_cbm_overlaps(r_cdp, d_cdp, _cbm,
>> +					      closid, exclusive);
> 
> 	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
> 		return false;
> 
> 	return __rdtgroup_cbm_overlaps(r_cpd, d_cdp, _cbm, closid, exclusive);
> 
> Makes the whole thing more obvious.

I think a different change is needed to support the request from your
review of the first patch to propagate that unthinkable error where only
one of the CDP peers could have an rdt_domain associated with it.

In the above that error in question from rdt_cdp_peer_get() will be lost.

I could do the following in support of propagating that error (note that
in support of the code below __rdtgroup_cbm_overlaps() also changes to
return int instead of bool):

int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
                          u32 cbm, int closid, bool exclusive)
{
        struct rdt_resource *r_cdp;
        struct rdt_domain *d_cdp;
        int ret;

        if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
                return 1;

        ret = rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
        if (ret == -ENOENT) {
                return 0;
        } else if (ret == -EINVAL) {
                rdt_last_cmd_puts("Error finding CDP peer\n");
                return ret;
        } else {
                return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm,
                                                closid, exclusive);
        }

        return -EINVAL;
}

With the above change in rdtgroup_cbm_overlaps() the call sites then
change to for example:

        ret = rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true);
        if (ret < 0) {
                /* last_cmd_status already populated with error */
                return -EINVAL;
        } else if (ret == 1) {
                rdt_last_cmd_puts("overlaps with exclusive group\n");
                return -EINVAL;
        }
        /* fall through when no overlap detected */

Would this be acceptable?

Thank you very much

Reinette
