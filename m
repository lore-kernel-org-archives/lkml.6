Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA5CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD0E208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD0E208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933385AbeFTV1R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:27:17 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.179]:47920 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933115AbeFTV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:27:16 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 551F111B04
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:27:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VkdEf6qBebXuJVkdFfJY8f; Wed, 20 Jun 2018 16:27:14 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58076 helo=[192.168.1.71])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fVkdD-004HA4-Qt; Wed, 20 Jun 2018 16:27:11 -0500
Subject: Re: [Intel-gfx] [PATCH] drm/i915: mark expected switch fall-through
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180620133100.GA608@embeddedor.com>
 <20180620190628.GC8258@intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <26740470-d7b7-0a58-0aae-fc628bd4f416@embeddedor.com>
Date:   Wed, 20 Jun 2018 16:27:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620190628.GC8258@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fVkdD-004HA4-Qt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.250.65.56]:58076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 02:06 PM, Rodrigo Vivi wrote:
> On Wed, Jun 20, 2018 at 08:31:00AM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 1470102 ("Missing break in switch")
> 
> Any other advantage besides coverity?
> Can't we address it by marking as "Intentional" on the tool?
> 

Yes. The advantage of this is that it will eventually allows to enable 
-Wimplicit-fallthrough, hence, enabling the compiler to trigger a 
warning, which will force us to double check if we are actually missing 
a break before committing the code.

The change in the code has nothing to do with the Coverity tool. The 
tool is only reporting the issue, which, in this case, is a false positive.


> I'm afraid there will be so many more places to add fallthrough
> marks....
> 

Oh yeah, there are around 1000 similar places in the whole codebase. 
There is an ongoing effort to review each case. Months ago, it used to 
be around 1500 of these cases.

Thanks
--
Gustavo

>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/gpu/drm/i915/intel_dpll_mgr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/i915/intel_dpll_mgr.c b/drivers/gpu/drm/i915/intel_dpll_mgr.c
>> index 132fe63..6a40a77 100644
>> --- a/drivers/gpu/drm/i915/intel_dpll_mgr.c
>> +++ b/drivers/gpu/drm/i915/intel_dpll_mgr.c
>> @@ -2566,6 +2566,7 @@ int icl_calc_dp_combo_pll_link(struct drm_i915_private *dev_priv,
>>   	switch (index) {
>>   	default:
>>   		MISSING_CASE(index);
>> +		/* fall through */
>>   	case 0:
>>   		link_clock = 540000;
>>   		break;
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
