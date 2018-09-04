Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25302075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 00:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25302075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeIDEu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 00:50:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:55698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbeIDEu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 00:50:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 17:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,327,1531810800"; 
   d="scan'208";a="80614668"
Received: from dbxu-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.212.218])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2018 17:28:19 -0700
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1fwzCc-0001zp-Gn; Tue, 04 Sep 2018 08:28:18 +0800
Date:   Tue, 4 Sep 2018 08:28:18 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nikita Leshenko <nikita.leshchenko@oracle.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        dongx.peng@intel.com, jingqi.liu@intel.com, eddie.dong@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, bgregg@netflix.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] [PATCH 1/5] kvm: register in task_struct
Message-ID: <20180904002818.nq2ejxlsn4o34anl@wfg-t540p.sh.intel.com>
References: <D3FBF73C-3C33-4F94-8BBB-CE6C70B81A70@oracle.com>
 <0ef9ccdc-3eae-f0b9-5304-8552cb94d166@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0ef9ccdc-3eae-f0b9-5304-8552cb94d166@de.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian and Nikita,

On Mon, Sep 03, 2018 at 06:03:49PM +0200, Christian Borntraeger wrote:
>
>
>On 09/03/2018 04:10 PM, Nikita Leshenko wrote:
>> On September 2, 2018 5:21:15 AM, fengguang.wu@intel.com wrote:
>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> index 8b47507faab5..0c483720de8d 100644
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -3892,6 +3892,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>>>  	if (type == KVM_EVENT_CREATE_VM) {
>>>  		add_uevent_var(env, "EVENT=create");
>>>  		kvm->userspace_pid = task_pid_nr(current);
>>> +		current->kvm = kvm;
>>
>> Is it OK to store `kvm` on the task_struct? What if the thread that
>> originally created the VM exits? From the documentation it seems
>> like a VM is associated with an address space and not a specific
>> thread, so maybe it should be stored on mm_struct?
>
>Yes, ioctls accessing the kvm can happen from all threads.

Good point, thank you for the tips! I'll move kvm pointer to mm_struct.

>> From Documentation/virtual/kvm/api.txt:
>>    Only run VM ioctls from the same process (address space) that was used
>>    to create the VM.
>>
>> -Nikita

Regards,
Fengguang
