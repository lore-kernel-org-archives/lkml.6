Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADE420883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADE420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKHKEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:04:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:60048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbeKHKEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:04:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 16:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,477,1534834800"; 
   d="scan'208";a="106370584"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2018 16:31:54 -0800
Subject: Re: [RFC PATCH v1 1/2] x86/fpu: detect AVX task
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <cd83910a-7197-9c49-3b93-22d699d887c4@linux.intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <216189f0-a411-8bba-99d2-c4661de0ff93@linux.intel.com>
Date:   Thu, 8 Nov 2018 08:31:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <cd83910a-7197-9c49-3b93-22d699d887c4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/8 1:41, Tim Chen wrote:
> On 11/06/2018 10:23 AM, Aubrey Li wrote:
> 
>> +static inline void update_avx_state(struct avx_state *avx)
>> +{
>> +	/*
>> +	 * Check if XGETBV with ECX = 1 supported. XGETBV with ECX = 1
>> +	 * returns the logical-AND of XCR0 and XINUSE. XINUSE is a bitmap
>> +	 * by which the processor tracks the status of various components.
>> +	 */
>> +	if (!use_xgetbv1()) {
>> +		avx->state = 0;
>> +		return;
>> +	}
>> +	/*
>> +	 * XINUSE is dynamic to track component state because VZEROUPPER
>> +	 * happens on every function end and reset the bitmap to the
>> +	 * initial configuration.
>> +	 *
>> +	 * State decay is introduced to solve the race condition between
>> +	 * context switch and a function end. State is aggressively set
>> +	 * once it's detected but need to be cleared by decay 3 context
>> +	 * switches
>> +	 */
>> +	if (xgetbv(XINUSE_STATE_BITMAP_INDEX) & XFEATURE_MASK_Hi16_ZMM) {
>> +		avx->state = 1;
>> +		avx->decay_count = AVX_STATE_DECAY_COUNT;
>> +	} else {
>> +		if (!avx->decay_count)
> 
> Seems like the check should be
> 
> 		if (avx->decay_count)
> 
> as we decrement the decay_count if it is non-zero.

Right, thanks to point this out, will fix in v2 soon.

Thanks,
-Aubrey
> 
>> +			avx->decay_count--;
>> +		else
>> +			avx->state = 0;
>> +	}
>> +}
> 
> Tim
> 

