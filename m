Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F85C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2112082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2112082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeLDJf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:35:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbeLDJf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:35:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89DA02D7E5;
        Tue,  4 Dec 2018 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 951F617DC0;
        Tue,  4 Dec 2018 09:35:14 +0000 (UTC)
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
Date:   Tue, 4 Dec 2018 17:35:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181203150809.GA4794@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 04 Dec 2018 09:35:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年12月03日 23:08, Borislav Petkov 写道:
> Add some more Ccs.
> 

Thanks a lot.

There are more people to review and improve this document together, that would
be fine.

> On Sun, Dec 02, 2018 at 11:08:38AM +0800, Lianbo Jiang wrote:
>> This document lists some variables that export to vmcoreinfo, and briefly
>> describles what these variables indicate. It should be instructive for
>> many people who do not know the vmcoreinfo, and it also normalizes the
>> exported variable as a standard ABI between kernel and use-space.
> 
> Yeah, I'm not sure about it being an ABI. Apparently, it is considered
> too tightly coupled to the kernel for it to be an ABI.
> 
> Regardless, thanks for doing that.
> 

It's my pleasure to do that.

>> Suggested-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  Documentation/kdump/vmcoreinfo.txt | 400 +++++++++++++++++++++++++++++
>>  1 file changed, 400 insertions(+)
>>  create mode 100644 Documentation/kdump/vmcoreinfo.txt
>>
>> diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt
> 
> Aren't we adding new docs in rst format only or what is the logic there?
> 
> Jon?
> 
>> new file mode 100644
>> index 000000000000..c6759be14af7
>> --- /dev/null
>> +++ b/Documentation/kdump/vmcoreinfo.txt
>> @@ -0,0 +1,400 @@
>> +================================================================
>> +		Documentation for Vmcoreinfo
>> +================================================================
>> +
>> +=======================
>> +What is the vmcoreinfo?
>> +=======================
>> +The vmcoreinfo contains the first kernel's various information, for
> 
> The first sentence here should be explaining what VMCOREINFO is: it is
> an ELF PT_NOTE section. So that people can go, oh ok, it is a special
> ELF section, when reading.
> 
> Then, MAKEDUMPFILE(8) spells VMCOREINFO in all caps and I think we
> should do that too here, for ease of recognition.
> 

This is good advice.

> Btw, do we have a makedumpfile switch or a tool/script which dumps
> VMCOREINFO contents in human-readable form?
> 

Generating VMCOREINFO is easy in the first kernel, for example:
# makedumpfile -g VMCOREINFO -x vmlinux

# file VMCOREINFO
VMCOREINFO: ASCII text

> Maybe something nicer than:
> 
> $ hexdump -C /proc/kcore
> 
>> +example, structure size, page size, symbol values and field offset,
>> +etc. These data are encapsulated into an elf format, and these data
>> +will also help user-space tools(e.g. makedumpfile, crash) analyze the
>> +first kernel's memory usage.
>> +
>> +================
>> +Common variables
>> +================
>> +
>> +init_uts_ns.name.release
>> +========================
>> +The number of OS release.
>> +
>> +PAGE_SIZE
>> +=========
>> +The size of a page. It is usually 4k bytes.
>> +
>> +init_uts_ns
>> +===========
>> +This is the UTS namespace, which is used to isolate two specific elements
>> +of the system that relate to the uname system call. The UTS namespace is
>> +named after the data structure used to store information returned by the
>> +uname system call.
> 
> Those non-obvious exports should also have a short explanation why
> they're part of VMCOREINFO.
> 
>> +
>> +node_online_map
>> +===============
>> +It is a macro definition, actually it is an arrary node_states[N_ONLINE],
>> +and it represents the set of online node in a system, one bit position
>> +per node number.
> 
> Ditto.
> 
> So yeah, people can find out what those things are but I think it is
> more important to state here *why* they're part of VMCOREINFO and how
> they're used and why they're exported.
> 

This is a good question.

