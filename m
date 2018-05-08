Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeEHWtq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:49:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:34096 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbeEHWtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:49:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39474051"
Subject: Re: [PATCH 0/9] [v3] x86, pkeys: two protection keys bug fixes
To: Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180427174527.0031016C@viggo.jf.intel.com>
 <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        tglx@linutronix.de, mpe@ellerman.id.au, akpm@linux-foundation.org,
        shuah@kernel.org, shakeelb@google.com
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <0bb50502-02f3-0eeb-b126-0345ec029145@intel.com>
Date: Tue, 8 May 2018 15:49:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1)
> 
> Minor patch series organization requests:
> 
>  - please include the shortlog and diffstat in the cover letter in the future, as 
>    it makes it easier to see the overall structure and makes it easier to reply to 
>    certain commits as a group.

Will do.

>  - please capitalize commit titles as is usually done in arch/x86/ and change the 
>    change the subsystem tags to the usual ones:
> 
> d76eeb1914c8: x86/pkeys: Override pkey when moving away from PROT_EXEC
> f30f10248200: x86/pkeys/selftests: Add PROT_EXEC test
> 0530ebfefcdc: x86/pkeys/selftests: Add allow faults on unknown keys
> e81c40e33818: x86/pkeys/selftests: Factor out "instruction page"
> 57042882631c: x86/pkeys/selftests: Fix pkey exhaustion test off-by-one
> 6b833e9d3171: x86/pkeys/selftests: Fix pointer math
> d16f12e3c4ca: x86/pkeys: Do not special case protection key 0
> 1cb7691d0ee4: x86/pkeys/selftests: Add a test for pkey 0
> 273ae5cde423: x86/pkeys/selftests: Save off 'prot' for allocations
>
>  - please re-order the series to first introduce a unit test which specifically 
>    tests for the failure, ascertain that it indeed fails, and then apply the 
>    kernel fix. I.e. please use the order I used above for future versions of this 
>    patch-set.

I can't _quite_ use this order, but I get your point and I'll do as you
suggest, conceptually.


> 2)
> 
> The new self-test you added does not fail overly nicely, it does the following on 
> older kernels:
...
> I.e. x86 unit tests should never 'crash' in a way that suggests that the testing 
> itself might be buggy - the crashes/failures should always be well controlled.

I've tried to make this nicer.  I never abort() any more, for instance.

> 3)
> 
> When the first kernel bug fix is applied but not the second, then I don't see the 
> new PROT_EXEC test catching the bug:

Thanks for catching this.  I forgot to add the test function to the
pkey_tests[] array.  It's fixed up now.

> 4)
> 
> In the above kernel that was missing the PROT_EXEC fix I was repeatedly running 
> the 64-bit and 32-bit testcases as non-root and as root as well, until I got a 
> hang in the middle of a 32-bit test running as root:

I believe this is all my stupidity from not being careful about using
signal-safe functions in the signal handlers.  There's no pretty
solution for this, but I've at least made it stop hanging.  The fixes
for that will be in the beginning of the next series.
