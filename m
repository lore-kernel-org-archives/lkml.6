Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZrdUDd4ev8wX2el+hjhPuznh8pJ9NCCN9S6QlzKl5Vj/FFYRvcvPyNdHLwDXetPz/363SGt
ARC-Seal: i=1; a=rsa-sha256; t=1525875291; cv=none;
        d=google.com; s=arc-20160816;
        b=kaIVlRH14YbU7Q80uZvgScCE/3vBc9YXKkRRVUqtK8/Giyq18cuAPmkblfv9JmpNnM
         HqL7EZvUkRLnjjL5vRLit9tVrcYQf2SqGFEQX1mMC8mT4lmtu143G8Yjiwa9kr2lj5yw
         MzxHbVwAjJXkAvJFvT3HrPppvZDAGBfgzdplLHfOCLBS981be9Ast8S7vSDrV2hnWBeS
         36kTx2VScws75WZYeNgknc4BRP07VBY4iPI/0EhdmofsMBXIZhJHlq5Ifh1gYAg4d2q9
         EiJ3/mnA6EgurvMExxam4t9h3M6kSH1rsuekNwhGBkGGge77g3R4E3qrKhMc7R1q8k/b
         JM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=qPtVi2SQn6YbsXxVwlF/cJzk77St/fc3G/46MOfpOHg=;
        b=bFj3HGtMze+GPMMUlwUZ1uHLhOArm0C89tzpTfwKVv5X4dE/ku5jNK+PR/XGixs55h
         w1aBU1shGtPKuOquSt4ArxMi2UQ7UVNYWqj4YIhG4hDglcoSMBxUzA2eFeir3yIlcAqb
         Ridg0/YG3aGjRIRHiKSaGJcTidx7L5Mri5P6hYfRxkAvAj6L8EP29rywK6NYThuoKclQ
         JSwbe/dB1a/VPVWZNqGj6J+wmvlzWwjmX4wANKaq5zPLJI0/2ZwCq3UPuKUCbtcB5HsV
         eM9XapoqcT9ZB+xHhyKQqM1FLwg5rhIQzDoKhNvSp7rljXzEnA9DVv6UOyWXjPMLRb1X
         eehA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH RCFv2 0/7] mm: online/offline 4MB chunks controlled by
 device driver
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>, Baoquan He <bhe@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, Huang Ying
 <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
 Ingo Molnar <mingo@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Juergen Gross <jgross@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <mawilcox@microsoft.com>, Mel Gorman <mgorman@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Miles Chen <miles.chen@mediatek.com>, Paul Mackerras <paulus@samba.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Rashmica Gupta <rashmica.g@gmail.com>, Reza Arbab
 <arbab@linux.vnet.ibm.com>, Souptick Joarder <jrdr.linux@gmail.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>
References: <20180430094236.29056-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ce2abc0b-8b6c-0a9a-30a5-31c185b5f8f8@redhat.com>
Date: Wed, 9 May 2018 16:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430094236.29056-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599163715332859080?=
X-GMAIL-MSGID: =?utf-8?q?1599996209642238571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30.04.2018 11:42, David Hildenbrand wrote:
> I am right now working on a paravirtualized memory device ("virtio-mem").
> These devices control a memory region and the amount of memory available
> via it. Memory will not be indicated/added/onlined via ACPI and friends,
> the device driver is responsible for it.
> 
> When the device driver starts up, it will add and online the requested
> amount of memory from its assigned physical memory region. On request, it can
> add (online) either more memory or try to remove (offline) memory. As it
> will be a virtio module, we also want to be able to have it as a loadable
> kernel module.
> 
> Such a device can be thought of like a "resizable DIMM" or a "huge
> number of 4MB DIMMS" that can be automatically managed.
> 
> As we want to be able to add/remove small chunks of memory to a VM without
> fragmenting guest memory ("it's not what the guest pays for" and "what if
> the hypervisor wants to sue huge pages"), it looks like we can do that
> under Linux in a 4MB granularity by using online_pages()/offline_pages()
> 
> We add a segment and online only 4MB blocks of it on demand. So the other
> memory might not be accessible. For kdump and offlining code, we have to
> mark pages as offline before a new segment is visible to the system (e.g.
> as these pages might not be backed by real memory in the hypervisor).
> 
> This is not a balloon driver. Main differences:
> - We can add more memory to a VM without having to use mixture of
>   technologies - e.g. ACPI for plugging, balloon for unplugging (in contrast
>   to virtio-balloon).
> - The device is responsible for its own memory only - will not inflate on
>   any system memory. (in contrast to all balloons)
> - Works on a coarser granularity (e.g. 4MB because that's what we can
>   online/offline in Linux). We are not using the buddy allocator when unplugging
>   but really search for chunks of memory we can offline. We actually
>   can support arbitrary block sizes. (in contrast to all balloons)
> - That's why we don't fragment guest memory.
> - A device can belong to exactly one NUMA node. This way we can online/offline
>   memory in a fine granularity NUMA aware. Even if the guest does not even
>   know how to spell NUMA. (in contrast to all balloons)
> - Architectures that don't have proper memory hotplug interfaces (e.g. s390x)
>   get memory hotplug support. I have a prototype for s390x.
> - Once all 4MB chunks of a memory block are offline, we can remove the
>   memory block and therefore the struct pages. (in contrast to all balloons)
> 
> This essentially allows us to add/remove 4MB chunks to/from a VM. Especially
> without caring about the future when adding memory ("If I add a 128GB DIMM
> I can only unplug 128GB again") or running into limits ("If I want my VM to
> grow to 4TB, I have to plug at least 16GB per DIMM").
> 
> Future work:
>  - Performance improvements
>  - Be smarter about which blocks to offline first (e.g. free ones)
>  - Automatically manage assignemnt to NORMAL/MOVABLE zone to make
>    unplug more likely to succeed.
> 
> I will post the next prototype of virtio-mem shortly.
> 

If there are no further comments, I'll send a v1 (!RFC) version, along
with the virtio-mem prototype after rebasing (assuming that nothing
breaks :) ).

-- 

Thanks,

David / dhildenb
