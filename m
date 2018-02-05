Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBET2T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:28:19 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45257 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBET2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:28:11 -0500
X-Google-Smtp-Source: AH8x227hvi4Aodu4odX5B1JamUcnS9we+YeYWAT5j4oMU3zG8a6JGKtM5AvrZpkfeeNXyn7uYiMfVWU3T7oS5topX+A=
MIME-Version: 1.0
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de> <1517856451-2932-3-git-send-email-karahmed@amazon.de>
In-Reply-To: <1517856451-2932-3-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 05 Feb 2018 19:27:59 +0000
Message-ID: <CALMp9eQyNFq2pYoDP=f4fJyaVSy15n6BnL4bu6mMnadQmZbT-g@mail.gmail.com>
Subject: Re: [RFC 02/12] KVM/VMX: Use the new host mapping API for apic_access_page
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w15JSOAI014559

Perhaps this is a good time to address the long-standing issues with kvm's
treatment of the "APIC-access address" in the VMCS. This address is simply
a token that the hypervisor puts into the PFN of a 4K EPTE (or PTE if using
shadow paging) that triggers APIC virtualization whenever a page walk
terminates with that PFN. This address has to be a legal address (i.e.
within the physical address with supported by the CPU), but it need not
have WB memory behind it. In fact, it need not have anything at all behind
it. When bit 31 ("activate secondary controls") of the primary
processor-based VM-execution controls is set and bit 0 ("virtualize APIC
accesses") of the secondary processor-based VM-execution controls is set,
the PFN recorded in the VMCS "APIC-access address" field will never be
touched. (Instead, the access triggers APIC virtualization, which may
access the PFN recorded in the "Virtual-APIC address" field of the VMCS.)
Mapping the "APIC-access address" page into the kernel is not necessary.

On Mon, Feb 5, 2018 at 10:50 AM KarimAllah Ahmed <karahmed@amazon.de> wrote:

> For nested guests the apic_access_page was mapped to the host kernel using
> kvm_vcpu_gpa_to_page which assumes that all guest memory is backed by a
> "struct page". This breaks guests that have their memory outside the
> kernel
> control.

> Switch to the new host mapping API which takes care of this use-case as
> well.

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>   arch/x86/kvm/vmx.c | 33 +++++++++++++--------------------
>   1 file changed, 13 insertions(+), 20 deletions(-)

> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 5d8a6a91..b76ab06 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -451,7 +451,7 @@ struct nested_vmx {
>           * Guest pages referred to in the vmcs02 with host-physical
>           * pointers, so we must keep them pinned while L2 runs.
>           */
> -       struct page *apic_access_page;
> +       struct kvm_host_mapping apic_access_mapping;
>          struct page *virtual_apic_page;
>          struct page *pi_desc_page;
>          struct pi_desc *pi_desc;
> @@ -7500,10 +7500,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>          }
>          kfree(vmx->nested.cached_vmcs12);
>          /* Unpin physical memory we referred to in the vmcs02 */
> -       if (vmx->nested.apic_access_page) {
> -               kvm_release_page_dirty(vmx->nested.apic_access_page);
> -               vmx->nested.apic_access_page = NULL;
> -       }
> +       if (vmx->nested.apic_access_mapping.pfn)
> +               kvm_release_host_mapping(&vmx->nested.apic_access_mapping,
> true);
>          if (vmx->nested.virtual_apic_page) {
>                  kvm_release_page_dirty(vmx->nested.virtual_apic_page);
>                  vmx->nested.virtual_apic_page = NULL;
> @@ -10056,25 +10054,22 @@ static void nested_get_vmcs12_pages(struct
> kvm_vcpu *vcpu,
>                   * physical address remains valid. We keep a reference
>                   * to it so we can release it later.
>                   */
> -               if (vmx->nested.apic_access_page) { /* shouldn't happen */
> -
>   kvm_release_page_dirty(vmx->nested.apic_access_page);
> -                       vmx->nested.apic_access_page = NULL;
> -               }
> -               page = kvm_vcpu_gpa_to_page(vcpu,
> vmcs12->apic_access_addr);
> +               if (vmx->nested.apic_access_mapping.pfn) /* shouldn't
> happen */
> +
>   kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
> +
>                  /*
>                   * If translation failed, no matter: This feature asks
>                   * to exit when accessing the given address, and if it
>                   * can never be accessed, this feature won't do
>                   * anything anyway.
>                   */
> -               if (!is_error_page(page)) {
> -                       vmx->nested.apic_access_page = page;
> -                       hpa = page_to_phys(vmx->nested.apic_access_page);
> -                       vmcs_write64(APIC_ACCESS_ADDR, hpa);
> -               } else {
> +               if (kvm_vcpu_gpa_to_host_mapping(vcpu,
> vmcs12->apic_access_addr,
> +
> &vmx->nested.apic_access_mapping, false))
> +                       vmcs_write64(APIC_ACCESS_ADDR,
> +                                    vmx->nested.apic_access_mapping.pfn
> << PAGE_SHIFT);
> +               else
>                          vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,

> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES);
> -               }
>          } else if (!(nested_cpu_has_virt_x2apic_mode(vmcs12)) &&
>                     cpu_need_virtualize_apic_accesses(&vmx->vcpu)) {
>                  vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
> @@ -11686,10 +11681,8 @@ static void nested_vmx_vmexit(struct kvm_vcpu
> *vcpu, u32 exit_reason,
>          vmx->host_rsp = 0;

>          /* Unpin physical memory we referred to in vmcs02 */
> -       if (vmx->nested.apic_access_page) {
> -               kvm_release_page_dirty(vmx->nested.apic_access_page);
> -               vmx->nested.apic_access_page = NULL;
> -       }
> +       if (vmx->nested.apic_access_mapping.pfn)
> +               kvm_release_host_mapping(&vmx->nested.apic_access_mapping,
> true);
>          if (vmx->nested.virtual_apic_page) {
>                  kvm_release_page_dirty(vmx->nested.virtual_apic_page);
>                  vmx->nested.virtual_apic_page = NULL;
> --
> 2.7.4
