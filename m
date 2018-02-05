Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBETdV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:33:21 -0500
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:57930 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750784AbeBETdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:33:14 -0500
Message-ID: <1517858790.22345.62.camel@bitdefender.com>
Subject: Re: [RFC 00/12] KVM/X86: Introduce a new guest mapping API
From: Mihai =?UTF-8?Q?Don=C8=9Bu?= <mdontu@bitdefender.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Date: Mon, 05 Feb 2018 21:26:30 +0200
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
Organization: Bitdefender
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BitDefender-Scanner: Clean, Agent: BitDefender qmail 3.1.6 on
 smtp02.buh.bitdefender.net, sigver: 7.74869
X-BitDefender-Spam: No (0)
X-BitDefender-SpamStamp: Build: [Engines: 2.15.8.1136, Dats: 474712,
 Stamp: 3], Multi: [Enabled, t: (0.000026,0.010049)], BW: [Enabled, t:
 (0.000034,0.000002)], RBL DNSBL: [Disabled], APM: [Enabled, Score:
 500, t: (0.008889), Flags: 85D2ED72; NN_LEGIT_VALID_REPLY;
 NN_LEGIT_SUMM_400_WORDS; NN_NO_LINK_NMD; NN_LEGIT_BITDEFENDER;
 NN_LEGIT_S_SQARE_BRACKETS], SGN: [Enabled, t: (0.020600,0.000334)],
 URL: [Enabled, t: (0.000010,0.000002)], RTDA: [Enabled, t: (0.477718),
 Hit: No, Details: v2.6.16; Id: 15.5f4eo4.1c3t503fh.lrlsv], total:
 0(775)
X-BitDefender-CF-Stamp: none
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-05 at 19:47 +0100, KarimAllah Ahmed wrote:
> Guest memory can either be directly managed by the kernel (i.e. have a "struct
> page") or they can simply live outside kernel control (i.e. do not have a
> "struct page"). KVM mostly support these two modes, except in a few places
> where the code seems to assume that guest memory must have a "struct page".

In cases where there is no 'struct page', would it be possible to get
two VM-s to share memory (in the way Xen's grant tables do)?

We are working on a page sharing mechanism and would like to know if
this use case can be accommodated.

Thank you,

> This patchset introduces a new mapping function to map guest memory into host
> kernel memory. Ideally I should also get rid of all guest mapping functions
> that end up converting a guest address to a page, but I decided to get feedback
> on this first and see if this is an acceptable API.
> 
> Most of the offending code paths that has been updated are in the nested code
> base. Mostly because I stumbled upon this code while looking at the nested MSR
> bitmap handling for the IBRS patches. There are also offending code paths in
> SVM code, but I will do that once the interface is accepted.
> 
> KarimAllah Ahmed (12):
>   KVM: Introduce helper functions to map/unmap guest memory
>   KVM/VMX: Use the new host mapping API for apic_access_page
>   KVM/VMX: Use the new host mapping API for virtual_apic_page
>   KVM/VMX: Use the new host mapping API for pi_desc_page
>   KVM/VMX: Use the new host mapping API for mapping nested vmptr
>   KVM/VMX: Use the new host mapping API for handle_vmptrld
>   KVM/VMX: Use the new host mapping API for mapping L12 MSR bitmap
>   KVM/VMX: Use the new host mapping API for mapping nested PML
>   KVM/VMX: Use the new host mapping API for cmpxchg_emulated
>   KVM/VMX: Use the new host mapping API for synic_clear_sint_msg_pending
>   KVM/VMX: Use the new host mapping API for synic_deliver_msg
>   KVM/VMX: Remove kvm_vcpu_gpa_to_page as it is now unused
> 
>  arch/x86/kvm/hyperv.c    |  24 +++----
>  arch/x86/kvm/vmx.c       | 159 ++++++++++++++++++++---------------------------
>  arch/x86/kvm/x86.c       |  12 ++--
>  include/linux/kvm_host.h |  18 +++++-
>  virt/kvm/kvm_main.c      |  62 ++++++++++++++++++
>  5 files changed, 161 insertions(+), 114 deletions(-)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

-- 
Mihai Donțu
