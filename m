Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8884C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9413221526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9413221526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbeITWQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeITWQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:16:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEC5E81106;
        Thu, 20 Sep 2018 16:32:17 +0000 (UTC)
Received: from [10.36.117.122] (ovpn-117-122.ams2.redhat.com [10.36.117.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1143E600C8;
        Thu, 20 Sep 2018 16:32:11 +0000 (UTC)
Subject: Re: [PATCH RESEND] kvm/x86: propagate fetch fault into guest
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peng Hao <penghao122@sina.com.cn>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        peng.hao2@zte.com, Peng Hao <peng.hao2@zte.com.cn>
References: <1537311828-4547-1-git-send-email-penghao122@sina.com.cn>
 <1537367635.9937.4.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a3f05921-d802-efd6-65bb-7cb99f804f0f@redhat.com>
Date:   Thu, 20 Sep 2018 18:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537367635.9937.4.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 20 Sep 2018 16:32:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2018 16:33, Sean Christopherson wrote:
> On Tue, 2018-09-18 at 19:03 -0400, Peng Hao wrote:
>> From: Peng Hao <peng.hao2@zte.com.cn>
>>
>> When handling ept misconfig exit, it will call emulate instruction
>> with insn_len = 0. The decode instruction function may return a fetch
>> fault and should propagate to guest.
> 
> What fault is encountered, e.g. #PF, #UD, etc...?  Something like a
> #UD at this point should result in an exit to userspace as it means
> KVM was unable to emulate an instruction that was successfully
> decoded by hardware.

If it's the same bug as https://lore.kernel.org/patchwork/patch/850077/
it would be a #PF.

Paolo

>> The problem will result to emulation fail.
>> KVM internal error. Suberror: 1
>> emulation failure
>> EAX=f81a0024 EBX=f6a07000 ECX=f6a0737c EDX=f8be0118
>> ESI=f6a0737c EDI=00000021 EBP=f6929f98 ESP=f6929f98
>> EIP=f8bdd141 EFL=00010086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
>> CS =0060 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
>> SS =0068 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>> DS =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
>> FS =00d8 2c044000 ffffffff 00809300 DPL=0 DS16 [-WA]
>> GS =0033 081a44c8 01000fff 00d0f300 DPL=3 DS   [-WA]
>> LDT=0000 00000000 ffffffff 00000000
>> TR =0080 f6ea0c80 0000206b 00008b00 DPL=0 TSS32-busy
>> GDT=     f6e99000 000000ff
>> IDT=     fffbb000 000007ff
>> CR0=80050033 CR2=b757d000 CR3=35d31000 CR4=001406d0
>>
>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
>> ---
>>  arch/x86/kvm/emulate.c | 5 ++++-
>>  arch/x86/kvm/x86.c     | 4 +++-
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index 106482d..aecf9a72 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -5105,8 +5105,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>>  		memcpy(ctxt->fetch.data, insn, insn_len);
>>  	else {
>>  		rc = __do_insn_fetch_bytes(ctxt, 1);
>> -		if (rc != X86EMUL_CONTINUE)
>> +		if (rc != X86EMUL_CONTINUE) {
>> +			if (rc == X86EMUL_PROPAGATE_FAULT)
>> +				ctxt->have_exception = true;
>>  			return rc;
>> +		}
>>  	}
>>  
>>  	switch (mode) {
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 542f631..27072e1 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -6188,8 +6188,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
>>  			if (reexecute_instruction(vcpu, cr2, write_fault_to_spt,
>>  						emulation_type))
>>  				return EMULATE_DONE;
>> -			if (ctxt->have_exception && inject_emulated_exception(vcpu))
>> +			if (ctxt->have_exception) {
>> +				inject_emulated_exception(vcpu);
>>  				return EMULATE_DONE;
>> +			}
>>  			if (emulation_type & EMULTYPE_SKIP)
>>  				return EMULATE_FAIL;
>>  			return handle_emulation_failure(vcpu, emulation_type);

