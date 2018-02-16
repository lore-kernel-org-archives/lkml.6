Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757375AbeBPDGI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 22:06:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757331AbeBPDGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 22:06:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D2F217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x226mrGgW7wC6PlDPewAK2oEbKeUSDxhm7yAD8GBE6XKzYcI+1PtViG94/ZHiLJ625k6OpsFdAEvA97Uxes6qe/A=
MIME-Version: 1.0
In-Reply-To: <D9B68521-7BDA-4088-BF66-8B1B6BF85E78@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com> <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
 <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com> <f0fc93ca-ba1d-2570-5d79-0c02ee388f9d@citrix.com>
 <D9B68521-7BDA-4088-BF66-8B1B6BF85E78@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 16 Feb 2018 03:05:45 +0000
X-Gmail-Original-Message-ID: <CALCETrVpSz95CyLTHKfN5G_Z4w8GuN+COCsUc6EO1y6zEhoPSA@mail.gmail.com>
Message-ID: <CALCETrVpSz95CyLTHKfN5G_Z4w8GuN+COCsUc6EO1y6zEhoPSA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:51 AM, Nadav Amit <nadav.amit@gmail.com> wrote:
> Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
>> On 16/02/2018 00:25, Nadav Amit wrote:
>>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>>
>>>> On 02/15/2018 08:35 AM, Nadav Amit wrote:
>>>>> I removed the PTI disabling while SMEP is unsupported, although I
>>>>> must admit I did not fully understand why it is required.
>>>> Do you mean you don't fully understand how PTI gives SMEP-like behavior
>>>> on non-SMEP hardware?
>>> No. I understand how it provide SMEP-like behavior, and I understand the value
>>> of SMEP by itself.
>>>
>>> However, I do not understand why SMEP-like protection is required to protect
>>> processes that run in compatibility-mode from Meltdown/Spectre attacks. As
>>> far as I understand, the process should not be able to manipulate the kernel
>>> to execute code in the low 4GB.
>>
>> Being 32bit is itself sufficient protection against Meltdown (as long as
>> there nothing interesting of the kernels mapped below the 4G boundary).
>>
>> However, a 32bit compatibility process try to attack with Spectre/SP2 to
>> redirect speculation back into userspace, at which point (if successful)
>> the pipeline will be speculating in 64bit mode, and Meltdown is back on
>> the table.  SMEP will block this attack vector, irrespective of other
>> SP2 defences the kernel may employ, but a fully SP2-defended kernel
>> doesn't require SMEP to be safe in this case.
>
> Based on Jann Horn’s description of the branch predictor, it basically only
> holds the lowest 31-bits of the target address. There might be a subtle
> problem if the prediction wrapsaround, but excluding this case, I do not see
> how Spectre v2 can be used to jump into running user code.
>

If you can make the *kernel* speculate into user code, you can create
whatever gadget you want.  A 32-bit task can poison the branch
predictor and use this to attack a non-retpolined kernel.
