Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EC220869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeIDLjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:39:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:32373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbeIDLjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:39:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="80677445"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2018 00:15:54 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fx5Z2-0005Vl-Q3; Tue, 04 Sep 2018 15:15:52 +0800
Date:   Tue, 4 Sep 2018 15:15:52 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Nikita Leshenko <nikita.leshchenko@oracle.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        dongx.peng@intel.com, jingqi.liu@intel.com, eddie.dong@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, bgregg@netflix.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] [PATCH 1/5] kvm: register in task_struct
Message-ID: <20180904071552.f4cmxo7hwtjw22dc@wfg-t540p.sh.intel.com>
References: <D3FBF73C-3C33-4F94-8BBB-CE6C70B81A70@oracle.com>
 <0ef9ccdc-3eae-f0b9-5304-8552cb94d166@de.ibm.com>
 <20180904002818.nq2ejxlsn4o34anl@wfg-t540p.sh.intel.com>
 <20180904004621.aqhemgpefwtq3kif@wfg-t540p.sh.intel.com>
 <F0A5145C-E401-43E8-9FE9-56A4470CD13E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <F0A5145C-E401-43E8-9FE9-56A4470CD13E@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 08:37:03AM +0200, Nikita Leshenko wrote:
>On 4 Sep 2018, at 2:46, Fengguang Wu <fengguang.wu@intel.com> wrote:
>>
>> Here it goes:
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 99ce070e7dcb..27c5446f3deb 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -27,6 +27,7 @@ typedef int vm_fault_t;
>> struct address_space;
>> struct mem_cgroup;
>> struct hmm;
>> +struct kvm;
>> /*
>> * Each physical page in the system has a struct page associated with
>> @@ -489,10 +490,19 @@ struct mm_struct {
>> 	/* HMM needs to track a few things per mm */
>> 	struct hmm *hmm;
>> #endif
>> +#if IS_ENABLED(CONFIG_KVM)
>> +	struct kvm *kvm;
>> +#endif
>> } __randomize_layout;
>> extern struct mm_struct init_mm;
>> +#if IS_ENABLED(CONFIG_KVM)
>> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return mm->kvm; }
>> +#else
>> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return NULL; }
>> +#endif
>> +
>> static inline void mm_init_cpumask(struct mm_struct *mm)
>> {
>> #ifdef CONFIG_CPUMASK_OFFSTACK
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 0c483720de8d..dca6156a7b35 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3892,7 +3892,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>> 	if (type == KVM_EVENT_CREATE_VM) {
>> 		add_uevent_var(env, "EVENT=create");
>> 		kvm->userspace_pid = task_pid_nr(current);
>> -		current->kvm = kvm;
>> +		current->mm->kvm = kvm;
>I think you also need to reset kvm to NULL once the VM is
>destroyed, otherwise it would point to dangling memory.

Good point! Here is the incremental patch:

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3894,6 +3894,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
                kvm->userspace_pid = task_pid_nr(current);
                current->mm->kvm = kvm;
        } else if (type == KVM_EVENT_DESTROY_VM) {
+               current->mm->kvm = NULL;
                add_uevent_var(env, "EVENT=destroy");
        }
        add_uevent_var(env, "PID=%d", kvm->userspace_pid);

Thanks,
Fengguang
