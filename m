Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC16C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397132077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397132077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIDMz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:55:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:59225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIDMz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:55:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 01:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="80692463"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2018 01:31:20 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fx6k3-0006In-K0; Tue, 04 Sep 2018 16:31:19 +0800
Date:   Tue, 4 Sep 2018 16:31:19 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nikita Leshenko <nikita.leshchenko@oracle.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        dongx.peng@intel.com, jingqi.liu@intel.com, eddie.dong@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, bgregg@netflix.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] [PATCH 1/5] kvm: register in task_struct
Message-ID: <20180904083119.t5zhv5m3slnossq6@wfg-t540p.sh.intel.com>
References: <D3FBF73C-3C33-4F94-8BBB-CE6C70B81A70@oracle.com>
 <0ef9ccdc-3eae-f0b9-5304-8552cb94d166@de.ibm.com>
 <20180904002818.nq2ejxlsn4o34anl@wfg-t540p.sh.intel.com>
 <20180904004621.aqhemgpefwtq3kif@wfg-t540p.sh.intel.com>
 <F0A5145C-E401-43E8-9FE9-56A4470CD13E@oracle.com>
 <20180904071552.f4cmxo7hwtjw22dc@wfg-t540p.sh.intel.com>
 <45efb10a-a55a-b917-589c-de55e88ec18f@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45efb10a-a55a-b917-589c-de55e88ec18f@de.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:43:50AM +0200, Christian Borntraeger wrote:
>
>
>On 09/04/2018 09:15 AM, Fengguang Wu wrote:
>> On Tue, Sep 04, 2018 at 08:37:03AM +0200, Nikita Leshenko wrote:
>>> On 4 Sep 2018, at 2:46, Fengguang Wu <fengguang.wu@intel.com> wrote:
>>>>
>>>> Here it goes:
>>>>
>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>> index 99ce070e7dcb..27c5446f3deb 100644
>>>> --- a/include/linux/mm_types.h
>>>> +++ b/include/linux/mm_types.h
>>>> @@ -27,6 +27,7 @@ typedef int vm_fault_t;
>>>> struct address_space;
>>>> struct mem_cgroup;
>>>> struct hmm;
>>>> +struct kvm;
>>>> /*
>>>> * Each physical page in the system has a struct page associated with
>>>> @@ -489,10 +490,19 @@ struct mm_struct {
>>>>     /* HMM needs to track a few things per mm */
>>>>     struct hmm *hmm;
>>>> #endif
>>>> +#if IS_ENABLED(CONFIG_KVM)
>>>> +    struct kvm *kvm;
>>>> +#endif
>>>> } __randomize_layout;
>>>> extern struct mm_struct init_mm;
>>>> +#if IS_ENABLED(CONFIG_KVM)
>>>> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return mm->kvm; }
>>>> +#else
>>>> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return NULL; }
>>>> +#endif
>>>> +
>>>> static inline void mm_init_cpumask(struct mm_struct *mm)
>>>> {
>>>> #ifdef CONFIG_CPUMASK_OFFSTACK
>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>> index 0c483720de8d..dca6156a7b35 100644
>>>> --- a/virt/kvm/kvm_main.c
>>>> +++ b/virt/kvm/kvm_main.c
>>>> @@ -3892,7 +3892,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>>>>     if (type == KVM_EVENT_CREATE_VM) {
>>>>         add_uevent_var(env, "EVENT=create");
>>>>         kvm->userspace_pid = task_pid_nr(current);
>>>> -        current->kvm = kvm;
>>>> +        current->mm->kvm = kvm;
>>> I think you also need to reset kvm to NULL once the VM is
>>> destroyed, otherwise it would point to dangling memory.
>>
>> Good point! Here is the incremental patch:
>>
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3894,6 +3894,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>>                kvm->userspace_pid = task_pid_nr(current);
>>                current->mm->kvm = kvm;
>>        } else if (type == KVM_EVENT_DESTROY_VM) {
>> +               current->mm->kvm = NULL;
>>                add_uevent_var(env, "EVENT=destroy");
>>        }
>>        add_uevent_var(env, "PID=%d", kvm->userspace_pid);
>
>I think you should put both code snippets somewhere else. This has probably nothing to do
>with the uevent. Instead this should go into kvm_destroy_vm and kvm_create_vm. Make sure
>to take care of the error handling.

OK. Will set the pointer late and reset it early like this. Since
there are several error conditions after kvm_create_vm(), it may be
more convenient to set it in kvm_dev_ioctl_create_vm(), when there are
no more errors to handle:

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -724,6 +724,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
        struct mm_struct *mm = kvm->mm;

        kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
+       current->mm->kvm = NULL;
        kvm_destroy_vm_debugfs(kvm);
        kvm_arch_sync_events(kvm);
        spin_lock(&kvm_lock);
@@ -3206,6 +3207,7 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
                fput(file);
                return -ENOMEM;
        }
+       current->mm->kvm = kvm;
        kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);

        fd_install(r, file);

>Can you point us to the original discussion about the why and what you are
>trying to achieve?

It's the initial RFC post. [PATCH 0] describes some background info.

Basically we're implementing /proc/PID/idle_bitmap for user space to
walk page tables and get "accessed" bits. Since VM's "accessed" bits
will be reflected in EPT (or AMD NPT), we'll need to walk EPT when
detected it is QEMU main process. 

Thanks,
Fengguang