For these two *why*, it should be easy to understand. Because user-space tools
need to know basic information, such as the symbol values, field offset, structure
size, etc. Otherwise, these tools won't know how to analyze the memory of the crash
kernel.

For the second question 'how they are used', we can get the answer from user-space
tools, such as makedumpfile, crash tools. Therefore, it may not need to explain any
more in kernel document. On the other hand, if we must put these contents into kernel
document, i have to say, that would be a hard task.


> Who knows, some might turn out to be not needed anymore. :)
> 
>> +
>> +swapper_pg_dir
>> +=============
>> +It is always an array, it gerenally stands for the pgd for the kernel.
>> +When mmu is enabled in config file, the 'swapper_pg_dir' is valid.
>> +
>> +_stext
>> +======
>> +It is an assemble directive that defines the beginning of the text section.
> 
> That's an assembly symbol.
> 
>> +In gerenal, the '_stext' indicates the kernel start address.
>> +
>> +vmap_area_list
>> +==============
>> +It stores the virtual area list, makedumpfile can get the vmalloc start
>> +value according to this variable.
> 
> "... from this variable."
> 
>> +
>> +mem_map
>> +=======
>> +Physical addresses are translated to struct pages by treating them as an
>> +index into the mem_map array. Shifting a physical address PAGE_SHIFT bits
>> +to the right will treat it as a PFN from physical address 0, which is also
>> +an index within the mem_map array.
>> +
>> +In a word, it can map the address to struct page.
> 
> "In short, ... "
> 
>> +
>> +contig_page_data
>> +================
>> +Makedumpfile can get the pglist_data structure according to this symbol
> 
> Please look up in the dictionary what "according" means. Using it in
> this context is at least weird.
> 

Thank you for pointing out my mistake.

I'm going to look up in the Collins dictionary and record this word on my
notebook using a pen.

>> +'contig_page_data'. The pglist_data structure is used to describe the
>> +memory layout.
>> +
>> +mem_section|(mem_section, NR_SECTION_ROOTS)|(mem_section, section_mem_map)
>> +==========================================================================
>> +Export the address of 'mem_section' array, and it's length, structure size,
>> +and the 'section_mem_map' offset.
>> +
>> +It exists in the sparse memory mapping model, and it is also somewhat
>> +similar to the mem_map variable, both of them will help to translate
>> +the address.
>> +
>> +page
>> +====
>> +The size of a 'page' structure.
>> +
>> +pglist_data
>> +===========
>> +The size of a 'pglist_data' structure.
>> +
>> +zone
>> +====
>> +The size of a 'zone' structure.
>> +
>> +free_area
>> +=========
>> +The size of a 'free_area' structure.
>> +
>> +list_head
>> +=========
>> +The size of a 'list_head' structure.
>> +
>> +nodemask_t
>> +==========
>> +The size of a 'nodemask_t' type.
>> +
>> +(page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|
>> +       compound_order|compound_head)
>> +===================================================================
>> +The page structure is a familiar concept for most of linuxer, there is no
>> +need to explain too much.
> 
> Just delete that sentence.
> 
>> To know more information, please refer to the
>> +definition of the page struct(include/linux/mm_types.h).
>> +
>> +(pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_
>> +              spanned_pages|node_id)
>> +===================================================================
>> +On NUMA machines, each NUMA node would have a pg_data_t to describe
> 
> s/would have/has/
> 
>> +it's memory layout. On UMA machines there is a single pglist_data which
>> +describes the whole memory.
>> +
>> +The pglist_data structure contains these varibales, here export their
> 					    ^^^^^^^^^
> 
> Before you send next time, run the *whole* text through a spellchecker.
> 
>> +offset in the pglist_data structure, which is defined in this file
>> +"include/linux/mmzone.h".
> 
> You don't have to state where stuff is defined - I hope everyone
> should be able to grep.
> 

Thanks for your comment in detail.
I will improve them in patch v3.

Regards,
Lianbo

> ...
> 
