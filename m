Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369EFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E43D2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbeLTOny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:43:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbeLTOnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 632EF3C2CDB;
        Thu, 20 Dec 2018 14:43:53 +0000 (UTC)
Received: from flask (unknown [10.43.2.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 83A1B4526;
        Thu, 20 Dec 2018 14:43:46 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 20 Dec 2018 15:43:45 +0100
Date:   Thu, 20 Dec 2018 15:43:45 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: MMU: Introduce single thread to zap collapsible
 sptes
Message-ID: <20181220144345.GB19579@flask>
References: <1544083089-13000-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544083089-13000-1-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Dec 2018 14:43:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-06 15:58+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Last year guys from huawei reported that the call of memory_global_dirty_log_start/stop() 
> takes 13s for 4T memory and cause guest freeze too long which increases the unacceptable 
> migration downtime. [1] [2]
> 
> Guangrong pointed out:
> 
> | collapsible_sptes zaps 4k mappings to make memory-read happy, it is not
> | required by the semanteme of KVM_SET_USER_MEMORY_REGION and it is not
> | urgent for vCPU's running, it could be done in a separate thread and use
> | lock-break technology.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05249.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg449994.html
> 
> Several TB memory guest is common now after NVDIMM is deployed in cloud environment.
> This patch utilizes worker thread to zap collapsible sptes in order to lazy collapse 
> small sptes into large sptes during roll-back after live migration fails.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> @@ -5679,14 +5679,41 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
>  	return need_tlb_flush;
>  }
>  
> +void zap_collapsible_sptes_fn(struct work_struct *work)
> +{
> +	struct kvm_memory_slot *memslot;
> +	struct kvm_memslots *slots;
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct kvm_arch *ka = container_of(dwork, struct kvm_arch,
> +					   kvm_mmu_zap_collapsible_sptes_work);
> +	struct kvm *kvm = container_of(ka, struct kvm, arch);
> +	int i;
> +
> +	mutex_lock(&kvm->slots_lock);
> +	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +		spin_lock(&kvm->mmu_lock);
> +		slots = __kvm_memslots(kvm, i);
> +		kvm_for_each_memslot(memslot, slots) {
> +			slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
> +				kvm_mmu_zap_collapsible_spte, true);
> +			if (need_resched() || spin_needbreak(&kvm->mmu_lock))
> +				cond_resched_lock(&kvm->mmu_lock);

I think we shouldn't zap all memslots when kvm_mmu_zap_collapsible_sptes
only wanted to zap a specific one.
Please add a list of memslots to be zapped; delete from the list here
and add in kvm_mmu_zap_collapsible_sptes().

> +		}
> +		spin_unlock(&kvm->mmu_lock);
> +	}
> +	kvm->arch.zap_in_progress = false;
> +	mutex_unlock(&kvm->slots_lock);
> +}
> +
> +#define KVM_MMU_ZAP_DELAYED (60 * HZ)
>  void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
>  				   const struct kvm_memory_slot *memslot)
>  {
> -	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
> -	spin_lock(&kvm->mmu_lock);
> -	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
> -			 kvm_mmu_zap_collapsible_spte, true);
> -	spin_unlock(&kvm->mmu_lock);
> +	if (!kvm->arch.zap_in_progress) {

The list can also serve in place of zap_in_progress -- if there were any
elements in it, then there is no need to schedule the work again.

Thanks.
