Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeCIOIk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:08:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41380 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeCIOIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:08:38 -0500
Date: Fri, 9 Mar 2018 15:08:34 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
In-Reply-To: <20180309140249.2840-8-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
References: <20180309140249.2840-1-vkuznets@redhat.com> <20180309140249.2840-8-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:

> Enlightened VMCS is just a structure in memory, the main benefit
> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
> mask: we tell the underlying hypervisor which fields were modified
> since VMEXIT so there's no need to inspect them all.
> 
> Tight CPUID loop test shows significant speedup:
> Before: 18890 cycles
> After: 8304 cycles
> 
> Static key is being used to avoid performance penalty for non-Hyper-V
> deployments. Tests show we add around 3 (three) CPU cycles on each
> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
> but I don't see a clean way to use static key in assembly.

STATIC_JUMP_IF_TRUE, STATIC_JUMP_IF_FALSE are your friends.

Thanks,

	tglx
