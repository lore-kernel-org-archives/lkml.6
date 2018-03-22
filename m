Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeCVKTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:19:44 -0400
Received: from ppsw-42.csi.cam.ac.uk ([131.111.8.142]:60690 "EHLO
        ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCVKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:19:41 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
Date: Thu, 22 Mar 2018 10:19:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 10:07, Paolo Bonzini wrote:
> On 22/03/2018 09:34, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Explicit segment overides other than %fs and %gs are documented as ignored by
>> both Intel and AMD.
>>
>> In practice, this means that:
>>
>>  * Explicit uses of %ss don't actually yield #SS[0] for non-canonical
>>    memory references.
>>  * Explicit uses of %{e,c,d}s don't override %rbp/%rsp-based memory references
>>    to yield #GP[0] for non-canonical memory references.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

When porting fixes from other projects, it is customary to identify so
in the commit message.  In this case, the fix you've ported is
http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=b7dce29d9faf3597d009c853ed1fcbed9f7a7f68

Here is an example of how Xen ports fixes from Linux for the drivers
that we share. 
http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=4e131596f1defec9407b6e60d584a696beaf5d7e


>> ---
>>  arch/x86/kvm/emulate.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index dd88158..5091255 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -5148,8 +5148,10 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>>  		case 0x2e:	/* CS override */
>>  		case 0x36:	/* SS override */
>>  		case 0x3e:	/* DS override */
>> -			has_seg_override = true;
>> -			ctxt->seg_override = (ctxt->b >> 3) & 3;
>> +			if (mode != X86EMUL_MODE_PROT64) {
>> +				has_seg_override = true;
>> +				ctxt->seg_override = (ctxt->b >> 3) & 3;
>> +			}
>>  			break;
>>  		case 0x64:	/* FS override */
>>  		case 0x65:	/* GS override */
>>
> Testcase, please...

If you want to crib from one, this is the testcase I made for Xen.

http://xenbits.xen.org/docs/xtf/test-memop-seg.html

With the impending KVM/PVH work which is ongoing, it will soon be easy
to run Xen's HVM test suite unmodified under KVM, but we're not quite
there yet.

~Andrew
