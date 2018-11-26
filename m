Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49982084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49982084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeKZO3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:29:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:20778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeKZO3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:29:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2018 19:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,280,1539673200"; 
   d="scan'208";a="111433439"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga002.jf.intel.com with ESMTP; 25 Nov 2018 19:36:13 -0800
Subject: Re: [PATCH v3 1/2] x86/fpu: track AVX-512 usage of tasks
To:     Samuel Neves <sneves@dei.uc.pt>, dave.hansen@intel.com,
        aubrey.li@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
References: <CAEX_ruH=9VHD-8YH2--4mYPq7LD2Ciya2ADeSO=c38s2KaQhUg@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <2a1a43a7-bb70-9629-0694-1f326ed70e54@linux.intel.com>
Date:   Mon, 26 Nov 2018 11:36:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAEX_ruH=9VHD-8YH2--4mYPq7LD2Ciya2ADeSO=c38s2KaQhUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/18 22:03, Samuel Neves wrote:
> On 11/17/18 12:36 AM, Li, Aubrey wrote:
>> On 2018/11/17 7:10, Dave Hansen wrote:
>>> Just to be clear: there are 3 AVX-512 XSAVE states:
>>>
>>>          XFEATURE_OPMASK,
>>>          XFEATURE_ZMM_Hi256,
>>>          XFEATURE_Hi16_ZMM,
>>>
>>> I honestly don't know what XFEATURE_OPMASK does.  It does not appear to
>>> be affected by VZEROUPPER (although VZEROUPPER's SDM documentation isn't
>>> looking too great).
> 
> XFEATURE_OPMASK refers to the additional 8 mask registers used in
> AVX512. These are more similar to general purpose registers than
> vector registers, and should not be too relevant here.
> 
>>>
>>> But, XFEATURE_ZMM_Hi256 is used for the upper 256 bits of the
>>> registers ZMM0-ZMM15.  Those are AVX-512-only registers.  The only way
>>> to get data into XFEATURE_ZMM_Hi256 state is by using AVX512 instructions.
>>>
>>> XFEATURE_Hi16_ZMM is the same.  The only way to get state in there is
>>> with AVX512 instructions.
>>>
>>> So, first of all, I think you *MUST* check XFEATURE_ZMM_Hi256 and
>>> XFEATURE_Hi16_ZMM.  That's without question.
>>
>> No, XFEATURE_ZMM_Hi256 does not request turbo license 2, so it's less
>> interested to us.
>>
> 
> I think Dave is right, and it's easy enough to check this. See the
> attached program. For the "high current" instruction vpmuludq
> operating on zmm0--zmm3 registers, we have (on a Skylake-SP Xeon Gold
> 5120)
> 
>            175,097      core_power.lvl0_turbo_license:u
>                      ( +-  2.18% )
>             41,185      core_power.lvl1_turbo_license:u
>                      ( +-  1.55% )
>         83,928,648      core_power.lvl2_turbo_license:u
>                      ( +-  0.00% )
> 
> while for the same code operating on zmm28--zmm31 registers, we have
> 
>            163,507      core_power.lvl0_turbo_license:u
>                      ( +-  6.85% )
>             47,390      core_power.lvl1_turbo_license:u
>                      ( +- 12.25% )
>         83,927,735      core_power.lvl2_turbo_license:u
>                      ( +-  0.00% )
> 
> In other words, the register index does not seem to matter at all for
> turbo license purposes (this makes sense, considering these chips have
> 168 vector registers internally; zmm15--zmm31 are simply newly exposed
> architectural registers).
> 
> We can also see that XFEATURE_Hi16_ZMM does not imply license 1 or 2;
> we may be using xmm15--xmm31 purely for the convenient extra register
> space. For example, cases 4 and 5 of the sample program:
> 
>         84,064,239      core_power.lvl0_turbo_license:u
>                      ( +-  0.00% )
>                  0      core_power.lvl1_turbo_license:u
>                  0      core_power.lvl2_turbo_license:u
> 
>         84,060,625      core_power.lvl0_turbo_license:u
>                      ( +-  0.00% )
>                  0      core_power.lvl1_turbo_license:u
>                  0      core_power.lvl2_turbo_license:u
> 
> So what's most important is the width of the vectors being used, not
> the instruction set or the register index. Second to that is the
> instruction type, namely whether those are "heavy" instructions.
> Neither of these things can be accurately captured by the XSAVE state.
> 

okay, in terms of license 2 we only care about, AVX512 is a requirement.
Do we have any exception of non-AVX512 producing license 2? If no, I'm
gonna use 

#define XFEATURE_MASK_AVX512            (XFEATURE_MASK_OPMASK \
                                         | XFEATURE_MASK_ZMM_Hi256 \
                                         | XFEATURE_MASK_Hi16_ZMM)

to expose AVX512 component usage. Although AVX512 is not a sufficient
condition of license 2, but the usage could be an useful hint to the user
tool to further check PMU counter. (That is, if the hint is zero, no need
further check).

What do you think?

Thanks,
-Aubrey
