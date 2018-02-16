Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756906AbeBPAvn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:51:43 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42007 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756845AbeBPAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:51:42 -0500
X-Google-Smtp-Source: AH8x226TVS/M/BQNk+NSWYY1HEY6xlvzVaOIUPEtUGe3QEiCe+aetsMfQYMggM8Ge2yWkSFTyVdM+A==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <f0fc93ca-ba1d-2570-5d79-0c02ee388f9d@citrix.com>
Date: Thu, 15 Feb 2018 16:51:38 -0800
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <D9B68521-7BDA-4088-BF66-8B1B6BF85E78@gmail.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <27a0082c-fadb-792a-740e-70932d51f1b5@linux.intel.com>
 <91CEEFA7-86C8-4731-BC7E-6AF5CC3A1BA4@gmail.com>
 <f0fc93ca-ba1d-2570-5d79-0c02ee388f9d@citrix.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1G0plb7001342

Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> On 16/02/2018 00:25, Nadav Amit wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> 
>>> On 02/15/2018 08:35 AM, Nadav Amit wrote:
>>>> I removed the PTI disabling while SMEP is unsupported, although I
>>>> must admit I did not fully understand why it is required.
>>> Do you mean you don't fully understand how PTI gives SMEP-like behavior
>>> on non-SMEP hardware?
>> No. I understand how it provide SMEP-like behavior, and I understand the value
>> of SMEP by itself.
>> 
>> However, I do not understand why SMEP-like protection is required to protect
>> processes that run in compatibility-mode from Meltdown/Spectre attacks. As
>> far as I understand, the process should not be able to manipulate the kernel
>> to execute code in the low 4GB.
> 
> Being 32bit is itself sufficient protection against Meltdown (as long as
> there nothing interesting of the kernels mapped below the 4G boundary).
> 
> However, a 32bit compatibility process try to attack with Spectre/SP2 to
> redirect speculation back into userspace, at which point (if successful)
> the pipeline will be speculating in 64bit mode, and Meltdown is back on
> the table.  SMEP will block this attack vector, irrespective of other
> SP2 defences the kernel may employ, but a fully SP2-defended kernel
> doesn't require SMEP to be safe in this case.

Based on Jann Horn’s description of the branch predictor, it basically only
holds the lowest 31-bits of the target address. There might be a subtle
problem if the prediction wrapsaround, but excluding this case, I do not see
how Spectre v2 can be used to jump into running user code.
