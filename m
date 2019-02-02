Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1154C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947A920870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBBG5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:57:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfBBG5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:57:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 022E989AE6;
        Sat,  2 Feb 2019 06:57:53 +0000 (UTC)
Received: from xz-x1 (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6F7C5C20D;
        Sat,  2 Feb 2019 06:57:43 +0000 (UTC)
Date:   Sat, 2 Feb 2019 14:57:41 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC][PATCH v2 14/21] kvm: register in mm_struct
Message-ID: <20190202065741.GA1011@xz-x1>
References: <20181226131446.330864849@intel.com>
 <20181226133351.894160986@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181226133351.894160986@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 02 Feb 2019 06:57:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 09:15:00PM +0800, Fengguang Wu wrote:
> VM is associated with an address space and not a specific thread.
> 
> >From Documentation/virtual/kvm/api.txt:
>    Only run VM ioctls from the same process (address space) that was used
>    to create the VM.

Hi, Fengguang,

AFAIU the commit message only explains why a kvm object needs to bind
to a single mm object (say, the reason why there is kvm->mm) however
not the reverse (say, the reason why there is mm->kvm), while the
latter is what this patch really needs?

I'm thinking whether it's legal for multiple VMs to run on a single mm
address space.  I don't see a limitation so far but it's very possible
I am just missing something there (if there is, IMHO they might be
something nice to put into the commit message?).  Thanks,

> 
> CC: Nikita Leshenko <nikita.leshchenko@oracle.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  include/linux/mm_types.h |   11 +++++++++++
>  virt/kvm/kvm_main.c      |    3 +++
>  2 files changed, 14 insertions(+)
> 
> --- linux.orig/include/linux/mm_types.h	2018-12-23 19:58:06.993417137 +0800
> +++ linux/include/linux/mm_types.h	2018-12-23 19:58:06.993417137 +0800
> @@ -27,6 +27,7 @@ typedef int vm_fault_t;
>  struct address_space;
>  struct mem_cgroup;
>  struct hmm;
> +struct kvm;
>  
>  /*
>   * Each physical page in the system has a struct page associated with
> @@ -496,6 +497,10 @@ struct mm_struct {
>  		/* HMM needs to track a few things per mm */
>  		struct hmm *hmm;
>  #endif
> +
> +#if IS_ENABLED(CONFIG_KVM)
> +		struct kvm *kvm;
> +#endif
>  	} __randomize_layout;
>  
>  	/*
> @@ -507,6 +512,12 @@ struct mm_struct {
>  
>  extern struct mm_struct init_mm;
>  
> +#if IS_ENABLED(CONFIG_KVM)
> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return mm->kvm; }
> +#else
> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return NULL; }
> +#endif
> +
>  /* Pointer magic because the dynamic array size confuses some compilers. */
>  static inline void mm_init_cpumask(struct mm_struct *mm)
>  {
> --- linux.orig/virt/kvm/kvm_main.c	2018-12-23 19:58:06.993417137 +0800
> +++ linux/virt/kvm/kvm_main.c	2018-12-23 19:58:06.993417137 +0800
> @@ -727,6 +727,7 @@ static void kvm_destroy_vm(struct kvm *k
>  	struct mm_struct *mm = kvm->mm;
>  
>  	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
> +	mm->kvm = NULL;
>  	kvm_destroy_vm_debugfs(kvm);
>  	kvm_arch_sync_events(kvm);
>  	spin_lock(&kvm_lock);
> @@ -3224,6 +3225,8 @@ static int kvm_dev_ioctl_create_vm(unsig
>  		fput(file);
>  		return -ENOMEM;
>  	}
> +
> +	kvm->mm->kvm = kvm;
>  	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>  
>  	fd_install(r, file);
> 
> 

Regards,

-- 
Peter Xu
