Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76322086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76322086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbeKQKvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:51:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:18160 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQKvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:51:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 16:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="92728333"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2018 16:36:35 -0800
Subject: Re: [PATCH v3 1/2] x86/fpu: track AVX-512 usage of tasks
To:     Dave Hansen <dave.hansen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <1542236407-4323-1-git-send-email-aubrey.li@intel.com>
 <6f8a7b97-d889-ce77-b5ad-d03dbf4986b0@intel.com>
 <88a5d6df-0005-db3e-f3be-83e2a8b63a27@linux.intel.com>
 <b67c995e-3883-ce17-0396-b1621ec5d58f@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ed5bf776-3e39-5a5f-4072-52dacde41772@linux.intel.com>
Date:   Sat, 17 Nov 2018 08:36:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <b67c995e-3883-ce17-0396-b1621ec5d58f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/17 7:10, Dave Hansen wrote:
> On 11/15/18 4:21 PM, Li, Aubrey wrote:
>> "Core cycles where the core was running with power delivery for license
>> level 2 (introduced in Skylake Server microarchitecture). This includes
>> high current AVX 512-bit instructions."
>>
>> I translated license level 2 to frequency drop.
> 
> BTW, the "high" in that text: "high-current AVX 512-bit instructions" is
> talking about high-current, not "high ... instructions" or high-numbered
> registers.  I think that might be the source of some of the confusion
> about which XSAVE state needs to be examined.
> 
> Just to be clear: there are 3 AVX-512 XSAVE states:
> 
>         XFEATURE_OPMASK,
>         XFEATURE_ZMM_Hi256,
>         XFEATURE_Hi16_ZMM,
> 
> I honestly don't know what XFEATURE_OPMASK does.  It does not appear to
> be affected by VZEROUPPER (although VZEROUPPER's SDM documentation isn't
> looking too great).
> 
> But, XFEATURE_ZMM_Hi256 is used for the upper 256 bits of the
> registers ZMM0-ZMM15.  Those are AVX-512-only registers.  The only way
> to get data into XFEATURE_ZMM_Hi256 state is by using AVX512 instructions.
> 
> XFEATURE_Hi16_ZMM is the same.  The only way to get state in there is
> with AVX512 instructions.
> 
> So, first of all, I think you *MUST* check XFEATURE_ZMM_Hi256 and
> XFEATURE_Hi16_ZMM.  That's without question.

No, XFEATURE_ZMM_Hi256 does not request turbo license 2, so it's less
interested to us.

> 
> It's probably *possible* to run AVX512 instructions by loading state
> into the YMM register and then executing AVX512 instructions that only
> write to memory and never to register state.  That *might* allow
> XFEATURE_Hi16_ZMM and XFEATURE_ZMM_Hi256 to stay in the init state, but
> for the frequency to be affected since AVX512 instructions _are_
> executing.  But, there's no way to detect this situation from XSAVE
> states themselves.
> 

Andi should have more details on this. FWICT, not all AVX512 instructions
has high current, those only touching memory do not cause notable frequency
drop.

Thanks,
-Aubrey
