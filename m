Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0777C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F2E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F2E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLLAeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:34:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:54939 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeLLAeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:34:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 16:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="117589257"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2018 16:34:43 -0800
Subject: Re: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <20181211002448.3520-1-aubrey.li@intel.com>
 <e51c6513-3b5d-972c-5d26-d20283057bb8@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <f142bab7-5ede-b17c-f0e0-f1ab0acb44cd@linux.intel.com>
Date:   Wed, 12 Dec 2018 08:34:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e51c6513-3b5d-972c-5d26-d20283057bb8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/12 1:20, Dave Hansen wrote:
>  to update AVX512 state
>> + */
>> +static inline void update_avx512_state(struct fpu *fpu)
>> +{
>> +	/*
>> +	 * AVX512 state is tracked here because its use is known to slow
>> +	 * the max clock speed of the core.
>> +	 *
>> +	 * However, AVX512-using tasks are expected to clear this state when
>> +	 * not actively using these registers. Thus, this tracking mechanism
>> +	 * can miss. To ensure that false-negatives do not immediately show
>> +	 * up, decay the usage count over time.
>> +	 */
>> +	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
>> +		fpu->avx512_usage = AVX512_STATE_DECAY_COUNT;
>> +	else if (fpu->avx512_usage)
>> +		fpu->avx512_usage--;
>> +}
>> +
>>  /*
>>   * This function is called only during boot time when x86 caps are not set
>>   * up and alternative can not be used yet.
>> @@ -411,6 +432,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
>>  {
>>  	if (likely(use_xsave())) {
>>  		copy_xregs_to_kernel(&fpu->state.xsave);
>> +		update_avx512_state(fpu);
>>  		return 1;
>>  	}
> 
> 
> Is there a reason we shouldn't do:
> 
> 	if (!cpu_feature_enabled(X86_FEATURE_AVX512F))
> 		update_avx512_state(fpu);
> 
> ?
> 

Why _!_ ?


