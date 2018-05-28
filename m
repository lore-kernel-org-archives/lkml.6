Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeE1SVu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932268AbeE1SVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:21:46 -0400
Subject: Re: [PATCH] KVM: irqfd: fix race between EPOLLHUP and
 irq_bypass_register_consumer
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: dvyukov@google.com, stable@vger.kernel.org
References: <20180528113113.30941-1-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0014b068-897d-bcb4-beb2-e5b2a5d2219b@redhat.com>
Date: Mon, 28 May 2018 20:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528113113.30941-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.2018 13:31, Paolo Bonzini wrote:
> A comment warning against this bug is there, but the code is not doing what
> the comment says.  Therefore it is possible that an EPOLLHUP races against
> irq_bypass_register_consumer.  The EPOLLHUP handler schedules irqfd_shutdown,
> and if that runs soon enough, you get a use-after-free.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/eventfd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 6e865e8b5b10..44dda5dad0ee 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -402,11 +402,6 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	if (events & EPOLLIN)
>  		schedule_work(&irqfd->inject);
>  
> -	/*
> -	 * do not drop the file until the irqfd is fully initialized, otherwise
> -	 * we might race against the EPOLLHUP
> -	 */
> -	fdput(f);
>  #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
>  	if (kvm_arch_has_irq_bypass()) {
>  		irqfd->consumer.token = (void *)irqfd->eventfd;
> @@ -421,6 +416,11 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	}
>  #endif
>  
> +	/*
> +	 * do not drop the file until the irqfd is fully initialized, otherwise
> +	 * we might race against the EPOLLHUP
> +	 */
> +	fdput(f);
>  	return 0;
>  
>  fail:
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
