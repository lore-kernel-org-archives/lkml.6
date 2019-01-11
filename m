Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfAKNaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:30:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfAKNaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:30:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C98EC04F4DD;
        Fri, 11 Jan 2019 13:30:11 +0000 (UTC)
Received: from flask (unknown [10.40.205.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 287F05D75D;
        Fri, 11 Jan 2019 13:30:03 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:30:03 +0100
Date:   Fri, 11 Jan 2019 14:30:03 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH]  kvm/x86: propagate fetch fault into guest
Message-ID: <20190111133002.GA14852@flask>
References: <1545652830-65253-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545652830-65253-1-git-send-email-peng.hao2@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 11 Jan 2019 13:30:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-24 20:00+0800, Peng Hao:
> When handling ept misconfig exit, it will call emulate instruction
> with insn_len = 0. The decode instruction function may return a fetch
> fault and should propagate to guest.
> 
> The problem will result to emulation fail.
> KVM internal error. Suberror: 1
> emulation failure
> EAX=f81a0024 EBX=f6a07000 ECX=f6a0737c EDX=f8be0118
> ESI=f6a0737c EDI=00000021 EBP=f6929f98 ESP=f6929f98
> EIP=f8bdd141 EFL=00010086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
> CS =0060 00000000 ffffffff 00c09b00 DPL=0 CS32 [-RA]
> SS =0068 00000000 ffffffff 00c09300 DPL=0 DS   [-WA]
> DS =007b 00000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
> FS =00d8 2c044000 ffffffff 00809300 DPL=0 DS16 [-WA]
> GS =0033 081a44c8 01000fff 00d0f300 DPL=3 DS   [-WA]
> LDT=0000 00000000 ffffffff 00000000
> TR =0080 f6ea0c80 0000206b 00008b00 DPL=0 TSS32-busy
> GDT=     f6e99000 000000ff
> IDT=     fffbb000 000007ff
> CR0=80050033 CR2=b757d000 CR3=35d31000 CR4=001406d0

Do you have a test case for this?

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> @@ -5114,8 +5114,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>  		memcpy(ctxt->fetch.data, insn, insn_len);
>  	else {
>  		rc = __do_insn_fetch_bytes(ctxt, 1);
> -		if (rc != X86EMUL_CONTINUE)
> +		if (rc != X86EMUL_CONTINUE) {
> +			if (rc == X86EMUL_PROPAGATE_FAULT)
> +				ctxt->have_exception = true;
>  			return rc;

(Ugh, the caller expects EMULATION_FAILED instead of rc.)

> +		}
>  	}
>  
>  	switch (mode) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -6333,8 +6333,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
>  			if (reexecute_instruction(vcpu, cr2, write_fault_to_spt,
>  						emulation_type))
>  				return EMULATE_DONE;
> -			if (ctxt->have_exception && inject_emulated_exception(vcpu))

I don't understand what that return value check was supposed to do, but
yours version seems good.

I have queued it for rc3 to get some extra testing,

thanks.
