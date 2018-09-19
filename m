Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9680FECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BBD2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BBD2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeISUMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:12:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:14360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbeISUMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:12:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 07:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="74286402"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.148])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 07:33:55 -0700
Message-ID: <1537367635.9937.4.camel@intel.com>
Subject: Re: [PATCH RESEND]  kvm/x86: propagate fetch fault into guest
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peng Hao <penghao122@sina.com.cn>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        peng.hao2@zte.com, Peng Hao <peng.hao2@zte.com.cn>
Date:   Wed, 19 Sep 2018 07:33:55 -0700
In-Reply-To: <1537311828-4547-1-git-send-email-penghao122@sina.com.cn>
References: <1537311828-4547-1-git-send-email-penghao122@sina.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-18 at 19:03 -0400, Peng Hao wrote:
> From: Peng Hao <peng.hao2@zte.com.cn>
> 
> When handling ept misconfig exit, it will call emulate instruction
> with insn_len = 0. The decode instruction function may return a fetch
> fault and should propagate to guest.

What fault is encountered, e.g. #PF, #UD, etc...?  Something like a
#UD at this point should result in an exit to userspace as it means
KVM was unable to emulate an instruction that was successfully
decoded by hardware.
> The problem will result to emulation fail.
> KVM internal error. Suberror: 1
> emulation failure
> EAX=f81a0024 EBX=f6a07000 ECX=f6a0737c EDX=f8be0118
> ESI=f6a0737c EDI=00000021 EBP=f6929f98 ESP=f6929f98
> EIP=f8bdd141 EFL=00010086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
> CS =0060 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
> SS =0068 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> DS =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
> FS =00d8 2c044000 ffffffff 00809300 DPL=0 DS16 [-WA]
> GS =0033 081a44c8 01000fff 00d0f300 DPL=3 DS   [-WA]
> LDT=0000 00000000 ffffffff 00000000
> TR =0080 f6ea0c80 0000206b 00008b00 DPL=0 TSS32-busy
> GDT=     f6e99000 000000ff
> IDT=     fffbb000 000007ff
> CR0=80050033 CR2=b757d000 CR3=35d31000 CR4=001406d0
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  arch/x86/kvm/emulate.c | 5 ++++-
>  arch/x86/kvm/x86.c     | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 106482d..aecf9a72 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5105,8 +5105,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>  		memcpy(ctxt->fetch.data, insn, insn_len);
>  	else {
>  		rc = __do_insn_fetch_bytes(ctxt, 1);
> -		if (rc != X86EMUL_CONTINUE)
> +		if (rc != X86EMUL_CONTINUE) {
> +			if (rc == X86EMUL_PROPAGATE_FAULT)
> +				ctxt->have_exception = true;
>  			return rc;
> +		}
>  	}
>  
>  	switch (mode) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 542f631..27072e1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6188,8 +6188,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
>  			if (reexecute_instruction(vcpu, cr2, write_fault_to_spt,
>  						emulation_type))
>  				return EMULATE_DONE;
> -			if (ctxt->have_exception && inject_emulated_exception(vcpu))
> +			if (ctxt->have_exception) {
> +				inject_emulated_exception(vcpu);
>  				return EMULATE_DONE;
> +			}
>  			if (emulation_type & EMULTYPE_SKIP)
>  				return EMULATE_FAIL;
>  			return handle_emulation_failure(vcpu, emulation_type);
