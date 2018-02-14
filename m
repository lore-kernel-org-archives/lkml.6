Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032895AbeBNQop (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:44:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41534 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032623AbeBNQon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:44:43 -0500
Date: Wed, 14 Feb 2018 17:44:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a framework for supporting
 MSR-based features
Message-ID: <20180214164438.GI18349@pd.tnic>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180208225846.22074.70944.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 04:58:46PM -0600, Tom Lendacky wrote:
> @@ -2681,11 +2731,15 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
>  {
>  	int i, idx;
>  
> -	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	if (vcpu)
> +		idx = srcu_read_lock(&vcpu->kvm->srcu);
> +
>  	for (i = 0; i < msrs->nmsrs; ++i)
>  		if (do_msr(vcpu, entries[i].index, &entries[i].data))
>  			break;
> -	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +
> +	if (vcpu)
> +		srcu_read_unlock(&vcpu->kvm->srcu, idx);


./include/linux/srcu.h:175:2: warning: ‘idx’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  __srcu_read_unlock(sp, idx);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/x86.c:2739:9: note: ‘idx’ was declared here
  int i, idx;
         ^~~

I know, silly gcc.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
