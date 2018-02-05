Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBEWP3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:15:29 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:46332 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBEWPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:15:13 -0500
X-Google-Smtp-Source: AH8x226Wd9IGqDLOqoF+iL5a3BbXxNuJMBMuDyVk2BheROeCnOFsI4KnWX5XvJJM04d0roFBrRU7ADBkNcpWOmVU7BI=
MIME-Version: 1.0
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de> <1517856451-2932-6-git-send-email-karahmed@amazon.de>
In-Reply-To: <1517856451-2932-6-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 05 Feb 2018 22:15:01 +0000
Message-ID: <CALMp9eScXeCi6J4kuktdZmmOg2oDyyatpzOdVmUSso7F8FU+zA@mail.gmail.com>
Subject: Re: [RFC 05/12] KVM/VMX: Use the new host mapping API for mapping
 nested vmptr
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:49 AM KarimAllah Ahmed <karahmed@amazon.de> wrote:


> @@ -7410,19 +7410,17 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
>                  return kvm_skip_emulated_instruction(vcpu);
>          }

> -       page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
> -       if (is_error_page(page)) {
> +       if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmptr, &mapping, true)) {
>                  nested_vmx_failInvalid(vcpu);
>                  return kvm_skip_emulated_instruction(vcpu);
>          }
> -       if (*(u32 *)kmap(page) != VMCS12_REVISION) {
> -               kunmap(page);
> -               kvm_release_page_clean(page);
> +       if (*(u32 *)mapping.kaddr != VMCS12_REVISION) {
> +               kvm_release_host_mapping(&mapping, false);
>                  nested_vmx_failInvalid(vcpu);
>                  return kvm_skip_emulated_instruction(vcpu);
>          }
> -       kunmap(page);
> -       kvm_release_page_clean(page);
> +
> +       kvm_release_host_mapping(&mapping, false);

Why go through this explicit mapping/release dance? Why not just:

uint32_t revision;
...
if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
     revision != VMCS12_REVISION) {
         nested_vmx_failInvalid(vcpu);
         return kvm_skip_emulated_instruction(vcpu);
}
