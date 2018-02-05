Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBEW1D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:27:03 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43882 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:26:55 -0500
X-Google-Smtp-Source: AH8x227pxGAyU/0aIYa6OEQzfqPH5Bvf7xuklIaBToQdvWrFOiw52nM8jVsoUX1/K0dApQBWw714e4R1UghmF9itmB4=
MIME-Version: 1.0
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de> <1517856451-2932-4-git-send-email-karahmed@amazon.de>
In-Reply-To: <1517856451-2932-4-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 05 Feb 2018 22:26:44 +0000
Message-ID: <CALMp9eRhHfoy7cL0x3qUMOHn4DUacHGc_497ac1QMPbiGU9O5g@mail.gmail.com>
Subject: Re: [RFC 03/12] KVM/VMX: Use the new host mapping API for virtual_apic_page
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:48 AM KarimAllah Ahmed <karahmed@amazon.de> wrote:

> @@ -5264,9 +5264,8 @@ static void
vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)

>          max_irr = find_last_bit((unsigned long
*)vmx->nested.pi_desc->pir, 256);
>          if (max_irr != 256) {
> -               vapic_page = kmap(vmx->nested.virtual_apic_page);
> +               vapic_page = vmx->nested.virtual_apic_mapping.kaddr;
>                  __kvm_apic_update_irr(vmx->nested.pi_desc->pir,
vapic_page);
> -               kunmap(vmx->nested.virtual_apic_page);

Your kernel mapping now survives exits to userspace. I didn't think that
was kosher, but I'd be happy to hear that I'm wrong.

> @@ -7502,10 +7501,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>          /* Unpin physical memory we referred to in the vmcs02 */
>          if (vmx->nested.apic_access_mapping.pfn)

kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
> -       if (vmx->nested.virtual_apic_page) {
> -               kvm_release_page_dirty(vmx->nested.virtual_apic_page);
> -               vmx->nested.virtual_apic_page = NULL;
> -       }
> +       if (vmx->nested.virtual_apic_mapping.pfn)
> +
kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);

Is the host PFN guaranteed to be non-zero?
