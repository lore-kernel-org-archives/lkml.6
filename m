Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEDM3R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:29:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:47073 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeEDM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:29:15 -0400
X-Google-Smtp-Source: AB8JxZpYg8XoOALDO4zvNpfHjfD3+fEx5xk6v36xKeFjqbFse1XZTHZHTXbEnsCwwRVOtO+dhbe38mwzN6TIPb80aJc=
MIME-Version: 1.0
In-Reply-To: <1524790503-3267-1-git-send-email-wanpengli@tencent.com>
References: <1524790503-3267-1-git-send-email-wanpengli@tencent.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 4 May 2018 20:29:14 +0800
Message-ID: <CANRm+CzRzejkFLoB+MMW5v_B1tytHEf7eGZHnye0H+=PLvHMqA@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
To: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tonny Lu <tonnylu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44CTNhX026922

ping,
2018-04-27 8:55 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Our virtual machines make use of device assignment by configuring
> 12 NVMe disks for high I/O performance. Each NVMe device has 129
> MSI-X Table entries:
> Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
> The windows virtual machines fail to boot since they will map the number of
> MSI-table entries that the NVMe hardware reported to the bus to msi routing
> table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096
> for all archs, in the future this might be extended again if needed.
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Tonny Lu <tonnylu@tencent.com>
> ---
> v2 -> v3:
>  * update comments in the code
> v1 -> v2:
>  * extend MAX_IRQ_ROUTES to 4096 for all archs
>
>  include/linux/kvm_host.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6930c63..6d6e79c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>
> -#ifdef CONFIG_S390
> -#define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
> -#elif defined(CONFIG_ARM64)
> -#define KVM_MAX_IRQ_ROUTES 4096
> -#else
> -#define KVM_MAX_IRQ_ROUTES 1024
> -#endif
> +#define KVM_MAX_IRQ_ROUTES 4096 /* might need extension/rework in the future */
>
>  bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
>  int kvm_set_irq_routing(struct kvm *kvm,
> --
> 2.7.4
>
