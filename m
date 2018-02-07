Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeBGSis (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:38:48 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:54715 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbeBGSir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:38:47 -0500
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
To: Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cab93459-5c44-4049-ae7e-096e37d43737@infradead.org>
Date: Wed, 7 Feb 2018 10:38:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 10:13 AM, Linus Torvalds wrote:
> Adding more people for this funky warning from the kbuild robot.
> 
> Something is confused. UD0 is 0f ff, the bytes after that shouldn't
> matter. But I guess they can be interpreted as modrm bytes, and
> somebody started doing that.
> 
> That said, intel only _documents_ UD2 (0f 0b).

Intel Order Number: 325383-064US, October 2017, documents UD0, UD1, and UD2.
Section A.2.5, Table A-1, says:

Use the 0F0B opcode (UD2 instruction), the 0FB9H opcode (UD1 instruction), or the 0FFFH opcode (UD0 instruction) when deliberately trying to generate an invalid opcode exception (#UD).

Could this regression be a result of:

commit f5b5fab1780c98b74526dbac527574bd02dc16f8
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Mon Dec 11 10:38:36 2017 -0800

    x86/decoder: Fix and update the opcodes map
    
    Update x86-opcode-map.txt based on the October 2017 Intel SDM publication.
    Fix INVPID to INVVPID.
    Add UD0 and UD1 instruction opcodes.


> Maybe we should avoid using UD0/UD1 entirely.
> 
>               Linus
> 
> On Wed, Feb 7, 2018 at 3:44 AM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
>> branch HEAD: a2e5790d841658485d642196dbb0927303d6c22f  Merge branch 'akpm' (patches from Andrew)
>>
>> Regressions in current branch:
>>
>> arch/x86/tools/insn_decoder_test: warning: ffffffff810010d7:    0f ff eb                ud0    %ebx,%ebp
>> arch/x86/tools/insn_decoder_test: warning: ffffffff81001152:    0f ff bf 09 00 00 00    ud0    0x9(%rdi),%edi
>> arch/x86/tools/insn_decoder_test: warning: ffffffff81001275:    0f ff eb                ud0    %ebx,%ebp
>> arch/x86/tools/insn_decoder_test: warning: ffffffff810013fd:    0f ff bf 09 00 00 00    ud0    0x9(%rdi),%edi
>> arch/x86/tools/insn_decoder_test: warning: ffffffff81001499:    0f ff bf 09 00 00 00    ud0    0x9(%rdi),%edi
>> arch/x86/tools/insn_decoder_test: warning: ffffffff812296eb:    0f ff e8                ud0    %eax,%ebp


-- 
~Randy
