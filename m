Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeEWLWL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:22:11 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35022 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeEWLWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:22:06 -0400
X-Google-Smtp-Source: AB8JxZpItG65+epwLerTfBZGRptQ+/7fg/CLBIkV3Gy8wJd/KKxlP5H8sbQT9tkcFH8NElenDSkSbXNrfVCO5MFAHp0=
MIME-Version: 1.0
In-Reply-To: <1520855584-10079-1-git-send-email-wanpengli@tencent.com>
References: <1520855584-10079-1-git-send-email-wanpengli@tencent.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 23 May 2018 19:22:05 +0800
Message-ID: <CANRm+Cwtqvn=6UQ308vNnPxTtWJONTrDt3L5ydteYpvYMqDuQQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Provides userspace with per-VM capability to
 improve latency
To: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        =?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4NBMF0Y022407

2018-03-12 19:53 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> Provides userspace with per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to
> not intercept MWAIT/HLT/PAUSE in order that to improve latency in some
> workloads.

When running cyclictest in the guest w/ vCPU pin on host and
cyclictest pin in guest, the avg latency can be reduced 40%.

Regards,
Wanpeng Li

>
> The patchset implements the original proposal from Radim.
> https://www.spinics.net/lists/kvm/msg146879.html
>
> In addition, thanks to Jan H. Schönherr's attempt last year.
>
> v1 -> v2:
>  * remove blinding setting KVM_ENABLE_CAP statement in doc
>  * move PV_UNHALT associated statement to 2/3
>  * rename kvm_mwait_can_in_guest to kvm_can_mwait_in_guest
>  * remove unconditionally set INTERCEPT HLT in svm
>  * call vmx_clear_hlt() from pre_enter_smm()
>  * add a check to kvm_update_cpuid() that forbits KVM_FEATURE_PV_UNHALT
>    when halt exits are disabld
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Jan H. Schönherr <jschoenh@amazon.de>
>
> Wanpeng Li (3):
>   KVM: X86: Provides userspace with a capability to not intercept MWAIT
>   KVM: X86: Provides userspace with a capability to not intercept HLT
>   KVM: X86: Provides userspace with a capability to not intercept PAUSE
>
>  Documentation/virtual/kvm/api.txt | 24 ++++++++++++-------
>  arch/x86/include/asm/kvm_host.h   |  4 ++++
>  arch/x86/kvm/cpuid.c              |  5 ++++
>  arch/x86/kvm/svm.c                |  9 ++++---
>  arch/x86/kvm/vmx.c                | 50 ++++++++++++++++++++++++++++++++-------
>  arch/x86/kvm/x86.c                | 29 +++++++++++++++++++----
>  arch/x86/kvm/x86.h                | 24 +++++++++++++++----
>  include/uapi/linux/kvm.h          |  2 +-
>  tools/include/uapi/linux/kvm.h    |  2 +-
>  9 files changed, 118 insertions(+), 31 deletions(-)
>
> --
> 2.7.4
>
