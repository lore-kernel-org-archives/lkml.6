Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeDTHPn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:15:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753508AbeDTHPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:15:41 -0400
Date: Fri, 20 Apr 2018 09:15:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tonny Lu <tonnylu@tencent.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
Message-ID: <20180420091537.1c6cb06b.cohuck@redhat.com>
In-Reply-To: <1524185248-51744-1-git-send-email-wanpengli@tencent.com>
References: <1524185248-51744-1-git-send-email-wanpengli@tencent.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 17:47:28 -0700
Wanpeng Li <kernellwp@gmail.com> wrote:

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
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Tonny Lu <tonnylu@tencent.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Tonny Lu <tonnylu@tencent.com>
> ---
> v1 -> v2:
>  * extend MAX_IRQ_ROUTES to 4096 for all archs 
> 
>  include/linux/kvm_host.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6930c63..0a5c299 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>  
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>  
> -#ifdef CONFIG_S390
>  #define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...

What about /* might need extension/rework in the future */ instead of
the FIXME?

As far as I understand, 4096 should cover most architectures and the
sane end of s390 configurations, but will not be enough at the scarier
end of s390. (I'm not sure how much it matters in practice.)

Do we want to make this a tuneable in the future? Do some kind of
dynamic allocation? Not sure whether it is worth the trouble.

> -#elif defined(CONFIG_ARM64)
> -#define KVM_MAX_IRQ_ROUTES 4096
> -#else
> -#define KVM_MAX_IRQ_ROUTES 1024
> -#endif
>  
>  bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
>  int kvm_set_irq_routing(struct kvm *kvm,
