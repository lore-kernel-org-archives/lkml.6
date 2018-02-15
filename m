Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166993AbeBOUpV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:45:21 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36448 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161844AbeBOUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:45:17 -0500
X-Google-Smtp-Source: AH8x226K7NQ1z5xKMKmcabJf+HdHu/wXuDeTrNXlBoT9pIKZZ7cvcDV9fguCfXsExDzHpIloPpTM6w==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <3f69237a-ee32-3d06-dacd-a7f7897f6251@linux.intel.com>
Date: Thu, 15 Feb 2018 12:45:11 -0800
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <7B00EFC7-7BF2-4A17-981E-01EC69AEADA8@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-6-namit@vmware.com>
 <CALCETrX+F5apPenXGBf9oAc+aJieQYDA81zigPk6q6q6pa_i5A@mail.gmail.com>
 <3f69237a-ee32-3d06-dacd-a7f7897f6251@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1FKjPoh025342

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 02/15/2018 11:53 AM, Andy Lutomirski wrote:
>>> --- a/arch/x86/include/asm/tlbflush.h
>>> +++ b/arch/x86/include/asm/tlbflush.h
>>> @@ -319,6 +319,12 @@ static inline void set_cpu_pti_disable(unsigned short disable)
>>>        WARN_ON_ONCE(preemptible());
>>> 
>>>        pti_update_user_cs64(cpu_pti_disable(), disable);
>>> +       if (__supported_pte_mask & _PAGE_GLOBAL) {
>>> +               if (disable)
>>> +                       cr4_set_bits(X86_CR4_PGE);
>>> +               else
>>> +                       cr4_clear_bits(X86_CR4_PGE);
>>> +       }
>> This will be *extremely* slow, and I don't see the point at all.  What
>> are you accomplishing here?
> 
> It won't be slow if you always run compat processes, I guess.
> 
> But mixing these in here will eat a big chunk of the benefit of having
> global pages (or PCIDs for that matter) in the first place.

These are all good points. The idea was to allow workloads like Apache, that
spawn multiple processes that frequently perform context-switches to incur
TLB misses on kernel pages. 

The double-flushing was not intentional - I missed it. Anyhow, based on your
comments, and because I don’t see an easy way to make the global
cpu_entry_area (your recent patches) to work with this patch, I think I will
drop this patch.
