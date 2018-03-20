Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCTUHj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:07:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58705 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCTUHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:07:36 -0400
Subject: Re: [PATCH 13/15] x86/fsgsbase/64: With FSGSBASE, compare GS bases on
 paranoid_entry
To: David Laight <David.Laight@ACULAB.COM>,
        "'Chang S. Bae'" <chang.seok.bae@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Cc: "luto@kernel.org" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "markus.t.metzger@intel.com" <markus.t.metzger@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-14-git-send-email-chang.seok.bae@intel.com>
 <eb30911b621144fe92e77fd2d9da7efe@AcuMS.aculab.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <191d8212-6740-3131-1653-d057f522843c@zytor.com>
Date: Tue, 20 Mar 2018 13:07:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <eb30911b621144fe92e77fd2d9da7efe@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/18 03:16, David Laight wrote:
> From: Chang S. Bae
>> Sent: 19 March 2018 17:49
> ...
>> When FSGSBASE is enabled, SWAPGS needs if and only if (current)
>> GS base is not the kernel's.
>>
>> FSGSBASE instructions allow user to write any value on GS base;
>> even negative. Sign check on the current GS base is not
>> sufficient. Fortunately, reading GS base is fast. Kernel GS
>> base is also known from the offset table with the CPU number.
> ...
> 
> Use code might want to put a negative value into GSBASE.
> While it is normal to put a valid address into GSBASE there
> is no reason why the code can't put an offset into GSBASE,
> in which case it might be negative.
> 
> Yes, I know you can't put arbitrary 64bit values into GSBASE.
> But the difference between 2 user pointers will always be valid.
> 

You don't have a choice: you can't control what userspace puts in there.
 Anything that depends on a specific value is inherently unsafe.

But we also don't need swapgs when we have rdgsbase/wrgsbase available.
We can indeed just unconditionally save it (via rdgsbase) into the stack
frame and wrgsbase the correct percpu value.  In that case it might be
necessary in order to avoid insane complexity to also save/restore the
gs selector.

Is it going to be faster?  *Probably* not as swapgs is designed to be
fast; it does, however, eliminate the need to RDMSR/WRMSR inside the
kernel task switch as the user space gsbase will simply live on the
stack.  (This is assuming we do this unconditionally on every method of
kernel entry, including non-paranoid.  I'm not sure if we ever care
about the userspace GS/GSBASE inside a paranoid handler, but if we do it
would be rather messy to find if we do this conditionally.

Now...

+	ALTERNATIVE "jmp .Lparanoid_entry_no_fsgsbase",	\
+		"RDGSBASE %rdx", X86_FEATURE_FSGSBASE
+	READ_KERNEL_GSBASE %rax

READ_KERNEL_GSBASE here seems like a Really Bad Name[TM] for this macro,
since it seems to imply reading MSR_KERNEL_GS_BASE, rather than finding
the current percpu offset.  I would prefer calling it something like
FIND_PERCPU_BASE or something like that.

	-hpa
