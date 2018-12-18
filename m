Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D85C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC1218A5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeLRPLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:11:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:23191 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLRPLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:11:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 07:11:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; 
   d="scan'208";a="119805608"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2018 07:11:40 -0800
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
To:     Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20181218042218.8653-1-aubrey.li@intel.com>
 <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <62997df2-0817-b54d-b11e-00a567f1d67c@linux.intel.com>
Date:   Tue, 18 Dec 2018 23:11:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/18 22:14, Thomas Gleixner wrote:
> On Tue, 18 Dec 2018, Aubrey Li wrote:
>> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
>> index a38bf5a1e37a..8778ac172255 100644
>> --- a/arch/x86/include/asm/fpu/internal.h
>> +++ b/arch/x86/include/asm/fpu/internal.h
>> @@ -411,6 +411,13 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
>>  {
>>  	if (likely(use_xsave())) {
>>  		copy_xregs_to_kernel(&fpu->state.xsave);
>> +
>> +		/*
>> +		 * AVX512 state is tracked here because its use is
>> +		 * known to slow the max clock speed of the core.
>> +		 */
>> +		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
>> +			fpu->avx512_timestamp = jiffies_64;
> 
> Even if unlikely this is incorrect when running a 32 bit kernel because
> there jiffies_64 cannot be atomically loaded vs. a concurrent update. See
> the comment in include/linux/jiffies.h right above the jiffies_64
> declaration.
> 
Yeah, I noticed this, because this is under use_xsave() condition, also need
valid AVX512 state, so a 32 bit kernel won't enter this branch.

Thanks,
-Aubrey
