Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755800AbeBOUcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:32:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:28029 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755639AbeBOUcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:32:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,518,1511856000";
   d="scan'208";a="27634628"
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
To: Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-6-namit@vmware.com>
 <CALCETrX+F5apPenXGBf9oAc+aJieQYDA81zigPk6q6q6pa_i5A@mail.gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <3f69237a-ee32-3d06-dacd-a7f7897f6251@linux.intel.com>
Date: Thu, 15 Feb 2018 12:32:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX+F5apPenXGBf9oAc+aJieQYDA81zigPk6q6q6pa_i5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 11:53 AM, Andy Lutomirski wrote:
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -319,6 +319,12 @@ static inline void set_cpu_pti_disable(unsigned short disable)
>>         WARN_ON_ONCE(preemptible());
>>
>>         pti_update_user_cs64(cpu_pti_disable(), disable);
>> +       if (__supported_pte_mask & _PAGE_GLOBAL) {
>> +               if (disable)
>> +                       cr4_set_bits(X86_CR4_PGE);
>> +               else
>> +                       cr4_clear_bits(X86_CR4_PGE);
>> +       }
> This will be *extremely* slow, and I don't see the point at all.  What
> are you accomplishing here?

It won't be slow if you always run compat processes, I guess.

But mixing these in here will eat a big chunk of the benefit of having
global pages (or PCIDs for that matter) in the first place.
