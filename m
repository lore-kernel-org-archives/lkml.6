Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeDEMTf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:19:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbeDEMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:19:33 -0400
Subject: Re: [Qemu-devel] [RFC] qemu: Add virtio pmem device
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com,
        niteshnarayanlal@hotmail.com, mst@redhat.com,
        ross zwisler <ross.zwisler@intel.com>, hch@infradead.org,
        stefanha@redhat.com, imammedo@redhat.com, marcel@redhat.com,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        nilal@redhat.com
References: <20180405104834.10457-1-pagupta@redhat.com>
 <20180405104834.10457-4-pagupta@redhat.com>
 <ad08ca09-71ee-08d5-3479-8b3d06380a03@redhat.com>
 <416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <782ac7e2-b8d9-139d-6182-cb4e2d082458@redhat.com>
Date: Thu, 5 Apr 2018 14:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> So right now you're just using some memdev for testing.
> 
> yes.
> 
>>
>> I assume that the memory region we will provide to the guest will be a
>> simple memory mapped raw file. Dirty tracking (using the kvm slot) will
>> be used to detect which blocks actually changed and have to be flushed
>> to disk.
> 
> Not really, we will perform fsync on raw file. As this file is created
> on regular storage and not nvdimm, so host page cache radix tree would have 
> the dirty pages information which will be used for fsync.

Ah right. That makes things a lot easier!

>    
>>
>> Will this raw file already have the "disk information header" (no idea
>> how that stuff is called) encoded? Are there any plans/possible ways to
>>
>> a) automatically create the headers? (if that's even possible)
> 
> Its raw. Right now we are just supporting raw format.  
> 
> As this is direct mapping of memory into guest address space, I don't
> think we can have an abstraction of headers for block specific features.
> Or may be we can get opinion of others(Qemu block people) it is at all possible?
> 
>> b) support anything but raw files?
>>
>> Please note that under x86, a KVM memory slot still has a (in my
>> opinion) fairly big overhead depending on the size of the slot (rmap,
>> page_track). We might have to optimize that.
> 
> I have not tried/observed this. Right now I just used single memory slot and cold add
> few MB's of memory in Qemu. Can you please provide more details on this?
> 

You can have a look at kvm_arch_create_memslot() in arch/x86/kvm/x86.c.

"npages" is used to allocate certain arrays (rmap for shadow page
tables). Also kvm_page_track_create_memslot() allocates data for page_track.

Having a big disk involves a lot of memory overhead due to the big kvm
memory slot. This is already the case for NVDIMMs as of now.

Other architectures (e.g. s390x) don't have this "problem". They don't
allocate any such data depending on the size of a memory slot.

This is certainly something to work on in the future.

-- 

Thanks,

David / dhildenb
