Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDRRNI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:13:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752096AbeDRRNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:13:07 -0400
Subject: Re: [PATCH] x86/entry/64/compat: Preserve r8-r11 in int $0x80
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <d4c4d9985fbe64f8c9e19291886453914b48caee.1523975710.git.luto@kernel.org>
 <cd1a4b8c-dd8e-d88d-c154-fcf02aca5d74@redhat.com>
 <CALCETrU3KLXwToBTOTnHpKrUhENFUVFJbWxfiPMbs2iQHoDDZA@mail.gmail.com>
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <7332768e-8afd-980b-19ee-0a9fadf2d625@redhat.com>
Date: Wed, 18 Apr 2018 19:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU3KLXwToBTOTnHpKrUhENFUVFJbWxfiPMbs2iQHoDDZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 06:53 PM, Andy Lutomirski wrote:
> On Tue, Apr 17, 2018 at 8:00 AM, Denys Vlasenko <dvlasenk@redhat.com> wrote:
>> This means that the new behavior is there for some 8 years already.
>> Whoever was impacted by it, probably already switched to the new ABI.
>>
>> Current ABI is "weaker", it allows kernel to save fewer registers.
>>
>> Which is generally a good thing, since saving/restoring things cost
>> cycles, and sometimes painful on entry paths where you may desperately
>> need a scratch register or two. (Recall this one? -
>> ...
>>          movq    %rsp, PER_CPU_VAR(rsp_scratch)
>>          movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>>          /* Construct struct pt_regs on stack */
>>          pushq   $__USER_DS                      /* pt_regs->ss */
>>          pushq   PER_CPU_VAR(rsp_scratch)        /* pt_regs->sp */
>> ...
>> wouldn't it be _great_ if one of GPRs would be available here
>> to hold userspace %rsp?
>> )
> 
> But this is the int $0x80 entry, which uses the stack sanely and
> doesn't have this problem at all.

It was a general point why not committing to save every register
may help on the callee (in this case kernel) side.
