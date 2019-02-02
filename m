Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F616C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7112D20869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfBBKuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:50:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:30847 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfBBKuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:50:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2019 02:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,552,1539673200"; 
   d="scan'208";a="130591685"
Received: from lzhan14x-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.188])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Feb 2019 02:50:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gpss6-0004tS-6L; Sat, 02 Feb 2019 18:50:02 +0800
Date:   Sat, 2 Feb 2019 18:50:02 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20190202105002.amvqgvnkgfxpiowe@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181226133351.894160986@intel.com>
 <20190202065741.GA1011@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190202065741.GA1011@xz-x1>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, Feb 02, 2019 at 02:57:41PM +0800, Peter Xu wrote:
>On Wed, Dec 26, 2018 at 09:15:00PM +0800, Fengguang Wu wrote:
>> VM is associated with an address space and not a specific thread.
>>
>> >From Documentation/virtual/kvm/api.txt:
>>    Only run VM ioctls from the same process (address space) that was used
>>    to create the VM.
>
>Hi, Fengguang,
>
>AFAIU the commit message only explains why a kvm object needs to bind
>to a single mm object (say, the reason why there is kvm->mm) however
>not the reverse (say, the reason why there is mm->kvm), while the
>latter is what this patch really needs?

Yeah good point. The addition of mm->kvm makes code in this patchset
simple. However if that field is considered not general useful for
other possible users, and the added space overheads is a concern, we
can instead do with a flag (saying the mm is referenced by some KVM),
and add extra lookup code to find out the exact kvm instance.

>I'm thinking whether it's legal for multiple VMs to run on a single mm
>address space.  I don't see a limitation so far but it's very possible
>I am just missing something there (if there is, IMHO they might be
>something nice to put into the commit message?).  Thanks,

So far one QEMU only starts one KVM. I cannot think of any strong
benefit to start multiple KVMs in one single QEMU, so it may well
remain so in future. Anyway it's internal data structure instead of
API, which can adapt to possible future changes.

Thanks,
Fengguang

>> CC: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> CC: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
>> ---
>>  include/linux/mm_types.h |   11 +++++++++++
>>  virt/kvm/kvm_main.c      |    3 +++
>>  2 files changed, 14 insertions(+)
>>
>> --- linux.orig/include/linux/mm_types.h	2018-12-23 19:58:06.993417137 +0800
>> +++ linux/include/linux/mm_types.h	2018-12-23 19:58:06.993417137 +0800
>> @@ -27,6 +27,7 @@ typedef int vm_fault_t;
>>  struct address_space;
>>  struct mem_cgroup;
>>  struct hmm;
>> +struct kvm;
>>
>>  /*
>>   * Each physical page in the system has a struct page associated with
>> @@ -496,6 +497,10 @@ struct mm_struct {
>>  		/* HMM needs to track a few things per mm */
>>  		struct hmm *hmm;
>>  #endif
>> +
>> +#if IS_ENABLED(CONFIG_KVM)
>> +		struct kvm *kvm;
>> +#endif
>>  	} __randomize_layout;
>>
>>  	/*
>> @@ -507,6 +512,12 @@ struct mm_struct {
>>
>>  extern struct mm_struct init_mm;
>>
>> +#if IS_ENABLED(CONFIG_KVM)
>> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return mm->kvm; }
>> +#else
>> +static inline struct kvm *mm_kvm(struct mm_struct *mm) { return NULL; }
>> +#endif
>> +
>>  /* Pointer magic because the dynamic array size confuses some compilers. */
>>  static inline void mm_init_cpumask(struct mm_struct *mm)
>>  {
>> --- linux.orig/virt/kvm/kvm_main.c	2018-12-23 19:58:06.993417137 +0800
>> +++ linux/virt/kvm/kvm_main.c	2018-12-23 19:58:06.993417137 +0800
>> @@ -727,6 +727,7 @@ static void kvm_destroy_vm(struct kvm *k
>>  	struct mm_struct *mm = kvm->mm;
>>
>>  	kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
>> +	mm->kvm = NULL;
>>  	kvm_destroy_vm_debugfs(kvm);
>>  	kvm_arch_sync_events(kvm);
>>  	spin_lock(&kvm_lock);
>> @@ -3224,6 +3225,8 @@ static int kvm_dev_ioctl_create_vm(unsig
>>  		fput(file);
>>  		return -ENOMEM;
>>  	}
>> +
>> +	kvm->mm->kvm = kvm;
>>  	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>>
>>  	fd_install(r, file);
>>
>>
>
>Regards,
>
>-- 
>Peter Xu
>
