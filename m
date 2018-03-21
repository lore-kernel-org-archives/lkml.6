Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeCUV4z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:56:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39523 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753772AbeCUV4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:56:54 -0400
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on
 paranoid_entry
To: Andy Lutomirski <luto@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "markus.t.metzger@intel.com" <markus.t.metzger@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <eb30911b621144fe92e77fd2d9da7efe@AcuMS.aculab.com>
 <191d8212-6740-3131-1653-d057f522843c@zytor.com>
 <CALCETrX0ew6xcbxiKDkpGw8CJsF0TWNZc=GHuVEPbDpfZ-X3ww@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <9aa3ef0a-84b5-9806-4213-1b63023e6c5a@zytor.com>
Date: Wed, 21 Mar 2018 14:56:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX0ew6xcbxiKDkpGw8CJsF0TWNZc=GHuVEPbDpfZ-X3ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/18 17:36, Andy Lutomirski wrote:
>>
>> But we also don't need swapgs when we have rdgsbase/wrgsbase available.
>> We can indeed just unconditionally save it (via rdgsbase) into the stack
>> frame and wrgsbase the correct percpu value.  In that case it might be
>> necessary in order to avoid insane complexity to also save/restore the
>> gs selector.
> 
> This is exactly what the old code did.  I liked the old code better.
> 
>>
>> Is it going to be faster?  *Probably* not as swapgs is designed to be
>> fast; it does, however, eliminate the need to RDMSR/WRMSR inside the
>> kernel task switch as the user space gsbase will simply live on the
>> stack.  (This is assuming we do this unconditionally on every method of
>> kernel entry, including non-paranoid.  I'm not sure if we ever care
>> about the userspace GS/GSBASE inside a paranoid handler, but if we do it
>> would be rather messy to find if we do this conditionally.
>>
>> Now...
>>
>> +       ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase", \
>> +               "RDGSBASE %rdx", X86_FEATURE_FSGSBASE
>> +       READ_KERNEL_GSBASE %rax
>>
>> READ_KERNEL_GSBASE here seems like a Really Bad Name[TM] for this macro,
>> since it seems to imply reading MSR_KERNEL_GS_BASE, rather than finding
>> the current percpu offset.  I would prefer calling it something like
>> FIND_PERCPU_BASE or something like that.
> 
> I think we should revert to what the old patches did here.
> 

I don't really understand why you want to do it this way.

1. It means that the location of the user space gs_base is ill-defined,
   whereas with the SWAPGS it is *always* in the same place.

2. It is most likely slower, although I obviously haven't benchmarked
   it.

	-hpa
